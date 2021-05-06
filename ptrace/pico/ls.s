.section .data

    name: .string "/bin/ls"

.section .text

.globl _start

_start:
    # third argument of execve is envp, set to NULL
    xor %rdx, %rdx 

    # push NULL to the stack, argv terminator
    pushq %rdx 

    # first argument to execve is the file name
    leaq name, %rdi


    # also argv[0]
    push %rdi

    # second argument to execve is argv
    mov %rsp, %rsi

    # 59 is syscall number for execve 
    movq $59, %rax 
    syscall

# gcc -nostdlib -static ls.s -o ls
# https://stackoverflow.com/questions/47897025/assembly-execve-bin-bash-x64
