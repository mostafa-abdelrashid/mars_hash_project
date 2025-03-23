.globl main

main:
#a0,a1 are passed as an arguments,s2 contains thw word

	lw $s2,0($a1)
	lb $s2,0($s2)
	addi $s2,$s2,-48
        #addi $s2,$zero,10

#t0 containing the mask value
	ori $t0,$zero,65280
	sll $t0,$t0,16
#t1 containing IV 2 4
	ori $t1,$zero,36
#t3 is the counter
	addi $t3,$zero,0

	jal hash_fn
#terminate the program after returning from hash function
	li $v0,10
        syscall
        
hash_fn:
#t2 containing a copy of the word input 
	add $t2,$s2,$zero
#setting the required 8 bits in the loop
	and $t2,$t2,$t0
#t1 is  the result of xoring x
	xor $t1,$t1,$t2
#put the result in t4
	addi $t4,$zero,-115
#-3x loop s0 is the min counter ,s1 is the max
	add $s0,$zero,$zero
	addi $s1,$zero,3
x_coeff_loop:
	beq $s0,$s1,set_x_squared_counter
	sub $t4,$t4,$t1
#increment the counter
	addi $s0,$s0,1
	j x_coeff_loop
set_x_squared_counter:
	add $s0,$zero,$zero
	addi $s1,$zero,21
	add $t5,$zero,$zero
	

x_squared_loop:
	beq $s0,$t1,set_x_squared_coeff_counter
#t5 contains x squared
	add $t5,$t5,$t1
#increment the counter
	addi $s0,$s0,1
	j x_squared_loop
set_x_squared_coeff_counter:
	add $s0,$zero,$zero
	addi $s1,$zero,21

x_squared_coeff_loop:
	beq $s0,$s1,set_x_cubed_counter
#t5 contains x^2 and t4 contains the result
	add $t4,$t4,$t5
	addi $s0,$s0,1
	j x_squared_coeff_loop
	
set_x_cubed_counter:
	add $s0,$zero,$zero
	add $t6,$zero,$zero
x_cubed_loop:
	beq $s0,$t1,set_x_cubed_counter_coeff
#t6 contains x^3
	add $t6,$t6,$t5
	addi $s0,$s0,1
	j x_cubed_loop
set_x_cubed_counter_coeff:
	add $s0,$zero,$zero
	addi $s1,$zero,201
set_x_cubed_coeff:
	beq $s0,$s1,set_the_8_bits
	sub $t4,$t4,$t6
	add $s0,$s0,1
	j set_x_cubed_coeff
set_the_8_bits:
#t7 is the mask for 0000 0000 0000 0000 0000 0000 1111	1111
	addi $t7,$zero,255
#t1 is the register containing 2 4 , t4 is the result of the function , t7 is the mask
	and $t1,$t4,$t7 

#incrementing the counter and changing the mask 
	addi $t3,$t3,1
	srl $t0,$t0,8
	bne $t3,4,hash_fn
#save the res in s0,v0,0x10010000
	add $s0,$t1,$zero
	add $v0,$t1,$zero
	ori $s1,$zero,4097
	sll $s1,$s1,16
	sw $s0,0($s1)
	
	
	jr $ra
