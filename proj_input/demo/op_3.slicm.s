	.file	"op_3.slicm.bc"
	.text
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Ltmp3:
	.cfi_def_cfa_offset 16
	pushq	%rbx
.Ltmp4:
	.cfi_def_cfa_offset 24
	pushq	%rax
.Ltmp5:
	.cfi_def_cfa_offset 32
.Ltmp6:
	.cfi_offset %rbx, -24
.Ltmp7:
	.cfi_offset %rbp, -16
	movq	8(%rsi), %rdi
	xorb	%al, %al
	callq	atoi
	movl	%eax, %ebx
	addl	$10, %ebx
	xorl	%ebp, %ebp
	imull	$10, %ebx, %eax
	imull	$20, %ebx, %ecx
	movl	%ebp, %edx
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_4:                                # %if.else
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	%ecx, %ebp
	.align	16, 0x90
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$9, %edx
	jg	.LBB0_5
# BB#2:                                 # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	%edx
	testl	%ebx, %ebx
	jne	.LBB0_4
# BB#3:                                 # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	%eax, %ebp
	jmp	.LBB0_1
.LBB0_5:                                # %for.end
	xorb	%al, %al
	callq	rand
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%eax, %ecx
	andl	$-2, %ecx
	subl	%ecx, %eax
	je	.LBB0_6
# BB#7:                                 # %if.else7
	movl	$.L.str1, %edi
	movl	%ebp, %esi
	movl	%ebx, %edx
	xorb	%al, %al
	callq	printf
	jmp	.LBB0_8
.LBB0_6:                                # %if.then5
	movl	$.L.str, %edi
	movl	%ebx, %esi
	xorb	%al, %al
	callq	printf
.LBB0_8:                                # %if.end9_copy
	xorl	%eax, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	ret
.Ltmp8:
	.size	main, .Ltmp8-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	 "%d"
	.size	.L.str, 3

	.type	.L.str1,@object         # @.str1
.L.str1:
	.asciz	 "In else: %d,%d"
	.size	.L.str1, 15

	.type	t_start,@object         # @t_start
	.comm	t_start,16,8
	.type	t_end,@object           # @t_end
	.comm	t_end,16,8
	.type	t_diff,@object          # @t_diff
	.comm	t_diff,8,8

	.section	".note.GNU-stack","",@progbits
