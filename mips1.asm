          .text
          .globl main

main:
         li $v0,4
         la $a0,mytext
         syscall
    # Exit the
.data 
	mytext: .ascii "hello world \n"