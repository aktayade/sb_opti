	.file	"operation_migration.slicm.bc"
	.text
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rax
.Ltmp1:
	.cfi_def_cfa_offset 16
	movb	$1, %al
	testb	%al, %al
	je	.LBB0_6
# BB#1:                                 # %if.end
	xorb	%al, %al
	callq	rand
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%eax, %ecx
	andl	$-2, %ecx
	subl	%ecx, %eax
	je	.LBB0_2
# BB#3:                                 # %if.else5
	movl	$.L.str1, %edi
	movl	$200, %esi
	jmp	.LBB0_4
.LBB0_6:                                # %if.end_copy
	xorb	%al, %al
	callq	rand
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%eax, %ecx
	andl	$-2, %ecx
	subl	%ecx, %eax
	je	.LBB0_2
# BB#7:                                 # %if.else5_copy
	movl	$.L.str1, %edi
	movl	$100, %esi
.LBB0_4:                                # %if.else5
	movl	$20, %edx
	xorb	%al, %al
	callq	printf
	jmp	.LBB0_5
.LBB0_2:                                # %if.then3
	movl	$.L.str, %edi
	movl	$20, %esi
	xorb	%al, %al
	callq	printf
.LBB0_5:                                # %if.end7
	xorl	%eax, %eax
	popq	%rdx
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


	.section	".note.GNU-stack","",@progbits
