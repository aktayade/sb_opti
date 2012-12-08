	.file	"<stdin>"
	.text
	.globl	my_filbuf
	.align	16, 0x90
	.type	my_filbuf,@function
my_filbuf:                              # @my_filbuf
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%r14
.Ltmp3:
	.cfi_def_cfa_offset 16
	pushq	%rbx
.Ltmp4:
	.cfi_def_cfa_offset 24
	pushq	%rax
.Ltmp5:
	.cfi_def_cfa_offset 32
.Ltmp6:
	.cfi_offset %rbx, -24
.Ltmp7:
	.cfi_offset %r14, -16
	movq	%rdi, %rbx
	leaq	(%rsp), %r14
	xorl	%edi, %edi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store8
	movq	%rbx, (%rsp)
	movl	$1, %edi
	movq	%r14, %rsi
	callq	LAMP_load8
	movq	(%rsp), %rbx
	movl	$2, %edi
	callq	LAMP_register
	movl	$buffer, %edi
	movl	$1, %esi
	movl	$8192, %edx             # imm = 0x2000
	movq	%rbx, %rcx
	callq	fread
	movslq	%eax, %rbx
	movl	$3, %edi
	movl	$bufcount, %esi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, bufcount(%rip)
	movl	$4, %edi
	movl	$bufcurrent, %esi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, bufcurrent(%rip)
	movl	$5, %edi
	movq	%r14, %rsi
	callq	LAMP_load8
	movq	(%rsp), %rbx
	movl	$6, %edi
	callq	LAMP_register
	movq	%rbx, %rdi
	callq	feof
	testl	%eax, %eax
	je	.LBB0_2
# BB#1:                                 # %if.then
	movl	$7, %edi
	movl	$bufcount, %esi
	callq	LAMP_load4
	movslq	bufcount(%rip), %rbx
	leal	1(%rbx), %eax
	movslq	%eax, %r14
	movl	$8, %edi
	movl	$bufcount, %esi
	movq	%r14, %rdx
	callq	LAMP_store4
	leaq	buffer(%rbx), %rsi
	movl	%r14d, bufcount(%rip)
	movl	$9, %edi
	movq	$-1, %rdx
	callq	LAMP_store1
	movb	$-1, buffer(%rbx)
.LBB0_2:                                # %if.end
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	ret
.Ltmp8:
	.size	my_filbuf, .Ltmp8-my_filbuf
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
.Ltmp16:
	.cfi_def_cfa_offset 16
	pushq	%r15
.Ltmp17:
	.cfi_def_cfa_offset 24
	pushq	%r14
.Ltmp18:
	.cfi_def_cfa_offset 32
	pushq	%r13
.Ltmp19:
	.cfi_def_cfa_offset 40
	pushq	%r12
.Ltmp20:
	.cfi_def_cfa_offset 48
	pushq	%rbx
.Ltmp21:
	.cfi_def_cfa_offset 56
	subq	$56, %rsp
.Ltmp22:
	.cfi_def_cfa_offset 112
.Ltmp23:
	.cfi_offset %rbx, -56
.Ltmp24:
	.cfi_offset %r12, -48
.Ltmp25:
	.cfi_offset %r13, -40
.Ltmp26:
	.cfi_offset %r14, -32
.Ltmp27:
	.cfi_offset %r15, -24
.Ltmp28:
	.cfi_offset %rbp, -16
	movq	%rsi, %r14
	movl	%edi, %ebx
	movl	$160, %edi
	movl	$5, %esi
	movl	$1, %edx
	xorl	%ecx, %ecx
	callq	LAMP_init
	leaq	52(%rsp), %rsi
	movl	$10, %edi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 52(%rsp)
	movslq	%ebx, %rbx
	leaq	48(%rsp), %r15
	movl	$11, %edi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	leaq	40(%rsp), %rbp
	movl	%ebx, 48(%rsp)
	movl	$12, %edi
	movq	%rbp, %rsi
	movq	%r14, %rdx
	callq	LAMP_store8
	movq	%r14, 40(%rsp)
	movl	$13, %edi
	callq	LAMP_register
	movl	$t_start, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movl	$162, %edi
	callq	LAMP_loop_invocation
	movl	$1049089, %r14d         # imm = 0x100201
	jmp	.LBB1_1
	.align	16, 0x90
