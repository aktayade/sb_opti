	.file	"wc.profile.ls.bc"
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
	incl	EdgeProfCounters(%rip)
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
	je	.LBB0_1
# BB#2:                                 # %if.then
	incl	EdgeProfCounters+4(%rip)
	movslq	bufcount(%rip), %rax
	leal	1(%rax), %ecx
	movl	%ecx, bufcount(%rip)
	movb	$-1, buffer(%rax)
	incl	EdgeProfCounters+12(%rip)
	popq	%rax
	ret
.LBB0_1:                                # %entry.if.end_crit_edge
	incl	EdgeProfCounters+8(%rip)
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
	pushq	%rbx
.Ltmp5:
	.cfi_def_cfa_offset 16
	subq	$48, %rsp
.Ltmp6:
	.cfi_def_cfa_offset 64
.Ltmp7:
	.cfi_offset %rbx, -16
	movq	%rsi, %rbx
	movl	$EdgeProfCounters, %edx
	movl	$89, %ecx
	callq	llvm_start_edge_profiling
	incl	EdgeProfCounters+16(%rip)
	movl	$0, 44(%rsp)
	movl	%eax, 40(%rsp)
	movq	%rbx, 32(%rsp)
	movl	$t_start, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	incl	EdgeProfCounters+20(%rip)
	jmp	.LBB1_1
	.align	16, 0x90
.LBB1_11:                               # %sw.bb
                                        #   in Loop: Header=BB1_1 Depth=1
	movq	32(%rsp), %rax
	movq	8(%rax), %rax
	incq	%rax
	movq	%rax, wd(%rip)
	incl	EdgeProfCounters+60(%rip)
	decl	40(%rsp)
	addq	$8, 32(%rsp)
	incl	EdgeProfCounters+68(%rip)
.LBB1_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$1, 40(%rsp)
	jle	.LBB1_2
# BB#3:                                 # %land.rhs
                                        #   in Loop: Header=BB1_1 Depth=1
	incl	EdgeProfCounters+24(%rip)
	movq	32(%rsp), %rax
	movq	8(%rax), %rax
	movsbl	(%rax), %eax
	incl	EdgeProfCounters+32(%rip)
	cmpl	$45, %eax
	sete	%al
	jmp	.LBB1_4
.LBB1_2:                                # %while.cond.land.end_crit_edge
                                        #   in Loop: Header=BB1_1 Depth=1
	incl	EdgeProfCounters+28(%rip)
	xorb	%al, %al
.LBB1_4:                                # %land.end
                                        #   in Loop: Header=BB1_1 Depth=1
	cmpb	$1, %al
	jne	.LBB1_13
# BB#5:                                 # %while.body
                                        #   in Loop: Header=BB1_1 Depth=1
	incl	EdgeProfCounters+36(%rip)
	movq	32(%rsp), %rax
	movq	8(%rax), %rax
	movsbl	1(%rax), %eax
	cmpl	$119, %eax
	jne	.LBB1_6
# BB#9:                                 # %while.body.sw.bb_crit_edge17
                                        #   in Loop: Header=BB1_1 Depth=1
	incl	EdgeProfCounters+52(%rip)
	jmp	.LBB1_11
.LBB1_6:                                # %while.body
                                        #   in Loop: Header=BB1_1 Depth=1
	cmpl	$108, %eax
	jne	.LBB1_7
# BB#10:                                # %while.body.sw.bb_crit_edge
                                        #   in Loop: Header=BB1_1 Depth=1
	incl	EdgeProfCounters+48(%rip)
	jmp	.LBB1_11
.LBB1_7:                                # %while.body
                                        #   in Loop: Header=BB1_1 Depth=1
	cmpl	$99, %eax
	jne	.LBB1_12
# BB#8:                                 # %while.body.sw.bb_crit_edge20
                                        #   in Loop: Header=BB1_1 Depth=1
	incl	EdgeProfCounters+56(%rip)
	jmp	.LBB1_11
