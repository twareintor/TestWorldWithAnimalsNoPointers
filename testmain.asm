CAnimal::eat(CAnimal&):
        push    rbp
        push    rbx
        sub     rsp, 8
        mov     rbx, rdi
        mov     rbp, rsi
        mov     rax, QWORD PTR [rdi]
        call    [QWORD PTR [rax]]
        test    al, al
        je      .L1
        movss   xmm0, DWORD PTR [rbx+16]
        mulss   xmm0, DWORD PTR [rbp+16]
        movss   DWORD PTR [rbx+16], xmm0
        mov     BYTE PTR [rbp+12], 0
.L1:
        add     rsp, 8
        pop     rbx
        pop     rbp
        ret
CHerbivore::canEat(CAnimal const&) const:
        mov     eax, 0
        ret
std::_Sp_counted_ptr<CWorld*, (__gnu_cxx::_Lock_policy)2>::~_Sp_counted_ptr() [complete object destructor]:
        ret
std::_Sp_counted_ptr<CWorld*, (__gnu_cxx::_Lock_policy)2>::_M_get_deleter(std::type_info const&):
        mov     eax, 0
        ret
std::_Sp_counted_ptr<CWorld*, (__gnu_cxx::_Lock_policy)2>::~_Sp_counted_ptr() [deleting destructor]:
        sub     rsp, 8
        mov     esi, 24
        call    operator delete(void*, unsigned long)
        add     rsp, 8
        ret
std::_Sp_counted_ptr<CWorld*, (__gnu_cxx::_Lock_policy)2>::_M_destroy():
        sub     rsp, 8
        mov     esi, 24
        call    operator delete(void*, unsigned long)
        add     rsp, 8
        ret
CCarnivore::canEat(CAnimal const&) const:
        sub     rsp, 24
        mov     rdi, rsi
        mov     rcx, -1
        mov     edx, OFFSET FLAT:typeinfo for CHerbivore
        mov     esi, OFFSET FLAT:typeinfo for CAnimal
        call    __dynamic_cast
        test    rax, rax
        je      .L18
        mov     eax, 1
.L11:
        add     rsp, 24
        ret
.L18:
        call    __cxa_bad_cast
        mov     rdi, rax
        cmp     rdx, 1
        je      .L14
        call    _Unwind_Resume
.L14:
        mov     QWORD PTR [rsp+8], OFFSET FLAT:_ZTVSt8bad_cast+16
        call    __cxa_begin_catch
        lea     rdi, [rsp+8]
        call    std::bad_cast::~bad_cast() [complete object destructor]
        call    __cxa_end_catch
        mov     eax, 0
        jmp     .L11
COmnivore::canEat(CAnimal const&) const:
        push    rbp
        push    rbx
        sub     rsp, 24
        mov     rbp, rdi
        mov     rbx, rsi
        mov     rcx, -1
        mov     edx, OFFSET FLAT:typeinfo for COmnivore
        mov     esi, OFFSET FLAT:typeinfo for CAnimal
        mov     rdi, rbx
        call    __dynamic_cast
        test    rax, rax
        je      .L28
        mov     ebx, 0
.L19:
        mov     eax, ebx
        add     rsp, 24
        pop     rbx
        pop     rbp
        ret
.L28:
        call    __cxa_bad_cast
        mov     rdi, rax
        cmp     rdx, 1
        je      .L22
        call    _Unwind_Resume
.L22:
        mov     QWORD PTR [rsp+8], OFFSET FLAT:_ZTVSt8bad_cast+16
        call    __cxa_begin_catch
        lea     rdi, [rbp+8]
        mov     rsi, rbx
        call    CCarnivore::canEat(CAnimal const&) const
        mov     ebx, eax
        lea     rdi, [rsp+8]
        call    std::bad_cast::~bad_cast() [complete object destructor]
        call    __cxa_end_catch
        jmp     .L19
        mov     rbx, rax
        lea     rdi, [rsp+8]
        call    std::bad_cast::~bad_cast() [complete object destructor]
        call    __cxa_end_catch
        mov     rdi, rbx
        call    _Unwind_Resume
virtual thunk to CHerbivore::canEat(CAnimal const&) const:
        mov     eax, 0
        ret
.LC0:
        .string "new world decommissioned\n"
