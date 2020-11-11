#written by Sam Dunny
.data
prompt: .asciiz "\nEnter 4 integers for A,B,C,D respectively: \n"
space: .asciiz "\n"
decimal1: .asciiz "f = "
decimal2: .asciiz "g = "
floatValue0: .float 0.0
floatValue1: .float 0.1
floatValue2: .float 0.2
floatValue3: .float 0.3
floatValue4: .float 0.4

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
   	
   	#load float values into registers
   	l.s $f0, floatValue0 
   	l.s $f1, floatValue1 
	l.s $f2, floatValue2 
	l.s $f3, floatValue3 
	l.s $f4, floatValue4 
	
	################ F START ################
	
	########## PROCESS FOR 0.1*A^4 ##########
	
	add $a0, $t1, $zero #loads A into $a0
	add $a1, $t1, $zero #loads A into $a1
	jal MULTIPLICATION #jump to procedure
	move $t0, $v0 #moves A^2 into $t0
	
	add $a0, $t0, $zero #loads A^2 into $a0
	add $a1, $t0, $zero #loads A^2 into $a1
	jal MULTIPLICATION #jump to procedure
	move $t0, $v0 #moves A^4 into $t0
	
	li $t6, 0 #increment
	Loop1:
		bge $t6, $t0, Quit1 #runs as long as $t6 < A^4
		add.s $f0, $f0, $f1 #adds 0.1 A^4 times
		addi $t6, $t6, 1 #increment
		j Loop1
		
	Quit1:
	
	add.s $f5, $f5, $f0 #duplicates $f0
	l.s $f0, floatValue0 #resets $f0
	#0.1*A^4 is now in $f5
	
	#########################################
	
	########## PROCESS FOR 0.2*B^3 ##########
	
	add $a0, $t2, $zero #loads B into $a0
	add $a1, $t2, $zero #loads B into $a1
	jal MULTIPLICATION #jump to procedure
	move $t0, $v0 #moves B^2 into $t0
	
	add $a0, $t2, $zero #loads B into $a0
	add $a1, $t0, $zero #loads B^2 into $a1
	jal MULTIPLICATION
	move $t0, $v0 #moves B^3 into $t0
	
	li $t6, 0 #increment
	Loop2:
		bge $t6, $t0, Quit2 #runs as long as $t6 < B^3
		add.s $f0, $f0, $f2 #adds 0.2 B^3 times
		addi $t6, $t6, 1 #increment
		j Loop2
		
	Quit2:
	
	add.s $f6, $f6, $f0 #duplicates $f0
	l.s $f0, floatValue0 #resets $f0
	#0.2*B^3 is now in $f6
	
	#########################################
	
	########## PROCESS FOR 0.3*C^2 ##########
	
	add $a0, $t3, $zero #loads C into $a0
	add $a1, $t3, $zero #loads C into $a1
	jal MULTIPLICATION #jump to procedure
	move $t0, $v0 #moves C^2 into $t0
	
	li $t6, 0 #increment
	Loop3:
		bge $t6, $t0, Quit3 #runs as long as $t6 < C^2
		add.s $f0, $f0, $f3 #adds 0.3 C^2 times
		addi $t6, $t6, 1 #increment
		j Loop3
		
	Quit3:
	
	add.s $f7, $f7, $f0 #duplicates $f0
	l.s $f0, floatValue0 #resets $f0
	#0.3*C^2 is now in $f7
	
	#########################################
	
	########### PROCESS FOR 0.4*D ###########
	
	li $t6, 0 #increment
	Loop4:
		bge $t6, $t4, Quit4 #runs as long as $t6 < D
		add.s $f0, $f0, $f4 #adds 0.4 D times
		addi $t6, $t6, 1 #increment
		j Loop4
		
	Quit4:
	
	add.s $f8, $f8, $f0 #duplicates $f0
	l.s $f0, floatValue0 #resets $f0
	#0.4*D is now in $f8
	
	#########################################
	
	############## F SUMMATION ##############
	
	#0.1*A^4 is now in $f5
   	#0.2*B^3 is now in $f6
	#0.3*C^2 is now in $f7
	#0.4*D is now in $f8
	
	sub.s $f5, $f5, $f6
	add.s $f5, $f5, $f7
	sub.s $f5, $f5, $f8 #final sum of F in $f5
	
	li $v0, 4 #syscall to print_string
	la $a0, decimal1 #prints out the decimal string prompt 
	syscall
	li $v0, 2 #syscall to print_float
	mov.s $f12, $f5
	syscall
	li $v0, 4 #syscall to print_string
	la $a0, space #prints out new line
	syscall
	
	#########################################
	
	################ G START ################
	
	########## PROCESS FOR 0.1*AB^2 #########
	
	add $a0, $t2, $zero #loads B into $a0
	add $a1, $t2, $zero #loads B into $a1
	jal MULTIPLICATION #jump to procedure
	move $t0, $v0 #moves B^2 into $t0
	
	add $a0, $t0, $zero #loads B^2 into $a0
	add $a1, $t1, $zero #loads A into $a1
	jal MULTIPLICATION #jump to procedure
	move $t0, $v0 #moves AB^2 into $t0
	
	li $t6, 0 #increment
	Loop5:
		bge $t6, $t0, Quit5 #runs as long as $t6 < AB^2
		add.s $f0, $f0, $f1 #adds 0.1 AB^2 times
		addi $t6, $t6, 1 #increment
		j Loop5
		
	Quit5:
	
	add.s $f9, $f9, $f0 #duplicates $f0
	l.s $f0, floatValue0 #resets $f0
	#0.1*AB^2 is now in $f9
	
	#########################################
	
	########## PROCESS FOR 0.2*C^2D^3 #########
	
	add $a0, $t3, $zero #loads C into $a0
	add $a1, $t3, $zero #loads C into $a1
	jal MULTIPLICATION #jump to procedure
	move $t0, $v0 #moves C^2 into $t0
	
	add $a0, $t4, $zero #loads D into $a0
	add $a1, $t4, $zero #loads D into $a1
	jal MULTIPLICATION #jump to procedure
	move $t7, $v0 #moves D^2 into $t7
	
	add $a0, $t7, $zero #loads D^2 into $a0
	add $a1, $t4, $zero #loads D into $a1
	jal MULTIPLICATION #jump to procedure
	move $t7, $v0 #moves D^3 into $t7
	
	add $a0, $t0, $zero #loads C^2 into $a0
	add $a1, $t7, $zero #loads D^3 into $a1
	jal MULTIPLICATION #jump to procedure
	move $t0, $v0 #moves C^2D^3 into $t0
	
	li $t6, 0 #increment
	Loop6:
		bge $t6, $t0, Quit6 #runs as long as $t6 < C^2D^3
		add.s $f0, $f0, $f2 #adds 0.2 C^2D^3 times
		addi $t6, $t6, 1 #increment
		j Loop6
		
	Quit6:
	
	add.s $f10, $f10, $f0 #duplicates $f0
	l.s $f0, floatValue0 #resets $f0
	#0.2*C^2D^3 is now in $f10
	
	#########################################
	
	############## G SUMMATION ##############
	
	#0.1*AB^2 is now in $f9
   	#0.2*C^2*D^3 is now in $f10
	
	add.s $f11, $f9, $f10 #final sum of G in $f11
	
	li $v0, 4 #syscall to print_string
	la $a0, decimal2 #prints out the decimal string prompt 
	syscall
	li $v0, 2 #syscall to print_float
	mov.s $f12, $f11
	syscall
	li $v0, 4 #syscall to print_string
	la $a0, space #prints out new line
	syscall
	
	#########################################
	
	################## END ##################
	
	#END
	li $v0, 10
	syscall	
	
	############# MULTIPLICATION ############
	
	MULTIPLICATION:
		addi $sp, $sp, -4 #push $t5 on stack
		sw $t5, 0($sp) #initializes $t5 in memory
	
		add $t5, $zero, $zero #clears $t5
		add $v0, $zero, $zero #clears $v0
	
		LoopMult:
			beq $t5, $a0, EXIT #branches when $t5 = input0
			add $v0, $v0, $a1 #result = result + input1, runs input0 times
			addi $t5, $t5, 1 #increment
			j LoopMult
	
		EXIT:
		lw $t5, 0($sp) #restores $t5
		addi $sp, $sp, 4 #restores memory
		jr $ra #return
