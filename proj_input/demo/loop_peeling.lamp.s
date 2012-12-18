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
	subq	$32, %rsp
.Ltmp11:
	.cfi_def_cfa_offset 80
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
	movl	$27, %edi
	movl	$1, %esi
	movl	$1, %edx
	xorl	%ecx, %ecx
	callq	LAMP_init
	leaq	28(%rsp), %rsi
	xorl	%edi, %edi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 28(%rsp)
	leaq	24(%rsp), %r15
	movl	$1, %edi
	movq	%r15, %rsi
	xorl	%edx, %edx
	callq	LAMP_store4
	leaq	20(%rsp), %rsi
	movl	$0, 24(%rsp)
	movl	$2, %edi
	movl	$1, %edx
	callq	LAMP_store4
	movl	$1, 20(%rsp)
	movl	$3, %edi
	callq	LAMP_register
	movl	$t_start, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	leaq	16(%rsp), %r14
	movl	$4, %edi
	movq	%r14, %rsi
	movl	$1, %edx
	callq	LAMP_store4
	movl	$1, 16(%rsp)
	movl	$27, %edi
	callq	LAMP_loop_invocation
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_5:                                # %if.else
                                        #   in Loop: Header=BB0_1 Depth=1
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 24(%rsp)
	movl	$14, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	16(%rsp), %eax
	addl	$2, %eax
	movslq	%eax, %rbx
	movl	$15, %edi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 16(%rsp)
	callq	LAMP_loop_iteration_end
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	callq	LAMP_loop_iteration_begin
	movl	$5, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	cmpl	$30000, 16(%rsp)        # imm = 0x7530
	jg	.LBB0_6
# BB#2:                                 # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$6, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	movl	24(%rsp), %ebx
	movl	$7, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	16(%rsp), %eax
	addl	%ebx, %eax
	movslq	%eax, %rbx
	movl	$8, %edi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 24(%rsp)
	movl	$9, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	movslq	24(%rsp), %rax
	imulq	$1717986919, %rax, %rcx # imm = 0x66666667
	movq	%rcx, %rdx
	shrq	$63, %rdx
	sarq	$34, %rcx
	addl	%edx, %ecx
	imull	$10, %ecx, %ecx
	subl	%ecx, %eax
	jne	.LBB0_4
# BB#3:                                 # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$10, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	movl	24(%rsp), %eax
	addl	$3, %eax
	movslq	%eax, %rbx
	movl	$11, %edi
	jmp	.LBB0_5
.LBB0_4:                                # %if.else
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$12, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	movl	24(%rsp), %eax
	addl	$5, %eax
	movslq	%eax, %rbx
	movl	$13, %edi
	jmp	.LBB0_5
.LBB0_6:                                # %for.end
	callq	LAMP_loop_iteration_end
	callq	LAMP_loop_exit
	leaq	24(%rsp), %r14
	movl	$16, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	24(%rsp), %ebp
	movl	$17, %edi
	callq	LAMP_register
	movl	$.L.str, %edi
	movl	%ebp, %esi
	xorb	%al, %al
	callq	printf
	movl	$18, %edi
	callq	LAMP_register
	movl	$t_end, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movl	$19, %edi
	movl	$t_end, %esi
	callq	LAMP_load8
	movq	t_end(%rip), %r12
	movl	$20, %edi
	movl	$t_start, %esi
	callq	LAMP_load8
	movq	t_start(%rip), %r15
	movl	$21, %edi
	movl	$t_end+8, %esi
	callq	LAMP_load8
	movq	t_end+8(%rip), %rbx
	movl	$22, %edi
	movl	$t_start+8, %esi
	callq	LAMP_load8
	subq	%r15, %r12
	movq	t_start+8(%rip), %rax
	subq	%rax, %rbx
	cvtsi2sdq	%rbx, %xmm1
	cvtsi2sdq	%r12, %xmm0
	divsd	.LCPI0_0(%rip), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, 8(%rsp)          # 8-byte Spill
	cvttsd2siq	%xmm1, %rdx
	movl	$23, %edi
	movl	$t_diff, %esi
	callq	LAMP_store8
	movsd	8(%rsp), %xmm0          # 8-byte Reload
	movsd	%xmm0, t_diff(%rip)
	movl	$24, %edi
	movl	$t_diff, %esi
	callq	LAMP_load8
	movsd	t_diff(%rip), %xmm0
	movsd	%xmm0, 8(%rsp)          # 8-byte Spill
	movl	$25, %edi
	callq	LAMP_register
	movl	$.L.str1, %edi
	movsd	8(%rsp), %xmm0          # 8-byte Reload
	movb	$1, %al
	callq	printf
	movl	$26, %edi
	movq	%r14, %rsi
	callq	LAMP_load4
	movl	24(%rsp), %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	ret
.Ltmp17:
	.size	main, .Ltmp17-main
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


	.section	".note.GNU-stack","",@progbits