.LBB1_6:                                # %sw.bb
                                        #   in Loop: Header=BB1_1 Depth=1
	movl	$21, %edi
	movq	%rbp, %rsi
	callq	LAMP_load8
	movq	40(%rsp), %rbx
	leaq	8(%rbx), %rsi
	movl	$22, %edi
	callq	LAMP_load8
	movq	8(%rbx), %rbx
	incq	%rbx
	movl	$23, %edi
	movl	$wd, %esi
	movq	%rbx, %rdx
	callq	LAMP_store8
	movq	%rbx, wd(%rip)
	movl	$27, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	movl	48(%rsp), %eax
	decl	%eax
	movslq	%eax, %rbx
	movl	$28, %edi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 48(%rsp)
	movl	$29, %edi
	movq	%rbp, %rsi
	callq	LAMP_load8
	movq	40(%rsp), %rbx
	addq	$8, %rbx
	movl	$30, %edi
	movq	%rbp, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store8
	movq	%rbx, 40(%rsp)
	callq	LAMP_loop_iteration_end
.LBB1_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	callq	LAMP_loop_iteration_begin
	movl	$14, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	xorb	%al, %al
	cmpl	$2, 48(%rsp)
	jl	.LBB1_3
# BB#2:                                 # %land.rhs
                                        #   in Loop: Header=BB1_1 Depth=1
	movl	$15, %edi
	movq	%rbp, %rsi
	callq	LAMP_load8
	movq	40(%rsp), %rbx
	leaq	8(%rbx), %rsi
	movl	$16, %edi
	callq	LAMP_load8
	movq	8(%rbx), %rbx
	movl	$17, %edi
	movq	%rbx, %rsi
	callq	LAMP_load1
	movsbl	(%rbx), %eax
	cmpl	$45, %eax
	sete	%al
.LBB1_3:                                # %land.end
                                        #   in Loop: Header=BB1_1 Depth=1
	cmpb	$1, %al
	jne	.LBB1_8
# BB#4:                                 # %while.body
                                        #   in Loop: Header=BB1_1 Depth=1
	movl	$18, %edi
	movq	%rbp, %rsi
	callq	LAMP_load8
	movq	40(%rsp), %rbx
	leaq	8(%rbx), %rsi
	movl	$19, %edi
	callq	LAMP_load8
	movq	8(%rbx), %rbx
	leaq	1(%rbx), %rsi
	movl	$20, %edi
	callq	LAMP_load1
	movsbl	1(%rbx), %eax
	addl	$-99, %eax
	cmpl	$20, %eax
	ja	.LBB1_7
# BB#5:                                 # %while.body
                                        #   in Loop: Header=BB1_1 Depth=1
	btl	%eax, %r14d
	jb	.LBB1_6
.LBB1_7:                                # %sw.default
	callq	LAMP_loop_iteration_end
	callq	LAMP_loop_exit
	movl	$24, %edi
	movl	$stderr, %esi
	callq	LAMP_load8
	movq	stderr(%rip), %rbx
	movl	$25, %edi
	callq	LAMP_register
	movq	%rbx, %rdi
	movl	$.L.str1, %esi
	xorb	%al, %al
	callq	fprintf
	movl	$26, %edi
	callq	LAMP_register
	movl	$1, %edi
	callq	exit
.LBB1_8:                                # %while.end
	callq	LAMP_loop_iteration_end
	callq	LAMP_loop_exit
	leaq	36(%rsp), %r15
	movl	$31, %edi
	movq	%r15, %rsi
	movl	$1, %edx
	callq	LAMP_store4
	movl	$1, 36(%rsp)
	movl	$32, %edi
	movl	$stdin, %esi
	callq	LAMP_load8
	leaq	24(%rsp), %rsi
	movq	stdin(%rip), %rbx
	movl	$33, %edi
	movq	%rbx, %rdx
	callq	LAMP_store8
	movq	%rbx, 24(%rsp)
	movl	$161, %edi
	callq	LAMP_loop_invocation
	leaq	48(%rsp), %rbx
	leaq	32(%rsp), %r12
	leaq	20(%rsp), %r13
	.align	16, 0x90
.LBB1_9:                                # %do.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_13 Depth 2
	callq	LAMP_loop_iteration_begin
	movl	$34, %edi
	movq	%rbx, %rsi
	callq	LAMP_load4
	cmpl	$2, 48(%rsp)
	jl	.LBB1_12