.LBB1_12:                               # %sw.default
	incl	EdgeProfCounters+44(%rip)
	incl	EdgeProfCounters+64(%rip)
	movq	stderr(%rip), %rdi
	movl	$.L.str1, %esi
	xorb	%al, %al
	callq	fprintf
	movl	$1, %edi
	callq	exit
.LBB1_13:                               # %while.end
	incl	EdgeProfCounters+40(%rip)
	movl	$1, 28(%rsp)
	movq	stdin(%rip), %rax
	movq	%rax, 16(%rsp)
	incl	EdgeProfCounters+72(%rip)
	jmp	.LBB1_14
	.align	16, 0x90
.LBB1_51:                               # %do.cond.do.body_crit_edge
                                        #   in Loop: Header=BB1_14 Depth=1
	incl	EdgeProfCounters+264(%rip)
.LBB1_14:                               # %do.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_19 Depth 2
	cmpl	$1, 40(%rsp)
	jle	.LBB1_15
# BB#16:                                # %land.lhs.true
                                        #   in Loop: Header=BB1_14 Depth=1
	incl	EdgeProfCounters+76(%rip)
	movslq	28(%rsp), %rax
	movq	32(%rsp), %rcx
	movq	(%rcx,%rax,8), %rdi
	movl	$.L.str2, %esi
	callq	fopen
	movq	%rax, 16(%rsp)
	testq	%rax, %rax
	jne	.LBB1_17
# BB#56:                                # %if.then
                                        #   in Loop: Header=BB1_14 Depth=1
	incl	EdgeProfCounters+84(%rip)
	movslq	28(%rsp), %rax
	movq	32(%rsp), %rcx
	movq	(%rcx,%rax,8), %rdi
	callq	perror
	incl	EdgeProfCounters+92(%rip)
	jmp	.LBB1_50
.LBB1_15:                               # %do.body.if.end_crit_edge
                                        #   in Loop: Header=BB1_14 Depth=1
	incl	EdgeProfCounters+80(%rip)
	jmp	.LBB1_18
.LBB1_17:                               # %land.lhs.true.if.end_crit_edge
                                        #   in Loop: Header=BB1_14 Depth=1
	incl	EdgeProfCounters+88(%rip)
.LBB1_18:                               # %if.end
                                        #   in Loop: Header=BB1_14 Depth=1
	movq	$0, linect(%rip)
	movq	$0, wordct(%rip)
	movq	$0, charct(%rip)
	movl	$0, 24(%rsp)
	movq	$0, last_charct(%rip)
	incl	EdgeProfCounters+96(%rip)
	jmp	.LBB1_19
	.align	16, 0x90
.LBB1_47:                               # %if.end71
                                        #   in Loop: Header=BB1_19 Depth=2
	movl	$0, 24(%rsp)
	incl	EdgeProfCounters+240(%rip)
	incl	EdgeProfCounters+176(%rip)
	.align	16, 0x90
.LBB1_19:                               # %for.cond
                                        #   Parent Loop BB1_14 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	bufcurrent(%rip), %eax
	cmpl	bufcount(%rip), %eax
	jl	.LBB1_21
# BB#20:                                # %cond.true
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+100(%rip)
	movq	16(%rsp), %rdi
	callq	my_filbuf
	movslq	bufcurrent(%rip), %rax
	leal	1(%rax), %ecx
	movl	%ecx, bufcurrent(%rip)
	movsbl	buffer(%rax), %eax
	incl	EdgeProfCounters+108(%rip)
	jmp	.LBB1_22
.LBB1_21:                               # %cond.false
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+104(%rip)
	movslq	bufcurrent(%rip), %rax
	leal	1(%rax), %ecx
	movl	%ecx, bufcurrent(%rip)
	movsbl	buffer(%rax), %eax
	incl	EdgeProfCounters+112(%rip)
