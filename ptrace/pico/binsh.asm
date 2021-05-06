section .text
	global _start   
 
_start:
	xor rax,rax
	mov rdx,rax
	mov rsi,rax	
	lea rdi, [rel msg]

	mov rax, 0x3b ; syscall for execve

	syscall
	msg db '/bin/sh',0 
	
; nasm -f elf64 -o binsh.o binsh.asm
; ld -o binsh binsh.o
; https://0x00sec.org/t/linux-infecting-running-processes/1097
