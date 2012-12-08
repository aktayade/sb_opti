	.file	"<stdin>"
	.section	.rodata.cst8,"aM",@progbits,8
	.align	8
.LCPI0_0:
	.quad	4696837146684686336     # double 1.000000e+06
                                        #  (0x412e848000000000)
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
	movl	$53, %edi
	movl	$3, %esi
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
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 16(%rsp)
	movl	$55, %edi
	callq	LAMP_loop_invocation
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_2:                                # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$3, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movslq	16(%rsp), %rbx
	leaq	a(,%rbx,4), %rsi
	movl	$4, %edi
	movl	$1, %edx
	callq	LAMP_store4
	movl	$1, a(,%rbx,4)
	movl	$5, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	16(%rsp), %eax
	incl	%eax
	movslq	%eax, %rbx
	movl	$6, %edi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 16(%rsp)
	callq	LAMP_loop_iteration_end
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	callq	LAMP_loop_iteration_begin
	movl	$2, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	cmpl	$999, 16(%rsp)          # imm = 0x3E7
	jle	.LBB0_2
# BB#3:                                 # %for.end
	callq	LAMP_loop_iteration_end
	callq	LAMP_loop_exit
	movl	$7, %edi
	callq	LAMP_register
	movl	$t_start, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	leaq	16(%rsp), %r14
	movl	$8, %edi
	movq	%r14, %rsi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 16(%rsp)
	movl	$54, %edi
	callq	LAMP_loop_invocation
	leaq	12(%rsp), %r15
	jmp	.LBB0_4
	.align	16, 0x90
.LBB0_17:                               # %for.end45
                                        #   in Loop: Header=BB0_4 Depth=1
	callq	LAMP_loop_iteration_end
	callq	LAMP_loop_exit
	movl	$43, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	16(%rsp), %eax
	incl	%eax
	movslq	%eax, %rbx
	movl	$44, %edi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 16(%rsp)
	callq	LAMP_loop_iteration_end
.LBB0_4:                                # %for.cond1
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_13 Depth 2
	callq	LAMP_loop_iteration_begin
	movl	$9, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	cmpl	$999, 16(%rsp)          # imm = 0x3E7
	jg	.LBB0_18
# BB#5:                                 # %for.body3
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	$10, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	cmpl	$996, 16(%rsp)          # imm = 0x3E4
	jl	.LBB0_7
# BB#6:                                 # %if.then
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	$11, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movslq	16(%rsp), %rbx
	leaq	a(,%rbx,4), %rsi
	movl	$12, %edi
	callq	LAMP_load4
	movl	a(,%rbx,4), %ebx
	movl	$13, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	16(%rsp), %eax
	incl	%ebx
	movslq	%ebx, %r12
	incl	%eax
	movslq	%eax, %rbx
	leaq	a(,%rbx,4), %rsi
	movl	$14, %edi
	movq	%r12, %rdx
	callq	LAMP_store4
	movl	%r12d, a(,%rbx,4)
.LBB0_7:                                # %if.end
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	$15, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	16(%rsp), %eax
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%eax, %ecx
	andl	$-2, %ecx
	subl	%ecx, %eax
	jne	.LBB0_9
# BB#8:                                 # %if.then11
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	$16, %edi
	movl	$a+40, %esi
	callq	LAMP_load4
	movl	a+40(%rip), %eax
	incl	%eax
	movslq	%eax, %rbx
	movl	$17, %edi
	movl	$a+40, %esi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, a+40(%rip)
.LBB0_9:                                # %if.end13
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	$18, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	cmpl	$989, 16(%rsp)          # imm = 0x3DD
	jg	.LBB0_11
# BB#10:                                # %if.then15
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	$19, %edi
	movl	$a+3988, %esi
	callq	LAMP_load4
	movl	a+3988(%rip), %ebx
	movl	$20, %edi
	movl	$a+3992, %esi
	callq	LAMP_load4
	movl	a+3992(%rip), %ebp
	movl	$21, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	leal	3(%rbp,%rbx,2), %eax
	movslq	%eax, %r12
	movslq	16(%rsp), %rbx
	leaq	b(,%rbx,4), %rsi
	movl	$22, %edi
	movq	%r12, %rdx
	callq	LAMP_store4
	movl	%r12d, b(,%rbx,4)
	jmp	.LBB0_12
.LBB0_11:                               # %if.else
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	$23, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movslq	16(%rsp), %rbx
	leaq	a(,%rbx,4), %rsi
	movl	$24, %edi
	callq	LAMP_load4
	movl	a(,%rbx,4), %ebx
	movl	$25, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movslq	16(%rsp), %r12
	incl	%ebx
	movslq	%ebx, %rbx
	leaq	b(,%r12,4), %rsi
	movl	$26, %edi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, b(,%r12,4)
