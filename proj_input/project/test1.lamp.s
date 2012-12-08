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
	subq	$24, %rsp
.Ltmp13:
	.cfi_def_cfa_offset 80
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
	movl	$38, %edi
	movl	$1, %esi
	movl	$1, %edx
	xorl	%ecx, %ecx
	callq	LAMP_init
	leaq	20(%rsp), %rsi
	xorl	%edi, %edi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 20(%rsp)
	leaq	16(%rsp), %r14
	movl	$1, %edi
	movq	%r14, %rsi
	movl	$10, %edx
	callq	LAMP_store4
	leaq	12(%rsp), %rbx
	movl	$10, 16(%rsp)
	movl	$2, %edi
	movq	%rbx, %rsi
	movl	$5, %edx
	callq	LAMP_store4
	leaq	8(%rsp), %r15
	movl	$5, 12(%rsp)
	movl	$3, %edi
	movq	%r15, %rsi
	movl	$6, %edx
	callq	LAMP_store4
	leaq	4(%rsp), %r12
	movl	$6, 8(%rsp)
	movl	$4, %edi
	movq	%r12, %rsi
	movl	$20, %edx
	callq	LAMP_store4
	leaq	(%rsp), %r13
	movl	$20, 4(%rsp)
	movl	$5, %edi
	movq	%r13, %rsi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, (%rsp)
	movl	$38, %edi
	callq	LAMP_loop_invocation
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_11:                               # %if.else11
                                        #   in Loop: Header=BB0_1 Depth=1
	movq	%r15, %rsi
	movq	%rbp, %rdx
	callq	LAMP_store4
	movl	%ebp, 8(%rsp)
	movl	$31, %edi
	movq	%r13, %rsi
	callq	LAMP_load4
	movl	(%rsp), %eax
	incl	%eax
	movslq	%eax, %rbp
	movl	$32, %edi
	movq	%r13, %rsi
	movq	%rbp, %rdx
	callq	LAMP_store4
	movl	%ebp, (%rsp)
	callq	LAMP_loop_iteration_end
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	callq	LAMP_loop_iteration_begin
	movl	$6, %edi
	movq	%r13, %rsi
	callq	LAMP_load4
	cmpl	$99, (%rsp)
	jg	.LBB0_12
# BB#2:                                 # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$7, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	16(%rsp), %ebp
	movl	$8, %edi
	movq	%rbx, %rsi
	callq	LAMP_load4
	cmpl	12(%rsp), %ebp
	jne	.LBB0_4
# BB#3:                                 # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$9, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	16(%rsp), %ebp
	movl	$10, %edi
	movq	%rbx, %rsi
	callq	LAMP_load4
	movl	12(%rsp), %eax
	addl	%ebp, %eax
	movslq	%eax, %rbp
	movl	$11, %edi
	jmp	.LBB0_5
.LBB0_4:                                # %if.else
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$12, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	16(%rsp), %ebp
	movl	$13, %edi
	movq	%rbx, %rsi
	callq	LAMP_load4
	movl	12(%rsp), %eax
	subl	%eax, %ebp
	movslq	%ebp, %rbp
	movl	$14, %edi
.LBB0_5:                                # %if.else
                                        #   in Loop: Header=BB0_1 Depth=1
	movq	%r15, %rsi
	movq	%rbp, %rdx
	callq	LAMP_store4
	movl	%ebp, 8(%rsp)
	movl	$15, %edi
	movq	%r12, %rsi
	callq	LAMP_load4
	movl	4(%rsp), %ebp
	movl	$16, %edi
	movq	%rbx, %rsi
	callq	LAMP_load4
	cmpl	12(%rsp), %ebp
	jne	.LBB0_7
# BB#6:                                 # %if.then3
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$17, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	16(%rsp), %ebp
	movl	$18, %edi
	movq	%rbx, %rsi
	callq	LAMP_load4
	movl	12(%rsp), %eax
	addl	%ebp, %eax
	movslq	%eax, %rbp
	movl	$19, %edi
	movq	%r12, %rsi
	movq	%rbp, %rdx
	callq	LAMP_store4
	movl	%ebp, 4(%rsp)
	jmp	.LBB0_8
.LBB0_7:                                # %if.else5
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$20, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	16(%rsp), %ebp
	movl	$21, %edi
	movq	%rbx, %rsi
	callq	LAMP_load4
	movl	12(%rsp), %eax
	subl	%eax, %ebp
	movslq	%ebp, %rbp
	movl	$22, %edi
	movq	%r15, %rsi
	movq	%rbp, %rdx
	callq	LAMP_store4
	movl	%ebp, 8(%rsp)
.LBB0_8:                                # %if.end7
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$23, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	16(%rsp), %ebp
	movl	$24, %edi
	movq	%rbx, %rsi
	callq	LAMP_load4
	cmpl	12(%rsp), %ebp
	jne	.LBB0_10
# BB#9:                                 # %if.then9
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$25, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	16(%rsp), %ebp
	movl	$26, %edi
	movq	%rbx, %rsi
	callq	LAMP_load4
	movl	12(%rsp), %eax
	addl	%ebp, %eax
	movslq	%eax, %rbp
	movl	$27, %edi
	jmp	.LBB0_11
.LBB0_10:                               # %if.else11
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$28, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	16(%rsp), %ebp
	movl	$29, %edi
	movq	%rbx, %rsi
	callq	LAMP_load4
	movl	12(%rsp), %eax
	subl	%eax, %ebp
	movslq	%ebp, %rbp
	movl	$30, %edi
	jmp	.LBB0_11
.LBB0_12:                               # %for.end
	callq	LAMP_loop_iteration_end
	callq	LAMP_loop_exit
	leaq	16(%rsp), %rsi
	movl	$33, %edi
	callq	LAMP_load4
	movl	16(%rsp), %r14d
	leaq	12(%rsp), %rsi
	movl	$34, %edi
	callq	LAMP_load4
	leaq	8(%rsp), %rsi
	movl	12(%rsp), %ebp
	movl	$35, %edi
	callq	LAMP_load4
	leaq	4(%rsp), %rsi
	movl	8(%rsp), %r15d
	movl	$36, %edi
	callq	LAMP_load4
	movl	4(%rsp), %ebx
	movl	$37, %edi
	callq	LAMP_register
	movl	$.L.str, %edi
	movl	%r14d, %esi
	movl	%ebp, %edx
	movl	%r15d, %ecx
	movl	%ebx, %r8d
	xorb	%al, %al
	callq	printf
	xorl	%eax, %eax
	addq	$24, %rsp
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
	.asciz	 "%d,%d,%d,%d\n"
	.size	.L.str, 13


	.section	".note.GNU-stack","",@progbits
