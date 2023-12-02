.global power_func 
.type power_func, @function
power_func:
	pushq %rbp
	movq  %rsp, %rbp
	xor   %rdi, %rdi
	xor   %rcx, %rcx
	movq  $1,   %rax
	movq  24(%rbp), %rdi
	movq  16(%rbp), %rcx

loop:
	imulq %rdi, %rax
	decq  %rcx
	cmpq  $0, %rcx
	jne   loop

quit_loop:
	movq %rbp, %rsp
	popq %rbp
	ret
	
