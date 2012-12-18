	.file	"<stdin>"
	.text
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Ltmp7:
	.cfi_def_cfa_offset 16
	pushq	%r15
.Ltmp8:
	.cfi_def_cfa_offset 24
	pushq	%r14
.Ltmp9:
	.cfi_def_cfa_offset 32
	pushq	%r13
.Ltmp10:
	.cfi_def_cfa_offset 40
	pushq	%r12
.Ltmp11:
	.cfi_def_cfa_offset 48
	pushq	%rbx
.Ltmp12:
	.cfi_def_cfa_offset 56
	subq	$40, %rsp
.Ltmp13:
	.cfi_def_cfa_offset 96
.Ltmp14:
	.cfi_offset %rbx, -56
.Ltmp15:
	.cfi_offset %r12, -48
.Ltmp16:
	.cfi_offset %r13, -40
.Ltmp17:
	.cfi_offset %r14, -32
.Ltmp18:
	.cfi_offset %r15, -24
.Ltmp19:
	.cfi_offset %rbp, -16
	movq	%rsi, %r12
	movl	%edi, %ebp
	movl	$29, %edi
	movl	$1, %esi
	movl	$1, %edx
	xorl	%ecx, %ecx
	callq	LAMP_init
	leaq	36(%rsp), %rsi
	xorl	%edi, %edi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 36(%rsp)
	movslq	%ebp, %rbx
	leaq	32(%rsp), %rsi
	movl	$1, %edi
	movq	%rbx, %rdx
	callq	LAMP_store4
	leaq	24(%rsp), %r15
	movl	%ebx, 32(%rsp)
	movl	$2, %edi
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	LAMP_store8
	leaq	20(%rsp), %r14
	movq	%r12, 24(%rsp)
	movl	$3, %edi
	movq	%r14, %rsi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 20(%rsp)
	movl	$4, %edi
	movq	%r15, %rsi
	callq	LAMP_load8
	movq	24(%rsp), %rbx
	leaq	8(%rbx), %rsi
	movl	$5, %edi
	callq	LAMP_load8
	movq	8(%rbx), %rbx
	movl	$6, %edi
	callq	LAMP_register
	movq	%rbx, %rdi
	xorb	%al, %al
	callq	atoi
	leaq	12(%rsp), %r15
	movslq	%eax, %rbx
	movl	$7, %edi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	leaq	8(%rsp), %rsi
	movl	%ebx, 12(%rsp)
	movl	$8, %edi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 8(%rsp)
	movl	$9, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	leaq	4(%rsp), %r13
	movl	12(%rsp), %eax
	addl	$10, %eax
	movslq	%eax, %r12
	movl	$10, %edi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	LAMP_store4
	leaq	(%rsp), %r15
	movl	%r12d, 4(%rsp)
	movl	$11, %edi
	movq	%r15, %rsi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, (%rsp)
	movl	$29, %edi
	callq	LAMP_loop_invocation
	leaq	16(%rsp), %r12
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_5:                                # %if.else
                                        #   in Loop: Header=BB0_1 Depth=1
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 20(%rsp)
	movl	$20, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	movl	(%rsp), %eax
	incl	%eax
	movslq	%eax, %rbx
	movl	$21, %edi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, (%rsp)
	callq	LAMP_loop_iteration_end
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	callq	LAMP_loop_iteration_begin
	movl	$12, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	cmpl	$9, (%rsp)
	jg	.LBB0_6
# BB#2:                                 # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$13, %edi
	movq	%r13, %rsi
	callq	LAMP_load4
	movslq	4(%rsp), %rbx
	movl	$14, %edi
	movq	%r12, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 16(%rsp)
	movl	$15, %edi
	movq	%r13, %rsi
	callq	LAMP_load4
	cmpl	$0, 4(%rsp)
	jne	.LBB0_4
# BB#3:                                 # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$16, %edi
	movq	%r13, %rsi
	callq	LAMP_load4
	movl	4(%rsp), %eax
	imull	$10, %eax, %eax
	movslq	%eax, %rbx
	movl	$17, %edi
	jmp	.LBB0_5
.LBB0_4:                                # %if.else
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$18, %edi
	movq	%r13, %rsi
	callq	LAMP_load4
	movl	4(%rsp), %eax
	imull	$20, %eax, %eax
	movslq	%eax, %rbx
	movl	$19, %edi
	jmp	.LBB0_5
.LBB0_6:                                # %for.end
	callq	LAMP_loop_iteration_end
	callq	LAMP_loop_exit
	movl	$22, %edi
	callq	LAMP_register
	xorb	%al, %al
	callq	rand
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%eax, %ecx
	andl	$-2, %ecx
	subl	%ecx, %eax
	je	.LBB0_7
# BB#8:                                 # %if.else7
	leaq	20(%rsp), %rsi
	movl	$25, %edi
	callq	LAMP_load4
	movl	20(%rsp), %ebx
	leaq	16(%rsp), %rsi
	movl	$26, %edi
	callq	LAMP_load4
	movl	16(%rsp), %ebp
	movl	$27, %edi
	callq	LAMP_register
	movl	$.L.str1, %edi
	movl	%ebx, %esi
	movl	%ebp, %edx
	xorb	%al, %al
	callq	printf
	jmp	.LBB0_9
.LBB0_7:                                # %if.then5
	leaq	16(%rsp), %rsi
	movl	$23, %edi
	callq	LAMP_load4
	movl	16(%rsp), %ebx
	movl	$24, %edi
	callq	LAMP_register
	movl	$.L.str, %edi
	movl	%ebx, %esi
	xorb	%al, %al
	callq	printf
.LBB0_9:                                # %if.end9
	leaq	36(%rsp), %rsi
	movl	$28, %edi
	callq	LAMP_load4
	movl	36(%rsp), %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	ret
.Ltmp20:
	.size	main, .Ltmp20-main
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

	.type	t_start,@object         # @t_start
	.comm	t_start,16,8
	.type	t_end,@object           # @t_end
	.comm	t_end,16,8
	.type	t_diff,@object          # @t_diff
	.comm	t_diff,8,8

	.section	".note.GNU-stack","",@progbits