# BB#10:                                # %land.lhs.true
                                        #   in Loop: Header=BB1_9 Depth=1
	movl	$35, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	movslq	36(%rsp), %rbx
	movl	$36, %edi
	leaq	40(%rsp), %rsi
	callq	LAMP_load8
	movq	40(%rsp), %rbp
	leaq	(%rbp,%rbx,8), %rsi
	movl	$37, %edi
	callq	LAMP_load8
	movq	(%rbp,%rbx,8), %rbx
	movl	$38, %edi
	callq	LAMP_register
	movq	%rbx, %rdi
	movl	$.L.str2, %esi
	callq	fopen
	movq	%rax, %rbx
	movl	$39, %edi
	leaq	24(%rsp), %rsi
	movq	%rbx, %rdx
	callq	LAMP_store8
	movq	%rbx, 24(%rsp)
	testq	%rbx, %rbx
	jne	.LBB1_12
# BB#11:                                # %if.then
                                        #   in Loop: Header=BB1_9 Depth=1
	movl	$40, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	movslq	36(%rsp), %rbx
	movl	$41, %edi
	leaq	40(%rsp), %rsi
	callq	LAMP_load8
	movq	40(%rsp), %rbp
	leaq	(%rbp,%rbx,8), %rsi
	movl	$42, %edi
	callq	LAMP_load8
	movq	(%rbp,%rbx,8), %rbx
	movl	$43, %edi
	callq	LAMP_register
	movq	%rbx, %rdi
	callq	perror
	jmp	.LBB1_38
.LBB1_12:                               # %if.end
                                        #   in Loop: Header=BB1_9 Depth=1
	movl	$44, %edi
	movl	$linect, %esi
	xorl	%edx, %edx
	callq	LAMP_store8
	movq	$0, linect(%rip)
	movl	$45, %edi
	movl	$wordct, %esi
	xorl	%edx, %edx
	callq	LAMP_store8
	movq	$0, wordct(%rip)
	movl	$46, %edi
	movl	$charct, %esi
	xorl	%edx, %edx
	callq	LAMP_store8
	movq	$0, charct(%rip)
	movl	$47, %edi
	movq	%r12, %rsi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 32(%rsp)
	movl	$48, %edi
	movl	$last_charct, %esi
	xorl	%edx, %edx
	callq	LAMP_store8
	movq	$0, last_charct(%rip)
	movl	$160, %edi
	callq	LAMP_loop_invocation
	jmp	.LBB1_13
	.align	16, 0x90
.LBB1_35:                               # %if.end71
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$93, %edi
	movq	%r12, %rsi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 32(%rsp)
	callq	LAMP_loop_iteration_end
	.align	16, 0x90
.LBB1_13:                               # %for.cond
                                        #   Parent Loop BB1_9 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	callq	LAMP_loop_iteration_begin
	movl	$49, %edi
	movl	$bufcurrent, %esi
	callq	LAMP_load4
	movl	bufcurrent(%rip), %ebx
	movl	$50, %edi
	movl	$bufcount, %esi
	callq	LAMP_load4
	cmpl	bufcount(%rip), %ebx
	jl	.LBB1_15
# BB#14:                                # %cond.true
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$51, %edi
	leaq	24(%rsp), %rsi
	callq	LAMP_load8
	movq	24(%rsp), %rdi
	callq	my_filbuf
	movl	$52, %edi
	movl	$bufcurrent, %esi
	callq	LAMP_load4
	movslq	bufcurrent(%rip), %rbp
	leal	1(%rbp), %eax
	movslq	%eax, %rbx
	movl	$53, %edi
	movl	$bufcurrent, %esi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, bufcurrent(%rip)
	leaq	buffer(%rbp), %rsi
	movl	$54, %edi
	jmp	.LBB1_16
.LBB1_15:                               # %cond.false
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$55, %edi
	movl	$bufcurrent, %esi
	callq	LAMP_load4
	movslq	bufcurrent(%rip), %rbp
	leal	1(%rbp), %eax
	movslq	%eax, %rbx
	movl	$56, %edi
	movl	$bufcurrent, %esi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, bufcurrent(%rip)
	leaq	buffer(%rbp), %rsi
	movl	$57, %edi
.LBB1_16:                               # %cond.false
                                        #   in Loop: Header=BB1_13 Depth=2
	callq	LAMP_load1
	movsbl	buffer(%rbp), %eax
	movq	%r15, %rbp
	movslq	%eax, %rbx
	movl	$58, %edi
	movq	%r13, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 20(%rsp)
	movl	$59, %edi
	movq	%r13, %rsi
	callq	LAMP_load4
	cmpl	$-1, 20(%rsp)
	je	.LBB1_17
