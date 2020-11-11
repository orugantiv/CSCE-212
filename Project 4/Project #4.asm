#By; V.N.Anirudh Oruganti
.data
prompt: .asciiz "\nEnter 4 integers for A,B,C,D respectively:\n"
space: .asciiz "\n"
f: .asciiz "f = "
g: .asciiz "g = "
Zero.Zero: .float 0.0
Zero.One: .float 0.1
Zero.Two: .float 0.2
Zero.Three: .float 0.3
Zero.Four: .float 0.4

.text

main:

	
	################ User's Input ##############
	
	#displays prompt 
	la $a0,prompt #loads address of string memory
	li $v0,4 #System Call Print String 
	syscall #syscall 
	
	#Takes input for A and stores it in $t0
	li $v0, 5 #System Call Input Integer
	syscall #syscall
	move $s0, $v0 #saves input A to $t0
	
	#Takes input for B and stores it in $t1
	li $v0, 5 #System Call Input Integer
   	syscall #syscall
   	move $s1, $v0 #saves input B to $t1
  
	#Takes input for C and stores it in $t2
	li $v0, 5 #System Call Input Integer
   	syscall #syscall
   	move $s2, $v0 ##saves input C to $t2
  
	#Takes input for D and stores it in $t3
	li $v0, 5 #System Call Input Integer
   	syscall #syscall
   	move $s3, $v0 #saves input D to $t3


	 
	
	################ F START ################
	
	########## PROCESS FOR 0.1*A^4 ##########
	li $t0, 1        
	li $t1, 4    
	move $t3,$s0        
	move $t4,$s0
	move $t5,$s0
	jal Integer_Multiplication
	
	li $t6,0
	l.s $f1,Zero.One
	move $t7,$t5
	jal Decimal_Multiplication
	mov.s $f2,$f0
	l.s $f0,Zero.Zero
	#########################################
	
	########## PROCESS FOR 0.2*B^3 ##########
	li $t0, 1        
	li $t1, 3    
	move $t3,$s1        
	move $t4,$s1
	move $t5,$s1
	jal Integer_Multiplication
	
	li $t6,0
	l.s $f1,Zero.Two
	move $t7,$t5
	jal Decimal_Multiplication
	mov.s $f3,$f0
	l.s $f0,Zero.Zero

		
	#########################################
	
	########## PROCESS FOR 0.3*C^2 ##########
	li $t0, 1        
	li $t1, 2    
	move $t3,$s2        
	move $t4,$s2
	move $t5,$s2
	jal Integer_Multiplication
	
	li $t6,0
	l.s $f1,Zero.Three
	move $t7,$t5
	jal Decimal_Multiplication
	mov.s $f4,$f0
	l.s $f0,Zero.Zero

	
	#########################################
	
	########### PROCESS FOR 0.4*D ###########

	li $t6,0
	l.s $f1,Zero.Four
	move $t7,$s3
	jal Decimal_Multiplication
	mov.s $f5,$f0
	l.s $f0,Zero.Zero

	
	#########################################
	
	############## F SUMMATION ##############
		
	add.s $f6,$f2,$f4
	add.s $f7,$f3,$f5
	sub.s,$f6,$f6,$f7
	
	mov.s $f12, $f6 
    	li $v0, 2
    	syscall
	
	la $a0,space #loads address of string memory
	li $v0,4 #System Call Print String 
	syscall #syscall
	
	

	
	#########################################
	
	################ G START ################
	
	########## PROCESS FOR 0.1*AB^2 #########
	
	li $t0, 1        
	li $t1, 2    
	move $t3,$s1        
	move $t4,$s1
	move $t5,$s1
	jal Integer_Multiplication
	
	li $t0, 1        
	li $t1, 2    
	move $t3,$s0        
	jal Integer_Multiplication
	
	li $t6,0
	l.s $f1,Zero.One
	move $t7,$t5
	jal Decimal_Multiplication
	mov.s $f7,$f0
	l.s $f0,Zero.Zero
	

	
	#########################################
	
	########## PROCESS FOR 0.2*C^2D^3 #######
	
	li $t0, 1        
	li $t1, 2    
	move $t3,$s2        
	move $t4,$s2
	move $t5,$s2
	jal Integer_Multiplication
	move $s4,$t5
	
	li $t0, 1        
	li $t1, 3    
	move $t3,$s3        
	move $t4,$s3
	move $t5,$s3
	jal Integer_Multiplication
	
	li $t0, 1        
	li $t1, 2    
	move $t3,$s4        
	jal Integer_Multiplication
	
	li $t6,0
	l.s $f1,Zero.Two
	move $t7,$t5
	jal Decimal_Multiplication
	mov.s $f8,$f0
	l.s $f0,Zero.Zero
	

	
	#########################################
	
	############## G SUMMATION ##############
	
	#0.1*AB^2 is now in $f9
   	#0.2*C^2*D^3 is now in $f10
   	
   	add.s $f9, $f7,$f8
   	mov.s $f12, $f9 
    	li $v0, 2
    	syscall 
	
	##########################################
   	########### Display Output ###############
	
	#########################################
	
	################## END ##################
	
	li $v0, 10
	syscall	
	
	############# MULTIPLICATION ############
	
	Integer_Multiplication:  
  	beq $t0, $t1, End
  	li $t2, 1            
	Loop:  
  	beq $t2, $t3, END  
  	add $t4,$t4,$t5
	addi $t2, $t2, 1    #Counter  
  	j Loop  
	END:  
	move $t5,$t4
	addi $t0, $t0, 1   #Counter   
  	j Integer_Multiplication  
	End: jr $ra
	
	Decimal_Multiplication:
		beq $t6, $t7, Exit 
		add.s $f0, $f0, $f1 
		addi $t6, $t6, 1 
		j Decimal_Multiplication	
	Exit: jr $ra
	
