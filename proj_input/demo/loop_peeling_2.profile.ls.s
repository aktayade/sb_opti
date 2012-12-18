	.file	"loop_peeling_2.profile.ls.bc"
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
	movl	$10, %ecx
	callq	llvm_start_edge_profiling
	incl	EdgeProfCounters(%rip)
	movl	$0, 20(%rsp)
	movl	$0, 16(%rsp)
	movl	$1, 12(%rsp)
	movl	$t_start, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movl	$1, 8(%rsp)
	incl	EdgeProfCounters+4(%rip)
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_5:                                # %if.end
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+32(%rip)
	addl	$2, 8(%rsp)
	incl	EdgeProfCounters+36(%rip)
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$30000, 8(%rsp)         # imm = 0x7530
	jg	.LBB0_6
# BB#2:                                 # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+8(%rip)
	movl	8(%rsp), %eax
	addl	$10, %eax
	movslq	%eax, %rax
	movl	%eax, 16(%rsp)
	imulq	$1717986919, %rax, %rcx # imm = 0x66666667
	sarq	$34, %rcx
	movl	%ecx, %edx
	shrl	$31, %edx
	addl	%ecx, %edx
	imull	$10, %edx, %ecx
	subl	%ecx, %eax
	jne	.LBB0_4
# BB#3:                                 # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+16(%rip)
	movl	12(%rsp), %eax
	addl	$3, %eax
	movl	%eax, 16(%rsp)
	movl	12(%rsp), %eax
	shll	$3, %eax
	movl	%eax, 16(%rsp)
	movl	12(%rsp), %eax
	addl	$-3, %eax
	movl	%eax, 16(%rsp)
	incl	EdgeProfCounters+24(%rip)
	jmp	.LBB0_5
.LBB0_4:                                # %if.else
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+20(%rip)
	movl	12(%rsp), %eax
	addl	$5, %eax
	movl	%eax, 16(%rsp)
	imull	$10, 12(%rsp), %eax
	movl	%eax, 16(%rsp)
	movl	12(%rsp), %eax
	addl	$-4, %eax
	movl	%eax, 16(%rsp)
	incl	EdgeProfCounters+28(%rip)
	jmp	.LBB0_5
.LBB0_6:                                # %for.end
	incl	EdgeProfCounters+12(%rip)
	movl	16(%rsp), %esi
	movl	$.L.str, %edi
	xorb	%al, %al
	callq	printf
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
	movl	$.L.str1, %edi
	movb	$1, %al
	callq	printf
	movl	16(%rsp), %eax
	addq	$24, %rsp
	ret
.Ltmp2:
	.size	main, .Ltmp2-main
	.cfi_endproc

	.type	t_start,@object         # @t_start
	.comm	t_start,16,8
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	 "%d"
	.size	.L.str, 3

	.type	t_end,@object           # @t_end
	.comm	t_end,16,8
	.type	t_diff,@object          # @t_diff
	.comm	t_diff,8,8
	.type	.L.str1,@object         # @.str1
.L.str1:
	.asciz	 " ---  time spent = %.6f  --- \n"
	.size	.L.str1, 31

	.type	EdgeProfCounters,@object # @EdgeProfCounters
	.local	EdgeProfCounters
	.comm	EdgeProfCounters,40,16

	.section	".note.GNU-stack","",@progbits