std::_Sp_counted_ptr<CWorld*, (__gnu_cxx::_Lock_policy)2>::_M_dispose():
        push    rbx
        mov     rbx, QWORD PTR [rdi+16]
        test    rbx, rbx
        je      .L30
        mov     edx, 25
        mov     esi, OFFSET FLAT:.LC0
        mov     edi, OFFSET FLAT:std::cout
        call    std::basic_ostream<char, std::char_traits<char> >& std::__ostream_insert<char, std::char_traits<char> >(std::basic_ostream<char, std::char_traits<char> >&, char const*, long)
        mov     rdi, QWORD PTR [rbx]
        test    rdi, rdi
        je      .L32
        mov     rsi, QWORD PTR [rbx+16]
        sub     rsi, rdi
        call    operator delete(void*, unsigned long)
.L32:
        mov     esi, 32
        mov     rdi, rbx
        call    operator delete(void*, unsigned long)
.L30:
        pop     rbx
        ret
std::shared_ptr<CWorld>::~shared_ptr() [base object destructor]:
        push    rbx
        mov     rbx, QWORD PTR [rdi+8]
        test    rbx, rbx
        je      .L34
        mov     eax, OFFSET FLAT:_ZL28__gthrw___pthread_key_createPjPFvPvE
        test    rax, rax
        jne     .L41
        mov     eax, DWORD PTR [rbx+8]
        lea     edx, [rax-1]
        mov     DWORD PTR [rbx+8], edx
.L37:
        cmp     eax, 1
        je      .L42
.L34:
        pop     rbx
        ret
.L41:
        mov     eax, -1
        lock xadd       DWORD PTR [rbx+8], eax
        jmp     .L37
.L42:
        mov     rax, QWORD PTR [rbx]
        mov     rdi, rbx
        call    [QWORD PTR [rax+16]]
        mov     eax, OFFSET FLAT:_ZL28__gthrw___pthread_key_createPjPFvPvE
        test    rax, rax
        jne     .L43
        mov     eax, DWORD PTR [rbx+12]
        lea     edx, [rax-1]
        mov     DWORD PTR [rbx+12], edx
.L39:
        cmp     eax, 1
        jne     .L34
        mov     rax, QWORD PTR [rbx]
        mov     rdi, rbx
        call    [QWORD PTR [rax+24]]
        jmp     .L34
.L43:
        mov     eax, -1
        lock xadd       DWORD PTR [rbx+12], eax
        jmp     .L39
virtual thunk to CCarnivore::canEat(CAnimal const&) const:
        sub     rsp, 24
        mov     rdi, rsi
        mov     rcx, -1
        mov     edx, OFFSET FLAT:typeinfo for CHerbivore
        mov     esi, OFFSET FLAT:typeinfo for CAnimal
        call    __dynamic_cast
        test    rax, rax
        je      .L51
        mov     eax, 1
.L44:
        add     rsp, 24
        ret
.L51:
        call    __cxa_bad_cast
        mov     rdi, rax
        cmp     rdx, 1
        je      .L47
        call    _Unwind_Resume
.L47:
        mov     QWORD PTR [rsp+8], OFFSET FLAT:_ZTVSt8bad_cast+16
        call    __cxa_begin_catch
        lea     rdi, [rsp+8]
        call    std::bad_cast::~bad_cast() [complete object destructor]
        call    __cxa_end_catch
        mov     eax, 0
        jmp     .L44
virtual thunk to COmnivore::canEat(CAnimal const&) const:
        push    r12
        push    rbp
        push    rbx
        sub     rsp, 16
        mov     rbp, rdi
        mov     rbx, rsi
        mov     rcx, -1
        mov     edx, OFFSET FLAT:typeinfo for COmnivore
        mov     esi, OFFSET FLAT:typeinfo for CAnimal
        mov     rdi, rbx
        call    __dynamic_cast
        test    rax, rax
        je      .L61
        mov     ebx, 0
.L52:
        mov     eax, ebx
        add     rsp, 16
        pop     rbx
        pop     rbp
        pop     r12
        ret
.L61:
        mov     rax, QWORD PTR [rbp+0]
        mov     r12, QWORD PTR [rax-24]
        call    __cxa_bad_cast
        mov     rdi, rax
        cmp     rdx, 1
        je      .L55
        call    _Unwind_Resume
.L55:
        mov     QWORD PTR [rsp+8], OFFSET FLAT:_ZTVSt8bad_cast+16
        call    __cxa_begin_catch
        lea     rdi, [r12+8+rbp]
        mov     rsi, rbx
        call    CCarnivore::canEat(CAnimal const&) const
        mov     ebx, eax
        lea     rdi, [rsp+8]
        call    std::bad_cast::~bad_cast() [complete object destructor]
        call    __cxa_end_catch
        jmp     .L52
        mov     rbx, rax
        lea     rdi, [rsp+8]
        call    std::bad_cast::~bad_cast() [complete object destructor]
        call    __cxa_end_catch
        mov     rdi, rbx
        call    _Unwind_Resume
