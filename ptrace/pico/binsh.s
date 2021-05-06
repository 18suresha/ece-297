.section .data
    name: .string "/bin/sh"

.section .text

.globl _start

_start:
    # third argument of execve is envp, set to NULL
    xor %rdx, %rdx 
    xor %rsi, %rsi 

    # first argument to execve is the file name
    leaq name, %rdi

    #copy 59 to rax, defining syscall number for execve  
    movq $59, %rax 
    syscall
