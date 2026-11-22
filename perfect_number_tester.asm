# Author:           Danny Watts
# Email address:    dannywatts@psu.edu
# Course:           CMPSC 312
# Assignment:       MIPS Programming Project
# Due date:         11/21/2026
# File:             perfect_number_tester.asm
# Purpose:          Prompts the user for a positive integer, determines whether
#                   the number is perfect, and outputs the result to the user
# Simulator:        MARS 4.5
# OS:               Windows 11 Pro
# References:       MIPS reference sheet
# AI tool(s):       None

.data
    inputMessage: .asciiz "Enter a positive number: "
    properFactors1: .asciiz "Proper factors of "
    properFactors2: .asciiz ": "
    properFactors3: .asciiz ", "
    newline: .asciiz "\n"
    sumMessage: .asciiz "Sum of proper factors: "
    perfectMessage: .asciiz "That number is perfect."
    notPerfectMessage: .asciiz "That number is not perfect."

.text
    main:
        # Print prompt
        li $v0, 4
        la $a0, inputMessage
        syscall

        # Read integer from user
        li $v0, 5
        syscall

        # Save integer
        move $s0, $v0

        # Allocate memory to store proper factors (the factors of a number
        # excluding the number itself). Therefore, the largest possible proper
        # factor would have to satisfy 2f = n, or f = n / 2. Therefore, we will
        # allocate n / 2 words of memory, or (n / 2) words * 4 bytes/word = n *
        # 2 bytes.
        li $v0, 9
        move $a0, $s0
        mul $a0, $a0, 2
        syscall

        # Save address of allocated memory
        move $s1, $v0

        # Determine proper factors. Begin by initializing registers for loop and
        # printing the prompt for the proper factors.
        li $t0, 1 # $t0 = iterator

        li $t1, 2
        div $s0, $t1
        mflo $t1 # $t1 = sentinel value ($s0 / 2)

        move $t2, $s1 # $t2 = memory address to store next factor

        li $v0, 4
        la $a0, properFactors1
        syscall

        li $v0, 1
        move $a0, $s0
        syscall

        li $v0, 4
        la $a0, properFactors2
        syscall

        # Because 1 is a proper factor of every positive integer and printing a
        # comma before the first number would be incorrect, we will process 1
        # separately.
        sw $t0, 0($t2)

        li $v0, 1
        move $a0, $t0
        syscall

        addi $t2, $t2, 4
        addi $t0, $t0, 1

    # For each number from 2 to n / 2, if $s0 is evenly divisible by that
    # number, store that number in allocated memory and print it.
    factorLoop:
        # Is n evenly divisible by the iterator?
        rem $t3, $s0, $t0
        bne $t3, $zero, notAFactor

        # If it is, store the iterator in memory, print a comma and it, and
        # increment the next memory address by 1 word, or 4 bytes.
        sw $t0, 0($t2)

        li $v0, 4
        la $a0, properFactors3
        syscall

        li $v0, 1
        move $a0, $t0
        syscall

        addi $t2, $t2, 4

    notAFactor:
        # Nothing needs to be done if the iterator is not a factor.

        # Increment the iterator, check if it is less than or equal to the
        # sentinel value, and continue the loop if it is.
        addi $t0, $t0, 1
        ble $t0, $t1, factorLoop

        # Ensure the array of factors is terminated by 0
        sw $zero, 0($t2)

        # End the line of printed factors with a newline
        li $v0, 4
        la $a0, newline
        syscall

        # Sum factors
        move $t0, $s1 # $t0 = address of factor
        move $t1, $zero # $t1 = sum

    sumLoop:
        # Load factor from memory address
        lw $a0, 0($t0)

        # Exit the loop if the factor is the sentinel value, 0
        beq $a0, $zero, sumDone

        # Otherwise, add the factor to the sum
        add $t1, $t1, $a0

        # Increment the memory address and continue the loop
        addi $t0, $t0, 4
        b sumLoop
    
    sumDone:
        # Print sum
        li $v0, 4
        la $a0, sumMessage
        syscall

        li $v0, 1
        move $a0, $t1
        syscall

        li $v0, 4
        la $a0, newline
        syscall

        # If the sum is not equal to the original number, the number is not
        # perfect.
        bne $t1, $s0, notPerfect

        # If it is, it is perfect. Let the user know.
        li $v0, 4
        la $a0, perfectMessage
        syscall

        b exit

    notPerfect:
        # Let the user know the number is not perfect.
        li $v0, 4
        la $a0, notPerfectMessage
        syscall

    exit:
        li $v0, 10
        syscall