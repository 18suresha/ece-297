	.text
	.file	"sys_call.c"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	leaq	-40(%rbp), %rax
	leaq	-32(%rbp), %rsi
	xorl	%ecx, %ecx
	movabsq	$.L.str, %rdx
	movq	%rdx, -8(%rbp)
	movq	-8(%rbp), %rdx
	movq	%rdx, -32(%rbp)
	movq	$0, -24(%rbp)
	movq	%rax, %rdx
	movq	%rdx, %rdi
	movq	%rsi, -48(%rbp)         # 8-byte Spill
	movl	%ecx, %esi
	movl	$8, %edx
	movq	%rax, -56(%rbp)         # 8-byte Spill
	callq	memset
	movq	-8(%rbp), %rdi
	movq	-48(%rbp), %rsi         # 8-byte Reload
	movq	-56(%rbp), %rdx         # 8-byte Reload
	callq	execve
	xorl	%ecx, %ecx
	movl	%eax, -60(%rbp)         # 4-byte Spill
	movl	%ecx, %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"/bin/ls"
	.size	.L.str, 8

	.ident	"clang version 10.0.0-4ubuntu1~18.04.2 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym execve
