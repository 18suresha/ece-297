section .text
	global _start   
 
_start:
	xor rax,rax
	mov rdx,rax 		; No Env
	lea rsi,[argv]		
	lea rdi, [rel msg]

	add al, 0x3b

	syscall
	msg db '/bin/ls',0 
	argv0 db '/bin/ls',0
	argv: dq argv0
	
; nasm -f elf64 -o ls.o ls.asm
; ld -o ls ls.o