non-virtual thunk to COmnivore::canEat(CAnimal const&) const:
        push    rbp
        push    rbx
        sub     rsp, 24
        mov     rbp, rdi
        mov     rbx, rsi
        mov     rcx, -1
        mov     edx, OFFSET FLAT:typeinfo for COmnivore
        mov     esi, OFFSET FLAT:typeinfo for CAnimal
        mov     rdi, rbx
        call    __dynamic_cast
        test    rax, rax
        je      .L71
        mov     ebx, 0
.L62:
        mov     eax, ebx
        add     rsp, 24
        pop     rbx
        pop     rbp
        ret
.L71:
        call    __cxa_bad_cast
        mov     rdi, rax
        cmp     rdx, 1
        je      .L65
        call    _Unwind_Resume
.L65:
        mov     QWORD PTR [rsp+8], OFFSET FLAT:_ZTVSt8bad_cast+16
        call    __cxa_begin_catch
        mov     rsi, rbx
        mov     rdi, rbp
        call    CCarnivore::canEat(CAnimal const&) const
        mov     ebx, eax
        lea     rdi, [rsp+8]
        call    std::bad_cast::~bad_cast() [complete object destructor]
        call    __cxa_end_catch
        jmp     .L62
        mov     rbx, rax
        lea     rdi, [rsp+8]
        call    std::bad_cast::~bad_cast() [complete object destructor]
        call    __cxa_end_catch
        mov     rdi, rbx
        call    _Unwind_Resume
.LC1:
        .string "generic animal: must be implemented"
CAnimal::canEat(CAnimal const&) const:
        push    rbx
        mov     edx, 35
        mov     esi, OFFSET FLAT:.LC1
        mov     edi, OFFSET FLAT:std::cout
        call    std::basic_ostream<char, std::char_traits<char> >& std::__ostream_insert<char, std::char_traits<char> >(std::basic_ostream<char, std::char_traits<char> >&, char const*, long)
        mov     rax, QWORD PTR std::cout[rip]
        mov     rax, QWORD PTR [rax-24]
        mov     rbx, QWORD PTR std::cout[rax+240]
        test    rbx, rbx
        je      .L77
        cmp     BYTE PTR [rbx+56], 0
        je      .L74
        movzx   esi, BYTE PTR [rbx+67]
.L75:
        movsx   esi, sil
        mov     edi, OFFSET FLAT:std::cout
        call    std::basic_ostream<char, std::char_traits<char> >::put(char)
        mov     rdi, rax
        call    std::basic_ostream<char, std::char_traits<char> >::flush()
        mov     eax, 0
        pop     rbx
        ret
.L77:
        call    std::__throw_bad_cast()
.L74:
        mov     rdi, rbx
        call    std::ctype<char>::_M_widen_init() const
        mov     rax, QWORD PTR [rbx]
        mov     esi, 10
        mov     rdi, rbx
        call    [QWORD PTR [rax+48]]
        mov     esi, eax
        jmp     .L75
.LC2:
        .string "world commissioned\n"
CWorld::getInstance():
        push    rbp
        push    rbx
        sub     rsp, 8
        movzx   eax, BYTE PTR guard variable for CWorld::getInstance()::instance[rip]
        test    al, al
        je      .L105
.L79:
        cmp     QWORD PTR CWorld::getInstance()::instance[rip], 0
        je      .L106
.L102:
        mov     eax, OFFSET FLAT:CWorld::getInstance()::instance
        add     rsp, 8
        pop     rbx
        pop     rbp
        ret
.L105:
        mov     edi, OFFSET FLAT:guard variable for CWorld::getInstance()::instance
        call    __cxa_guard_acquire
        test    eax, eax
        je      .L79
        mov     edi, OFFSET FLAT:guard variable for CWorld::getInstance()::instance
        call    __cxa_guard_release
        mov     edx, OFFSET FLAT:__dso_handle
        mov     esi, OFFSET FLAT:CWorld::getInstance()::instance
        mov     edi, OFFSET FLAT:_ZNSt10shared_ptrI6CWorldED1Ev
        call    __cxa_atexit
        jmp     .L79
.L106:
        mov     eax, OFFSET FLAT:_ZL28__gthrw___pthread_key_createPjPFvPvE
        test    rax, rax
        je      .L81
        mov     edi, OFFSET FLAT:_ZN6CWorld5m_mutE
        call    __gthrw_pthread_mutex_lock(pthread_mutex_t*)
        test    eax, eax
        jne     .L107
        cmp     QWORD PTR CWorld::getInstance()::instance[rip], 0
        je      .L81
