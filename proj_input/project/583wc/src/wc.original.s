	.file	"wc.bc"
	.text
	.globl	my_filbuf
	.align	16, 0x90
	.type	my_filbuf,@function
my_filbuf:                              # @my_filbuf
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rax
.Ltmp1:
	.cfi_def_cfa_offset 16
	movq	%rdi, %rax
	movq	%rax, (%rsp)
	movl	$buffer, %edi
	movl	$1, %esi
	movl	$8192, %edx             # imm = 0x2000
	movq	%rax, %rcx
	callq	fread
	movl	%eax, bufcount(%rip)
	movl	$0, bufcurrent(%rip)
	movq	(%rsp), %rdi
	callq	feof
	testl	%eax, %eax
	je	.LBB0_2
# BB#1:                                 # %if.then
	movslq	bufcount(%rip), %rax
	leal	1(%rax), %ecx
	movl	%ecx, bufcount(%rip)
	movb	$-1, buffer(%rax)
.LBB0_2:                                # %if.end
	popq	%rax
	ret
.Ltmp2:
	.size	my_filbuf, .Ltmp2-my_filbuf
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
	subq	$56, %rsp
.Ltmp4:
	.cfi_def_cfa_offset 64
	movl	$0, 52(%rsp)
	movl	%edi, 48(%rsp)
	movq	%rsi, 40(%rsp)
	movl	$t_start, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movl	$1049089, %eax          # imm = 0x100201
	jmp	.LBB1_1
	.align	16, 0x90
.LBB1_6:                                # %sw.bb
                                        #   in Loop: Header=BB1_1 Depth=1
	movq	40(%rsp), %rcx
	movq	8(%rcx), %rcx
	incq	%rcx
	movq	%rcx, wd(%rip)
	decl	48(%rsp)
	addq	$8, 40(%rsp)
.LBB1_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	xorb	%cl, %cl
	cmpl	$2, 48(%rsp)
	jl	.LBB1_3
# BB#2:                                 # %land.rhs
                                        #   in Loop: Header=BB1_1 Depth=1
	movq	40(%rsp), %rcx
	movq	8(%rcx), %rcx
	movsbl	(%rcx), %ecx
	cmpl	$45, %ecx
	sete	%cl
.LBB1_3:                                # %land.end
                                        #   in Loop: Header=BB1_1 Depth=1
	cmpb	$1, %cl
	jne	.LBB1_7
# BB#4:                                 # %while.body
                                        #   in Loop: Header=BB1_1 Depth=1
	movq	40(%rsp), %rcx
	movq	8(%rcx), %rcx
	movsbl	1(%rcx), %ecx
	addl	$-99, %ecx
	cmpl	$20, %ecx
	ja	.LBB1_38
# BB#5:                                 # %while.body
                                        #   in Loop: Header=BB1_1 Depth=1
	btl	%ecx, %eax
	jb	.LBB1_6
.LBB1_38:                               # %usage
	movq	stderr(%rip), %rdi
	movl	$.L.str1, %esi
	xorb	%al, %al
	callq	fprintf
	movl	$1, %edi
	callq	exit
.LBB1_7:                                # %while.end
	movl	$1, 36(%rsp)
	movq	stdin(%rip), %rax
	movq	%rax, 24(%rsp)
	.align	16, 0x90
.LBB1_8:                                # %do.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_12 Depth 2
                                        #       Child Loop BB1_13 Depth 3
	cmpl	$2, 48(%rsp)
	jl	.LBB1_11
# BB#9:                                 # %land.lhs.true
                                        #   in Loop: Header=BB1_8 Depth=1
	movslq	36(%rsp), %rax
	movq	40(%rsp), %rcx
	movq	(%rcx,%rax,8), %rdi
	movl	$.L.str2, %esi
	callq	fopen
	movq	%rax, 24(%rsp)
	testq	%rax, %rax
	jne	.LBB1_11
# BB#10:                                # %if.then
                                        #   in Loop: Header=BB1_8 Depth=1
	movslq	36(%rsp), %rax
	movq	40(%rsp), %rcx
	movq	(%rcx,%rax,8), %rdi
	callq	perror
	jmp	.LBB1_34
.LBB1_11:                               # %if.end
                                        #   in Loop: Header=BB1_8 Depth=1
	movq	$0, linect(%rip)
	movq	$0, wordct(%rip)
	movq	$0, charct(%rip)
	movl	$0, 32(%rsp)
	jmp	.LBB1_12
	.align	16, 0x90