# BB#19:                                # %if.end28
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$60, %edi
	movl	$charct, %esi
	callq	LAMP_load8
	movq	charct(%rip), %rbx
	incq	%rbx
	movl	$61, %edi
	movl	$charct, %esi
	movq	%rbx, %rdx
	callq	LAMP_store8
	movq	%rbx, charct(%rip)
	movl	$62, %edi
	movl	$last_charct, %esi
	callq	LAMP_load8
	movq	last_charct(%rip), %rbx
	incq	%rbx
	movl	$63, %edi
	movl	$last_charct, %esi
	movq	%rbx, %rdx
	callq	LAMP_store8
	movq	%rbx, last_charct(%rip)
	movl	$64, %edi
	movq	%r13, %rsi
	callq	LAMP_load4
	cmpl	$33, 20(%rsp)
	movq	%rbp, %r15
	jl	.LBB1_27
# BB#20:                                # %land.lhs.true33
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$65, %edi
	movq	%r13, %rsi
	callq	LAMP_load4
	cmpl	$126, 20(%rsp)
	jg	.LBB1_27
# BB#21:                                # %if.then36
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$66, %edi
	movq	%r12, %rsi
	callq	LAMP_load4
	cmpl	$0, 32(%rsp)
	jne	.LBB1_26
# BB#22:                                # %if.then37
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$67, %edi
	movl	$wordct, %esi
	callq	LAMP_load8
	movq	wordct(%rip), %rbx
	incq	%rbx
	movl	$68, %edi
	movl	$wordct, %esi
	movq	%rbx, %rdx
	callq	LAMP_store8
	movq	%rbx, wordct(%rip)
	movl	$69, %edi
	movq	%r12, %rsi
	callq	LAMP_load4
	movl	32(%rsp), %eax
	incl	%eax
	movslq	%eax, %rbx
	movl	$70, %edi
	movq	%r12, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 32(%rsp)
	movl	$71, %edi
	movl	$last_charct, %esi
	callq	LAMP_load8
	cmpq	$25, last_charct(%rip)
	jl	.LBB1_24
# BB#23:                                # %if.then42
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$72, %edi
	movl	$wordct_array+192, %esi
	callq	LAMP_load8
	movq	wordct_array+192(%rip), %rbx
	incq	%rbx
	movl	$73, %edi
	movl	$wordct_array+192, %esi
	movq	%rbx, %rdx
	callq	LAMP_store8
	movq	%rbx, wordct_array+192(%rip)
	jmp	.LBB1_25
.LBB1_27:                               # %if.end48
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$78, %edi
	movq	%r13, %rsi
	callq	LAMP_load4
	cmpl	$10, 20(%rsp)
	jne	.LBB1_33
# BB#28:                                # %if.then51
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$79, %edi
	movl	$linect, %esi
	callq	LAMP_load8
	movq	linect(%rip), %rbx
	incq	%rbx
	movl	$80, %edi
	movl	$linect, %esi
	movq	%rbx, %rdx
	callq	LAMP_store8
	movq	%rbx, linect(%rip)
	movl	$81, %edi
	movl	$linect, %esi
	callq	LAMP_load8
	cmpq	$21, linect(%rip)
	jl	.LBB1_31
# BB#29:                                # %land.lhs.true55
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$82, %edi
	movl	$last_charct, %esi
	callq	LAMP_load8
	cmpq	$11, last_charct(%rip)
	jl	.LBB1_31
# BB#30:                                # %if.then58
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$83, %edi
	movl	$linect, %esi
	callq	LAMP_load8
	movabsq	$7378697629483820647, %rax # imm = 0x6666666666666667
	imulq	linect(%rip)
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	%rdx
	addq	%rax, %rdx
	movslq	%edx, %rbx
	movl	$84, %edi
	movl	$main.x, %esi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, main.x(%rip)
	movl	$85, %edi
	movl	$main.x, %esi
	callq	LAMP_load4
	movl	main.x(%rip), %eax
	imull	$98, %eax, %eax
	movslq	%eax, %rbx
	movl	$86, %edi
	movl	$main.y, %esi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, main.y(%rip)
	movl	$87, %edi
	movl	$main.y, %esi
	callq	LAMP_load4
	movl	main.y(%rip), %eax
	movslq	%eax, %rax
	imulq	$-1307163959, %rax, %rdx # imm = 0xFFFFFFFFB21642C9
	shrq	$32, %rdx
	movl	%eax, %ecx
	addl	%edx, %ecx
	movl	%ecx, %edx
	shrl	$31, %edx
	sarl	$4, %ecx
	addl	%edx, %ecx
	imull	$23, %ecx, %ecx
	subl	%ecx, %eax
	movslq	%eax, %rbx
	movl	$88, %edi
	jmp	.LBB1_32