.L83:
        mov     eax, OFFSET FLAT:_ZL28__gthrw___pthread_key_createPjPFvPvE
        test    rax, rax
        je      .L102
        mov     edi, OFFSET FLAT:_ZN6CWorld5m_mutE
        call    __gthrw_pthread_mutex_unlock(pthread_mutex_t*)
        jmp     .L102
.L107:
        mov     edi, eax
        call    std::__throw_system_error(int)
.L81:
        mov     edi, 32
        call    operator new(unsigned long)
        mov     rbx, rax
        mov     QWORD PTR [rax], 0
        mov     QWORD PTR [rax+8], 0
        mov     QWORD PTR [rax+16], 0
        mov     DWORD PTR [rax+24], 1000
        mov     edx, 19
        mov     esi, OFFSET FLAT:.LC2
        mov     edi, OFFSET FLAT:std::cout
        call    std::basic_ostream<char, std::char_traits<char> >& std::__ostream_insert<char, std::char_traits<char> >(std::basic_ostream<char, std::char_traits<char> >&, char const*, long)
        jmp     .L108
        mov     rbp, rax
        mov     rdi, QWORD PTR [rbx]
        mov     rsi, QWORD PTR [rbx+16]
        sub     rsi, rdi
        test    rdi, rdi
        je      .L86
        call    operator delete(void*, unsigned long)
.L86:
        mov     esi, 32
        mov     rdi, rbx
        call    operator delete(void*, unsigned long)
        mov     rbx, rbp
.L87:
        mov     eax, OFFSET FLAT:_ZL28__gthrw___pthread_key_createPjPFvPvE
        test    rax, rax
        je      .L97
        mov     edi, OFFSET FLAT:_ZN6CWorld5m_mutE
        call    __gthrw_pthread_mutex_unlock(pthread_mutex_t*)
.L97:
        mov     rdi, rbx
        call    _Unwind_Resume
.L108:
        mov     edi, 24
        call    operator new(unsigned long)
        mov     DWORD PTR [rax+8], 1
        mov     DWORD PTR [rax+12], 1
        mov     QWORD PTR [rax], OFFSET FLAT:vtable for std::_Sp_counted_ptr<CWorld*, (__gnu_cxx::_Lock_policy)2>+16
        mov     QWORD PTR [rax+16], rbx
        mov     QWORD PTR CWorld::getInstance()::instance[rip], rbx
        mov     rbx, QWORD PTR CWorld::getInstance()::instance[rip+8]
        mov     QWORD PTR CWorld::getInstance()::instance[rip+8], rax
        test    rbx, rbx
        je      .L83
        mov     eax, OFFSET FLAT:_ZL28__gthrw___pthread_key_createPjPFvPvE
        test    rax, rax
        jne     .L109
        mov     eax, DWORD PTR [rbx+8]
        lea     edx, [rax-1]
        mov     DWORD PTR [rbx+8], edx
.L94:
        cmp     eax, 1
        jne     .L83
        mov     rax, QWORD PTR [rbx]
        mov     rdi, rbx
        call    [QWORD PTR [rax+16]]
        mov     eax, OFFSET FLAT:_ZL28__gthrw___pthread_key_createPjPFvPvE
        test    rax, rax
        jne     .L110
        mov     eax, DWORD PTR [rbx+12]
        lea     edx, [rax-1]
        mov     DWORD PTR [rbx+12], edx
.L96:
        cmp     eax, 1
        jne     .L83
        mov     rax, QWORD PTR [rbx]
        mov     rdi, rbx
        call    [QWORD PTR [rax+24]]
        jmp     .L83
        mov     rdi, rax
        call    __cxa_begin_catch
        mov     edx, 25
        mov     esi, OFFSET FLAT:.LC0
        mov     edi, OFFSET FLAT:std::cout
        call    std::basic_ostream<char, std::char_traits<char> >& std::__ostream_insert<char, std::char_traits<char> >(std::basic_ostream<char, std::char_traits<char> >&, char const*, long)
        mov     rdi, QWORD PTR [rbx]
        mov     rsi, QWORD PTR [rbx+16]
        sub     rsi, rdi
        test    rdi, rdi
        je      .L91
        call    operator delete(void*, unsigned long)
.L91:
        mov     esi, 32
        mov     rdi, rbx
        call    operator delete(void*, unsigned long)
        call    __cxa_rethrow
        mov     rbx, rax
        call    __cxa_end_catch
        jmp     .L87
.L109:
        mov     eax, -1
        lock xadd       DWORD PTR [rbx+8], eax
        jmp     .L94
