/*
To do a simple division:
	- Dividend %rax
	- Divisor %rcx
	- Results in %rdx.
*/
.section .bss
	.equ   BUFFER_SIZE, 500
	.lcomm BUFFER_DATA, BUFFER_SIZE
	
.section .data

.section .text
	.equ diviseur, 10
.global _start
_start:
	pushq %rbp
	movq %rsp, %rbp
	movq  $1, %r8
	pushq $7654321
	callq allocate
	
.write_std_output:
	movq $1, %rax
	movq $1, %rdi
	movq $1, %rsi
	movq BUFFER_DATA, %rsi
	movq $500, %rdx
	syscall	
	
allocate:
	pushq %rbp
	movq %rsp, %rbp
	xor %rax, %rax
	movq 16(%rbp), %rax
	movq $10, %rcx
looping:
	xor %rdx, %rdx
	divq %rcx
	cmpq $0, %rax
	je revert_stack
	addq $'0', %rdx
	pushq %rdx
	incq %rsi
	jmp looping

/*
%rdi holds the increment
*/	
revert_stack:
	addq $'0', %rdx
	pushq %rdx
	movq $0, %rdi
	xor %rcx, %rcx
start_loop:
	cmpq $0, %rsi
	jl exit_system
	popq %rax
	movb %al, %cl
	movq $BUFFER_DATA, %rax
	movb %cl, (%rax,%rdi,1)
	incq %rdi
	decq %rsi
	jmp start_loop
		
		
	
exit_system:
	movq $1, %rax
	movq $1, %rdi
	movq $BUFFER_DATA, %rsi
	movq $77, %rdx
	syscall	
	
	movq $60, %rax
	movq $69, %rdi
	syscall
