	.file	"test1.slicm.bc"
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
	movl	$20, %r8d
	movl	$6, %ecx
	movl	$-1, %eax
	movb	$1, %dl
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_5:                                # %if.then9
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$15, %ecx
	.align	16, 0x90
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	incl	%eax
	cmpl	$99, %eax
	jg	.LBB0_7
# BB#2:                                 # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	testb	%dl, %dl
	cmpl	$5, %r8d
	jne	.LBB0_4
# BB#3:                                 # %if.then3
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$15, %r8d
.LBB0_4:                                # %if.end7
                                        #   in Loop: Header=BB0_1 Depth=1
	testb	%dl, %dl
	je	.LBB0_5
# BB#6:                                 # %if.else11
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$5, %ecx
	jmp	.LBB0_1
.LBB0_7:                                # %for.end
	movl	$.L.str, %edi
	movl	$10, %esi
	movl	$5, %edx
	xorb	%al, %al
	callq	printf
	xorl	%eax, %eax
	popq	%rdx
	ret
.Ltmp2:
	.size	main, .Ltmp2-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	 "%d,%d,%d,%d\n"
	.size	.L.str, 13


	.section	".note.GNU-stack","",@progbits