.L110:
        mov     eax, -1
        lock xadd       DWORD PTR [rbx+12], eax
        jmp     .L96
        mov     rbx, rax
        jmp     .L87

.LC3:
        .string "vector::_M_realloc_insert"
void std::vector<CAnimal*, std::allocator<CAnimal*> >::_M_realloc_insert<CAnimal* const&>(__gnu_cxx::__normal_iterator<CAnimal**, std::vector<CAnimal*, std::allocator<CAnimal*> > >, CAnimal* const&):
        push    r15
        push    r14
        push    r13
        push    r12
        push    rbp
        push    rbx
        sub     rsp, 24
        mov     QWORD PTR [rsp], rsi
        mov     QWORD PTR [rsp+8], rdx
        mov     r12, QWORD PTR [rdi+8]
        mov     r13, QWORD PTR [rdi]
        mov     rax, r12
        sub     rax, r13
        sar     rax, 3
        mov     rcx, rax
        movabs  rax, 1152921504606846975
        cmp     rcx, rax
        je      .L126
        mov     rbx, rdi
        test    rcx, rcx
        mov     edx, 1
        mov     rax, rdx
        cmovne  rax, rcx
        add     rax, rcx
        jc      .L113
        movabs  r14, 1152921504606846975
        cmp     rax, r14
        cmovbe  r14, rax
        mov     r15, QWORD PTR [rsp]
        sub     r15, r13
        mov     ebp, 0
        test    rax, rax
        je      .L114
        jmp     .L121
.L126:
        mov     edi, OFFSET FLAT:.LC3
        call    std::__throw_length_error(char const*)
.L127:
        mov     rdx, r15
        mov     rsi, r13
        mov     rdi, rbp
        call    memmove
        lea     r15, [rbp+8+r15]
        sub     r12, QWORD PTR [rsp]
        test    r12, r12
        jg      .L116
        add     r12, r15
        mov     rsi, QWORD PTR [rbx+16]
        sub     rsi, r13
        jmp     .L120
.L113:
        mov     r15, QWORD PTR [rsp]
        sub     r15, r13
        movabs  r14, 1152921504606846975
.L121:
        lea     rdi, [0+r14*8]
        call    operator new(unsigned long)
        mov     rbp, rax
.L114:
        mov     rax, QWORD PTR [rsp+8]
        mov     rax, QWORD PTR [rax]
        mov     QWORD PTR [rbp+0+r15], rax
        test    r15, r15
        jg      .L127
        lea     r15, [rbp+8+r15]
        sub     r12, QWORD PTR [rsp]
        test    r12, r12
        jle     .L118
.L116:
        mov     rdx, r12
        mov     rsi, QWORD PTR [rsp]
        mov     rdi, r15
        call    memcpy
.L118:
        add     r12, r15
        test    r13, r13
        je      .L119
        mov     rsi, QWORD PTR [rbx+16]
        sub     rsi, r13
.L120:
        mov     rdi, r13
        call    operator delete(void*, unsigned long)
.L119:
        mov     QWORD PTR [rbx], rbp
        mov     QWORD PTR [rbx+8], r12
        lea     rax, [rbp+0+r14*8]
        mov     QWORD PTR [rbx+16], rax
        add     rsp, 24
        pop     rbx
        pop     rbp
        pop     r12
        pop     r13
        pop     r14
        pop     r15
        ret
COmnivore& CWorld::spawn<COmnivore>():
        push    rbx
        sub     rsp, 16
        mov     rbx, rdi
        mov     edi, 48
        call    operator new(unsigned long)
        mov     QWORD PTR [rax+24], 0
        mov     QWORD PTR [rax+32], 0
        mov     QWORD PTR [rax+40], 0
        mov     BYTE PTR [rax+28], 1
        mov     DWORD PTR [rax+32], 0x3f800000
        mov     QWORD PTR [rax], OFFSET FLAT:vtable for COmnivore+24
        mov     QWORD PTR [rax+16], OFFSET FLAT:vtable for COmnivore+96
        mov     QWORD PTR [rax+8], OFFSET FLAT:vtable for COmnivore+56
        add     rax, 16
        mov     QWORD PTR [rsp+8], rax
        mov     rsi, QWORD PTR [rbx+8]
        cmp     rsi, QWORD PTR [rbx+16]
        je      .L129
        mov     QWORD PTR [rsi], rax
        add     QWORD PTR [rbx+8], 8
.L130:
        mov     rax, QWORD PTR [rbx+8]
        mov     rax, QWORD PTR [rax-8]
        test    rax, rax
        je      .L128
        mov     rcx, -1
        mov     edx, OFFSET FLAT:typeinfo for COmnivore
        mov     esi, OFFSET FLAT:typeinfo for CAnimal
        mov     rdi, rax
        call    __dynamic_cast