.LBB1_33:                               # %if.else63
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$91, %edi
	movq	%r13, %rsi
	callq	LAMP_load4
	cmpl	$32, 20(%rsp)
	je	.LBB1_35
# BB#34:                                # %land.lhs.true66
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$92, %edi
	movq	%r13, %rsi
	callq	LAMP_load4
	cmpl	$9, 20(%rsp)
	jne	.LBB1_26
	jmp	.LBB1_35
.LBB1_31:                               # %if.else60
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$89, %edi
	movl	$main.z, %esi
	callq	LAMP_load4
	movl	main.z(%rip), %eax
	incl	%eax
	movslq	%eax, %rbx
	movl	$90, %edi
.LBB1_32:                               # %if.else60
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$main.z, %esi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, main.z(%rip)
	jmp	.LBB1_35
.LBB1_24:                               # %if.else
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$74, %edi
	movl	$last_charct, %esi
	callq	LAMP_load8
	movq	last_charct(%rip), %rbx
	leaq	wordct_array(,%rbx,8), %r14
	movl	$75, %edi
	movq	%r14, %rsi
	callq	LAMP_load8
	movq	wordct_array(,%rbx,8), %rbp
	incq	%rbp
	movl	$76, %edi
	movq	%r14, %rsi
	movq	%rbp, %rdx
	callq	LAMP_store8
	movq	%rbp, wordct_array(,%rbx,8)
.LBB1_25:                               # %if.end46
                                        #   in Loop: Header=BB1_13 Depth=2
	movl	$77, %edi
	movl	$last_charct, %esi
	xorl	%edx, %edx
	callq	LAMP_store8
	movq	$0, last_charct(%rip)
.LBB1_26:                               # %for.cond.backedge
                                        #   in Loop: Header=BB1_13 Depth=2
	callq	LAMP_loop_iteration_end
	jmp	.LBB1_13
.LBB1_17:                               # %if.then27
                                        #   in Loop: Header=BB1_9 Depth=1
	callq	LAMP_loop_iteration_end
	callq	LAMP_loop_exit
	movl	$94, %edi
	movl	$wd, %esi
	callq	LAMP_load8
	movq	wd(%rip), %r15
	movl	$95, %edi
	movl	$charct, %esi
	callq	LAMP_load8
	movq	charct(%rip), %rbx
	movl	$96, %edi
	movl	$wordct, %esi
	callq	LAMP_load8
	movq	wordct(%rip), %r14
	movl	$97, %edi
	movl	$linect, %esi
	callq	LAMP_load8
	movq	linect(%rip), %rcx
	movq	%r15, %rdi
	movq	%rbx, %rsi
	movq	%r14, %rdx
	movl	$wordct_array, %r8d
	callq	wcp
	movl	$98, %edi
	leaq	48(%rsp), %rsi
	callq	LAMP_load4
	cmpl	$2, 48(%rsp)
	jl	.LBB1_36
# BB#18:                                # %if.then74
                                        #   in Loop: Header=BB1_9 Depth=1
	movl	$99, %edi
	movq	%rbp, %r15
	movq	%r15, %rsi
	callq	LAMP_load4
	movslq	36(%rsp), %rbx
	movl	$100, %edi
	leaq	40(%rsp), %rsi
	callq	LAMP_load8
	movq	40(%rsp), %rbp
	leaq	(%rbp,%rbx,8), %rsi
	movl	$101, %edi
	callq	LAMP_load8
	movq	(%rbp,%rbx,8), %rbx
	movl	$102, %edi
	callq	LAMP_register
	movl	$.L.str3, %edi
	movq	%rbx, %rsi
	xorb	%al, %al
	callq	printf
	jmp	.LBB1_37
.LBB1_36:                               # %if.else78
                                        #   in Loop: Header=BB1_9 Depth=1
	movl	$103, %edi
	callq	LAMP_register
	movl	$.L.str4, %edi
	xorb	%al, %al
	callq	printf
	movq	%rbp, %r15
