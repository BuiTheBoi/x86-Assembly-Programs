;=====================================================================================================================================
;Program Name: Circumference of Circle
;Programming Language: x86 Assembly
;Program Description: This program asks the user to input an integer, representing
;the radius. It then uses basic arithmetic to calculate the circumference of a circle
;using the following formula: circumference = 2 * radius * pi, where pi is 22/7.


;Author: Justin Bui
;Email: Justin_Bui12@csu.fullerton.edu
;Institution: California State University, Fullerton
;Course: CPSC 240-05

;Copyright (C) 2020 Justin Bui
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
;version 3 as published by the Free Software Foundation.
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
;Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.
;======================================================================================================================================

	extern printf				;Getting external printf from driver program
	extern scanf			 	;Getting external scanf from driver program
	global start

section .data
	;Defining all my variables
	authormessage db "This circle function is brought to you by Justin.", 10, 0
	instruction db "Please enter the radius of a circle in whole number of meters: ", 0
	numoutputformat db "The number %ld was received.", 10, 0
	invalidinput db "ERROR: Integer must be a positive value. Please try again", 10, 0
	quotientoutputformat db "The circumference of a circle with this radius is %ld.", 0
	remainderoutputformat db " and %ld/7 meters.", 10, 0
	endprogram db "The integer part of the area will be returned to the main program. Please enjoy your circles.", 10, 0
	stringoutputformat db "%s", 0
	signedintinputformat db "%ld", 0

section .bss
	var1: resq 1				;Reserving 1 quadword for user input

section .text
start:						;Assembly module
	push rbp				;Alligning stack to 16 bits

	;printing intro onto screen
	mov rdi, stringoutputformat
	mov rsi, authormessage
	mov rax, 0
	call printf

promptUser:

	;Prompting user for input
	mov rsi, instruction
	mov rdi, stringoutputformat
	mov rax, 0
	call printf

takeInput:

	;Taking radius by calling scanf
	mov rdi, signedintinputformat
	mov rsi, var1
	mov rax, 0
	call scanf

	;Printing user input
	mov rdi, numoutputformat		;"The number %ld was received"
	mov rsi, [var1]					;var1 is address. [var1] is value of address
	mov rax, 0
	call printf

	;Checking if user input is positive or negative
	mov r14, [var1]				;Moving user input into r14
	cmp r14, 0					;Comparing r14 to 0
	jle error					;Jump to error block if negative value
	jg calculate				;Jump to calculate block if positive value


error:
	mov rdi, stringoutputformat
	mov rsi, invalidinput
	mov rax, 0
	call printf

	jmp promptUser				;Looping back to taking input until
								;positive integer is entered


calculate:						;Performing arithmetic to find circumference
	;Multiply user input by 2
	mov r9, 2					;Assigning 2 to r9
	mov rax, [var1]				;Assigning user var1 into rax
	mul r9						;rax = rax * r9
	mov r12, rax				;Updating rax as product

	;Multiply above product by 22
	mov r10, 22					;Assigning r10 register as 22
	mov rax, r12				;Updating rax register, in case if overridden
	mul r10						;rax = rax * r10
	mov r12, rax				;Updating rax after multiplying by 22

	;Divide entire product by 7
	mov rdx, 0					;Assigning rdx (remainder) as 0 so far
	mov rax, r12				;Again updating rax in case if overriden
	mov r11, 7					;Assigning r11 as denominator
	div r11						;rax = rax / r11
	mov r12, rax				;Assigning r12 as quotient 
	mov r13, rdx				;Assigning r13 as remainder

printCircumference:
	;Printing quotient
	mov rdi, quotientoutputformat
	mov rsi, r12
	mov rax, 0
	call printf

	;Printing remainder
	mov rdi, remainderoutputformat
	mov rsi, r13				;Assigning rsi as remainder
	mov rdx, r13				;Assigning rdx as remainder
	mov rax, 0
	call printf

endProgram:
	;Calling end to your program
	mov rdi, stringoutputformat
	mov rsi, endprogram
	mov rax, 0
	call printf

	pop rbp					;Restoring stack

	mov rax, r12			;Assigning quotient to overrriden rax
	ret						;Program returns rax containing quotient




