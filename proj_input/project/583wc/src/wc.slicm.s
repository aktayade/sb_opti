	.file	"wc.slicm.bc"
	.text
	.globl	my_filbuf
	.align	16, 0x90
	.type	my_filbuf,@function
my_filbuf:                              # @my_filbuf
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbx
.Ltmp2:
	.cfi_def_cfa_offset 16
.Ltmp3:
	.cfi_offset %rbx, -16
	movq	%rdi, %rbx
	movl	$buffer, %edi
	movl	$1, %esi
	movl	$8192, %edx             # imm = 0x2000
	movq	%rbx, %rcx
	callq	fread
	movl	%eax, bufcount(%rip)
	movl	$0, bufcurrent(%rip)
	movq	%rbx, %rdi
	callq	feof
	testl	%eax, %eax
	je	.LBB0_2
# BB#1:                                 # %if.then
	movslq	bufcount(%rip), %rax
	leal	1(%rax), %ecx
	movl	%ecx, bufcount(%rip)
	movb	$-1, buffer(%rax)
.LBB0_2:                                # %if.end
	popq	%rbx
	ret
.Ltmp4:
	.size	my_filbuf, .Ltmp4-my_filbuf
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.align	8
.LCPI1_0:
	.quad	4696837146684686336     # double 1.000000e+06
                                        #  (0x412e848000000000)
	.text
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Ltmp11:
	.cfi_def_cfa_offset 16
	pushq	%r15
.Ltmp12:
	.cfi_def_cfa_offset 24
	pushq	%r14
.Ltmp13:
	.cfi_def_cfa_offset 32
	pushq	%r12
.Ltmp14:
	.cfi_def_cfa_offset 40
	pushq	%rbx
.Ltmp15:
	.cfi_def_cfa_offset 48
.Ltmp16:
	.cfi_offset %rbx, -48
.Ltmp17:
	.cfi_offset %r12, -40
.Ltmp18:
	.cfi_offset %r14, -32
.Ltmp19:
	.cfi_offset %r15, -24
.Ltmp20:
	.cfi_offset %rbp, -16
	movq	%rsi, %r14
	movl	%edi, %ebx
	movl	$t_start, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movl	$1049089, %eax          # imm = 0x100201
	jmp	.LBB1_1
	.align	16, 0x90
.LBB1_6:                                # %sw.bb
                                        #   in Loop: Header=BB1_1 Depth=1
	movq	8(%r14), %rcx
	incq	%rcx
	movq	%rcx, wd(%rip)
	addq	$8, %r14
	decl	%ebx
.LBB1_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	xorb	%cl, %cl
	cmpl	$2, %ebx
	jl	.LBB1_3
# BB#2:                                 # %land.rhs
                                        #   in Loop: Header=BB1_1 Depth=1
	movq	8(%r14), %rcx
	movsbl	(%rcx), %ecx
	cmpl	$45, %ecx
	sete	%cl
.LBB1_3:                                # %land.end
                                        #   in Loop: Header=BB1_1 Depth=1
	cmpb	$1, %cl
	jne	.LBB1_7
# BB#4:                                 # %while.body
                                        #   in Loop: Header=BB1_1 Depth=1
	movq	8(%r14), %rcx
	movsbl	1(%rcx), %ecx
	addl	$-99, %ecx
	cmpl	$20, %ecx
	ja	.LBB1_37
# BB#5:                                 # %while.body
                                        #   in Loop: Header=BB1_1 Depth=1
	btl	%ecx, %eax
	jb	.LBB1_6
.LBB1_37:                               # %usage
	movq	stderr(%rip), %rdi
	movl	$.L.str1, %esi
	xorb	%al, %al
	callq	fprintf
	movl	$1, %edi
	callq	exit
.LBB1_7:                                # %while.end
	movl	$1, %ebp
	movq	stdin(%rip), %r15
	.align	16, 0x90
.LBB1_8:                                # %do.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_12 Depth 2
                                        #       Child Loop BB1_13 Depth 3
	cmpl	$2, %ebx
	jl	.LBB1_11
# BB#9:                                 # %land.lhs.true
                                        #   in Loop: Header=BB1_8 Depth=1
	movslq	%ebp, %r12
	movq	(%r14,%r12,8), %rdi
	movl	$.L.str2, %esi
	callq	fopen
	movq	%rax, %r15
	testq	%r15, %r15
	jne	.LBB1_11
# BB#10:                                # %if.then
                                        #   in Loop: Header=BB1_8 Depth=1
	movq	(%r14,%r12,8), %rdi
	callq	perror
	jmp	.LBB1_33
