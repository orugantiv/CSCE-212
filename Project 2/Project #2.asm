#By: V.N. Anirudh Oruganti
     .data
hardcoded_statement:        .asciiz    "The South Carolina Gamecocks football program represents the University of South Carolina in the sport of American football. The Gamecocks compete in the Football Bowl Subdivision of the National Collegiate Athletic Association (NCAA) and the Eastern Division of the Southeastern Conference. Will Muschamp currently serves as the team's head coach. They play their home games at Williams-Brice Stadium. Currently, it is the 20th largest stadium in college football. "
input1:      .space      300
input2:      .space      300
FirstWord:   .asciiz     "Please input first word:"
SecondWord:  .asciiz     "Please input second word:"
semi:	.asciiz          ": "
nextline: .asciiz 	"\n"



    .text

main:
 #*************************************Part-1*********************************
    # The First Input From The User
    li $v0, 4		# Prints string
    la $a0, FirstWord 	# The message we want to print
    syscall
    li $v0, 8		# takes string input
    la $a0, input1  	# the address
    li $a1, 300      	# Number of char space
    move $s0, $a0 	# saveing the string to s0
    syscall
    la $t0,input1
    jal Remove


    # The Second Input From The User
    li $v0, 4		# Prints string
    la $a0, SecondWord  # The message we want to print
    syscall
    li $v0, 8       	# takes string input
    la $a0, input2  	# the address
    li $a1, 300      	# Number of char space
    move $s1, $a0   	# saveing the string to s1
    syscall
    la $t0,input2	#This Remove the "/n" which the user entered to continue
    jal Remove		#This Removes chars ",.()/n-", from the hardcoded message.


    #Printing out the stats for the user's first input
    la $t0,hardcoded_statement
    jal Remove		#This Removes chars ",.()/n-", from the hardcoded message.
    move $s2,$t2	#Saving the new Hardcoded message to register $s2
    move $t0,$s2	#Initializing the hardcoded message for jump and loop "WordCheck"
    move $s4,$s0	#Initializing the first user's input for jump and loop "WordCheck"
    jal WordCheck	#This jal statement count the frequency of the user's input in hardcorded message
    move $s5,$s3    	#Saveing the counter to $s5
    li      $v0,4       #Printing string
    la      $a0,input1  #Printhing user's input
    syscall
    li      $v0,4	#Printing string
    la      $a0,semi	#Printing semicolon and a space
    syscall
    li      $v0,1	#Printing Int
    move    $a0,$s5     #Printing the number of times the word matched in the hardcorded message
    syscall
    li      $v0,4	#Printing String
    la      $a0,nextline #Moving to nextline
    syscall

    #Printing out the stats for the user's second input
    la $t0,hardcoded_statement
    jal Remove		#This Removes chars ",.()/n-", from the hardcoded message.
    move $s2,$t2	#Saving the new Hardcoded message to register $s2

    move $t0,$s2	#Initializing the hardcorded message for jump and loop "WordCheck"
    move $s4,$s1	#Initializing the first user's input for jump and loop "WordCheck"
    jal WordCheck	#This jal statement count the frequency of the user's input in hardcorded message
    move $s6,$s3	#Saveing the counter to $s6
    li      $v0,4       #Printing string
    la      $a0,input2  #Printhing user's input
    syscall
    li      $v0,4     	#Printing string
    la      $a0,semi   	#Printing semicolon and a space
    syscall
    li      $v0,1       #Printing Int
    move    $a0,$s6     #Printing the number of times the word matched in the hardcorded message
    syscall

    li      $v0,10	#exit
    syscall
    
#*************************************Part-2*********************************
Remove:
     move $t1,$t0
     move $t2,$t0
     li $t4,' '
StartRemove:

     lb $t3,0($t0)
     addi $t0, $t0, 1
     beq $t3,'.',Check
     beq $t3,',',Check
     beq $t3,'(',Check
     beq $t3,')',Check
     beq $t3,'-',Change
     sb $t3,0($t1)
     addi $t1, $t1, 1
     j Check
     Change:
          sb $t4,0($t1)
          addi $t1, $t1, 1
Check:
     bnez $t3,StartRemove
     jr $ra

#*************************************Part-3*********************************

	WordCheck:
    li $s3,0
	loop1:
    move    $t1,$t0
    move    $t2,$s4
	loop2:
    lb      $t3,0($t1)
    lb      $t4,0($t2)
    addi    $t1,$t1,1
    addi    $t2,$t2,1
    bne     $t3,$t4,case1
    bne     $t3,' ',loop2
    addi    $s3,$s3,1
    	j loop2
    	case1:
    addi    $t4,$t4,32
    bne     $t3,$t4,case2
    	j loop2
   	 case2:
    addi    $t4,$t4,-64
    bne     $t3,$t4,space
    	j loop2
   	 space:
    lb      $t4,0($t2)
    lb      $t3,0($t1)
    addi    $t1,$t1,1
    addi    $t0,$t0,1
    beq     $t3,' ',loop3
    beqz     $t3,loop3
  	  j space
   	loop3:
    addi    $t0,$t0,1
    bnez    $t3,loop1
	jr $ra
