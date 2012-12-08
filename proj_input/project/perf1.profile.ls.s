	.file	"perf1.profile.ls.bc"
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
	subq	$24, %rsp
.Ltmp1:
	.cfi_def_cfa_offset 32
	xorl	%edi, %edi
	xorl	%esi, %esi
	movl	$EdgeProfCounters, %edx
	movl	$29, %ecx
	callq	llvm_start_edge_profiling
	incl	EdgeProfCounters(%rip)
	movl	$0, 20(%rsp)
	movl	$0, 16(%rsp)
	incl	EdgeProfCounters+4(%rip)
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_2:                                # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+8(%rip)
	movslq	16(%rsp), %rax
	movl	$1, a(,%rax,4)
	incl	EdgeProfCounters+16(%rip)
	incl	16(%rsp)
	incl	EdgeProfCounters+20(%rip)
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$999, 16(%rsp)          # imm = 0x3E7
	jle	.LBB0_2
# BB#3:                                 # %for.end
	incl	EdgeProfCounters+12(%rip)
	movl	$t_start, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movl	$0, 16(%rsp)
	incl	EdgeProfCounters+24(%rip)
	jmp	.LBB0_4
	.align	16, 0x90
.LBB0_20:                               # %for.end45
                                        #   in Loop: Header=BB0_4 Depth=1
	incl	EdgeProfCounters+84(%rip)
	incl	EdgeProfCounters+108(%rip)
	incl	16(%rsp)
	incl	EdgeProfCounters+112(%rip)
.LBB0_4:                                # %for.cond1
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_15 Depth 2
	cmpl	$999, 16(%rsp)          # imm = 0x3E7
	jg	.LBB0_21
# BB#5:                                 # %for.body3
                                        #   in Loop: Header=BB0_4 Depth=1
	incl	EdgeProfCounters+28(%rip)
	cmpl	$995, 16(%rsp)          # imm = 0x3E3
	jle	.LBB0_6
# BB#7:                                 # %if.then
                                        #   in Loop: Header=BB0_4 Depth=1
	incl	EdgeProfCounters+36(%rip)
	movslq	16(%rsp), %rax
	movl	a(,%rax,4), %ecx
	incl	%ecx
	incl	%eax
	movslq	%eax, %rax
	movl	%ecx, a(,%rax,4)
	incl	EdgeProfCounters+44(%rip)
	jmp	.LBB0_8
.LBB0_6:                                # %for.body3.if.end_crit_edge
                                        #   in Loop: Header=BB0_4 Depth=1
	incl	EdgeProfCounters+40(%rip)
.LBB0_8:                                # %if.end
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	16(%rsp), %eax
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%eax, %ecx
	andl	$-2, %ecx
	subl	%ecx, %eax
	jne	.LBB0_9
# BB#10:                                # %if.then11
                                        #   in Loop: Header=BB0_4 Depth=1
	incl	EdgeProfCounters+48(%rip)
	incl	a+40(%rip)
	incl	EdgeProfCounters+56(%rip)
	jmp	.LBB0_11
.LBB0_9:                                # %if.end.if.end13_crit_edge
                                        #   in Loop: Header=BB0_4 Depth=1
	incl	EdgeProfCounters+52(%rip)
.LBB0_11:                               # %if.end13
                                        #   in Loop: Header=BB0_4 Depth=1
	cmpl	$989, 16(%rsp)          # imm = 0x3DD
	jg	.LBB0_13
# BB#12:                                # %if.then15
                                        #   in Loop: Header=BB0_4 Depth=1
	incl	EdgeProfCounters+60(%rip)
	movl	a+3988(%rip), %eax
	movl	a+3992(%rip), %ecx
	leal	3(%rcx,%rax,2), %eax
	movslq	16(%rsp), %rcx
	movl	%eax, b(,%rcx,4)
	incl	EdgeProfCounters+68(%rip)
	jmp	.LBB0_14
.LBB0_13:                               # %if.else
                                        #   in Loop: Header=BB0_4 Depth=1
	incl	EdgeProfCounters+64(%rip)
	movslq	16(%rsp), %rax
	movl	a(,%rax,4), %ecx
	incl	%ecx
	movl	%ecx, b(,%rax,4)
	incl	EdgeProfCounters+72(%rip)
.LBB0_14:                               # %if.end25
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	a+40(%rip), %eax
	movslq	%eax, %rax
	imulq	$1374389535, %rax, %rax # imm = 0x51EB851F
	movq	%rax, %rcx
	shrq	$63, %rcx
	sarq	$37, %rax
	addl	%ecx, %eax
	movl	a+3996(%rip), %ecx
	leal	20(%rcx,%rax), %eax
	movslq	16(%rsp), %rcx
	movl	%eax, d(,%rcx,4)
	movl	$0, 12(%rsp)
	incl	EdgeProfCounters+76(%rip)
	jmp	.LBB0_15
	.align	16, 0x90
.LBB0_19:                               # %if.end35
                                        #   in Loop: Header=BB0_15 Depth=2
	movl	b+3996(%rip), %eax
	movl	a+3996(%rip), %ecx
	leal	1(%rcx,%rax,2), %eax
	movslq	16(%rsp), %rcx
	imulq	$4000, %rcx, %rcx       # imm = 0xFA0
	movslq	12(%rsp), %rdx
	movl	%eax, c(%rcx,%rdx,4)
	incl	EdgeProfCounters+100(%rip)
	incl	12(%rsp)
	incl	EdgeProfCounters+104(%rip)
.LBB0_15:                               # %for.cond30
                                        #   Parent Loop BB0_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$999, 12(%rsp)          # imm = 0x3E7
	jg	.LBB0_20
# BB#16:                                # %for.body32
                                        #   in Loop: Header=BB0_15 Depth=2
	incl	EdgeProfCounters+80(%rip)
	cmpl	$500, 12(%rsp)          # imm = 0x1F4
	jne	.LBB0_17
# BB#18:                                # %if.then34
                                        #   in Loop: Header=BB0_15 Depth=2
	incl	EdgeProfCounters+88(%rip)
	movl	$0, a+3996(%rip)
	movl	$0, b+3996(%rip)
	incl	EdgeProfCounters+96(%rip)
	jmp	.LBB0_19
.LBB0_17:                               # %for.body32.if.end35_crit_edge
                                        #   in Loop: Header=BB0_15 Depth=2
	incl	EdgeProfCounters+92(%rip)
	jmp	.LBB0_19
.LBB0_21:                               # %for.end48
	incl	EdgeProfCounters+32(%rip)
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
	addq	$24, %rsp
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

	.type	EdgeProfCounters,@object # @EdgeProfCounters
	.local	EdgeProfCounters
	.comm	EdgeProfCounters,116,16

	.section	".note.GNU-stack","",@progbits