.LBB1_11:                               # %if.end
                                        #   in Loop: Header=BB1_8 Depth=1
	movq	$0, linect(%rip)
	movq	$0, wordct(%rip)
	movq	$0, charct(%rip)
	movq	$0, last_charct(%rip)
	jmp	.LBB1_12
	.align	16, 0x90
.LBB1_26:                               # %if.else60
                                        #   in Loop: Header=BB1_12 Depth=2
	incl	main.z(%rip)
	.align	16, 0x90
.LBB1_12:                               # %if.end
                                        #   Parent Loop BB1_8 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_13 Depth 3
	xorl	%r12d, %r12d
	jmp	.LBB1_13
	.align	16, 0x90
.LBB1_20:                               # %if.then42
                                        #   in Loop: Header=BB1_13 Depth=3
	incq	wordct_array+192(%rip)
	movq	$0, last_charct(%rip)
	.align	16, 0x90
.LBB1_13:                               # %for.cond
                                        #   Parent Loop BB1_8 Depth=1
                                        #     Parent Loop BB1_12 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	bufcurrent(%rip), %eax
	cmpl	bufcount(%rip), %eax
	jl	.LBB1_15
# BB#14:                                # %cond.true
                                        #   in Loop: Header=BB1_13 Depth=3
	movq	%r15, %rdi
	callq	my_filbuf
.LBB1_15:                               # %cond.false
                                        #   in Loop: Header=BB1_13 Depth=3
	movslq	bufcurrent(%rip), %rax
	leal	1(%rax), %ecx
	movl	%ecx, bufcurrent(%rip)
	movsbl	buffer(%rax), %eax
	cmpl	$-1, %eax
	je	.LBB1_29
# BB#16:                                # %if.end28
                                        #   in Loop: Header=BB1_13 Depth=3
	incq	charct(%rip)
	incq	last_charct(%rip)
	cmpl	$33, %eax
	jl	.LBB1_22
# BB#17:                                # %land.lhs.true33
                                        #   in Loop: Header=BB1_13 Depth=3
	cmpl	$126, %eax
	jg	.LBB1_22
# BB#18:                                # %if.then36
                                        #   in Loop: Header=BB1_13 Depth=3
	testl	%r12d, %r12d
	jne	.LBB1_13
# BB#19:                                # %if.then37
                                        #   in Loop: Header=BB1_13 Depth=3
	incq	wordct(%rip)
	incl	%r12d
	cmpq	$25, last_charct(%rip)
	jge	.LBB1_20
# BB#21:                                # %if.else
                                        #   in Loop: Header=BB1_13 Depth=3
	movq	last_charct(%rip), %rax
	incq	wordct_array(,%rax,8)
	movq	$0, last_charct(%rip)
	jmp	.LBB1_13
.LBB1_22:                               # %if.end48
                                        #   in Loop: Header=BB1_13 Depth=3
	cmpl	$10, %eax
	je	.LBB1_23
# BB#27:                                # %if.else63
                                        #   in Loop: Header=BB1_13 Depth=3
	cmpl	$32, %eax
	je	.LBB1_12
# BB#28:                                # %land.lhs.true66
                                        #   in Loop: Header=BB1_13 Depth=3
	cmpl	$9, %eax
	je	.LBB1_12
	jmp	.LBB1_13
.LBB1_23:                               # %if.then51
                                        #   in Loop: Header=BB1_12 Depth=2
	movq	linect(%rip), %rax
	incq	%rax
	movq	%rax, linect(%rip)
	cmpq	$21, %rax
	jl	.LBB1_26
# BB#24:                                # %land.lhs.true55
                                        #   in Loop: Header=BB1_12 Depth=2
	cmpq	$11, last_charct(%rip)
	jl	.LBB1_26
# BB#25:                                # %if.then58
                                        #   in Loop: Header=BB1_12 Depth=2
	movabsq	$7378697629483820647, %rax # imm = 0x6666666666666667
	imulq	linect(%rip)
	movq	%rdx, %rax
	shrq	$63, %rax
	shrq	%rdx
	addl	%eax, %edx
	movl	%edx, main.x(%rip)
	imull	$98, %edx, %eax
	movslq	%eax, %rax
	imulq	$-1307163959, %rax, %rcx # imm = 0xFFFFFFFFB21642C9
	shrq	$32, %rcx
	movl	%eax, main.y(%rip)
	movl	%eax, %edx
	addl	%ecx, %edx
	movl	%edx, %ecx
	shrl	$31, %ecx
	sarl	$4, %edx
	addl	%ecx, %edx
	imull	$23, %edx, %ecx
	subl	%ecx, %eax
	movl	%eax, main.z(%rip)
	jmp	.LBB1_12