.L128:
        add     rsp, 16
        pop     rbx
        ret
.L129:
        lea     rdx, [rsp+8]
        mov     rdi, rbx
        call    void std::vector<CAnimal*, std::allocator<CAnimal*> >::_M_realloc_insert<CAnimal* const&>(__gnu_cxx::__normal_iterator<CAnimal**, std::vector<CAnimal*, std::allocator<CAnimal*> > >, CAnimal* const&)
        jmp     .L130
CHerbivore& CWorld::spawn<CHerbivore>():
        push    rbx
        sub     rsp, 16
        mov     rbx, rdi
        mov     edi, 40
        call    operator new(unsigned long)
        mov     QWORD PTR [rax+16], 0
        mov     QWORD PTR [rax+24], 0
        mov     QWORD PTR [rax+32], 0
        mov     BYTE PTR [rax+20], 1
        mov     DWORD PTR [rax+24], 0x3f800000
        mov     QWORD PTR [rax], OFFSET FLAT:vtable for CHerbivore+24
        mov     QWORD PTR [rax+8], OFFSET FLAT:vtable for CHerbivore+64
        add     rax, 8
        mov     QWORD PTR [rsp+8], rax
        mov     rsi, QWORD PTR [rbx+8]
        cmp     rsi, QWORD PTR [rbx+16]
        je      .L134
        mov     QWORD PTR [rsi], rax
        add     QWORD PTR [rbx+8], 8
.L135:
        mov     rax, QWORD PTR [rbx+8]
        mov     rax, QWORD PTR [rax-8]
        test    rax, rax
        je      .L133
        mov     rcx, -1
        mov     edx, OFFSET FLAT:typeinfo for CHerbivore
        mov     esi, OFFSET FLAT:typeinfo for CAnimal
        mov     rdi, rax
        call    __dynamic_cast
.L133:
        add     rsp, 16
        pop     rbx
        ret
.L134:
        lea     rdx, [rsp+8]
        mov     rdi, rbx
        call    void std::vector<CAnimal*, std::allocator<CAnimal*> >::_M_realloc_insert<CAnimal* const&>(__gnu_cxx::__normal_iterator<CAnimal**, std::vector<CAnimal*, std::allocator<CAnimal*> > >, CAnimal* const&)
        jmp     .L135
CCarnivore& CWorld::spawn<CCarnivore>():
        push    rbx
        sub     rsp, 16
        mov     rbx, rdi
        mov     edi, 40
        call    operator new(unsigned long)
        mov     QWORD PTR [rax+16], 0
        mov     QWORD PTR [rax+24], 0
        mov     QWORD PTR [rax+32], 0
        mov     BYTE PTR [rax+20], 1
        mov     DWORD PTR [rax+24], 0x3f800000
        mov     QWORD PTR [rax], OFFSET FLAT:vtable for CCarnivore+24
        mov     QWORD PTR [rax+8], OFFSET FLAT:vtable for CCarnivore+64
        add     rax, 8
        mov     QWORD PTR [rsp+8], rax
        mov     rsi, QWORD PTR [rbx+8]
        cmp     rsi, QWORD PTR [rbx+16]
        je      .L139
        mov     QWORD PTR [rsi], rax
        add     QWORD PTR [rbx+8], 8
.L140:
        mov     rax, QWORD PTR [rbx+8]
        mov     rax, QWORD PTR [rax-8]
        test    rax, rax
        je      .L138
        mov     rcx, -1
        mov     edx, OFFSET FLAT:typeinfo for CCarnivore
        mov     esi, OFFSET FLAT:typeinfo for CAnimal
        mov     rdi, rax
        call    __dynamic_cast
.L138:
        add     rsp, 16
        pop     rbx
        ret
.L139:
        lea     rdx, [rsp+8]
        mov     rdi, rbx
        call    void std::vector<CAnimal*, std::allocator<CAnimal*> >::_M_realloc_insert<CAnimal* const&>(__gnu_cxx::__normal_iterator<CAnimal**, std::vector<CAnimal*, std::allocator<CAnimal*> > >, CAnimal* const&)
        jmp     .L140
main:
        push    r13
        push    r12
        push    rbp
        push    rbx
        sub     rsp, 8
        call    CWorld::getInstance()
        mov     rbx, QWORD PTR [rax]
        mov     rdi, rbx
        call    CHerbivore& CWorld::spawn<CHerbivore>()
        mov     rdi, rbx
        call    CCarnivore& CWorld::spawn<CCarnivore>()
        mov     rdi, rbx
        call    COmnivore& CWorld::spawn<COmnivore>()
        mov     r12, QWORD PTR [rbx]
        mov     r13, QWORD PTR [rbx+8]
        cmp     r12, r13
        jne     .L148
