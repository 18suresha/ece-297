section .data
	msg db "Injection ;)" ; const
	len equ $-msg

section .text
	global _start  

_start:
	
	mov rax,0 ; syscall for write
	mov rdi,1 ; stdout 
	mov rsi,msg ; what to print
	mov rdx,len
	syscall

	

	mov rax,60          ;system call number (sys_exit)
    xor rdi,rdi         ;clear destination index register
    syscall             ;call kernel

end:
	
; nasm -f elf64 -o inject_shellcode.o inject_shellcode.asm
; ld -o inject_shellcode inject_shellcode.o