.LBB1_29:                               # %for.end
                                        #   in Loop: Header=BB1_8 Depth=1
	movq	linect(%rip), %rcx
	movq	wordct(%rip), %rdx
	movq	charct(%rip), %rsi
	movq	wd(%rip), %rdi
	movl	$wordct_array, %r8d
	callq	wcp
	cmpl	$2, %ebx
	jl	.LBB1_31
# BB#30:                                # %if.then74
                                        #   in Loop: Header=BB1_8 Depth=1
	movslq	%ebp, %rax
	movq	(%r14,%rax,8), %rsi
	movl	$.L.str3, %edi
	xorb	%al, %al
	callq	printf
	jmp	.LBB1_32
.LBB1_31:                               # %if.else78
                                        #   in Loop: Header=BB1_8 Depth=1
	movl	$.L.str4, %edi
	xorb	%al, %al
	callq	printf
.LBB1_32:                               # %if.end80
                                        #   in Loop: Header=BB1_8 Depth=1
	movq	%r15, %rdi
	callq	fclose
	movq	linect(%rip), %rax
	addq	%rax, tlinect(%rip)
	movq	wordct(%rip), %rax
	addq	%rax, twordct(%rip)
	movq	charct(%rip), %rax
	addq	%rax, tcharct(%rip)
.LBB1_33:                               # %do.cond
                                        #   in Loop: Header=BB1_8 Depth=1
	incl	%ebp
	cmpl	%ebx, %ebp
	jl	.LBB1_8
# BB#34:                                # %do.end
	cmpl	$3, %ebx
	jl	.LBB1_36
# BB#35:                                # %if.then89
	movq	tlinect(%rip), %rcx
	movq	twordct(%rip), %rdx
	movq	tcharct(%rip), %rsi
	movq	wd(%rip), %rdi
	movl	$wordct_array, %r8d
	callq	wcp
	movl	$.L.str5, %edi
	xorb	%al, %al
	callq	printf
.LBB1_36:                               # %if.end91
	movl	$t_end, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movq	t_end+8(%rip), %rax
	subq	t_start+8(%rip), %rax
	cvtsi2sdq	%rax, %xmm1
	divsd	.LCPI1_0(%rip), %xmm1
	movq	t_end(%rip), %rax
	subq	t_start(%rip), %rax
	cvtsi2sdq	%rax, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, t_diff(%rip)
	movl	$.L.str6, %edi
	movb	$1, %al
	callq	printf
	xorl	%edi, %edi
	callq	exit
.Ltmp21:
	.size	main, .Ltmp21-main
	.cfi_endproc

	.globl	wcp
	.align	16, 0x90
	.type	wcp,@function
wcp:                                    # @wcp
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Ltmp29:
	.cfi_def_cfa_offset 16
	pushq	%r15
.Ltmp30:
	.cfi_def_cfa_offset 24
	pushq	%r14
.Ltmp31:
	.cfi_def_cfa_offset 32
	pushq	%r13
.Ltmp32:
	.cfi_def_cfa_offset 40
	pushq	%r12
.Ltmp33:
	.cfi_def_cfa_offset 48
	pushq	%rbx
.Ltmp34:
	.cfi_def_cfa_offset 56
	pushq	%rax
.Ltmp35:
	.cfi_def_cfa_offset 64
.Ltmp36:
	.cfi_offset %rbx, -56
.Ltmp37:
	.cfi_offset %r12, -48
.Ltmp38:
	.cfi_offset %r13, -40
.Ltmp39:
	.cfi_offset %r14, -32
.Ltmp40:
	.cfi_offset %r15, -24
.Ltmp41:
	.cfi_offset %rbp, -16
	movq	%r8, %r13
	movq	%rcx, %r14
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, %rbx
	movl	$.L.str7, %edi
	xorb	%al, %al
	callq	printf
	xorl	%ebp, %ebp
	jmp	.LBB2_1
	.align	16, 0x90
.LBB2_2:                                # %for.body
                                        #   in Loop: Header=BB2_1 Depth=1
	movq	(%r13,%rbp,8), %rdx
	movl	$.L.str8, %edi
	movl	%ebp, %esi
	xorb	%al, %al
	callq	printf
	incq	%rbp
.LBB2_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$24, %ebp
	jg	.LBB2_5
	jmp	.LBB2_2
	.align	16, 0x90
.LBB2_4:                                # %sw.bb2
                                        #   in Loop: Header=BB2_5 Depth=1
	callq	ipr
	.align	16, 0x90
.LBB2_5:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpb	$0, (%rbx)
	je	.LBB2_11
# BB#6:                                 # %while.body
                                        #   in Loop: Header=BB2_5 Depth=1
	movsbl	(%rbx), %eax
	incq	%rbx
	cmpl	$99, %eax
	jne	.LBB2_7
# BB#10:                                # %sw.bb3
                                        #   in Loop: Header=BB2_5 Depth=1
	movq	%r12, %rdi
	jmp	.LBB2_4
