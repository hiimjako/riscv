.include "functions.s" 

#-----------constant-----------#
.global main
    .equ _SYS_WR, 64
    .equ _SYS_EX, 93

.section .rodata
    msgStart: .string "Number to find: %d, the array length is %d\n"
    msgEnd: .string "The index of the number is: a[%d]\n"
    msgErr: .string "The number isn't in the array\n"

#-----------global symbol-----------#
.section .data
    array: .byte 11, 15, 21, 23, 27, 31, 39, 40, 47, 50, 51, 52, 63
    num: .byte 12
    len: .byte 13

#-----------code-----------#
.section .text

main:
    #startin message
    la a0, msgStart
    la a1, num
    lb a1, 0(a1)
    la a2, len
    lb a2, 0(a2)
    jal ra, printf 
	 
    #call sequential_search
    la a0, array #array address
    la a1, num
    lb a1, 0(a1) #number to find
    la a2, len
    lb a2, 0(a2) #array length
    jal ra, sequential_search
    
    #return sequential_search
    blt a0, zero, else
        mv a1, a0
        la a0, msgEnd
        jal ra, printf
    beq zero, zero, _end
else:
    la a0, msgErr
    jal ra, printf
_end:
    li a7, _SYS_EX
    ecall
