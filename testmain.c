//Microsoft (R) C/C++ Optimizing Compiler Version 19.00.23506 for x64

/***************************************************************************************************************************
 * 
 * Version: 000.A00/ 2021.02.22 22:00:00 // At the time of this alpha it wasn't tested!
 * Author: Claudiu "Twareintor" Ciutacu 
 *
 * Description: This is a demo framework of a world spawning animals and keeping a reference of every one of them in a vector
 * of reference wrappers. It doesn't have to be a vector of references; it works very good with a vector of copies but this
 * is just a demo program to learn and test this feature of modern C++ again. 
 * Note the function CWorld::spawn() in which to store a reference to a derived type into a vector of reference wrappers to
 * its base type, we have to static_cast<>() it to reference to base. Conversely, we have to dynamic_cast<>() to retrieve it.
 * Only compiles when we do so but I don't know if is the right way. The program will probably crash by segfault. Casting
 * references vertical across hierarchy is a known issue.
 * 
 **************************************************************************************************************************/

#include <iostream>
#include <vector>  
#include <functional> // for reference_wrapper
#include <algorithm> // for for_each()
#include <typeinfo> // for typeid
#include <memory>  // for smart pointers
#include <mutex>  // for thread-safe singleton

class CWorld;

/** abstract class for a generic animal, from which we will derive any kind of animal, carnivore, herbivore etc
 * members:
 * isAlive() true if the animal is alive; because of using no pointers in this program;
 * canEat() true if this can eat other animal, e.g., carnivore eating herbivore
 * eat() check if this can eat other and then, gets its energy and other will no more be alive
 * id() returns a reference to its m_id (in order to can be set and get in a single function)
 * I hope the (member) functions names are descriptive enough so, I don't insert any comment about
 */
class CAnimal
{
protected:
    friend class CWorld; // for onTick() - not visible from outside in order not to tick any 
                        // faster or slower than the world ticks
    void onTick(float dt){m_age+=dt; m_alive = m_age>m_lifespan && m_health>0.1;}
                        // a heath under 10% doesnt' define the animal as alive
    int m_id;    
protected:
    bool m_alive; // when created, 
    float m_health;  // must be at most 1.0
    float m_lifespan; // every animal gets a lifespan according to species
    float m_age; // increases by onTick()
public:
    CAnimal(): m_alive(true), m_health(1.f){}
    ~CAnimal(){}
    bool isAlive(){return m_alive && m_lifespan>m_age;}
    virtual bool canEat(const CAnimal& other) const = 0; // WARNING! Pure virtual
    virtual void eat(CAnimal& other){if(this->canEat(other)){m_health*=other.m_health; other.m_alive = false;}}
    int& id(){return m_id;}
};

/** derived from animals, must be abstract too, defining herbivores (producers) */
class CHerbivore: public virtual CAnimal // assumes herbivores eat no other animal
{
public:
    virtual bool canEat(const CAnimal& other) const
    {
        return false; // herbivore cannot eat another animal
    }   
};

/** derived from animals, must be abstract too, defining carnivores (standard consumers) */
class CCarnivore: public virtual CAnimal // assumes normal carnivores eats only herbivores
{
public:
    virtual bool canEat(const CAnimal& other) const
    {
        try // I prefer pointer version like this: return dynamic_cast<const CHerbivore*>(pOther);
        {
            dynamic_cast<const CHerbivore&>(other);
            return true;
        }
        catch(std::bad_cast)
        {
            return false;
        }
    }   
};

/** derived from both herbivores and carnivores (producers and consumers too) */
class COmnivore: public CHerbivore, public CCarnivore // can eaten only herbivores
{     // but can be eaten by normal carnivores; additionally, they cannot eat other omnivores!
public:
    virtual bool canEat(const CAnimal& other) const
    {
        try 
        {
            dynamic_cast<const COmnivore&>(other);
            return false; // if the other is omnivore too, cannot be eaten by omnivore!
        }
        catch(std::bad_cast)
        {       // but if other is no omnivore, can eat it if herbivore
            return CCarnivore::canEat(other); // everything what carnivores eat...
        }
    }    // being herbivore at the same time, can be eaten by carnivores
};

/** eat also carnivores, except animals from same species */
class CFerocious: public CCarnivore // eat also carnivores, except its species
{
public:
    virtual bool canEat(const CAnimal& other) const
    {
        return typeid(*this).name()!=typeid(const_cast<decltype(other)>(other)).name();
    }    
};

/** eats everything, also animals from the same species, except itself (never imagined!) */
class CCanibal: public CCarnivore
{
public:
    virtual bool canEat(const CAnimal& other) const
    {
        return &other!=this; // ditto!
    }    
};