.LBB1_22:                               # %cond.end
                                        #   in Loop: Header=BB1_19 Depth=2
	movl	%eax, 12(%rsp)
	cmpl	$-1, %eax
	je	.LBB1_23
# BB#25:                                # %if.end28
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+120(%rip)
	incq	charct(%rip)
	incq	last_charct(%rip)
	cmpl	$32, 12(%rsp)
	jle	.LBB1_26
# BB#30:                                # %land.lhs.true33
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+128(%rip)
	cmpl	$127, 12(%rsp)
	jge	.LBB1_31
# BB#32:                                # %if.then36
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+136(%rip)
	cmpl	$0, 24(%rsp)
	je	.LBB1_34
# BB#33:                                # %if.then36.if.end47_crit_edge
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+144(%rip)
	jmp	.LBB1_38
.LBB1_26:                               # %if.end28.if.end48_crit_edge
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+132(%rip)
	jmp	.LBB1_27
.LBB1_31:                               # %land.lhs.true33.if.end48_crit_edge
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+140(%rip)
.LBB1_27:                               # %if.end48
                                        #   in Loop: Header=BB1_19 Depth=2
	cmpl	$10, 12(%rsp)
	jne	.LBB1_42
# BB#28:                                # %if.then51
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+180(%rip)
	movq	linect(%rip), %rax
	incq	%rax
	movq	%rax, linect(%rip)
	cmpq	$20, %rax
	jle	.LBB1_29
# BB#39:                                # %land.lhs.true55
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+188(%rip)
	cmpq	$10, last_charct(%rip)
	jle	.LBB1_40
# BB#57:                                # %if.then58
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+196(%rip)
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
	incl	EdgeProfCounters+204(%rip)
	incl	EdgeProfCounters+212(%rip)
	jmp	.LBB1_47
.LBB1_42:                               # %if.else63
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+184(%rip)
	cmpl	$32, 12(%rsp)
	je	.LBB1_43
# BB#44:                                # %land.lhs.true66
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+216(%rip)
	cmpl	$9, 12(%rsp)
	je	.LBB1_45
# BB#58:                                # %if.then69
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+224(%rip)
	incl	EdgeProfCounters+232(%rip)
	incl	EdgeProfCounters+176(%rip)
	jmp	.LBB1_19
.LBB1_29:                               # %if.then51.if.else60_crit_edge
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+192(%rip)
	jmp	.LBB1_41
.LBB1_43:                               # %if.else63.if.end70_crit_edge
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+220(%rip)
	jmp	.LBB1_46
.LBB1_34:                               # %if.then37
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+148(%rip)
	incq	wordct(%rip)
	incl	24(%rsp)
	cmpq	$25, last_charct(%rip)
	jl	.LBB1_36
# BB#35:                                # %if.then42
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+152(%rip)
	incq	wordct_array+192(%rip)
	incl	EdgeProfCounters+160(%rip)
	jmp	.LBB1_37
.LBB1_40:                               # %land.lhs.true55.if.else60_crit_edge
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+200(%rip)
.LBB1_41:                               # %if.else60
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	main.z(%rip)
	incl	EdgeProfCounters+208(%rip)
	incl	EdgeProfCounters+212(%rip)
	jmp	.LBB1_47
.LBB1_45:                               # %land.lhs.true66.if.end70_crit_edge
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+228(%rip)
.LBB1_46:                               # %if.end70
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+236(%rip)
	jmp	.LBB1_47
.LBB1_36:                               # %if.else
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+156(%rip)
	movq	last_charct(%rip), %rax
	incq	wordct_array(,%rax,8)
	incl	EdgeProfCounters+164(%rip)
.LBB1_37:                               # %if.end46
                                        #   in Loop: Header=BB1_19 Depth=2
	movq	$0, last_charct(%rip)
	incl	EdgeProfCounters+168(%rip)
