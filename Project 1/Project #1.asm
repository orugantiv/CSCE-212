#By: V.N. Anirudh Oruganti
.data
prompt: .asciiz "\n Enter 4 integers for A,B,C,D respectively: \n"
space: .asciiz "\n"
decimal: .asciiz "f_ten = "
binary: .asciiz "f_two = "
decimal2: .asciiz "g_ten = "
binary2: .asciiz "g_two = " 
quotient: .asciiz "h_quotient = "
remainder: .asciiz "h_remainder = "

.text
main:
	
	#displays prompt 
	li $v0,4 #loads syscall-4, address of string 
	la $a0,prompt #loads address of string memory
	syscall #print
	
	#Read A input to $v0 and store it in $t1
	li $v0, 5 #read_int
	syscall #make the syscall
	move $t1, $v0 #moves $v0 to $t1
	
	#Read B input in $v0 and store it in $t2
   	li $v0, 5 #read_int
   	syscall #makes the syscall
   	move $t2, $v0 #moves $v0 to $t2
  
	#Read C input in $v0 and store it in $t3
  	li $v0, 5 #read_int
   	syscall #makes the syscall
   	move $t3, $v0 #moves $v0 to $t3
  
   	#Read D input in $v0 and store it in $t4
	li $v0, 5 #read_int
   	syscall #makes the syscall
   	move $t4, $v0 #moves $v0 to $t4
   	
   	#Finding AC^3
   	li $t5, 0 #loads variable $t5 = 0
   	Loop1: 
   		#loop for A*C
   		bge $t5, $t1, Quit1 #runs as long as $t5 < A
   		add $s1, $s1, $t3 #declares $s1, adds C A times
   		addi $t5, $t5, 1 #i = i+1
   		j Loop1
   		#you now have A*C
   	Quit1:
   		#loop for (C^2)
   		li $t5, 0 #resets $t5 to 0
   	Loop1A:
   		bge $t5, $t3, Quit1A #runs as long as $t5 < C
   		add $s2, $s2, $t3 #declares $s2, add C to C
   		add $t5, $t5, 1 #i = i+1
   		j Loop1A
   		#you now have (C^2)
   	Quit1A: 
   		li $t5, 0 #resets $t5 to 0
   	Loop1AA:
   		#loop for (AC) * (C^2)
   		bge $t5, $s1, Quit1AA #runs AC times
   		add $t6, $t6, $s2 #adding $s2 to $s2
   		addi $t5, $t5, 1 # i= i+1
   		j Loop1AA
   	#END of finding AC^3	
   	
   	
   	#Finding 3C^2
   	Quit1AA:  	
   		li $t5, 0 #resets $t5 to 0
   	Loop2:
   		#loop for C^2
   		bge $t5, $t3, Quit2 #runs as long as $t5 < C
   		add $s3, $s3, $t3 #declares $s3, adds C to it repetitively
   		addi $t5, $t5, 1 # i = i+1
   		j Loop2
   		#you now have C^2
   	Quit2:
   		li $t5, 0 #resets $t5 to 0
   	Loop2A:
   		#loop for 3C^2
   		bge $t5, 3, Quit2A #runs 3 times, to get (C^2)+(C^2)+(C^2)
   		add $s4, $s4, $s3 #declares $s4, $s4 + (C^2)
		addi $t5, $t5, 1 # i = i+1
		j Loop2A
	#END of finding 3C^2
	
	
	#Finding BD^2
	Quit2A:
		li $t5, 0 #resets $t5 to 0
	Loop3:
		#loop for D^2
		bge $t5, $t4, Quit3 #runs as long as $t5 < D
		add $s5, $s5, $t4 #declares $s5, adds D
		addi $t5, $t5, 1 # i = i+1
		j Loop3
		#you now have D^2
	Quit3:
		li $t5, 0 #resets $t5 to 0
	Loop3A:
		#loop for BD^2
		bge $t5, $t2, Quit3A #runs as long as $t5 < B
		add $s6, $s6, $s5 #declares $s6, adds $s5=D^2
		addi $t5, $t5, 1 #i = i+1
		j Loop3A
	#END of finding BD^2
	
	
	#Finding 4B
	Quit3A:
		li $t5, 0 #resets $t5 to 0
	Loop4:
		#loop to get 4B
		bge $t5, 4, Quit4 #runs as long as $t5 < 4
		add $s7, $s7, $t2 #declares $s7, adds B to it repetitively
		addi $t5, $t5, 1 #i = i+1
		j Loop4
	#END of finding 4B
	
	#START G EQUATION
		
	#Finding A^2C	
	Quit4:
		li $t5, 0 #rests $t5 to 0
	Loop5:
		#loop to find A^2
		bge $t5, $t1, Quit5
		add $s0, $s0, $t1 #declares $s0, last saved variable, adds A to it repetitively
		addi $t5, $t5, 1 #i = i+1
		j Loop5
		#you know have A^2
	Quit5:
		li $t5, 0 #resets $t5 to 0
		li $s1, 0 #resets $s1 to 0 because we ran out of saved registers
	Loop5A:
		#loop to find A^2C
		bge $t5, $t3, Quit5A #runs as long as $t5 < C
		add $s1, $s1, $s0 #redeclares $s1, adds A^2 repetitively
		addi $t5, $t5, 1
		j Loop5A
	#END of finding A^2C
	
	
	#Finding B^2D^2		
	Quit5A:		
		li $t5, 0 #resets $t5 to 0
		li $s2, 0 #resets $s2 to 0 because we ran out of saved registers
	Loop6:
		#loop to find B^2
		bge $t5, $t2, Quit6
		add $s2, $s2, $t2 #redeclares $s2, adds B repetitively
		addi $t5, $t5, 1 # i = i+1
		j Loop6
		#you now B^2
	Quit6:
		li $t5, 0 #resets $t5 to 0
		li $s3, 0 #resets $s3 to 0 because we ran out of saved registers
	Loop6A:
		#loop to find D^2
		bge $t5, $t4, Quit6A #runs as long as $t5 < D
		add $s3, $s3, $t4 #redeclares $s3, adds D repetitively
		addi $t5, $t5, 1 #i = i+1
		j Loop6A
		#you now have D^2
	Quit6A:
		li $t5, 0 #resets $t5 to 0
		li $s5, 0 #resets $s5 to 0 because we ran out of saved registers
	Loop6AA:
		#loop to find B^2D^2
		bge $t5, $s2, Quit6AA # runs as long as $t5 < B^2
		add $s5, $s5, $s3 #redeclares $s5, adds D^2 repetitively
		addi $t5, $t5, 1 #i = i+1
		j Loop6AA
	#END of finding B^2D^2
	
	
	#CALCULATIONS FOR F AND G
	Quit6AA:
		#f is $t7
		li $t7, 0 #zeroes out $t7
		sub $t7, $t6, $s4 #AC^3 - 3C^2
		add $t7, $t7, $s6 #AC^3 - 3C^2 + BD^2
		sub $t7, $t7, $s7 #AC^3 - 3C^2 + BD^2 -4B
		
		#g is $t8
		li $t8, 0 #zeroes out $t8
		add $t8, $s1, $s5 # A^2C + $B^2D^2	
		
			
	#PART B:: h = f/g
		li $t5, 0 #sets $t5 to 0, counter for this loop
		li $t9, 0 
		add $t9, $t7, $zero #duplicates $t7 into $t9
	Loop7:
		#$t9 = f, $t8 = g
		#loop to get quotient, will be $t5
		ble $t9, $t8, EXIT #runs as long g <= f, f is getting smaller
		sub $t9, $t9, $t8 #subtracts 1 g from f each loop, stores in f
		addi $t5, $t5, 1 # i = i+1, quotient
		j Loop7
		#you now have quotient $t5
		#you now have remainder $t9
	
	
	EXIT:	
	#OUTPUT RESULTS FOR PART A
	#1st EQUATION
	
	li $v0, 4 #syscall to print_string
	la $a0, decimal #prints out the decimal string prompt and int
	syscall
	
	li $v0, 1 #syscall to print_int
	move $a0, $t7 #moves $a0 to $t7
	syscall
	
	li $v0, 4 #syscall to print_string
	la $a0, space #prints out new line
	syscall
	
	li $v0, 4 #syscall to print_string
	la $a0, binary #prints out the binary string prompt and int
	syscall
	
	li $v0, 35 #syscall to print_binary
	move $a0, $t7 #moves $a0 to $t7
	syscall
	
	li $v0, 4 #syscall to print_string
	la $a0, space #prints out new line
	syscall
	
	#2nd EQUATION
	
	li $v0, 4 #syscall to print_string
	la $a0, decimal2 #prints out the decimal string prompt and int
	syscall
	
	li $v0, 1 #syscall to print_int
	move $a0, $t8 #moves $a0 to $t8
	syscall
	
	li $v0, 4 #syscall to print_string
	la $a0, space #prints out new line
	syscall
	
	li $v0, 4 #syscall to print_string
	la $a0, binary2 #prints out the binary string prompt and int
	syscall
	
	li $v0, 35 #syscall to print_binary
	move $a0, $t8 #moves $a0 to $t8
	syscall
	
	li $v0, 4 #syscall to print_string
	la $a0, space #prints out new line
	syscall
	
	#OUTPUT RESULTS FOR PART B

	li $v0, 4 #syscall to print_string
	la $a0, quotient #prints out the quotient string prompt and int
	syscall
	
	li $v0, 1 #syscall to print_int
	move $a0, $t5 #moves $a0 to $t5
	syscall
	
	li $v0, 4 #syscall to print_string
	la $a0, space #prints out new line
	syscall
	
	li $v0, 4 #syscall to print_string
	la $a0, remainder #prints out the remainder string prompt and int
	syscall
	
	li $v0, 1 #syscall to print_int
	move $a0, $t9 #moves $a0 to $t9
	syscall
	
	li $v0, 4 #syscall to print_string
	la $a0, space #prints out new line
	syscall
	
	#END
	li $v0, 10
	syscall
