# Author:           Danny Watts
# Email address:    dannywatts@psu.edu
# Course:           CMPSC 312
# Assignment:       MIPS Programming Project
# Due date:         11/21/2026
# File:             perfect_number_tester.asm
# Purpose:
# Simulator:        MARS 4.5
# OS:               Windows 11 Pro
# References:
# AI tool(s):

.data
    message: .asciiz "Enter a positive number: "

.text
    main:
        # Prompt user
        li $v0, 4
        la $a0, message
        syscall

        # Read integer from user
        li $v0, 5
        syscall

        # Save integer
        move $s0, $v0

        # Allocate memory to store factors
        move $a0, $s0
        li $v0, 9
        syscall

        # Save address of allocated memory
        move $s1, $v0

        # Determine factors — for each number from 2 to $s0 / 2, if $s0 is evenly divisible by that number, store that number in
        # allocated memory
        li $t0, 2 # $t0 = loop iterator
        li $t1, 2
        div $s0, $t1
        mflo $t1 # $t1 = loop ending value ($s0 / 2)

    loop:
        # Print $t0
        li $v0, 1
        move $a0, $t0
        syscall

        addi $t0, $t0, 1
        ble $t0, $t1, loop

        # Exit
        li $v0, 10
        syscall