.LBB1_21:                               # %if.else
                                        #   in Loop: Header=BB1_12 Depth=2
	movq	last_charct(%rip), %rax
	incq	wordct_array(,%rax,8)
	.align	16, 0x90
.LBB1_12:                               # %if.end
                                        #   Parent Loop BB1_8 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_13 Depth 3
	movq	$0, last_charct(%rip)
	jmp	.LBB1_13
	.align	16, 0x90
.LBB1_29:                               # %if.end71
                                        #   in Loop: Header=BB1_13 Depth=3
	movl	$0, 32(%rsp)
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
	movq	24(%rsp), %rdi
	callq	my_filbuf
.LBB1_15:                               # %cond.false
                                        #   in Loop: Header=BB1_13 Depth=3
	movslq	bufcurrent(%rip), %rax
	leal	1(%rax), %ecx
	movl	%ecx, bufcurrent(%rip)
	movsbl	buffer(%rax), %eax
	movl	%eax, 20(%rsp)
	cmpl	$-1, %eax
	je	.LBB1_30
# BB#16:                                # %if.end28
                                        #   in Loop: Header=BB1_13 Depth=3
	incq	charct(%rip)
	incq	last_charct(%rip)
	cmpl	$33, 20(%rsp)
	jl	.LBB1_22
# BB#17:                                # %land.lhs.true33
                                        #   in Loop: Header=BB1_13 Depth=3
	cmpl	$126, 20(%rsp)
	jg	.LBB1_22
# BB#18:                                # %if.then36
                                        #   in Loop: Header=BB1_13 Depth=3
	cmpl	$0, 32(%rsp)
	jne	.LBB1_13
	jmp	.LBB1_19
.LBB1_22:                               # %if.end48
                                        #   in Loop: Header=BB1_13 Depth=3
	cmpl	$10, 20(%rsp)
	jne	.LBB1_27
# BB#23:                                # %if.then51
                                        #   in Loop: Header=BB1_13 Depth=3
	movq	linect(%rip), %rax
	incq	%rax
	movq	%rax, linect(%rip)
	cmpq	$21, %rax
	jl	.LBB1_26
# BB#24:                                # %land.lhs.true55
                                        #   in Loop: Header=BB1_13 Depth=3
	cmpq	$11, last_charct(%rip)
	jl	.LBB1_26
# BB#25:                                # %if.then58
                                        #   in Loop: Header=BB1_13 Depth=3
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
	movl	$0, 32(%rsp)
	jmp	.LBB1_13
.LBB1_27:                               # %if.else63
                                        #   in Loop: Header=BB1_13 Depth=3
	cmpl	$32, 20(%rsp)
	je	.LBB1_29
# BB#28:                                # %land.lhs.true66
                                        #   in Loop: Header=BB1_13 Depth=3
	cmpl	$9, 20(%rsp)
	jne	.LBB1_13
	jmp	.LBB1_29
.LBB1_26:                               # %if.else60
                                        #   in Loop: Header=BB1_13 Depth=3
	incl	main.z(%rip)
	movl	$0, 32(%rsp)
	jmp	.LBB1_13
.LBB1_19:                               # %if.then37
                                        #   in Loop: Header=BB1_12 Depth=2
	incq	wordct(%rip)
	incl	32(%rsp)
	cmpq	$25, last_charct(%rip)
	jl	.LBB1_21
# BB#20:                                # %if.then42
                                        #   in Loop: Header=BB1_12 Depth=2
	incq	wordct_array+192(%rip)
	jmp	.LBB1_12
.LBB1_30:                               # %for.end
                                        #   in Loop: Header=BB1_8 Depth=1
	movq	linect(%rip), %rcx
	movq	wordct(%rip), %rdx
	movq	charct(%rip), %rsi
	movq	wd(%rip), %rdi
	movl	$wordct_array, %r8d
	callq	wcp
	cmpl	$2, 48(%rsp)
	jl	.LBB1_32
# BB#31:                                # %if.then74
                                        #   in Loop: Header=BB1_8 Depth=1
	movslq	36(%rsp), %rax
	movq	40(%rsp), %rcx
	movq	(%rcx,%rax,8), %rsi
	movl	$.L.str3, %edi
	xorb	%al, %al
	callq	printf
	jmp	.LBB1_33
.LBB1_32:                               # %if.else78
                                        #   in Loop: Header=BB1_8 Depth=1
	movl	$.L.str4, %edi
	xorb	%al, %al
	callq	printf
