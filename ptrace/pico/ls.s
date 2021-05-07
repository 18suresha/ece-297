.section .data

    name: .string "/bin/ls"

.section .text

.globl _start

_start:
    # set envp to NULL
    xor %rdx, %rdx 

    # NULL acts as argv array terminator
    pushq %rdx 

    # rdi is file name
    leaq name, %rdi


    # file name is also argv[0]
    push %rdi

    # set argv to point to top of stack as NULL and file name were pushed (acts as NULL-terminated array)
    mov %rsp, %rsi

    # 59 is syscall number for execve 
    movq $59, %rax 
    syscall

# gcc -nostdlib -static ls.s -o ls
# https://stackoverflow.com/questions/47897025/assembly-execve-bin-bash-x64
