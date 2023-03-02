# *********************************************************************************
# * Program name: inout                                                           *
# * Description :                                                                 *
# *********************************************************************************

#ifndef MACOS
.ifndef CODEGRADE
    .global main
    main: jmp my_main
.endif
#else
    .global _main
    _main: jmp my_main
    printf: jmp _printf
    scanf: jmp _scanf
    exit: jmp _exit
#endif

.text
    mystring : .asciz "Assignment 2: inout \n " # format string that will be printed to terminal
    formatstr : .asciz "%ld"            # string that is entered, value of scanf
.global my_main                         # make my_main accessible globally
.global my_increment                    # make my_increment accessible globally

my_main:
        # set up the stack frame
        
        pushq %rbp   # push value of base pointer onto stack, so that it is saved and can be returned to
        movq %rsp , %rbp  # the base pointer register(rbp) is updated to point to the base of the current stack frame
        movq $0 , %rax # no vector registers in use for printf, 0 is replacing contents of rax to clear it.
        leaq mystring(%rip), %rdi # load address of the string into rdi
        call printf
        
        call    inout                

        # clear the stack and return
inout:
        # read input and increment it using my_increment
        
        subq $8 , %rsp # Reserve stack space for variable
        leaq -8(%rbp) , %rsi # Load address of stack var in rsi
        leaq formatstr (%rip) , %rdi # l o a d f i r s t argument o f s c a n f
        movq $0 , %rax # no vector registers for scanf
        call scanf
        
        # call    my_increment

        # output incremented number

my_increment:
        # IMPLEMENT ME
end:
	mov     $0, %rdi            # load program exit code
	call    exit 