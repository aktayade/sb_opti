	.file	"operation_migration.profile.ls.bc"
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
	movl	$9, %ecx
	callq	llvm_start_edge_profiling
	incl	EdgeProfCounters(%rip)
	movl	$0, 20(%rsp)
	movl	$0, 16(%rsp)
	movl	$10, 8(%rsp)
	movl	$20, 12(%rsp)
	cmpl	$0, 8(%rsp)
	je	.LBB0_1
# BB#2:                                 # %if.else
	incl	EdgeProfCounters+8(%rip)
	imull	$20, 8(%rsp), %eax
	movl	%eax, 16(%rsp)
	incl	EdgeProfCounters+16(%rip)
	jmp	.LBB0_3
.LBB0_1:                                # %if.then
	incl	EdgeProfCounters+4(%rip)
	imull	$10, 8(%rsp), %eax
	movl	%eax, 16(%rsp)
	incl	EdgeProfCounters+12(%rip)
.LBB0_3:                                # %if.end
	xorb	%al, %al
	callq	rand
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%eax, %ecx
	andl	$-2, %ecx
	subl	%ecx, %eax
	je	.LBB0_4
# BB#5:                                 # %if.else5
	incl	EdgeProfCounters+24(%rip)
	movl	12(%rsp), %edx
	movl	16(%rsp), %esi
	movl	$.L.str1, %edi
	xorb	%al, %al
	callq	printf
	incl	EdgeProfCounters+32(%rip)
	jmp	.LBB0_6
.LBB0_4:                                # %if.then3
	incl	EdgeProfCounters+20(%rip)
	movl	12(%rsp), %esi
	movl	$.L.str, %edi
	xorb	%al, %al
	callq	printf
	incl	EdgeProfCounters+28(%rip)
.LBB0_6:                                # %if.end7
	movl	20(%rsp), %eax
	addq	$24, %rsp
	ret
.Ltmp2:
	.size	main, .Ltmp2-main
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

	.type	EdgeProfCounters,@object # @EdgeProfCounters
	.local	EdgeProfCounters
	.comm	EdgeProfCounters,36,16

	.section	".note.GNU-stack","",@progbits