.LBB2_7:                                # %while.body
                                        #   in Loop: Header=BB2_5 Depth=1
	cmpl	$119, %eax
	jne	.LBB2_8
# BB#3:                                 # %sw.bb2
                                        #   in Loop: Header=BB2_5 Depth=1
	movq	%r15, %rdi
	jmp	.LBB2_4
.LBB2_8:                                # %while.body
                                        #   in Loop: Header=BB2_5 Depth=1
	cmpl	$108, %eax
	jne	.LBB2_5
# BB#9:                                 # %sw.bb
                                        #   in Loop: Header=BB2_5 Depth=1
	movq	%r14, %rdi
	jmp	.LBB2_4
.LBB2_11:                               # %while.end
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	ret
.Ltmp42:
	.size	wcp, .Ltmp42-wcp
	.cfi_endproc

	.globl	ipr
	.align	16, 0x90
	.type	ipr,@function
ipr:                                    # @ipr
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rax
.Ltmp44:
	.cfi_def_cfa_offset 16
	movq	%rdi, %rax
	movl	$.L.str9, %edi
	movq	%rax, %rsi
	xorb	%al, %al
	callq	printf
	popq	%rax
	ret
.Ltmp45:
	.size	ipr, .Ltmp45-ipr
	.cfi_endproc

	.type	copyright,@object       # @copyright
	.data
	.globl	copyright
	.align	16
copyright:
	.asciz	 "@(#) Copyright (c) 1980 Regents of the University of California.\n All rights reserved.\n"
	.size	copyright, 88

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	 "lwc"
	.size	.L.str, 4

	.type	wd,@object              # @wd
	.data
	.globl	wd
	.align	8
wd:
	.quad	.L.str
	.size	wd, 8

	.type	buffer,@object          # @buffer
	.local	buffer
	.comm	buffer,8192,16
	.type	bufcount,@object        # @bufcount
	.local	bufcount
	.comm	bufcount,4,4
	.type	bufcurrent,@object      # @bufcurrent
	.local	bufcurrent
	.comm	bufcurrent,4,4
	.type	main.x,@object          # @main.x
	.local	main.x
	.comm	main.x,4,4
	.type	main.y,@object          # @main.y
	.local	main.y
	.comm	main.y,4,4
	.type	main.z,@object          # @main.z
	.local	main.z
	.comm	main.z,4,4
	.type	t_start,@object         # @t_start
	.comm	t_start,16,8
	.type	.L.str1,@object         # @.str1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str1:
	.asciz	 "Usage: wc [-lwc] [files]\n"
	.size	.L.str1, 26

	.type	.L.str2,@object         # @.str2
.L.str2:
	.asciz	 "r"
	.size	.L.str2, 2

	.type	linect,@object          # @linect
	.comm	linect,8,8
	.type	wordct,@object          # @wordct
	.comm	wordct,8,8
	.type	charct,@object          # @charct
	.comm	charct,8,8
	.type	last_charct,@object     # @last_charct
	.comm	last_charct,8,8
	.type	wordct_array,@object    # @wordct_array
	.comm	wordct_array,200,16
	.type	.L.str3,@object         # @.str3
.L.str3:
	.asciz	 " %s\n"
	.size	.L.str3, 5

	.type	.L.str4,@object         # @.str4
.L.str4:
	.asciz	 "\n"
	.size	.L.str4, 2

	.type	tlinect,@object         # @tlinect
	.comm	tlinect,8,8
	.type	twordct,@object         # @twordct
	.comm	twordct,8,8
	.type	tcharct,@object         # @tcharct
	.comm	tcharct,8,8
	.type	.L.str5,@object         # @.str5
.L.str5:
	.asciz	 " total\n"
	.size	.L.str5, 8

	.type	t_end,@object           # @t_end
	.comm	t_end,16,8
	.type	t_diff,@object          # @t_diff
	.comm	t_diff,8,8
	.type	.L.str6,@object         # @.str6
.L.str6:
	.asciz	 " ---  time spent = %.6f  --- \n"
	.size	.L.str6, 31

	.type	.L.str7,@object         # @.str7
.L.str7:
	.asciz	 "Word size histogran\n"
	.size	.L.str7, 21

	.type	.L.str8,@object         # @.str8
.L.str8:
	.asciz	 "%d: %ld\n"
	.size	.L.str8, 9

	.type	.L.str9,@object         # @.str9
.L.str9:
	.asciz	 " %7ld"
	.size	.L.str9, 6

	.type	pagect,@object          # @pagect
	.comm	pagect,8,8
	.type	tpagect,@object         # @tpagect
	.comm	tpagect,8,8

	.section	".note.GNU-stack","",@progbits