.L144:
        mov     eax, 0
        add     rsp, 8
        pop     rbx
        pop     rbp
        pop     r12
        pop     r13
        ret
.L151:
        call    std::__throw_bad_cast()
.L146:
        mov     rdi, rbp
        call    std::ctype<char>::_M_widen_init() const
        mov     rax, QWORD PTR [rbp+0]
        mov     esi, 10
        mov     rdi, rbp
        call    [QWORD PTR [rax+48]]
        mov     esi, eax
.L147:
        movsx   esi, sil
        mov     rdi, rbx
        call    std::basic_ostream<char, std::char_traits<char> >::put(char)
        mov     rdi, rax
        call    std::basic_ostream<char, std::char_traits<char> >::flush()
        add     r12, 8
        cmp     r13, r12
        je      .L144
.L148:
        mov     rax, QWORD PTR [r12]
        mov     esi, DWORD PTR [rax+8]
        mov     edi, OFFSET FLAT:std::cout
        call    std::basic_ostream<char, std::char_traits<char> >::operator<<(int)
        mov     rbx, rax
        mov     rax, QWORD PTR [rax]
        mov     rax, QWORD PTR [rax-24]
        mov     rbp, QWORD PTR [rbx+240+rax]
        test    rbp, rbp
        je      .L151
        cmp     BYTE PTR [rbp+56], 0
        je      .L146
        movzx   esi, BYTE PTR [rbp+67]
        jmp     .L147
_GLOBAL__sub_I_CAnimal::canEat(CAnimal const&) const:
        sub     rsp, 8
        mov     edi, OFFSET FLAT:_ZStL8__ioinit
        call    std::ios_base::Init::Init() [complete object constructor]
        mov     edx, OFFSET FLAT:__dso_handle
        mov     esi, OFFSET FLAT:_ZStL8__ioinit
        mov     edi, OFFSET FLAT:_ZNSt8ios_base4InitD1Ev
        call    __cxa_atexit
        add     rsp, 8
        ret
typeinfo name for std::_Mutex_base<(__gnu_cxx::_Lock_policy)2>:
        .string "St11_Mutex_baseILN9__gnu_cxx12_Lock_policyE2EE"
typeinfo for std::_Mutex_base<(__gnu_cxx::_Lock_policy)2>:
        .quad   vtable for __cxxabiv1::__class_type_info+16
        .quad   typeinfo name for std::_Mutex_base<(__gnu_cxx::_Lock_policy)2>
typeinfo name for std::_Sp_counted_base<(__gnu_cxx::_Lock_policy)2>:
        .string "St16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE"
typeinfo for std::_Sp_counted_base<(__gnu_cxx::_Lock_policy)2>:
        .quad   vtable for __cxxabiv1::__si_class_type_info+16
        .quad   typeinfo name for std::_Sp_counted_base<(__gnu_cxx::_Lock_policy)2>
        .quad   typeinfo for std::_Mutex_base<(__gnu_cxx::_Lock_policy)2>
typeinfo name for CAnimal:
        .string "7CAnimal"
typeinfo for CAnimal:
        .quad   vtable for __cxxabiv1::__class_type_info+16
        .quad   typeinfo name for CAnimal
typeinfo name for CHerbivore:
        .string "10CHerbivore"
typeinfo for CHerbivore:
        .quad   vtable for __cxxabiv1::__vmi_class_type_info+16
        .quad   typeinfo name for CHerbivore
        .long   0
        .long   1
        .quad   typeinfo for CAnimal
        .quad   -6141
typeinfo name for CCarnivore:
        .string "10CCarnivore"
typeinfo for CCarnivore:
        .quad   vtable for __cxxabiv1::__vmi_class_type_info+16
        .quad   typeinfo name for CCarnivore
        .long   0
        .long   1
        .quad   typeinfo for CAnimal
        .quad   -6141
typeinfo name for COmnivore:
        .string "9COmnivore"
typeinfo for COmnivore:
        .quad   vtable for __cxxabiv1::__vmi_class_type_info+16
        .quad   typeinfo name for COmnivore
        .long   2
        .long   2
        .quad   typeinfo for CHerbivore
        .quad   2
        .quad   typeinfo for CCarnivore
        .quad   2050
typeinfo name for std::_Sp_counted_ptr<CWorld*, (__gnu_cxx::_Lock_policy)2>:
        .string "St15_Sp_counted_ptrIP6CWorldLN9__gnu_cxx12_Lock_policyE2EE"
