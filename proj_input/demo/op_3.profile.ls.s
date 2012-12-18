	.file	"op_3.profile.ls.bc"
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
	movq	%rsi, %rbx
	movl	$EdgeProfCounters, %edx
	movl	$14, %ecx
	callq	llvm_start_edge_profiling
	incl	EdgeProfCounters(%rip)
	movl	$0, 44(%rsp)
	movl	%eax, 40(%rsp)
	movq	%rbx, 32(%rsp)
	movl	$0, 28(%rsp)
	movq	32(%rsp), %rax
	movq	8(%rax), %rdi
	xorb	%al, %al
	callq	atoi
	movl	%eax, 20(%rsp)
	movl	$0, 16(%rsp)
	movl	20(%rsp), %eax
	addl	$10, %eax
	movl	%eax, 12(%rsp)
	movl	$0, 8(%rsp)
	incl	EdgeProfCounters+4(%rip)
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_5:                                # %if.end
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+32(%rip)
	incl	8(%rsp)
	incl	EdgeProfCounters+36(%rip)
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$9, 8(%rsp)
	jg	.LBB0_6
# BB#2:                                 # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+8(%rip)
	movl	12(%rsp), %eax
	movl	%eax, 24(%rsp)
	cmpl	$0, 12(%rsp)
	jne	.LBB0_4
# BB#3:                                 # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+16(%rip)
	imull	$10, 12(%rsp), %eax
	movl	%eax, 28(%rsp)
	incl	EdgeProfCounters+24(%rip)
	jmp	.LBB0_5
.LBB0_4:                                # %if.else
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+20(%rip)
	imull	$20, 12(%rsp), %eax
	movl	%eax, 28(%rsp)
	incl	EdgeProfCounters+28(%rip)
	jmp	.LBB0_5
.LBB0_6:                                # %for.end
	incl	EdgeProfCounters+12(%rip)
	xorb	%al, %al
	callq	rand
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%eax, %ecx
	andl	$-2, %ecx
	subl	%ecx, %eax
	je	.LBB0_7
# BB#8:                                 # %if.else7
	incl	EdgeProfCounters+44(%rip)
	movl	24(%rsp), %edx
	movl	28(%rsp), %esi
	movl	$.L.str1, %edi
	xorb	%al, %al
	callq	printf
	incl	EdgeProfCounters+52(%rip)
	jmp	.LBB0_9
.LBB0_7:                                # %if.then5
	incl	EdgeProfCounters+40(%rip)
	movl	24(%rsp), %esi
	movl	$.L.str, %edi
	xorb	%al, %al
	callq	printf
	incl	EdgeProfCounters+48(%rip)
.LBB0_9:                                # %if.end9
	movl	44(%rsp), %eax
	addq	$48, %rsp
	popq	%rbx
	ret
.Ltmp5:
	.size	main, .Ltmp5-main
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
	.type	EdgeProfCounters,@object # @EdgeProfCounters
	.local	EdgeProfCounters
	.comm	EdgeProfCounters,56,16

	.section	".note.GNU-stack","",@progbits