.LBB1_37:                               # %if.end80
                                        #   in Loop: Header=BB1_9 Depth=1
	movl	$104, %edi
	leaq	24(%rsp), %rsi
	callq	LAMP_load8
	movq	24(%rsp), %rbx
	movl	$105, %edi
	callq	LAMP_register
	movq	%rbx, %rdi
	callq	fclose
	movl	$106, %edi
	movl	$linect, %esi
	callq	LAMP_load8
	movq	linect(%rip), %rbp
	movl	$107, %edi
	movl	$tlinect, %esi
	callq	LAMP_load8
	movq	tlinect(%rip), %rbx
	addq	%rbp, %rbx
	movl	$108, %edi
	movl	$tlinect, %esi
	movq	%rbx, %rdx
	callq	LAMP_store8
	movq	%rbx, tlinect(%rip)
	movl	$109, %edi
	movl	$wordct, %esi
	callq	LAMP_load8
	movq	wordct(%rip), %rbp
	movl	$110, %edi
	movl	$twordct, %esi
	callq	LAMP_load8
	movq	twordct(%rip), %rbx
	addq	%rbp, %rbx
	movl	$111, %edi
	movl	$twordct, %esi
	movq	%rbx, %rdx
	callq	LAMP_store8
	movq	%rbx, twordct(%rip)
	movl	$112, %edi
	movl	$charct, %esi
	callq	LAMP_load8
	movq	charct(%rip), %rbp
	movl	$113, %edi
	movl	$tcharct, %esi
	callq	LAMP_load8
	movq	tcharct(%rip), %rbx
	addq	%rbp, %rbx
	movl	$114, %edi
	movl	$tcharct, %esi
	movq	%rbx, %rdx
	callq	LAMP_store8
	movq	%rbx, tcharct(%rip)
.LBB1_38:                               # %do.cond
                                        #   in Loop: Header=BB1_9 Depth=1
	movl	$115, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	movl	36(%rsp), %eax
	incl	%eax
	movslq	%eax, %rbx
	movl	$116, %edi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 36(%rsp)
	movl	$117, %edi
	leaq	48(%rsp), %rbp
	movq	%rbp, %rsi
	callq	LAMP_load4
	movl	48(%rsp), %r14d
	callq	LAMP_loop_iteration_end
	cmpl	%r14d, %ebx
	movq	%rbp, %rbx
	jl	.LBB1_9
# BB#39:                                # %do.end
	callq	LAMP_loop_iteration_end
	callq	LAMP_loop_exit
	leaq	48(%rsp), %rsi
	movl	$118, %edi
	callq	LAMP_load4
	cmpl	$3, 48(%rsp)
	jl	.LBB1_41
# BB#40:                                # %if.then89
	movl	$119, %edi
	movl	$wd, %esi
	callq	LAMP_load8
	movq	wd(%rip), %r14
	movl	$120, %edi
	movl	$tcharct, %esi
	callq	LAMP_load8
	movq	tcharct(%rip), %rbp
	movl	$121, %edi
	movl	$twordct, %esi
	callq	LAMP_load8
	movq	twordct(%rip), %rbx
	movl	$122, %edi
	movl	$tlinect, %esi
	callq	LAMP_load8
	movq	tlinect(%rip), %rcx
	movq	%r14, %rdi
	movq	%rbp, %rsi
	movq	%rbx, %rdx
	movl	$wordct_array, %r8d
	callq	wcp
	movl	$123, %edi
	callq	LAMP_register
	movl	$.L.str5, %edi
	xorb	%al, %al
	callq	printf
.LBB1_41:                               # %if.end91
	movl	$124, %edi
	callq	LAMP_register
	movl	$t_end, %edi
	xorl	%esi, %esi
	callq	gettimeofday
	movl	$125, %edi
	movl	$t_end, %esi
	callq	LAMP_load8
	movq	t_end(%rip), %rbx
	movl	$126, %edi
	movl	$t_start, %esi
	callq	LAMP_load8
	movq	t_start(%rip), %r14
	movl	$127, %edi
	movl	$t_end+8, %esi
	callq	LAMP_load8
	movq	t_end+8(%rip), %rbp
	movl	$128, %edi
	movl	$t_start+8, %esi
	callq	LAMP_load8
	subq	%r14, %rbx
	movq	t_start+8(%rip), %rax
	subq	%rax, %rbp
	cvtsi2sdq	%rbp, %xmm1
	cvtsi2sdq	%rbx, %xmm0
	divsd	.LCPI1_0(%rip), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, (%rsp)           # 8-byte Spill
	cvttsd2siq	%xmm1, %rdx
	movl	$129, %edi
	movl	$t_diff, %esi
	callq	LAMP_store8
	movsd	(%rsp), %xmm0           # 8-byte Reload
	movsd	%xmm0, t_diff(%rip)
	movl	$130, %edi
	movl	$t_diff, %esi
	callq	LAMP_load8
	movsd	t_diff(%rip), %xmm0
	movsd	%xmm0, (%rsp)           # 8-byte Spill
	movl	$131, %edi
	callq	LAMP_register
	movl	$.L.str6, %edi
	movsd	(%rsp), %xmm0           # 8-byte Reload
	movb	$1, %al
	callq	printf
	movl	$132, %edi
	callq	LAMP_register
	xorl	%edi, %edi
	callq	exit
