	.file	"op_2.slicm.bc"
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
	movq	$-1, %r14
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
	incq	%r14
	cmpq	$999999, %r14           # imm = 0xF423F
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
	pushq	%rbp
.Ltmp18:
	.cfi_def_cfa_offset 16
	pushq	%r15
.Ltmp19:
	.cfi_def_cfa_offset 24
	pushq	%r14
.Ltmp20:
	.cfi_def_cfa_offset 32
	pushq	%r13
.Ltmp21:
	.cfi_def_cfa_offset 40
	pushq	%r12
.Ltmp22:
	.cfi_def_cfa_offset 48
	pushq	%rbx
.Ltmp23:
	.cfi_def_cfa_offset 56
	pushq	%rax
.Ltmp24:
	.cfi_def_cfa_offset 64
.Ltmp25:
	.cfi_offset %rbx, -56
.Ltmp26:
	.cfi_offset %r12, -48
.Ltmp27:
	.cfi_offset %r13, -40
.Ltmp28:
	.cfi_offset %r14, -32
.Ltmp29:
	.cfi_offset %r15, -24
.Ltmp30:
	.cfi_offset %rbp, -16
	movl	%edi, %eax
	addl	$10, %eax
	leal	300(%rdi), %r13d
	leal	1000(%rdi), %edx
	leal	30(%rdi), %ebx
	leal	100(%rdi), %ecx
	leal	3(%rdi), %ebp
	je	.LBB1_1
# BB#2:                                 # %if.else
	shll	$2, %r13d
	imull	$10, %edx, %r14d
	shll	$2, %ebx
	imull	$10, %ecx, %r15d
	imull	$6, %ebp, %ebp
	imull	$20, %eax, %r12d
	jmp	.LBB1_3
.LBB1_1:                                # %if.then
	shll	$2, %r13d
	imull	$10, %edx, %r14d
	shll	$2, %ebx
	imull	$10, %ecx, %r15d
	shll	$2, %ebp
	imull	$10, %eax, %r12d
.LBB1_3:                                # %if.else
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
# BB#4:                                 # %if.else19
	movl	%r13d, (%rsp)
	movl	$.L.str2, %edi
	movl	%r12d, %esi
	movl	%ebp, %edx
	movl	%r15d, %ecx
	movl	%ebx, %r8d
	movl	%r14d, %r9d
	xorb	%al, %al
	callq	printf
.LBB1_5:                                # %if.end21
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	ret
.Ltmp31:
	.size	func, .Ltmp31-func
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


	.section	".note.GNU-stack","",@progbits
