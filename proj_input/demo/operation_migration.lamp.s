	.file	"<stdin>"
	.text
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Ltmp4:
	.cfi_def_cfa_offset 16
	pushq	%r14
.Ltmp5:
	.cfi_def_cfa_offset 24
	pushq	%rbx
.Ltmp6:
	.cfi_def_cfa_offset 32
	subq	$16, %rsp
.Ltmp7:
	.cfi_def_cfa_offset 48
.Ltmp8:
	.cfi_offset %rbx, -32
.Ltmp9:
	.cfi_offset %r14, -24
.Ltmp10:
	.cfi_offset %rbp, -16
	movl	$17, %edi
	xorl	%esi, %esi
	movl	$1, %edx
	xorl	%ecx, %ecx
	callq	LAMP_init
	leaq	12(%rsp), %rsi
	xorl	%edi, %edi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 12(%rsp)
	leaq	8(%rsp), %rsi
	movl	$1, %edi
	xorl	%edx, %edx
	callq	LAMP_store4
	leaq	(%rsp), %r14
	movl	$0, 8(%rsp)
	movl	$2, %edi
	movq	%r14, %rsi
	movl	$10, %edx
	callq	LAMP_store4
	movl	$10, (%rsp)
	movl	$3, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	leaq	4(%rsp), %rsi
	movl	(%rsp), %eax
	addl	$10, %eax
	movslq	%eax, %rbx
	movl	$4, %edi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 4(%rsp)
	movl	$5, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	cmpl	$0, (%rsp)
	je	.LBB0_1
# BB#2:                                 # %if.else
	leaq	(%rsp), %rsi
	movl	$8, %edi
	callq	LAMP_load4
	movl	(%rsp), %eax
	imull	$20, %eax, %eax
	movslq	%eax, %rbx
	leaq	8(%rsp), %rsi
	movl	$9, %edi
	jmp	.LBB0_3
.LBB0_1:                                # %if.then
	leaq	(%rsp), %rsi
	movl	$6, %edi
	callq	LAMP_load4
	movl	(%rsp), %eax
	imull	$10, %eax, %eax
	movslq	%eax, %rbx
	leaq	8(%rsp), %rsi
	movl	$7, %edi
.LBB0_3:                                # %if.else
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 8(%rsp)
	movl	$10, %edi
	callq	LAMP_register
	xorb	%al, %al
	callq	rand
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%eax, %ecx
	andl	$-2, %ecx
	subl	%ecx, %eax
	je	.LBB0_4
# BB#5:                                 # %if.else5
	leaq	8(%rsp), %rsi
	movl	$13, %edi
	callq	LAMP_load4
	movl	8(%rsp), %ebx
	leaq	4(%rsp), %rsi
	movl	$14, %edi
	callq	LAMP_load4
	movl	4(%rsp), %ebp
	movl	$15, %edi
	callq	LAMP_register
	movl	$.L.str1, %edi
	movl	%ebx, %esi
	movl	%ebp, %edx
	xorb	%al, %al
	callq	printf
	jmp	.LBB0_6
.LBB0_4:                                # %if.then3
	leaq	4(%rsp), %rsi
	movl	$11, %edi
	callq	LAMP_load4
	movl	4(%rsp), %ebx
	movl	$12, %edi
	callq	LAMP_register
	movl	$.L.str, %edi
	movl	%ebx, %esi
	xorb	%al, %al
	callq	printf
.LBB0_6:                                # %if.end7
	leaq	12(%rsp), %rsi
	movl	$16, %edi
	callq	LAMP_load4
	movl	12(%rsp), %eax
	addq	$16, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	ret
.Ltmp11:
	.size	main, .Ltmp11-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	 "%d"
	.size	.L.str, 3

	.type	.L.str1,@object         # @.str1
.L.str1:
	.asciz	 "In else: %d,%d"
	.size	.L.str1, 15


	.section	".note.GNU-stack","",@progbits