.LBB0_12:                               # %if.end25
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	$27, %edi
	movl	$a+40, %esi
	callq	LAMP_load4
	movl	a+40(%rip), %ebp
	movl	$28, %edi
	movl	$a+3996, %esi
	callq	LAMP_load4
	movl	a+3996(%rip), %ebx
	movl	$29, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movslq	%ebp, %rax
	imulq	$1374389535, %rax, %rax # imm = 0x51EB851F
	movq	%rax, %rcx
	shrq	$63, %rcx
	sarq	$37, %rax
	addl	%ecx, %eax
	leal	20(%rbx,%rax), %eax
	movslq	%eax, %r12
	movslq	16(%rsp), %rbx
	leaq	d(,%rbx,4), %rsi
	movl	$30, %edi
	movq	%r12, %rdx
	callq	LAMP_store4
	movl	%r12d, d(,%rbx,4)
	movl	$31, %edi
	movq	%r15, %rsi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 12(%rsp)
	movl	$53, %edi
	callq	LAMP_loop_invocation
	jmp	.LBB0_13
	.align	16, 0x90
.LBB0_16:                               # %if.end35
                                        #   in Loop: Header=BB0_13 Depth=2
	movl	$36, %edi
	movl	$b+3996, %esi
	callq	LAMP_load4
	movl	b+3996(%rip), %ebx
	movl	$37, %edi
	movl	$a+3996, %esi
	callq	LAMP_load4
	movl	a+3996(%rip), %ebp
	movl	$38, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	movslq	12(%rsp), %r12
	movl	$39, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	leal	1(%rbp,%rbx,2), %eax
	movslq	16(%rsp), %rcx
	imulq	$4000, %rcx, %r13       # imm = 0xFA0
	leaq	c(%r13,%r12,4), %rsi
	movslq	%eax, %rbx
	movl	$40, %edi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, c(%r13,%r12,4)
	movl	$41, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	movl	12(%rsp), %eax
	incl	%eax
	movslq	%eax, %rbx
	movl	$42, %edi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 12(%rsp)
	callq	LAMP_loop_iteration_end
.LBB0_13:                               # %for.cond30
                                        #   Parent Loop BB0_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	callq	LAMP_loop_iteration_begin
	movl	$32, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	cmpl	$999, 12(%rsp)          # imm = 0x3E7
	jg	.LBB0_17
# BB#14:                                # %for.body32
                                        #   in Loop: Header=BB0_13 Depth=2
	movl	$33, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	cmpl	$500, 12(%rsp)          # imm = 0x1F4
	jne	.LBB0_16
# BB#15:                                # %if.then34
                                        #   in Loop: Header=BB0_13 Depth=2
	movl	$34, %edi
	movl	$a+3996, %esi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, a+3996(%rip)
	movl	$35, %edi
	movl	$b+3996, %esi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, b+3996(%rip)
	jmp	.LBB0_16
.LBB0_18:                               # %for.end48
	callq	LAMP_loop_iteration_end
	callq	LAMP_loop_exit
	movl	$45, %edi
	callq	LAMP_register
	movl	$t_end, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movl	$46, %edi
	movl	$t_end, %esi
	callq	LAMP_load8
	movq	t_end(%rip), %r15
	movl	$47, %edi
	movl	$t_start, %esi
	callq	LAMP_load8
	movq	t_start(%rip), %r14
	movl	$48, %edi
	movl	$t_end+8, %esi
	callq	LAMP_load8
	movq	t_end+8(%rip), %rbx
	movl	$49, %edi
	movl	$t_start+8, %esi
	callq	LAMP_load8
	subq	%r14, %r15
	movq	t_start+8(%rip), %rax
	subq	%rax, %rbx
	cvtsi2sdq	%rbx, %xmm1
	cvtsi2sdq	%r15, %xmm0
	divsd	.LCPI0_0(%rip), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, (%rsp)           # 8-byte Spill
	cvttsd2siq	%xmm1, %rdx
	movl	$50, %edi
	movl	$t_diff, %esi
	callq	LAMP_store8
	movsd	(%rsp), %xmm0           # 8-byte Reload
	movsd	%xmm0, t_diff(%rip)
	movl	$51, %edi
	movl	$t_diff, %esi
	callq	LAMP_load8
	movsd	t_diff(%rip), %xmm0
	movsd	%xmm0, (%rsp)           # 8-byte Spill
	movl	$52, %edi
	callq	LAMP_register
	movl	$.L.str, %edi
	movsd	(%rsp), %xmm0           # 8-byte Reload
	movb	$1, %al
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

	.type	a,@object               # @a
	.comm	a,4000,16
	.type	t_start,@object         # @t_start
	.comm	t_start,16,8
	.type	b,@object               # @b
	.comm	b,4000,16
	.type	d,@object               # @d
	.comm	d,4000,16
	.type	c,@object               # @c
	.comm	c,4000000,16
	.type	t_end,@object           # @t_end
	.comm	t_end,16,8
	.type	t_diff,@object          # @t_diff
	.comm	t_diff,8,8
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	 " ---  time spent = %.6f  --- \n"
	.size	.L.str, 31


	.section	".note.GNU-stack","",@progbits
