# *********************************************************************************
# * Program name: Hello World                                                     *
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
    exit: jmp _exit
#endif

.text
    mystring : .asciz "Tomas Schuster and Ties Schasfoort. Lab Group 211. Assignment 1. \n " # format string that will be printed to terminal

.global my_main #make my_main accessible globally

my_main:
    pushq %rbp   # push value of base pointer onto stack, so that it is saved and can be returned to
    movq %rsp , %rbp  # the base pointer register(rbp) is updated to point to the base of the current stack frame
    movq $0 , %rax # no vector registers in use for printf, 0 is replacing contents of rax to clear it.
    leaq mystring(%rip), %rdi # load address of the string into rdi
    call printf # Call the printf routine  
end:
	mov     $0, %rdi            # load program exit code
	call    exit                # exit the program