.LBB1_38:                               # %if.end47
                                        #   in Loop: Header=BB1_19 Depth=2
	incl	EdgeProfCounters+172(%rip)
	incl	EdgeProfCounters+176(%rip)
	jmp	.LBB1_19
.LBB1_23:                               # %if.then27
                                        #   in Loop: Header=BB1_14 Depth=1
	incl	EdgeProfCounters+116(%rip)
	incl	EdgeProfCounters+124(%rip)
	movq	linect(%rip), %rcx
	movq	wordct(%rip), %rdx
	movq	charct(%rip), %rsi
	movq	wd(%rip), %rdi
	movl	$wordct_array, %r8d
	callq	wcp
	cmpl	$2, 40(%rsp)
	jl	.LBB1_48
# BB#24:                                # %if.then74
                                        #   in Loop: Header=BB1_14 Depth=1
	incl	EdgeProfCounters+244(%rip)
	movslq	28(%rsp), %rax
	movq	32(%rsp), %rcx
	movq	(%rcx,%rax,8), %rsi
	movl	$.L.str3, %edi
	xorb	%al, %al
	callq	printf
	incl	EdgeProfCounters+252(%rip)
	jmp	.LBB1_49
.LBB1_48:                               # %if.else78
                                        #   in Loop: Header=BB1_14 Depth=1
	incl	EdgeProfCounters+248(%rip)
	movl	$.L.str4, %edi
	xorb	%al, %al
	callq	printf
	incl	EdgeProfCounters+256(%rip)
.LBB1_49:                               # %if.end80
                                        #   in Loop: Header=BB1_14 Depth=1
	movq	16(%rsp), %rdi
	callq	fclose
	movq	linect(%rip), %rax
	addq	%rax, tlinect(%rip)
	movq	wordct(%rip), %rax
	addq	%rax, twordct(%rip)
	movq	charct(%rip), %rax
	addq	%rax, tcharct(%rip)
	incl	EdgeProfCounters+260(%rip)
.LBB1_50:                               # %do.cond
                                        #   in Loop: Header=BB1_14 Depth=1
	movl	28(%rsp), %eax
	incl	%eax
	movl	%eax, 28(%rsp)
	cmpl	40(%rsp), %eax
	jl	.LBB1_51
# BB#52:                                # %do.end
	incl	EdgeProfCounters+268(%rip)
	cmpl	$2, 40(%rsp)
	jle	.LBB1_53
# BB#54:                                # %if.then89
	incl	EdgeProfCounters+272(%rip)
	movq	tlinect(%rip), %rcx
	movq	twordct(%rip), %rdx
	movq	tcharct(%rip), %rsi
	movq	wd(%rip), %rdi
	movl	$wordct_array, %r8d
	callq	wcp
	movl	$.L.str5, %edi
	xorb	%al, %al
	callq	printf
	incl	EdgeProfCounters+280(%rip)
	jmp	.LBB1_55
.LBB1_53:                               # %do.end.if.end91_crit_edge
	incl	EdgeProfCounters+276(%rip)
.LBB1_55:                               # %if.end91
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
.Ltmp8:
	.size	main, .Ltmp8-main
	.cfi_endproc

	.globl	wcp
	.align	16, 0x90
	.type	wcp,@function
wcp:                                    # @wcp
	.cfi_startproc
# BB#0:                                 # %entry
	subq	$56, %rsp
.Ltmp10:
	.cfi_def_cfa_offset 64
	incl	EdgeProfCounters+284(%rip)
	movq	%rdi, 48(%rsp)
	movq	%rsi, 40(%rsp)
	movq	%rdx, 32(%rsp)
	movq	%rcx, 24(%rsp)
	movq	%r8, 16(%rsp)
	movl	$.L.str7, %edi
	xorb	%al, %al
	callq	printf
	movl	$0, 12(%rsp)
	incl	EdgeProfCounters+288(%rip)
	jmp	.LBB2_1
	.align	16, 0x90
