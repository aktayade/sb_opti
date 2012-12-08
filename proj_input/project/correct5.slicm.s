	.file	"correct5.slicm.bc"
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
	movl	$1, b(,%rcx,4)
	incq	%rcx
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$99, %ecx
	jg	.LBB0_4
	jmp	.LBB0_2
	.align	16, 0x90
.LBB0_3:                                # %if.end
                                        #   in Loop: Header=BB0_4 Depth=1
	movl	a+388(%rip), %eax
	imull	$3, a+392(%rip), %edx
	leal	(%rdx,%rax,2), %eax
	movl	a+396(%rip), %edx
	leal	10(%rax,%rdx,4), %eax
	movl	%eax, c(,%rcx,4)
	movl	b+388(%rip), %eax
	imull	$3, a+396(%rip), %edx
	leal	(%rdx,%rax,2), %eax
	movl	%eax, d(,%rcx,4)
	incl	%ecx
	movl	%ecx, %eax
	.align	16, 0x90
.LBB0_4:                                # %for.cond3
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$99, %eax
	jg	.LBB0_7
# BB#5:                                 # %for.body5
                                        #   in Loop: Header=BB0_4 Depth=1
	movslq	%eax, %rcx
	cmpl	$96, a(,%rcx,4)
	jl	.LBB0_3
# BB#6:                                 # %if.then
                                        #   in Loop: Header=BB0_4 Depth=1
	incl	%eax
	movslq	%eax, %rdx
	movl	$1, a(,%rdx,4)
	movl	$0, b(,%rdx,4)
	movl	a+388(%rip), %edx
	imull	$3, a+392(%rip), %esi
	leal	(%rsi,%rdx,2), %edx
	movl	a+396(%rip), %esi
	leal	10(%rdx,%rsi,4), %edx
	movl	%edx, c(,%rcx,4)
	movl	b+388(%rip), %edx
	imull	$3, a+396(%rip), %esi
	leal	(%rsi,%rdx,2), %edx
	movl	%edx, d(,%rcx,4)
	jmp	.LBB0_4
.LBB0_7:                                # %for.end28
	movl	c+396(%rip), %ecx
	movl	c+392(%rip), %edx
	movl	c+388(%rip), %esi
	movl	$.L.str, %edi
	xorb	%al, %al
	callq	printf
	movl	d+396(%rip), %ecx
	movl	d+392(%rip), %edx
	movl	d+388(%rip), %esi
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
	.type	c,@object               # @c
	.comm	c,400,16
	.type	d,@object               # @d
	.comm	d,400,16
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	 "%d, %d, %d\n"
	.size	.L.str, 12


	.section	".note.GNU-stack","",@progbits
