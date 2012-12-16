	.file	"loop_peeling_2.slicm.bc"
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
	movl	$-2, %ebx
	addl	$2, %eax
	.align	16, 0x90
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_4
# BB#2:                                 # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	leal	10(%rax), %ecx
	movslq	%ecx, %rcx
	imulq	$1717986919, %rcx, %rdx # imm = 0x66666667
	movq	%rdx, %rsi
	shrq	$63, %rsi
	sarq	$34, %rdx
	addl	%esi, %edx
	imull	$10, %edx, %edx
	subl	%edx, %ecx
	je	.LBB0_3
# BB#5:                                 # %if.else
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$-3, %ebx
	addl	$2, %eax
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_4
# BB#6:                                 # %for.body_copy
                                        #   in Loop: Header=BB0_1 Depth=1
	leal	10(%rax), %ecx
	movslq	%ecx, %rcx
	imulq	$1717986919, %rcx, %rdx # imm = 0x66666667
	movq	%rdx, %rsi
	shrq	$63, %rsi
	sarq	$34, %rdx
	addl	%esi, %edx
	imull	$10, %edx, %edx
	subl	%edx, %ecx
	je	.LBB0_3
# BB#7:                                 # %if.else_copy
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$-3, %ebx
	addl	$2, %eax
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_4
# BB#8:                                 # %for.body_copy6
                                        #   in Loop: Header=BB0_1 Depth=1
	leal	10(%rax), %ecx
	movslq	%ecx, %rcx
	imulq	$1717986919, %rcx, %rdx # imm = 0x66666667
	movq	%rdx, %rsi
	shrq	$63, %rsi
	sarq	$34, %rdx
	addl	%esi, %edx
	imull	$10, %edx, %edx
	subl	%edx, %ecx
	je	.LBB0_3
# BB#9:                                 # %if.else_copy10
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$-3, %ebx
	addl	$2, %eax
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_4
# BB#10:                                # %for.body_copy_copy
                                        #   in Loop: Header=BB0_1 Depth=1
	leal	10(%rax), %ecx
	movslq	%ecx, %rcx
	imulq	$1717986919, %rcx, %rdx # imm = 0x66666667
	movq	%rdx, %rsi
	shrq	$63, %rsi
	sarq	$34, %rdx
	addl	%esi, %edx
	imull	$10, %edx, %edx
	subl	%edx, %ecx
	je	.LBB0_3
# BB#11:                                # %if.else_copy_copy
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$-3, %ebx
	addl	$2, %eax
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_4
# BB#12:                                # %for.body_copy19
                                        #   in Loop: Header=BB0_1 Depth=1
	leal	10(%rax), %ecx
	movslq	%ecx, %rcx
	imulq	$1717986919, %rcx, %rdx # imm = 0x66666667
	movq	%rdx, %rsi
	shrq	$63, %rsi
	sarq	$34, %rdx
	addl	%esi, %edx
	imull	$10, %edx, %edx
	subl	%edx, %ecx
	je	.LBB0_3
# BB#13:                                # %if.else_copy23
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$-3, %ebx
	addl	$2, %eax
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_4
# BB#14:                                # %for.body_copy_copy32
                                        #   in Loop: Header=BB0_1 Depth=1
	leal	10(%rax), %ecx
	movslq	%ecx, %rcx
	imulq	$1717986919, %rcx, %rdx # imm = 0x66666667
	movq	%rdx, %rsi
	shrq	$63, %rsi
	sarq	$34, %rdx
	addl	%esi, %edx
	imull	$10, %edx, %edx
	subl	%edx, %ecx
	je	.LBB0_3
# BB#15:                                # %if.else_copy_copy36
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$-3, %ebx
	addl	$2, %eax
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_4
# BB#16:                                # %for.body_copy6_copy
                                        #   in Loop: Header=BB0_1 Depth=1
	leal	10(%rax), %ecx
	movslq	%ecx, %rcx
	imulq	$1717986919, %rcx, %rdx # imm = 0x66666667
	movq	%rdx, %rsi
	shrq	$63, %rsi
	sarq	$34, %rdx
	addl	%esi, %edx
	imull	$10, %edx, %edx
	subl	%edx, %ecx
	je	.LBB0_3
# BB#17:                                # %if.else_copy10_copy
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$-3, %ebx
	addl	$2, %eax
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_4
# BB#18:                                # %for.body_copy_copy_copy
                                        #   in Loop: Header=BB0_1 Depth=1
	leal	10(%rax), %ecx
	movslq	%ecx, %rcx
	imulq	$1717986919, %rcx, %rdx # imm = 0x66666667
	movq	%rdx, %rsi
	shrq	$63, %rsi
	sarq	$34, %rdx
	addl	%esi, %edx
	imull	$10, %edx, %edx
	subl	%edx, %ecx
	je	.LBB0_3
# BB#19:                                # %if.else_copy_copy_copy
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$-3, %ebx
	addl	$2, %eax
	jmp	.LBB0_1
.LBB0_4:                                # %for.end
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
