	.file	"test1.profile.ls.bc"
	.text
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	subq	$24, %rsp
.Ltmp1:
	.cfi_def_cfa_offset 32
	xorl	%edi, %edi
	xorl	%esi, %esi
	movl	$EdgeProfCounters, %edx
	movl	$18, %ecx
	callq	llvm_start_edge_profiling
	incl	EdgeProfCounters(%rip)
	movl	$0, 20(%rsp)
	movl	$10, 16(%rsp)
	movl	$5, 12(%rsp)
	movl	$6, 8(%rsp)
	movl	$20, 4(%rsp)
	movl	$0, (%rsp)
	incl	EdgeProfCounters+4(%rip)
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_11:                               # %if.end13
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+64(%rip)
	incl	(%rsp)
	incl	EdgeProfCounters+68(%rip)
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$99, (%rsp)
	jg	.LBB0_12
# BB#2:                                 # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+8(%rip)
	movl	16(%rsp), %eax
	cmpl	12(%rsp), %eax
	jne	.LBB0_4
# BB#3:                                 # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+16(%rip)
	movl	16(%rsp), %eax
	addl	12(%rsp), %eax
	movl	%eax, 8(%rsp)
	incl	EdgeProfCounters+24(%rip)
	jmp	.LBB0_5
.LBB0_4:                                # %if.else
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+20(%rip)
	movl	16(%rsp), %eax
	subl	12(%rsp), %eax
	movl	%eax, 8(%rsp)
	incl	EdgeProfCounters+28(%rip)
.LBB0_5:                                # %if.end
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	4(%rsp), %eax
	cmpl	12(%rsp), %eax
	jne	.LBB0_7
# BB#6:                                 # %if.then3
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+32(%rip)
	movl	16(%rsp), %eax
	addl	12(%rsp), %eax
	movl	%eax, 4(%rsp)
	incl	EdgeProfCounters+40(%rip)
	jmp	.LBB0_8
.LBB0_7:                                # %if.else5
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+36(%rip)
	movl	16(%rsp), %eax
	subl	12(%rsp), %eax
	movl	%eax, 8(%rsp)
	incl	EdgeProfCounters+44(%rip)
.LBB0_8:                                # %if.end7
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	16(%rsp), %eax
	cmpl	12(%rsp), %eax
	jne	.LBB0_10
# BB#9:                                 # %if.then9
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+48(%rip)
	movl	16(%rsp), %eax
	addl	12(%rsp), %eax
	movl	%eax, 8(%rsp)
	incl	EdgeProfCounters+56(%rip)
	jmp	.LBB0_11
.LBB0_10:                               # %if.else11
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	EdgeProfCounters+52(%rip)
	movl	16(%rsp), %eax
	subl	12(%rsp), %eax
	movl	%eax, 8(%rsp)
	incl	EdgeProfCounters+60(%rip)
	jmp	.LBB0_11
.LBB0_12:                               # %for.end
	incl	EdgeProfCounters+12(%rip)
	movl	4(%rsp), %r8d
	movl	8(%rsp), %ecx
	movl	12(%rsp), %edx
	movl	16(%rsp), %esi
	movl	$.L.str, %edi
	xorb	%al, %al
	callq	printf
	xorl	%eax, %eax
	addq	$24, %rsp
	ret
.Ltmp2:
	.size	main, .Ltmp2-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	 "%d,%d,%d,%d\n"
	.size	.L.str, 13

	.type	EdgeProfCounters,@object # @EdgeProfCounters
	.local	EdgeProfCounters
	.comm	EdgeProfCounters,72,16

	.section	".note.GNU-stack","",@progbits
