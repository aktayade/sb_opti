	.file	"<stdin>"
	.text
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Ltmp5:
	.cfi_def_cfa_offset 16
	pushq	%r15
.Ltmp6:
	.cfi_def_cfa_offset 24
	pushq	%r14
.Ltmp7:
	.cfi_def_cfa_offset 32
	pushq	%rbx
.Ltmp8:
	.cfi_def_cfa_offset 40
	subq	$24, %rsp
.Ltmp9:
	.cfi_def_cfa_offset 64
.Ltmp10:
	.cfi_offset %rbx, -40
.Ltmp11:
	.cfi_offset %r14, -32
.Ltmp12:
	.cfi_offset %r15, -24
.Ltmp13:
	.cfi_offset %rbp, -16
	movl	$24, %edi
	movl	$2, %esi
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
	leaq	(%rsp), %rsi
	movl	$0, 16(%rsp)
	movl	$2, %edi
	movl	$a, %edx
	callq	LAMP_store8
	leaq	12(%rsp), %r14
	movq	$a, (%rsp)
	movl	$3, %edi
	movq	%r14, %rsi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 12(%rsp)
	movl	$25, %edi
	callq	LAMP_loop_invocation
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_2:                                # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$5, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movslq	12(%rsp), %r15
	movl	$6, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movslq	12(%rsp), %rbx
	leaq	a(,%rbx,4), %rsi
	movl	$7, %edi
	movq	%r15, %rdx
	callq	LAMP_store4
	movl	%r15d, a(,%rbx,4)
	movl	$8, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	12(%rsp), %eax
	incl	%eax
	movslq	%eax, %rbx
	movl	$9, %edi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 12(%rsp)
	callq	LAMP_loop_iteration_end
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	callq	LAMP_loop_iteration_begin
	movl	$4, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	cmpl	$99, 12(%rsp)
	jle	.LBB0_2
# BB#3:                                 # %for.end
	callq	LAMP_loop_iteration_end
	callq	LAMP_loop_exit
	leaq	12(%rsp), %r14
	movl	$10, %edi
	movq	%r14, %rsi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 12(%rsp)
	movl	$24, %edi
	callq	LAMP_loop_invocation
	jmp	.LBB0_4
	.align	16, 0x90
.LBB0_7:                                # %if.end
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	$15, %edi
	movl	$a+388, %esi
	callq	LAMP_load4
	movslq	a+388(%rip), %r15
	movl	$16, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movslq	12(%rsp), %rbx
	leaq	b(,%rbx,4), %rsi
	movl	$17, %edi
	movq	%r15, %rdx
	callq	LAMP_store4
	movl	%r15d, b(,%rbx,4)
	movl	$18, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	12(%rsp), %eax
	incl	%eax
	movslq	%eax, %rbx
	movl	$19, %edi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 12(%rsp)
	callq	LAMP_loop_iteration_end
.LBB0_4:                                # %for.cond1
                                        # =>This Inner Loop Header: Depth=1
	callq	LAMP_loop_iteration_begin
	movl	$11, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	cmpl	$99, 12(%rsp)
	jg	.LBB0_8
# BB#5:                                 # %for.body3
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	$12, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	cmpl	$1000, 12(%rsp)         # imm = 0x3E8
	jl	.LBB0_7
# BB#6:                                 # %if.then
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	$13, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	12(%rsp), %eax
	incl	%eax
	movslq	%eax, %rbx
	leaq	a(,%rbx,4), %rsi
	movl	$14, %edi
	movl	$1, %edx
	callq	LAMP_store4
	movl	$1, a(,%rbx,4)
	jmp	.LBB0_7
.LBB0_8:                                # %for.end11
	callq	LAMP_loop_iteration_end
	callq	LAMP_loop_exit
	movl	$20, %edi
	movl	$b+388, %esi
	callq	LAMP_load4
	movl	b+388(%rip), %r14d
	movl	$21, %edi
	movl	$b+392, %esi
	callq	LAMP_load4
	movl	b+392(%rip), %ebp
	movl	$22, %edi
	movl	$b+396, %esi
	callq	LAMP_load4
	movl	b+396(%rip), %ebx
	movl	$23, %edi
	callq	LAMP_register
	movl	$.L.str, %edi
	movl	%r14d, %esi
	movl	%ebp, %edx
	movl	%ebx, %ecx
	xorb	%al, %al
	callq	printf
	xorl	%eax, %eax
	addq	$24, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	ret
.Ltmp14:
	.size	main, .Ltmp14-main
	.cfi_endproc

	.type	a,@object               # @a
	.comm	a,400,16
	.type	b,@object               # @b
	.comm	b,400,16
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	 "%d, %d, %d\n"
	.size	.L.str, 12


	.section	".note.GNU-stack","",@progbits
