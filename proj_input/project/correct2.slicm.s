	.file	"correct2.slicm.bc"
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
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_2:                                # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	%ecx, a(,%rcx,4)
	incq	%rcx
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$99, %ecx
	jg	.LBB0_4
	jmp	.LBB0_2
	.align	16, 0x90
.LBB0_3:                                # %if.end
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	a+388(%rip), %ecx
	leal	2(%rcx,%rcx,2), %ecx
	movslq	%eax, %rax
	movl	%ecx, b(,%rax,4)
	incl	%eax
	.align	16, 0x90
.LBB0_4:                                # %for.cond1
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$99, %eax
	jg	.LBB0_7
# BB#5:                                 # %for.body3
                                        #   in Loop: Header=BB0_4 Depth=1
	cmpl	$1000, %eax             # imm = 0x3E8
	jl	.LBB0_3
# BB#6:                                 # %if.then
                                        #   in Loop: Header=BB0_4 Depth=1
	leal	1(%rax), %ecx
	movslq	%ecx, %rdx
	movl	$1, a(,%rdx,4)
	movl	a+388(%rip), %edx
	leal	2(%rdx,%rdx,2), %edx
	movslq	%eax, %rax
	movl	%edx, b(,%rax,4)
	movl	%ecx, %eax
	jmp	.LBB0_4
.LBB0_7:                                # %for.end12
	movl	b+396(%rip), %ecx
	movl	b+392(%rip), %edx
	movl	b+388(%rip), %esi
	movl	$.L.str, %edi
	xorb	%al, %al
	callq	printf
	xorl	%eax, %eax
	popq	%rdx
	ret
.Ltmp2:
	.size	main, .Ltmp2-main
	.cfi_endproc

	.type	a,@object               # @a
	.comm	a,400,16
	.type	b,@object               # @b
	.comm	b,400,16
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	 "%d, %d, %d\n"
	.size	.L.str, 12


	.section	".note.GNU-stack","",@progbits
