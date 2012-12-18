	.file	"op.profile.ls.bc"
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
	movl	$0, 4(%rsp)
	movl	$t_start, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movl	$0, 4(%rsp)
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
	incl	4(%rsp)
	incl	EdgeProfCounters+20(%rip)
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$9999, 4(%rsp)          # imm = 0x270F
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
	subq	$24, %rsp
.Ltmp7:
	.cfi_def_cfa_offset 32
	incl	EdgeProfCounters+24(%rip)
	movl	%edi, 16(%rsp)
	movl	$0, 12(%rsp)
	movl	$0, 8(%rsp)
	movl	16(%rsp), %eax
	addl	$10, %eax
	movl	%eax, 4(%rsp)
	je	.LBB1_1
# BB#2:                                 # %if.else
	incl	EdgeProfCounters+32(%rip)
	imull	$20, 4(%rsp), %eax
	movl	%eax, 12(%rsp)
	incl	EdgeProfCounters+40(%rip)
	jmp	.LBB1_3
.LBB1_1:                                # %if.then
	incl	EdgeProfCounters+28(%rip)
	imull	$10, 4(%rsp), %eax
	movl	%eax, 12(%rsp)
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
# BB#5:                                 # %if.else5
	incl	EdgeProfCounters+48(%rip)
	movl	8(%rsp), %edx
	movl	12(%rsp), %esi
	movl	$.L.str3, %edi
	xorb	%al, %al
	callq	printf
	incl	EdgeProfCounters+56(%rip)
	jmp	.LBB1_6
.LBB1_4:                                # %if.then3
	incl	EdgeProfCounters+44(%rip)
	movl	8(%rsp), %esi
	movl	$.L.str2, %edi
	xorb	%al, %al
	callq	printf
	incl	EdgeProfCounters+52(%rip)
.LBB1_6:                                # %if.end7
	movl	20(%rsp), %eax
	addq	$24, %rsp
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
	.asciz	 "%d"
	.size	.L.str2, 3

	.type	.L.str3,@object         # @.str3
.L.str3:
	.asciz	 "In else: %d,%d"
	.size	.L.str3, 15

	.type	EdgeProfCounters,@object # @EdgeProfCounters
	.local	EdgeProfCounters
	.comm	EdgeProfCounters,60,16

	.section	".note.GNU-stack","",@progbits
