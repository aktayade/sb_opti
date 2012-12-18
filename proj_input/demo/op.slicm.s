	.file	"op.slicm.bc"
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
.Ltmp4:
	.cfi_def_cfa_offset 16
	pushq	%r14
.Ltmp5:
	.cfi_def_cfa_offset 24
	pushq	%rbx
.Ltmp6:
	.cfi_def_cfa_offset 32
.Ltmp7:
	.cfi_offset %rbx, -32
.Ltmp8:
	.cfi_offset %r14, -24
.Ltmp9:
	.cfi_offset %rbp, -16
	movq	8(%rsi), %rdi
	xorb	%al, %al
	callq	atoi
	movl	%eax, %ebx
	movl	$t_start, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	xorl	%ebp, %ebp
	movl	$-1, %r14d
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_2:                                # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	%ebx, %edi
	xorb	%al, %al
	callq	func
	addl	%eax, %ebp
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	incl	%r14d
	cmpl	$9999, %r14d            # imm = 0x270F
	jle	.LBB0_2
# BB#3:                                 # %for.end
	movl	$.L.str, %edi
	movl	%ebp, %esi
	xorb	%al, %al
	callq	printf
	movl	$t_end, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movq	t_end+8(%rip), %rax
	subq	t_start+8(%rip), %rax
	cvtsi2sdq	%rax, %xmm0
	movq	t_end(%rip), %rax
	subq	t_start(%rip), %rax
	cvtsi2sdq	%rax, %xmm1
	divsd	.LCPI0_0(%rip), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, t_diff(%rip)
	movl	$.L.str1, %edi
	movb	$1, %al
	callq	printf
	xorl	%eax, %eax
	popq	%rbx
	popq	%r14
	popq	%rbp
	ret
.Ltmp10:
	.size	main, .Ltmp10-main
	.cfi_endproc

	.globl	func
	.align	16, 0x90
	.type	func,@function
func:                                   # @func
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbx
.Ltmp13:
	.cfi_def_cfa_offset 16
.Ltmp14:
	.cfi_offset %rbx, -16
	addl	$10, %edi
	je	.LBB1_1
# BB#4:                                 # %if.else
	imull	$20, %edi, %ebx
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
	je	.LBB1_5
# BB#6:                                 # %if.else5
	movl	$.L.str3, %edi
	movl	%ebx, %esi
	xorl	%edx, %edx
	xorb	%al, %al
	callq	printf
	popq	%rbx
	ret
.LBB1_1:                                # %if.then
	imull	$10, %edi, %ebx
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
	je	.LBB1_5
# BB#2:                                 # %if.else5_copy
	movl	$.L.str3, %edi
	movl	%ebx, %esi
	xorl	%edx, %edx
	xorb	%al, %al
	callq	printf
	popq	%rbx
	ret
.LBB1_5:                                # %if.then3
	movl	$.L.str2, %edi
	xorl	%esi, %esi
	xorb	%al, %al
	callq	printf
	popq	%rbx
	ret
.Ltmp15:
	.size	func, .Ltmp15-func
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


	.section	".note.GNU-stack","",@progbits