typeinfo for std::_Sp_counted_ptr<CWorld*, (__gnu_cxx::_Lock_policy)2>:
        .quad   vtable for __cxxabiv1::__si_class_type_info+16
        .quad   typeinfo name for std::_Sp_counted_ptr<CWorld*, (__gnu_cxx::_Lock_policy)2>
        .quad   typeinfo for std::_Sp_counted_base<(__gnu_cxx::_Lock_policy)2>
VTT for CHerbivore:
        .quad   vtable for CHerbivore+24
        .quad   vtable for CHerbivore+64
vtable for CHerbivore:
        .quad   8
        .quad   0
        .quad   typeinfo for CHerbivore
        .quad   CHerbivore::canEat(CAnimal const&) const
        .quad   0
        .quad   -8
        .quad   -8
        .quad   typeinfo for CHerbivore
        .quad   virtual thunk to CHerbivore::canEat(CAnimal const&) const
        .quad   CAnimal::eat(CAnimal&)
VTT for CCarnivore:
        .quad   vtable for CCarnivore+24
        .quad   vtable for CCarnivore+64
vtable for CCarnivore:
        .quad   8
        .quad   0
        .quad   typeinfo for CCarnivore
        .quad   CCarnivore::canEat(CAnimal const&) const
        .quad   0
        .quad   -8
        .quad   -8
        .quad   typeinfo for CCarnivore
        .quad   virtual thunk to CCarnivore::canEat(CAnimal const&) const
        .quad   CAnimal::eat(CAnimal&)
construction vtable for CCarnivore-in-COmnivore:
        .quad   8
        .quad   0
        .quad   typeinfo for CCarnivore
        .quad   CCarnivore::canEat(CAnimal const&) const
        .quad   0
        .quad   -8
        .quad   -8
        .quad   typeinfo for CCarnivore
        .quad   virtual thunk to CCarnivore::canEat(CAnimal const&) const
        .quad   CAnimal::eat(CAnimal&)
construction vtable for CHerbivore-in-COmnivore:
        .quad   16
        .quad   0
        .quad   typeinfo for CHerbivore
        .quad   CHerbivore::canEat(CAnimal const&) const
        .quad   0
        .quad   -16
        .quad   -16
        .quad   typeinfo for CHerbivore
        .quad   virtual thunk to CHerbivore::canEat(CAnimal const&) const
        .quad   CAnimal::eat(CAnimal&)
VTT for COmnivore:
        .quad   vtable for COmnivore+24
        .quad   construction vtable for CHerbivore-in-COmnivore+24
        .quad   construction vtable for CHerbivore-in-COmnivore+64
        .quad   construction vtable for CCarnivore-in-COmnivore+24
        .quad   construction vtable for CCarnivore-in-COmnivore+64
        .quad   vtable for COmnivore+96
        .quad   vtable for COmnivore+56
vtable for COmnivore:
        .quad   16
        .quad   0
        .quad   typeinfo for COmnivore
        .quad   COmnivore::canEat(CAnimal const&) const
        .quad   8
        .quad   -8
        .quad   typeinfo for COmnivore
        .quad   non-virtual thunk to COmnivore::canEat(CAnimal const&) const
        .quad   0
        .quad   -16
        .quad   -16
        .quad   typeinfo for COmnivore
        .quad   virtual thunk to COmnivore::canEat(CAnimal const&) const
        .quad   CAnimal::eat(CAnimal&)
vtable for std::_Sp_counted_ptr<CWorld*, (__gnu_cxx::_Lock_policy)2>:
        .quad   0
        .quad   typeinfo for std::_Sp_counted_ptr<CWorld*, (__gnu_cxx::_Lock_policy)2>
        .quad   std::_Sp_counted_ptr<CWorld*, (__gnu_cxx::_Lock_policy)2>::~_Sp_counted_ptr() [complete object destructor]
        .quad   std::_Sp_counted_ptr<CWorld*, (__gnu_cxx::_Lock_policy)2>::~_Sp_counted_ptr() [deleting destructor]
        .quad   std::_Sp_counted_ptr<CWorld*, (__gnu_cxx::_Lock_policy)2>::_M_dispose()
        .quad   std::_Sp_counted_ptr<CWorld*, (__gnu_cxx::_Lock_policy)2>::_M_destroy()
        .quad   std::_Sp_counted_ptr<CWorld*, (__gnu_cxx::_Lock_policy)2>::_M_get_deleter(std::type_info const&)
guard variable for CWorld::getInstance()::instance:
        .zero   8
CWorld::getInstance()::instance:
        .zero   16
