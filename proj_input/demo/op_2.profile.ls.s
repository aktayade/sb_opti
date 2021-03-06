	.file	"op_2.profile.ls.bc"
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
	pushq	%rbx
.Ltmp2:
	.cfi_def_cfa_offset 16
	subq	$32, %rsp
.Ltmp3:
	.cfi_def_cfa_offset 48
.Ltmp4:
	.cfi_offset %rbx, -16
	movq	%rsi, %rbx
	movl	$EdgeProfCounters, %edx
	movl	$15, %ecx
	callq	llvm_start_edge_profiling
	incl	EdgeProfCounters(%rip)
	movl	$0, 28(%rsp)
	movl	%eax, 24(%rsp)
	movq	%rbx, 16(%rsp)
	movq	8(%rbx), %rdi
	xorb	%al, %al
	callq	atoi
	movl	%eax, 12(%rsp)
	movl	$0, 8(%rsp)
	movq	$0, (%rsp)
	movl	$t_start, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movq	$0, (%rsp)
	incl	EdgeProfCounters+4(%rip)
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_2:                                # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+8(%rip)
	movl	12(%rsp), %edi
	xorb	%al, %al
	callq	func
	addl	%eax, 8(%rsp)
	incl	EdgeProfCounters+16(%rip)
	incq	(%rsp)
	incl	EdgeProfCounters+20(%rip)
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpq	$999999, (%rsp)         # imm = 0xF423F
	jle	.LBB0_2
# BB#3:                                 # %for.end
	incl	EdgeProfCounters+12(%rip)
	movl	8(%rsp), %esi
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
	movl	28(%rsp), %eax
	addq	$32, %rsp
	popq	%rbx
	ret
.Ltmp5:
	.size	main, .Ltmp5-main
	.cfi_endproc

	.globl	func
	.align	16, 0x90
	.type	func,@function
func:                                   # @func
	.cfi_startproc
# BB#0:                                 # %entry
	subq	$72, %rsp
.Ltmp7:
	.cfi_def_cfa_offset 80
	incl	EdgeProfCounters+24(%rip)
	movl	%edi, 64(%rsp)
	movl	$0, 60(%rsp)
	movl	$0, 56(%rsp)
	movl	64(%rsp), %eax
	addl	$10, %eax
	movl	%eax, 36(%rsp)
	movl	64(%rsp), %eax
	addl	$3, %eax
	movl	%eax, 32(%rsp)
	movl	64(%rsp), %eax
	addl	$100, %eax
	movl	%eax, 28(%rsp)
	movl	64(%rsp), %eax
	addl	$30, %eax
	movl	%eax, 24(%rsp)
	movl	$1000, %eax             # imm = 0x3E8
	addl	64(%rsp), %eax
	movl	%eax, 20(%rsp)
	movl	$300, %eax              # imm = 0x12C
	addl	64(%rsp), %eax
	movl	%eax, 16(%rsp)
	cmpl	$0, 36(%rsp)
	je	.LBB1_1
# BB#2:                                 # %if.else
	incl	EdgeProfCounters+32(%rip)
	imull	$20, 36(%rsp), %eax
	movl	%eax, 60(%rsp)
	imull	$6, 32(%rsp), %eax
	movl	%eax, 56(%rsp)
	imull	$10, 28(%rsp), %eax
	movl	%eax, 52(%rsp)
	movl	24(%rsp), %eax
	shll	$2, %eax
	movl	%eax, 48(%rsp)
	imull	$10, 20(%rsp), %eax
	movl	%eax, 44(%rsp)
	movl	16(%rsp), %eax
	shll	$2, %eax
	movl	%eax, 40(%rsp)
	incl	EdgeProfCounters+40(%rip)
	jmp	.LBB1_3
.LBB1_1:                                # %if.then
	incl	EdgeProfCounters+28(%rip)
	imull	$10, 36(%rsp), %eax
	movl	%eax, 60(%rsp)
	movl	32(%rsp), %eax
	shll	$2, %eax
	movl	%eax, 56(%rsp)
	imull	$10, 28(%rsp), %eax
	movl	%eax, 52(%rsp)
	movl	24(%rsp), %eax
	shll	$2, %eax
	movl	%eax, 48(%rsp)
	imull	$10, 20(%rsp), %eax
	movl	%eax, 44(%rsp)
	movl	16(%rsp), %eax
	shll	$2, %eax
	movl	%eax, 40(%rsp)
	incl	EdgeProfCounters+36(%rip)
.LBB1_3:                                # %if.end
	xorb	%al, %al
	callq	rand
	movslq	%eax, %rax
	imulq	$-1518422781, %rax, %rdx # imm = 0xFFFFFFFFA57EB503
	shrq	$32, %rdx
	movl	%eax, %ecx
	addl	%edx, %ecx
	movl	%ecx, %edx
	shrl	$31, %edx
	sarl	$6, %ecx
	addl	%edx, %ecx
	imull	$99, %ecx, %ecx
	subl	%ecx, %eax
	je	.LBB1_4
# BB#5:                                 # %if.else19
	incl	EdgeProfCounters+48(%rip)
	movl	44(%rsp), %r9d
	movl	48(%rsp), %r8d
	movl	52(%rsp), %ecx
	movl	56(%rsp), %edx
	movl	60(%rsp), %esi
	movl	40(%rsp), %eax
	movl	%eax, (%rsp)
	movl	$.L.str2, %edi
	xorb	%al, %al
	callq	printf
	incl	EdgeProfCounters+56(%rip)
	jmp	.LBB1_6
.LBB1_4:                                # %if.then18
	incl	EdgeProfCounters+44(%rip)
	incl	EdgeProfCounters+52(%rip)
.LBB1_6:                                # %if.end21
	movl	68(%rsp), %eax
	addq	$72, %rsp
	ret
.Ltmp8:
	.size	func, .Ltmp8-func
	.cfi_endproc

	.type	t_start,@object         # @t_start
	.comm	t_start,16,8
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	 "In main : %d"
	.size	.L.str, 13

	.type	t_end,@object           # @t_end
	.comm	t_end,16,8
	.type	t_diff,@object          # @t_diff
	.comm	t_diff,8,8
	.type	.L.str1,@object         # @.str1
.L.str1:
	.asciz	 " ---  time spent = %.6f  --- \n"
	.size	.L.str1, 31

	.type	.L.str2,@object         # @.str2
.L.str2:
	.asciz	 "In else: %d,%d,%d,%d,%d,%d"
	.size	.L.str2, 27

	.type	EdgeProfCounters,@object # @EdgeProfCounters
	.local	EdgeProfCounters
	.comm	EdgeProfCounters,60,16

	.section	".note.GNU-stack","",@progbits
