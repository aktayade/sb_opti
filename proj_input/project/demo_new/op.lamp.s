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
.Ltmp6:
	.cfi_def_cfa_offset 16
	pushq	%r15
.Ltmp7:
	.cfi_def_cfa_offset 24
	pushq	%r14
.Ltmp8:
	.cfi_def_cfa_offset 32
	pushq	%r12
.Ltmp9:
	.cfi_def_cfa_offset 40
	pushq	%rbx
.Ltmp10:
	.cfi_def_cfa_offset 48
	subq	$48, %rsp
.Ltmp11:
	.cfi_def_cfa_offset 96
.Ltmp12:
	.cfi_offset %rbx, -48
.Ltmp13:
	.cfi_offset %r12, -40
.Ltmp14:
	.cfi_offset %r14, -32
.Ltmp15:
	.cfi_offset %r15, -24
.Ltmp16:
	.cfi_offset %rbp, -16
	movq	%rsi, %r15
	movl	%edi, %ebp
	movl	$46, %edi
	movl	$1, %esi
	movl	$1, %edx
	xorl	%ecx, %ecx
	callq	LAMP_init
	leaq	44(%rsp), %rsi
	xorl	%edi, %edi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 44(%rsp)
	movslq	%ebp, %rbx
	leaq	40(%rsp), %rsi
	movl	$1, %edi
	movq	%rbx, %rdx
	callq	LAMP_store4
	leaq	32(%rsp), %r14
	movl	%ebx, 40(%rsp)
	movl	$2, %edi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	LAMP_store8
	movq	%r15, 32(%rsp)
	movl	$3, %edi
	movq	%r14, %rsi
	callq	LAMP_load8
	movq	32(%rsp), %rbx
	leaq	8(%rbx), %rsi
	movl	$4, %edi
	callq	LAMP_load8
	movq	8(%rbx), %rbx
	movl	$5, %edi
	callq	LAMP_register
	movq	%rbx, %rdi
	xorb	%al, %al
	callq	atoi
	leaq	28(%rsp), %r14
	movslq	%eax, %rbx
	movl	$6, %edi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	leaq	24(%rsp), %r15
	movl	%ebx, 28(%rsp)
	movl	$7, %edi
	movq	%r15, %rsi
	xorl	%edx, %edx
	callq	LAMP_store4
	leaq	20(%rsp), %r12
	movl	$0, 24(%rsp)
	movl	$8, %edi
	movq	%r12, %rsi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 20(%rsp)
	movl	$9, %edi
	callq	LAMP_register
	movl	$t_start, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movl	$10, %edi
	movq	%r12, %rsi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 20(%rsp)
	movl	$46, %edi
	callq	LAMP_loop_invocation
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_2:                                # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$12, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	28(%rsp), %ebx
	movl	$13, %edi
	callq	LAMP_register
	movl	%ebx, %edi
	xorb	%al, %al
	callq	func
	movl	%eax, %ebp
	movl	$14, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	movl	24(%rsp), %eax
	addl	%ebp, %eax
	movslq	%eax, %rbx
	movl	$15, %edi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 24(%rsp)
	movl	$16, %edi
	movq	%r12, %rsi
	callq	LAMP_load4
	movl	20(%rsp), %eax
	incl	%eax
	movslq	%eax, %rbx
	movl	$17, %edi
	movq	%r12, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 20(%rsp)
	callq	LAMP_loop_iteration_end
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	callq	LAMP_loop_iteration_begin
	movl	$11, %edi
	movq	%r12, %rsi
	callq	LAMP_load4
	cmpl	$9999, 20(%rsp)         # imm = 0x270F
	jle	.LBB0_2