.Ltmp29:
	.size	main, .Ltmp29-main
	.cfi_endproc

	.globl	wcp
	.align	16, 0x90
	.type	wcp,@function
wcp:                                    # @wcp
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Ltmp37:
	.cfi_def_cfa_offset 16
	pushq	%r15
.Ltmp38:
	.cfi_def_cfa_offset 24
	pushq	%r14
.Ltmp39:
	.cfi_def_cfa_offset 32
	pushq	%r13
.Ltmp40:
	.cfi_def_cfa_offset 40
	pushq	%r12
.Ltmp41:
	.cfi_def_cfa_offset 48
	pushq	%rbx
.Ltmp42:
	.cfi_def_cfa_offset 56
	subq	$56, %rsp
.Ltmp43:
	.cfi_def_cfa_offset 112
.Ltmp44:
	.cfi_offset %rbx, -56
.Ltmp45:
	.cfi_offset %r12, -48
.Ltmp46:
	.cfi_offset %r13, -40
.Ltmp47:
	.cfi_offset %r14, -32
.Ltmp48:
	.cfi_offset %r15, -24
.Ltmp49:
	.cfi_offset %rbp, -16
	movq	%r8, %r15
	movq	%rcx, %r12
	movq	%rdx, %r14
	movq	%rsi, %r13
	movq	%rdi, %rbx
	leaq	48(%rsp), %rsi
	movl	$134, %edi
	movq	%rbx, %rdx
	callq	LAMP_store8
	movq	%rbx, 48(%rsp)
	leaq	40(%rsp), %rsi
	movl	$135, %edi
	movq	%r13, %rdx
	callq	LAMP_store8
	movq	%r13, 40(%rsp)
	leaq	32(%rsp), %rsi
	movl	$136, %edi
	movq	%r14, %rdx
	callq	LAMP_store8
	leaq	24(%rsp), %rsi
	movq	%r14, 32(%rsp)
	movl	$137, %edi
	movq	%r12, %rdx
	callq	LAMP_store8
	leaq	16(%rsp), %r14
	movq	%r12, 24(%rsp)
	movl	$138, %edi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	LAMP_store8
	movq	%r15, 16(%rsp)
	movl	$139, %edi
	callq	LAMP_register
	movl	$.L.str7, %edi
	xorb	%al, %al
	callq	printf
	leaq	12(%rsp), %r15
	movl	$140, %edi
	movq	%r15, %rsi
	xorl	%edx, %edx
	callq	LAMP_store4
	movl	$0, 12(%rsp)
	movl	$164, %edi
	callq	LAMP_loop_invocation
	jmp	.LBB2_1
	.align	16, 0x90
.LBB2_2:                                # %for.body
                                        #   in Loop: Header=BB2_1 Depth=1
	movl	$142, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	movl	12(%rsp), %r12d
	movl	$143, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	movslq	12(%rsp), %rbx
	movl	$144, %edi
	movq	%r14, %rsi
	callq	LAMP_load8
	movq	16(%rsp), %rbp
	leaq	(%rbp,%rbx,8), %rsi
	movl	$145, %edi
	callq	LAMP_load8
	movq	(%rbp,%rbx,8), %rbx
	movl	$146, %edi
	callq	LAMP_register
	movl	$.L.str8, %edi
	movl	%r12d, %esi
	movq	%rbx, %rdx
	xorb	%al, %al
	callq	printf
	movl	$147, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	movl	12(%rsp), %eax
	incl	%eax
	movslq	%eax, %rbx
	movl	$148, %edi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store4
	movl	%ebx, 12(%rsp)
	callq	LAMP_loop_iteration_end
