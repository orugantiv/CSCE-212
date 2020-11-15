#By; V.N.Anirudh Oruganti
.data
InputMsg: .asciiz "\nEnter 4 integers for A,B,C,D respectively:\n"
NextLine: .asciiz "\n"
f: .asciiz "f = "
g: .asciiz "g = "
Zero.Zero: .float 0.0
Zero.One: .float 0.1
Zero.Two: .float 0.2
Zero.Three: .float 0.3
Zero.Four: .float 0.4

.text

main:

	##########################################################
	##################### User's Input #######################
	##########################################################
	
	#Displays InputMsg  
	la $a0,InputMsg 		#loads address of string memory
	li $v0,4 			#System Call Print String 
	syscall 			#syscall 
	
	#Takes input for A and stores it in $s0
	li $v0, 5 			#System Call Input Integer
	syscall 			#syscall
	move $s0, $v0 			#saves input A to $t0
	
	#Takes input for B and stores it in $s1
	li $v0, 5 			#System Call Input Integer
   	syscall 			#syscall
   	move $s1, $v0 			#saves input B to $t1
  
	#Takes input for C and stores it in $s2
	li $v0, 5 			#System Call Input Integer
   	syscall 			#syscall
   	move $s2, $v0 			#saves input C to $t2
  
	#Takes input for D and stores it in $s3
	li $v0, 5 			#System Call Input Integer
   	syscall 			#syscall
   	move $s3, $v0 			#saves input D to $t3


	########################################################## 
	######### F=(0.1×A4)-(0.2×B3)+(0.3×C2)-(0.4×D) ###########
	##########################################################
	################# Calculating 0.1*A^4 ####################
	##########################################################
	
	## A^4 ##
	li $t0, 1 			#Initializing i=1 for Integer_Multiplication      
	li $t1, 4 			#Initializing the number of times Integer_Multiplication loops   
	move $t3,$s0			#Initializing A for conditional purposes        
	move $t4,$s0			#Initializing A for adding purposes
	move $t5,$s0			#Initializing A for adding purposes
	jal Integer_Multiplication	#This procedure calculates A^4 and return the value in $t5 register
	
	## 0.1*A^4 ##
	li $t6,0			#Initializing i=1 for Decimal_Multiplication 
	l.s $f1,Zero.One		#Initializing 0.1 into $f1 for adding purposes in Decimal_Multiplication
	move $t7,$t5			#The number of times $f1 should add to a register in Decimal_Multiplication
	jal Decimal_Multiplication	#This procedure calculates 0.1*A^4 Decimal Multiplication and return the value in $f0 register
	mov.s $f2,$f0			#Stores the returned value in $f2 for adding purposes 
	l.s $f0,Zero.Zero		#Resets $f0 register to 0 for future calculations 

	########################################################## 	
	################# Calculating 0.2*B^3 ####################
	##########################################################
	
	## B^3 ##
	li $t0, 1 			#Initializing i=1 for Integer_Multiplication      
	li $t1, 3 			#Initializing the number of times Integer_Multiplication loops   
	move $t3,$s1			#Initializing B for conditional purposes          
	move $t4,$s1			#Initializing B for adding purposes
	move $t5,$s1			#Initializing B for adding purposes
	jal Integer_Multiplication	#This procedure calculates B^3 and return the value in $t5 register
	 
	## 0.2*B^3 ## 
	li $t6,0			#Initializing i=0 for Decimal_Multiplication 
	l.s $f1,Zero.Two		#Initializing 0.2 into $f1 for adding purposes in Decimal_Multiplication
	move $t7,$t5			#The number of times $f1 should add to a register in Decimal_Multiplication
	jal Decimal_Multiplication	#This procedure calculates 0.2*B^3 Decimal Multiplication and return the value in $f0 register
	mov.s $f3,$f0			#Stores the returned value in $f3 for adding purposes 
	l.s $f0,Zero.Zero		#Resets $f0 register to 0 for future calculations 
			
	########################################################## 	
	################# Calculating 0.3*C^2 ####################
	##########################################################
	
	## C^2 ##
	li $t0, 1 			#Initializing i=1 for Integer_Multiplication      
	li $t1, 2 			#Initializing the number of times Integer_Multiplication loops   
	move $t3,$s2			#Initializing C for conditional purposes          
	move $t4,$s2			#Initializing C for adding purposes
	move $t5,$s2			#Initializing C for adding purposes
	jal Integer_Multiplication	#This procedure calculates C^2 and return the value in $t5 register
	 
	## 0.3*C^2 ## 
	li $t6,0			#Initializing i=0 for Decimal_Multiplication 
	l.s $f1,Zero.Three		#Initializing 0.3 into $f1 for adding purposes in Decimal_Multiplication
	move $t7,$t5			#The number of times $f1 should add to a register in Decimal_Multiplication
	jal Decimal_Multiplication	#This procedure calculates 0.3*C^2 Decimal Multiplication and return the value in $f0 register
	mov.s $f4,$f0			#Stores the returned value in $f4 for adding purposes 
	l.s $f0,Zero.Zero		#Resets $f0 register to 0 for future calculations 
	

	########################################################## 	
	################# Calculating 0.4*D ######################
	##########################################################

	## 0.4*D ## 
	li $t6,0			#Initializing i=0 for Decimal_Multiplication 
	l.s $f1,Zero.Four		#Initializing 0.4 into $f1 for adding purposes in Decimal_Multiplication
	move $t7,$s3			#The number of times $f1 should add to a register in Decimal_Multiplication
	jal Decimal_Multiplication	#This procedure calculates 0.4*D Decimal Multiplication and return the value in $f0 register
	mov.s $f5,$f0			#Stores the returned value in $f5 for adding purposes 
	l.s $f0,Zero.Zero		#Resets $f0 register to 0 for future calculations 
	
	##########################################################
	##################### F Calculations #####################
	##########################################################
	
	#Summation of F
	add.s $f6,$f2,$f4		#Adding (0.1×A4)+(0.3×C2)	
	add.s $f7,$f3,$f5		#Adding (0.2×B3)+(0.4×D)
	sub.s,$f6,$f6,$f7		#Subtracting (0.1×A4)+(0.3×C2) - (0.2×B3)+(0.4×D) = F
			
	#Displays f =  		
	la $a0,f 			#loads address of string memory
	li $v0,4 			#System Call Print String 
	syscall 			#syscall 
	
	#Displays Value of f	
	mov.s $f12, $f6 		#Saving F value to $f12 to print 
    	li $v0, 2			#System call Print Floating Point
    	syscall				#syscall
	
	la $a0,NextLine			#loads address of string memory
	li $v0,4 			#System Call Print String 
	syscall 			#syscall
		
	########################################################## 
	############ G=(0.1×A*B^2)+(0.2×C^2*D^3) #################
	##########################################################
	################ Calculating 0.1×A*B^2 ###################
	##########################################################
	
	## B^2 ##
	li $t0, 1 			#Initializing i=1 for Integer_Multiplication      
	li $t1, 2 			#Initializing the number of times Integer_Multiplication loops   
	move $t3,$s1			#Initializing B for conditional purposes         
	move $t4,$s1			#Initializing B for adding purposes
	move $t5,$s1			#Initializing B for adding purposes
	jal Integer_Multiplication	#This procedure calculates B^2 and return the value in $t5 register
	
	#A*B^2					
	li $t0, 1 			#Initializing i=1 for Integer_Multiplication			       
	li $t1, 2    			#Initializing i<2 only loops once, Since it is a simple multiplaciton 
	move $t3,$s0        		#Initializing A for conditional purposes, Number of time the Inner loop loops. Also $t4 and $t5 are defined from previous procedure  
	jal Integer_Multiplication	#This procedure calculates A*B^2 and return the value in $t5 register
	
	#0.1×A*B^2
	li $t6,0			#Initializing i=0 for Decimal_Multiplication 
	l.s $f1,Zero.One		#Initializing 0.1 into $f1 for adding purposes in Decimal_Multiplication
	move $t7,$t5			#The number of times $f1 should add to a register in Decimal_Multiplication
	jal Decimal_Multiplication	#This procedure calculates 0.1*A*B^2 Decimal Multiplication and return the value in $f0 register
	mov.s $f7,$f0			#Stores the returned value in $f7 for adding purposes 
	l.s $f0,Zero.Zero		#Resets $f0 register to 0 for future calculations 
		
	##########################################################
	################ Calculating 0.2*C^2D^3 ##################
	##########################################################		
	
	## C^2 ##
	li $t0, 1 			#Initializing i=1 for Integer_Multiplication      
	li $t1, 2 			#Initializing the number of times Integer_Multiplication loops   
	move $t3,$s2			#Initializing C for conditional purposes         
	move $t4,$s2			#Initializing C for adding purposes
	move $t5,$s2			#Initializing C for adding purposes
	jal Integer_Multiplication	#This procedure calculates B^2 and return the value in $t5 register
	move $s4,$t5			#Saving the returned value into $t5 for future calculations
		
	## D^3 ##
	li $t0, 1 			#Initializing i=1 for Integer_Multiplication      
	li $t1, 3 			#Initializing the number of times Integer_Multiplication loops   
	move $t3,$s3			#Initializing D for conditional purposes         
	move $t4,$s3			#Initializing D for adding purposes
	move $t5,$s3			#Initializing D for adding purposes
	jal Integer_Multiplication	#This procedure calculates B^2 and return the value in $t5 register
	
	#C^2D^3				
	li $t0, 1 			#Initializing i=1 for Integer_Multiplication			       
	li $t1, 2    			#Initializing i<2 only loops once, Since it is a simple multiplaciton 
	move $t3,$s4        		#Initializing C^2 for conditional purposes, Number of time the Inner loop loops. Also $t4 and $t5 are defined/initialized from previous procedure  
	jal Integer_Multiplication	#This procedure calculates C^2D^3 and return the value in $t5 register
		
	#0.2*C^2D^3
	li $t6,0			#Initializing i=0 for Decimal_Multiplication 
	l.s $f1,Zero.Two		#Initializing 0.2 into $f1 for adding purposes in Decimal_Multiplication
	move $t7,$t5			#The number of times $f1 should add to a register in Decimal_Multiplication
	jal Decimal_Multiplication	#This procedure calculates 0.2*C^2D^3 Decimal Multiplication and return the value in $f0 register
	mov.s $f8,$f0			#Stores the returned value in $f8 for adding purposes 
	l.s $f0,Zero.Zero		#Resets $f0 register to 0 for future calculations 
			

	
	##########################################################
	##################### G Calculations #####################
	##########################################################
	
   	#Summation of G
   	add.s $f9, $f7,$f8		#Adding (0.1×A*B^2)+(0.2×C^2*D^3) and storing it in $f9

	#Displays g =		
	la $a0,g 			#loads address of string memory
	li $v0,4 			#System Call Print String 
	syscall 			#syscall 
	
	#Displays Value of g	
	mov.s $f12, $f9 		#Saving F value to $f12 to print 
    	li $v0, 2			#System call Print Floating Point
    	syscall				#syscall
	
	#Exit
	li $v0,10 			#System Call Exit
	syscall 			#syscall
		
	##########################################################
	############## Multiplication Procedures #################
	##########################################################
	
	###########################################################################################################################################################################################
	### Register ############## Purpose #######################################################################################################################################################
	### $t0		#### The counter/number of times the loop has looped,initially this is set to 1 before the procedure is called.								###
	### $t1	     	#### The power/number of time loop loops,this value is set before the procedure is called.										###
	### $t2		#### The counter in the inner loop,this reset everytime to 1 after outter loop repeats.											###
	### $t3		#### The multiplication number 1. This is the number of time that number 2 is added to a register. This initially is set before the procedure is called. 		###
	### $t4		#### This register has the multiplyed value from the loop, This is set before the procedure is called.  								###
	### $t5		#### This register works as a temporary value that gets reset to $t4 everytime inner loop is completed. Also this addes to $t4 in inner loop to complete multiplication ###
	###########################################################################################################################################################################################
	
	Integer_Multiplication:  
  	beq $t0, $t1, End		#while(i<power){
  	li $t2, 1            		#int t=1
	Loop:  				
  	beq $t2, $t3, END  		#while(t<number){
  	add $t4,$t4,$t5			#number2=number2+tempnumber
	addi $t2, $t2, 1    		#++t } 	
  	j Loop  
	END:  
	move $t5,$t4			# tempnumber=number2
	addi $t0, $t0, 1   #Counter   	#++i}
  	j Integer_Multiplication  
	End: jr $ra
	
	###################################################################################################################################################
	### Register ############## Purpose ###############################################################################################################
	### $t6		#### This register is a counter to the number of times the loop should repeat.							###
	### $t7	     	#### This register is a the number of times loop repeats									###
	### $f0		#### This is the final multiplicated value. This is initially set to 0 before the procedure is called				###
	### $f1		#### This register cotains the decimal value and this value is added once every one loop to $f0 		 		###
	###################################################################################################################################################
	
	Decimal_Multiplication:
	beq $t6, $t7, Exit 		#while($t6<$t7){
	add.s $f0, $f0, $f1 		#$f0= $f0+$f1
	addi $t6, $t6, 1 		#++$t6 #counter
	j Decimal_Multiplication	#}
	Exit: jr $ra
	
