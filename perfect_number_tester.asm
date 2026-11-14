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

        # Determine factors of integer

        # Exit
        li $v0, 10
        syscall