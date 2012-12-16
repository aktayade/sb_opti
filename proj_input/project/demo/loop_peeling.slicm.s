	.file	"loop_peeling.slicm.bc"
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
.Ltmp3:
	.cfi_offset %rbx, -16
	movl	$t_start, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movl	$1, %eax
	xorl	%ebx, %ebx
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_3:                                # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	addl	$3, %ebx
	addl	$2, %eax
	.align	16, 0x90
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_7
# BB#2:                                 # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	addl	%eax, %ebx
	movslq	%ebx, %rcx
	imulq	$1717986919, %rcx, %rcx # imm = 0x66666667
	movq	%rcx, %rdx
	shrq	$63, %rdx
	sarq	$34, %rcx
	addl	%edx, %ecx
	imull	$10, %ecx, %ecx
	movl	%ebx, %edx
	subl	%ecx, %edx
	je	.LBB0_3
# BB#4:                                 # %if.else
                                        #   in Loop: Header=BB0_1 Depth=1
	addl	$5, %ebx
	addl	$2, %eax
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_7
# BB#5:                                 # %for.body_copy
                                        #   in Loop: Header=BB0_1 Depth=1
	addl	%eax, %ebx
	movslq	%ebx, %rcx
	imulq	$1717986919, %rcx, %rcx # imm = 0x66666667
	movq	%rcx, %rdx
	shrq	$63, %rdx
	sarq	$34, %rcx
	addl	%edx, %ecx
	imull	$10, %ecx, %ecx
	movl	%ebx, %edx
	subl	%ecx, %edx
	je	.LBB0_3
# BB#6:                                 # %if.else_copy
                                        #   in Loop: Header=BB0_1 Depth=1
	addl	$5, %ebx
	addl	$2, %eax
	jmp	.LBB0_1
.LBB0_7:                                # %for.end
	movl	$.L.str, %edi
	movl	%ebx, %esi
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
	movl	%ebx, %eax
	popq	%rbx
	ret
.Ltmp4:
	.size	main, .Ltmp4-main
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
