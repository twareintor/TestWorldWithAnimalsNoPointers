//Microsoft (R) C/C++ Optimizing Compiler Version 19.00.23506 for x64

// Type your code here, or load an example.
/***************************************************************************************************************************
 * 
 * Version: 000.A00/ 2021.02.20 10:00:00
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

/** abstract class, for animals */
class CAnimal
{
private:
    friend class CWorld; // for onTick() - not visible from outside in order not to tick any 
                        // faster or slower than the world ticks
    void onTick(float dt){m_age+=dt; m_alive = m_age>m_lifespan && m_health>0.1;}
                        // a heath under 10% doesnt' define the animal as alive
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
    virtual void eat(CAnimal& other){m_health*=other.m_health; other.m_alive = false;}
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

/**
 *
 * credits: https://silviuardelean.ro/tag/singleton-with-smart-pointers/ for this construct 
 *
 */
class CWorld final //it must be a singleton
{
    static std::mutex m_mut;
    static std::unique_ptr<CWorld> m_instptr;

    std::vector<std::reference_wrapper<CAnimal>> m_animals;
    static std::unique_ptr<CWorld> m_inst;
    CWorld(){std::cout<<"world commissioned\n";}

    CWorld(const CWorld&); 
    CWorld& operator=(const CWorld&); 
public:
    ~CWorld(){std::cout<<"new world decommissioned\n";}
    static std::shared_ptr<CWorld>& getInstance()
    {
        static std::shared_ptr<CWorld> instance = nullptr;
        if(!instance)
        {
            std::lock_guard<std::mutex> lock(m_mut);
            if(!instance)
            {
                instance.reset(new CWorld());
            }
        }
        return instance;
    }
    CWorld(CWorld&&){}
    CWorld&& operator=(CWorld&&){return std::move(*getInstance().get());}
    template <class T>
    T spawn()
    {
        T t;
        // m_animals.push_back(dynamic_cast<CAnimal&>(std::ref(t))); // <== does not compile: base not polymorphic
        m_animals.push_back(static_cast<CAnimal&>(std::ref(t))); // this does, but WARNING!
        // return static_cast<T&>(m_animals.back().get()); // <== doesn't compile: base is virtual
        return dynamic_cast<T&>(m_animals.back().get()); // <== this does!
        return t;
    }
    void tick(float dt) // assign the tick of all animals
    {
        std::for_each(m_animals.begin(), m_animals.end(), [dt](auto&& a){a.get().onTick(dt);});
    }
};

int main()
{
    CWorld& world = *CWorld::getInstance().get();

    CHerbivore myCow = world.spawn<CHerbivore>();
    CCarnivore myDog = world.spawn<CCarnivore>();
    COmnivore myPig = world.spawn<COmnivore>();

    return 0;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