.LBB2_2:                                # %for.body
                                        #   in Loop: Header=BB2_1 Depth=1
	incl	EdgeProfCounters+292(%rip)
	movslq	12(%rsp), %rsi
	movq	16(%rsp), %rax
	movq	(%rax,%rsi,8), %rdx
	movl	$.L.str8, %edi
                                        # kill: ESI<def> ESI<kill> RSI<kill>
	xorb	%al, %al
	callq	printf
	incl	EdgeProfCounters+300(%rip)
	incl	12(%rsp)
	incl	EdgeProfCounters+304(%rip)
.LBB2_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$24, 12(%rsp)
	jle	.LBB2_2
# BB#3:                                 # %for.end
	incl	EdgeProfCounters+296(%rip)
	incl	EdgeProfCounters+308(%rip)
	jmp	.LBB2_4
	.align	16, 0x90
.LBB2_11:                               # %sw.bb3
                                        #   in Loop: Header=BB2_4 Depth=1
	incl	EdgeProfCounters+332(%rip)
	movq	40(%rsp), %rdi
	callq	ipr
	incl	EdgeProfCounters+344(%rip)
	incl	EdgeProfCounters+348(%rip)
	.align	16, 0x90
.LBB2_4:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	48(%rsp), %rax
	cmpb	$0, (%rax)
	je	.LBB2_12
# BB#5:                                 # %while.body
                                        #   in Loop: Header=BB2_4 Depth=1
	incl	EdgeProfCounters+312(%rip)
	movq	48(%rsp), %rax
	leaq	1(%rax), %rcx
	movq	%rcx, 48(%rsp)
	movsbl	(%rax), %eax
	cmpl	$99, %eax
	je	.LBB2_11
# BB#6:                                 # %while.body
                                        #   in Loop: Header=BB2_4 Depth=1
	cmpl	$108, %eax
	jne	.LBB2_7
# BB#9:                                 # %sw.bb
                                        #   in Loop: Header=BB2_4 Depth=1
	incl	EdgeProfCounters+324(%rip)
	movq	24(%rsp), %rdi
	callq	ipr
	incl	EdgeProfCounters+336(%rip)
	incl	EdgeProfCounters+348(%rip)
	jmp	.LBB2_4
.LBB2_7:                                # %while.body
                                        #   in Loop: Header=BB2_4 Depth=1
	cmpl	$119, %eax
	jne	.LBB2_8
# BB#10:                                # %sw.bb2
                                        #   in Loop: Header=BB2_4 Depth=1
	incl	EdgeProfCounters+328(%rip)
	movq	32(%rsp), %rdi
	callq	ipr
	incl	EdgeProfCounters+340(%rip)
	incl	EdgeProfCounters+348(%rip)
	jmp	.LBB2_4
.LBB2_8:                                # %while.body.sw.epilog_crit_edge
                                        #   in Loop: Header=BB2_4 Depth=1
	incl	EdgeProfCounters+320(%rip)
	incl	EdgeProfCounters+348(%rip)
	jmp	.LBB2_4
.LBB2_12:                               # %while.end
	incl	EdgeProfCounters+316(%rip)
	addq	$56, %rsp
	ret
.Ltmp11:
	.size	wcp, .Ltmp11-wcp
	.cfi_endproc

	.globl	ipr
	.align	16, 0x90
	.type	ipr,@function
ipr:                                    # @ipr
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rax
.Ltmp13:
	.cfi_def_cfa_offset 16
	movq	%rdi, %rax
	incl	EdgeProfCounters+352(%rip)
	movq	%rax, (%rsp)
	movl	$.L.str9, %edi
	movq	%rax, %rsi
	xorb	%al, %al
	callq	printf
	popq	%rax
	ret
.Ltmp14:
	.size	ipr, .Ltmp14-ipr
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
	.type	EdgeProfCounters,@object # @EdgeProfCounters
	.local	EdgeProfCounters
	.comm	EdgeProfCounters,356,16

	.section	".note.GNU-stack","",@progbits