# BB#3:                                 # %for.end
	callq	LAMP_loop_iteration_end
	callq	LAMP_loop_exit
	leaq	24(%rsp), %rsi
	movl	$18, %edi
	callq	LAMP_load4
	movl	24(%rsp), %ebx
	movl	$19, %edi
	callq	LAMP_register
	movl	$.L.str, %edi
	movl	%ebx, %esi
	xorb	%al, %al
	callq	printf
	movl	$20, %edi
	callq	LAMP_register
	movl	$t_end, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movl	$21, %edi
	movl	$t_end, %esi
	callq	LAMP_load8
	movq	t_end(%rip), %r15
	movl	$22, %edi
	movl	$t_start, %esi
	callq	LAMP_load8
	movq	t_start(%rip), %r14
	movl	$23, %edi
	movl	$t_end+8, %esi
	callq	LAMP_load8
	movq	t_end+8(%rip), %rbx
	movl	$24, %edi
	movl	$t_start+8, %esi
	callq	LAMP_load8
	subq	%r14, %r15
	movq	t_start+8(%rip), %rax
	subq	%rax, %rbx
	cvtsi2sdq	%rbx, %xmm1
	cvtsi2sdq	%r15, %xmm0
	divsd	.LCPI0_0(%rip), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, 8(%rsp)          # 8-byte Spill
	cvttsd2siq	%xmm1, %rdx
	movl	$25, %edi
	movl	$t_diff, %esi
	callq	LAMP_store8
	movsd	8(%rsp), %xmm0          # 8-byte Reload
	movsd	%xmm0, t_diff(%rip)
	movl	$26, %edi
	movl	$t_diff, %esi
	callq	LAMP_load8
	movsd	t_diff(%rip), %xmm0
	movsd	%xmm0, 8(%rsp)          # 8-byte Spill
	movl	$27, %edi
	callq	LAMP_register
	movl	$.L.str1, %edi
	movsd	8(%rsp), %xmm0          # 8-byte Reload
	movb	$1, %al
	callq	printf
	leaq	44(%rsp), %rsi
	movl	$28, %edi
	callq	LAMP_load4
	movl	44(%rsp), %eax
	addq	$48, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	ret
.Ltmp17:
	.size	main, .Ltmp17-main
	.cfi_endproc

	.globl	func
	.align	16, 0x90
	.type	func,@function
func:                                   # @func
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Ltmp22:
	.cfi_def_cfa_offset 16
	pushq	%r14
.Ltmp23:
	.cfi_def_cfa_offset 24
	pushq	%rbx
.Ltmp24:
	.cfi_def_cfa_offset 32
	subq	$32, %rsp
.Ltmp25:
	.cfi_def_cfa_offset 64
.Ltmp26:
	.cfi_offset %rbx, -32
.Ltmp27:
	.cfi_offset %r14, -24
.Ltmp28:
	.cfi_offset %rbp, -16
	movslq	%edi, %rbx
	leaq	24(%rsp), %r14
	movl	$29, %edi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 24(%rsp)
	leaq	20(%rsp), %rsi
	movl	$30, %edi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 20(%rsp)
	leaq	16(%rsp), %rsi
	movl	$31, %edi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 16(%rsp)
	movl	$32, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	leaq	12(%rsp), %r14
	movl	24(%rsp), %eax
	addl	$10, %eax
	movslq	%eax, %rbx
	movl	$33, %edi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 12(%rsp)
	movl	$34, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	cmpl	$0, 12(%rsp)
	je	.LBB1_1
# BB#2:                                 # %if.else
	leaq	12(%rsp), %rsi
	movl	$37, %edi
	callq	LAMP_load4
	movl	12(%rsp), %eax
	imull	$20, %eax, %eax
	movslq	%eax, %rbx
	leaq	20(%rsp), %rsi
	movl	$38, %edi
	jmp	.LBB1_3
.LBB1_1:                                # %if.then
	leaq	12(%rsp), %rsi
	movl	$35, %edi
	callq	LAMP_load4
	movl	12(%rsp), %eax
	imull	$10, %eax, %eax
	movslq	%eax, %rbx
	leaq	20(%rsp), %rsi
	movl	$36, %edi
.LBB1_3:                                # %if.else
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 20(%rsp)
	movl	$39, %edi
	callq	LAMP_register
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
	leaq	20(%rsp), %rsi
	movl	$42, %edi
	callq	LAMP_load4
	movl	20(%rsp), %ebx
	leaq	16(%rsp), %rsi
	movl	$43, %edi
	callq	LAMP_load4
	movl	16(%rsp), %ebp
	movl	$44, %edi
	callq	LAMP_register
	movl	$.L.str3, %edi
	movl	%ebx, %esi
	movl	%ebp, %edx
	xorb	%al, %al
	callq	printf
	jmp	.LBB1_6
.LBB1_4:                                # %if.then3
	leaq	16(%rsp), %rsi
	movl	$40, %edi
	callq	LAMP_load4
	movl	16(%rsp), %ebx
	movl	$41, %edi
	callq	LAMP_register
	movl	$.L.str2, %edi
	movl	%ebx, %esi
	xorb	%al, %al
	callq	printf
.LBB1_6:                                # %if.end7
	leaq	28(%rsp), %rsi
	movl	$45, %edi
	callq	LAMP_load4
	movl	28(%rsp), %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	ret
.Ltmp29:
	.size	func, .Ltmp29-func
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