.LBB1_33:                               # %if.end80
                                        #   in Loop: Header=BB1_8 Depth=1
	movq	24(%rsp), %rdi
	callq	fclose
	movq	linect(%rip), %rax
	addq	%rax, tlinect(%rip)
	movq	wordct(%rip), %rax
	addq	%rax, twordct(%rip)
	movq	charct(%rip), %rax
	addq	%rax, tcharct(%rip)
.LBB1_34:                               # %do.cond
                                        #   in Loop: Header=BB1_8 Depth=1
	movl	36(%rsp), %eax
	incl	%eax
	movl	%eax, 36(%rsp)
	cmpl	48(%rsp), %eax
	jl	.LBB1_8
# BB#35:                                # %do.end
	cmpl	$3, 48(%rsp)
	jl	.LBB1_37
# BB#36:                                # %if.then89
	movq	tlinect(%rip), %rcx
	movq	twordct(%rip), %rdx
	movq	tcharct(%rip), %rsi
	movq	wd(%rip), %rdi
	movl	$wordct_array, %r8d
	callq	wcp
	movl	$.L.str5, %edi
	xorb	%al, %al
	callq	printf
.LBB1_37:                               # %if.end91
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
.Ltmp5:
	.size	main, .Ltmp5-main
	.cfi_endproc

	.globl	wcp
	.align	16, 0x90
	.type	wcp,@function
wcp:                                    # @wcp
	.cfi_startproc
# BB#0:                                 # %entry
	subq	$56, %rsp
.Ltmp7:
	.cfi_def_cfa_offset 64
	movq	%rdi, 48(%rsp)
	movq	%rsi, 40(%rsp)
	movq	%rdx, 32(%rsp)
	movq	%rcx, 24(%rsp)
	movq	%r8, 16(%rsp)
	movl	$.L.str7, %edi
	xorb	%al, %al
	callq	printf
	movl	$0, 12(%rsp)
	jmp	.LBB2_1
	.align	16, 0x90
.LBB2_2:                                # %for.body
                                        #   in Loop: Header=BB2_1 Depth=1
	movslq	12(%rsp), %rsi
	movq	16(%rsp), %rax
	movq	(%rax,%rsi,8), %rdx
	movl	$.L.str8, %edi
                                        # kill: ESI<def> ESI<kill> RSI<kill>
	xorb	%al, %al
	callq	printf
	incl	12(%rsp)
.LBB2_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$24, 12(%rsp)
	jg	.LBB2_5
	jmp	.LBB2_2
	.align	16, 0x90
.LBB2_4:                                # %sw.bb2
                                        #   in Loop: Header=BB2_5 Depth=1
	callq	ipr
	.align	16, 0x90
.LBB2_5:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	48(%rsp), %rax
	cmpb	$0, (%rax)
	je	.LBB2_11
# BB#6:                                 # %while.body
                                        #   in Loop: Header=BB2_5 Depth=1
	movq	48(%rsp), %rax
	leaq	1(%rax), %rcx
	movq	%rcx, 48(%rsp)
	movsbl	(%rax), %eax
	cmpl	$99, %eax
	jne	.LBB2_7
# BB#10:                                # %sw.bb3
                                        #   in Loop: Header=BB2_5 Depth=1
	movq	40(%rsp), %rdi
	jmp	.LBB2_4
.LBB2_7:                                # %while.body
                                        #   in Loop: Header=BB2_5 Depth=1
	cmpl	$119, %eax
	jne	.LBB2_8
# BB#3:                                 # %sw.bb2
                                        #   in Loop: Header=BB2_5 Depth=1
	movq	32(%rsp), %rdi
	jmp	.LBB2_4
.LBB2_8:                                # %while.body
                                        #   in Loop: Header=BB2_5 Depth=1
	cmpl	$108, %eax
	jne	.LBB2_5
# BB#9:                                 # %sw.bb
                                        #   in Loop: Header=BB2_5 Depth=1
	movq	24(%rsp), %rdi
	jmp	.LBB2_4
.LBB2_11:                               # %while.end
	addq	$56, %rsp
	ret
.Ltmp8:
	.size	wcp, .Ltmp8-wcp
	.cfi_endproc

	.globl	ipr
	.align	16, 0x90
	.type	ipr,@function
ipr:                                    # @ipr
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rax
.Ltmp10:
	.cfi_def_cfa_offset 16
	movq	%rdi, %rax
	movq	%rax, (%rsp)
	movl	$.L.str9, %edi
	movq	%rax, %rsi
	xorb	%al, %al
	callq	printf
	popq	%rax
	ret
.Ltmp11:
	.size	ipr, .Ltmp11-ipr
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
