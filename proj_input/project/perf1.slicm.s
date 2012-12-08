	.file	"perf1.slicm.bc"
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
	pushq	%rax
.Ltmp1:
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_2:                                # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$1, a(,%rax,4)
	incq	%rax
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$999, %eax              # imm = 0x3E7
	jle	.LBB0_2
# BB#3:                                 # %for.end
	movl	$t_start, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	xorl	%eax, %eax
	movl	$c, %r8d
	jmp	.LBB0_4
	.align	16, 0x90
.LBB0_17:                               # %for.inc46
                                        #   in Loop: Header=BB0_4 Depth=1
	addq	$4000, %r8              # imm = 0xFA0
	incl	%eax
.LBB0_4:                                # %for.cond1
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_13 Depth 2
	cmpl	$999, %eax              # imm = 0x3E7
	jg	.LBB0_18
# BB#5:                                 # %for.body3
                                        #   in Loop: Header=BB0_4 Depth=1
	cmpl	$996, %eax              # imm = 0x3E4
	jl	.LBB0_7
# BB#6:                                 # %if.then
                                        #   in Loop: Header=BB0_4 Depth=1
	leal	1(%rax), %edx
	movslq	%edx, %rdx
	movslq	%eax, %rsi
	movl	a(,%rsi,4), %esi
	incl	%esi
	movl	%esi, a(,%rdx,4)
.LBB0_7:                                # %if.end
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%eax, %edx
	andl	$-2, %edx
	movl	%eax, %esi
	subl	%edx, %esi
	jne	.LBB0_9
# BB#8:                                 # %if.then11
                                        #   in Loop: Header=BB0_4 Depth=1
	incl	a+40(%rip)
.LBB0_9:                                # %if.end13
                                        #   in Loop: Header=BB0_4 Depth=1
	cmpl	$989, %eax              # imm = 0x3DD
	jg	.LBB0_11
# BB#10:                                # %if.then15
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	a+3988(%rip), %edx
	movl	a+3992(%rip), %esi
	leal	3(%rsi,%rdx,2), %edx
	movslq	%eax, %rsi
	movl	%edx, b(,%rsi,4)
	jmp	.LBB0_12
.LBB0_11:                               # %if.else
                                        #   in Loop: Header=BB0_4 Depth=1
	movslq	%eax, %rdx
	movl	a(,%rdx,4), %esi
	incl	%esi
	movl	%esi, b(,%rdx,4)
.LBB0_12:                               # %if.end25
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	a+40(%rip), %edx
	movslq	%edx, %rdx
	imulq	$1374389535, %rdx, %rdx # imm = 0x51EB851F
	movq	%rdx, %rsi
	shrq	$63, %rsi
	sarq	$37, %rdx
	addl	%esi, %edx
	movl	a+3996(%rip), %esi
	leal	20(%rsi,%rdx), %esi
	movslq	%eax, %rdi
	xorl	%edx, %edx
	movl	%esi, d(,%rdi,4)
	movq	%r8, %rsi
	jmp	.LBB0_13
	.align	16, 0x90
.LBB0_16:                               # %if.end35
                                        #   in Loop: Header=BB0_13 Depth=2
	movl	b+3996(%rip), %edi
	movl	a+3996(%rip), %ecx
	leal	1(%rcx,%rdi,2), %ecx
	movl	%ecx, (%rsi)
	incq	%rdx
	addq	$4, %rsi
.LBB0_13:                               # %for.cond30
                                        #   Parent Loop BB0_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$999, %edx              # imm = 0x3E7
	jg	.LBB0_17
# BB#14:                                # %for.body32
                                        #   in Loop: Header=BB0_13 Depth=2
	cmpl	$500, %edx              # imm = 0x1F4
	jne	.LBB0_16
# BB#15:                                # %if.then34
                                        #   in Loop: Header=BB0_13 Depth=2
	movl	$0, a+3996(%rip)
	movl	$0, b+3996(%rip)
	jmp	.LBB0_16
.LBB0_18:                               # %for.end48
	movl	$t_end, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movq	t_end+8(%rip), %rax
	subq	t_start+8(%rip), %rax
	cvtsi2sdq	%rax, %xmm1
	divsd	.LCPI0_0(%rip), %xmm1
	movq	t_end(%rip), %rax
	subq	t_start(%rip), %rax
	cvtsi2sdq	%rax, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, t_diff(%rip)
	movl	$.L.str, %edi
	movb	$1, %al
	callq	printf
	xorl	%eax, %eax
	popq	%rdx
	ret
.Ltmp2:
	.size	main, .Ltmp2-main
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