/** solving a fight between two animals; although a single winner, if no one can eat no one, every animal will survive */
template <class R, class T, class U>
R& animalFight(T& t, U& u)
{
    if(t.canEat(u))
    {
        t.eat(u); return t;
    }
    else if(u.canEat(t))
    {
        u.eat(t); return u;
    }
    // note: the return value doesn't have any importance except for extending to variadic
    // if nobody can eat nobody, all animals stay alive
}

/** solving a skirmish between more than two animals, the winner (returned value) is not well defined but is not important */
template <class R, class T, class... Args>
R& animalFight(T& t, Args&... args)
{
    return animalFight(t, animalFight(args...));
    // if nobody can eat nobody, all animals stay alive; otherwise, result is not well defined
}

/** the generic pure virtual functio body of the abstract CAnimal{}; */
bool CAnimal::canEat(const CAnimal& other) const
{
    std::cout<<"generic animal: must be implemented"<<std::endl;
    return false;
}

template <class T>
class CShelter
{
    friend class CWorld;
    std::vector<CAnimal*> m_animals;
    CShelter(std::vector<CAnimal*> animals):m_animals(animals){}
    T& operator[](int i)
    {
        return *(dynamic_cast<T*>(m_animals[i]));
    }
};

/**
 * A world class. Functions:
 * spawn() will generate a reference to an animal and will add this reference in the member m_animals
 * note that the spawn<T>() function is template and is intended to spawn an animal of the specialized type
 * tick() will call the onTick() function of every element in m_animals, that is, every animal in the world
 * credits: https://silviuardelean.ro/tag/singleton-with-smart-pointers/ for this construct 
 *
 */
class CWorld final //it must be a singleton
{
    static std::mutex m_mut; // to be thread save
    static std::unique_ptr<CWorld> m_instptr; // its instance as unique ptr

    std::vector<CAnimal*> m_animals; // the animals contained by this world
    static std::unique_ptr<CWorld> m_inst; // 
    int m_crtId = 1000; // the autogenerated ID, starting with this figure...

    /** private constructor to assure the singleton functionality */
    CWorld(){std::cout<<"world commissioned\n";} // private constructor
    /** private copy constructor to assure the singleton functionality */
    CWorld(const CWorld&);  // .. not to be accessed form outside, just through getInstance()
    /** private assignment operator to assure the singleton functionality */
    CWorld& operator=(const CWorld&); // must be private

public:
    ~CWorld(){std::cout<<"new world decommissioned\n";} 
    /** The getInstance() of the singleton (our word is a singleton) */
    static std::shared_ptr<CWorld>& getInstance()
    {
        static std::shared_ptr<CWorld> instance = nullptr;
        if(!instance)
        {
            std::lock_guard<std::mutex> lock(m_mut);
            if(!instance)
                instance.reset(new CWorld());
        }
        return instance;
    }
    CWorld(CWorld&&) = default;
    CWorld&& operator=(CWorld&&){return std::move(*getInstance().get());}
    /** Spawns an object of type CAnimal when the template argument is specified */
    template <class T>
    T& spawn() // this adds a new member to the vector of animals and returns it; now uses RTTI
    {
        CAnimal* ani = new T();
        m_animals.push_back(ani);
        return *dynamic_cast<T*>(m_animals.back()); // uses RTTI
    }
    void tick(float dt) // assign the tick of all animals
    {
        std::for_each(m_animals.begin(), m_animals.end(), [dt](auto&& a){a->onTick(dt);});
    }
    /** Returns a vector of pointers to every member: There is no other possibility! */
    std::vector<CAnimal*>& getAnimals(){return m_animals;}
    /** Then next two functions are useless. As long as you don't use the next one, compiles fine */
    template <class T>
    T& getAnimal(int i)
    {
        return *(dynamic_cast<T*>(m_animals[i]));
    }
    int animalCount(){return m_animals.size();}
};

int main()
{
    CWorld& world = *CWorld::getInstance().get();

    CAnimal& myCow = world.spawn<CHerbivore>();
    CAnimal& myDog = world.spawn<CCarnivore>();
    CAnimal& myPig = world.spawn<COmnivore>();

    for(auto&& it: world.getAnimals())
        std::cout<<it->id()<<std::endl; // does compile, but why to do something like this?
    /** when comment this, it compiles, but you cannot have something like this: 
    for(int i = 0; i<world.animalCount(); i++)
        std::cout<<world.getAnimal(i)<<std::endl; <<<< this don't compile!!!
    */
    return 0;
}