.LBB2_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	callq	LAMP_loop_iteration_begin
	movl	$141, %edi
	movq	%r15, %rsi
	callq	LAMP_load4
	cmpl	$24, 12(%rsp)
	jle	.LBB2_2
# BB#3:                                 # %for.end
	callq	LAMP_loop_iteration_end
	callq	LAMP_loop_exit
	movl	$163, %edi
	callq	LAMP_loop_invocation
	leaq	48(%rsp), %r13
	leaq	40(%rsp), %r14
	leaq	32(%rsp), %r15
	leaq	24(%rsp), %r12
	jmp	.LBB2_4
	.align	16, 0x90
.LBB2_12:                               # %sw.epilog
                                        #   in Loop: Header=BB2_4 Depth=1
	callq	LAMP_loop_iteration_end
.LBB2_4:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	callq	LAMP_loop_iteration_begin
	movl	$149, %edi
	movq	%r13, %rsi
	callq	LAMP_load8
	movq	48(%rsp), %rbx
	movl	$150, %edi
	movq	%rbx, %rsi
	callq	LAMP_load1
	cmpb	$0, (%rbx)
	je	.LBB2_13
# BB#5:                                 # %while.body
                                        #   in Loop: Header=BB2_4 Depth=1
	movl	$151, %edi
	movq	%r13, %rsi
	callq	LAMP_load8
	movq	48(%rsp), %rbx
	leaq	1(%rbx), %rbp
	movl	$152, %edi
	movq	%r13, %rsi
	movq	%rbp, %rdx
	callq	LAMP_store8
	movq	%rbp, 48(%rsp)
	movl	$153, %edi
	movq	%rbx, %rsi
	callq	LAMP_load1
	movsbl	(%rbx), %eax
	cmpl	$99, %eax
	jne	.LBB2_6
# BB#10:                                # %sw.bb3
                                        #   in Loop: Header=BB2_4 Depth=1
	movl	$156, %edi
	movq	%r14, %rsi
	callq	LAMP_load8
	movq	40(%rsp), %rdi
	jmp	.LBB2_11
.LBB2_6:                                # %while.body
                                        #   in Loop: Header=BB2_4 Depth=1
	cmpl	$119, %eax
	jne	.LBB2_7
# BB#9:                                 # %sw.bb2
                                        #   in Loop: Header=BB2_4 Depth=1
	movl	$155, %edi
	movq	%r15, %rsi
	callq	LAMP_load8
	movq	32(%rsp), %rdi
	jmp	.LBB2_11
.LBB2_7:                                # %while.body
                                        #   in Loop: Header=BB2_4 Depth=1
	cmpl	$108, %eax
	jne	.LBB2_12
# BB#8:                                 # %sw.bb
                                        #   in Loop: Header=BB2_4 Depth=1
	movl	$154, %edi
	movq	%r12, %rsi
	callq	LAMP_load8
	movq	24(%rsp), %rdi
.LBB2_11:                               # %sw.bb3
                                        #   in Loop: Header=BB2_4 Depth=1
	callq	ipr
	jmp	.LBB2_12
.LBB2_13:                               # %while.end
	callq	LAMP_loop_iteration_end
	callq	LAMP_loop_exit
	addq	$56, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	ret
.Ltmp50:
	.size	wcp, .Ltmp50-wcp
	.cfi_endproc

	.globl	ipr
	.align	16, 0x90
	.type	ipr,@function
ipr:                                    # @ipr
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%r14
.Ltmp54:
	.cfi_def_cfa_offset 16
	pushq	%rbx
.Ltmp55:
	.cfi_def_cfa_offset 24
	pushq	%rax
.Ltmp56:
	.cfi_def_cfa_offset 32
.Ltmp57:
	.cfi_offset %rbx, -24
.Ltmp58:
	.cfi_offset %r14, -16
	movq	%rdi, %rbx
	leaq	(%rsp), %r14
	movl	$157, %edi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	LAMP_store8
	movq	%rbx, (%rsp)
	movl	$158, %edi
	movq	%r14, %rsi
	callq	LAMP_load8
	movq	(%rsp), %rbx
	movl	$159, %edi
	callq	LAMP_register
	movl	$.L.str9, %edi
	movq	%rbx, %rsi
	xorb	%al, %al
	callq	printf
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	ret
.Ltmp59:
	.size	ipr, .Ltmp59-ipr
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
