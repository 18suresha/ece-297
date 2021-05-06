section .text
	global _start   
 
_start:
	xor rax,rax
	mov rdx,rax 		; No Env
	lea rsi,[argv]		
	lea rdi, [rel msg]

	add al, 0x3b

	syscall
	msg db '/usr/bin/ssh',0 
	argv0 db '/usr/bin/ssh',0
	argv1 db 'adarshs3@linux-a3.ews.illinois.edu',0
	argv: dq argv0, argv1
	
; nasm -f elf64 -o ssh.o ssh.asm
; ld -o ssh ssh.o