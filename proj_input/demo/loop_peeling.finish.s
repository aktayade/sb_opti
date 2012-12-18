	.file	"loop_peeling.finish.bc"
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
	subq	$48, %rsp
.Ltmp3:
	.cfi_def_cfa_offset 64
.Ltmp4:
	.cfi_offset %rbx, -16
	movl	$t_start, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movl	$1, 44(%rsp)
	movl	$3, 40(%rsp)
	movl	$5, 36(%rsp)
	movl	$7, 32(%rsp)
	movl	$9, 28(%rsp)
	xorl	%ebx, %ebx
	movl	$11, 24(%rsp)
	movl	$13, 20(%rsp)
	movl	$15, 16(%rsp)
	movb	$0, 15(%rsp)
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_20:                               # %for.inc_copy_copy
                                        #   in Loop: Header=BB0_1 Depth=1
	addl	$2, %eax
	movl	%eax, 40(%rsp)
	.align	16, 0x90
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	44(%rsp), %eax
	movb	$0, 15(%rsp)
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_21
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
# BB#5:                                 # %if.else
                                        #   in Loop: Header=BB0_1 Depth=1
	addl	$5, %ebx
	addl	$16, %eax
	movl	%eax, 44(%rsp)
	movb	$1, 15(%rsp)
	movl	40(%rsp), %eax
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_21
# BB#6:                                 # %for.body_copy
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
# BB#7:                                 # %if.else_copy
                                        #   in Loop: Header=BB0_1 Depth=1
	addl	$5, %ebx
	addl	$16, %eax
	movl	%eax, 40(%rsp)
	movl	36(%rsp), %eax
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_21
# BB#8:                                 # %for.body_copy6
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
# BB#9:                                 # %if.else_copy10
                                        #   in Loop: Header=BB0_1 Depth=1
	addl	$5, %ebx
	addl	$16, %eax
	movl	%eax, 36(%rsp)
	movl	32(%rsp), %eax
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_21
# BB#10:                                # %for.body_copy_copy
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
# BB#11:                                # %if.else_copy_copy
                                        #   in Loop: Header=BB0_1 Depth=1
	addl	$5, %ebx
	addl	$16, %eax
	movl	%eax, 32(%rsp)
	movl	28(%rsp), %eax
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_21
# BB#12:                                # %for.body_copy17
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
# BB#13:                                # %if.else_copy21
                                        #   in Loop: Header=BB0_1 Depth=1
	addl	$5, %ebx
	addl	$16, %eax
	movl	%eax, 28(%rsp)
	movl	24(%rsp), %eax
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_21
# BB#14:                                # %for.body_copy_copy28
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
# BB#15:                                # %if.else_copy_copy32
                                        #   in Loop: Header=BB0_1 Depth=1
	addl	$5, %ebx
	addl	$16, %eax
	movl	%eax, 24(%rsp)
	movl	20(%rsp), %eax
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_21
# BB#16:                                # %for.body_copy6_copy
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
# BB#17:                                # %if.else_copy10_copy
                                        #   in Loop: Header=BB0_1 Depth=1
	addl	$5, %ebx
	addl	$16, %eax
	movl	%eax, 20(%rsp)
	movl	16(%rsp), %eax
	cmpl	$30000, %eax            # imm = 0x7530
	jg	.LBB0_21
# BB#18:                                # %for.body_copy_copy_copy
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
# BB#19:                                # %if.else_copy_copy_copy
                                        #   in Loop: Header=BB0_1 Depth=1
	addl	$5, %ebx
	addl	$16, %eax
	movl	%eax, 16(%rsp)
	jmp	.LBB0_1
.LBB0_3:                                # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	addl	$3, %ebx
	movb	15(%rsp), %cl
	cmpb	$1, %cl
	jne	.LBB0_20
# BB#4:                                 # %for.inc_copy
                                        #   in Loop: Header=BB0_1 Depth=1
	addl	$16, %eax
	movl	%eax, 40(%rsp)
	jmp	.LBB0_1
.LBB0_21:                               # %for.end
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
	addq	$48, %rsp
	popq	%rbx
	ret
.Ltmp5:
	.size	main, .Ltmp5-main
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
