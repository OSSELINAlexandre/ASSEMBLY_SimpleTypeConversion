.section .bss
	.lcomm first_input_buffer,  10
	.lcomm second_input_buffer, 10

.section .data
	
first_in:
	.int 0
second_in:
	.int 0
	
rules:
	.asciz "Simple String to int transformation."

first_input_msg_to_user:
	.asciz "First input : "

second_input_msg_to_user:
	.asciz "Second input : "

.section .text
.global _start
_start:

intro_msg:
	mov $1, %rax
	mov $1, %rdi
	lea [rules] , %rsi
	mov $36, %rdx
	syscall	
	
first_input_msg:
	movq $1, %rax
	movq $1, %rdi
	leaq [first_input_msg_to_user] , %rsi
	movq $14, %rdx
	syscall	

first_input_user:
	movq $0, %rax
	movq $0, %rdi
	leaq [first_input_buffer], %rsi
	movq $10, %rdx
	syscall
	
second_input_msg:
	movq $1, %rax
	movq $1, %rdi
	leaq [second_input_msg_to_user] , %rsi
	movq $15, %rdx
	syscall	

second_input_user:
	movq $0, %rax
	movq $0, %rdi
	leaq [second_input_buffer], %rsi
	movq $10, %rdx
	syscall

transforming_to_int:

	pushq $first_input_buffer
	callq convert_to_int
	movq  %rdx, first_in
	
	pushq $second_input_buffer
	callq convert_to_int
	movq  %rdx, second_in

exit_function:
	movq %rbp, %rsp
	popq %rbp
	retq


convert_to_int:
	pushq %rbp
	movq  %rsp, %rbp
	xor   %rdi, %rdi
	xor   %rdx, %rdx
	xor   %rbx, %rbx
	movq  16(%rbp), %rsi

loop:
	cmpq  $10, %rdi /*Parcourir les 10 octets du buffer*/
	je    revert_loop_init
	xor   %rax, %rax
	movb  (%rsi, %rdi, 1), %cl
	cmpb  $'0', %cl /*Check result isn't /n or other non necessary character.*/
	jl    continue_loop
	cmpb  $'9', %cl
	jg    continue_loop
	subb  $'0', %cl
	incq  %rbx
	movb  %cl, %al
	pushq %rax
continue_loop:
	incq  %rdi
	jmp   loop
	
revert_loop_init:
	xor   %rdx, %rdx
	movq  %rbx, %r9
	movq  %rbx ,%r10

revert_loop:
	xor   %rsi, %rsi
	popq  %rsi
	callq multiply_ten
	addq  %rsi, %rdx
	decq  %rbx
	cmpq  $0, %rbx
	je    exit_func
	jmp   revert_loop
	
multiply_ten:
	movq  %rbx, %r8
	subq  %r8,  %r9
multiply:
	cmpq  $0, %r9
	je    exit
	imulq $10, %rsi
	decq  %r9
	jmp  multiply 
exit:
	movq  %r10, %r9
	retq

	
exit_func:
	movq  %rbp, %rsp
	popq  %rbp
	retq

