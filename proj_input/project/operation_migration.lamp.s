	.file	"<stdin>"
	.text
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%r14
.Ltmp3:
	.cfi_def_cfa_offset 16
	pushq	%rbx
.Ltmp4:
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
.Ltmp5:
	.cfi_def_cfa_offset 48
.Ltmp6:
	.cfi_offset %rbx, -24
.Ltmp7:
	.cfi_offset %r14, -16
	movl	$16, %edi
	xorl	%esi, %esi
	movl	$1, %edx
	xorl	%ecx, %ecx
	callq	LAMP_init
	leaq	20(%rsp), %rsi
	xorl	%edi, %edi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 20(%rsp)
	leaq	16(%rsp), %rsi
	movl	$1, %edi
	xorl	%edx, %edx
	callq	LAMP_store4
	leaq	8(%rsp), %r14
	movl	$0, 16(%rsp)
	movl	$2, %edi
	movq	%r14, %rsi
	movl	$10, %edx
	callq	LAMP_store4
	movl	$10, 8(%rsp)
	movl	$3, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	leaq	12(%rsp), %rsi
	movl	8(%rsp), %eax
	addl	$10, %eax
	movslq	%eax, %rbx
	movl	$4, %edi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 12(%rsp)
	movl	$5, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	cmpl	$0, 8(%rsp)
	je	.LBB0_1
# BB#2:                                 # %if.else
	leaq	8(%rsp), %rsi
	movl	$8, %edi
	callq	LAMP_load4
	movl	8(%rsp), %eax
	imull	$20, %eax, %eax
	movslq	%eax, %rbx
	leaq	16(%rsp), %rsi
	movl	$9, %edi
	jmp	.LBB0_3
.LBB0_1:                                # %if.then
	leaq	8(%rsp), %rsi
	movl	$6, %edi
	callq	LAMP_load4
	movl	8(%rsp), %eax
	imull	$10, %eax, %eax
	movslq	%eax, %rbx
	leaq	16(%rsp), %rsi
	movl	$7, %edi
.LBB0_3:                                # %if.else
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 16(%rsp)
	movl	$10, %edi
	callq	LAMP_register
	xorb	%al, %al
	callq	rand
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%eax, %ecx
	andl	$-2, %ecx
	leaq	12(%rsp), %rsi
	subl	%ecx, %eax
	je	.LBB0_4
# BB#5:                                 # %if.else5
	movl	$13, %edi
	callq	LAMP_load4
	movl	12(%rsp), %ebx
	movl	$14, %edi
	callq	LAMP_register
	movl	$.L.str1, %edi
	jmp	.LBB0_6
.LBB0_4:                                # %if.then3
	movl	$11, %edi
	callq	LAMP_load4
	movl	12(%rsp), %ebx
	movl	$12, %edi
	callq	LAMP_register
	movl	$.L.str, %edi
.LBB0_6:                                # %if.else5
	movl	%ebx, %esi
	xorb	%al, %al
	callq	printf
	leaq	20(%rsp), %rsi
	movl	$15, %edi
	callq	LAMP_load4
	movl	20(%rsp), %eax
	addq	$24, %rsp
	popq	%rbx
	popq	%r14
	ret
.Ltmp8:
	.size	main, .Ltmp8-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	 "%d"
	.size	.L.str, 3

	.type	.L.str1,@object         # @.str1
.L.str1:
	.asciz	 "In else: %d"
	.size	.L.str1, 12


	.section	".note.GNU-stack","",@progbits
