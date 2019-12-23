#-------------------COMMAND ON TERMINAL WINDOW----------------#
# cd Scrivania, cd Esercizi, ..
# ./compile.sh fileName
# qemu-riscv64 fileName
# qemu-riscv64 -g 2223 fileName

# riscv64-unknown-elf-gdb fileName
# target remote localhost:2223
# step/s
# continue
# x/10x &varAddress

#-----------NUMBER AND MNEMONIC NAME REGISTER RISCV-----------#
# x0 -x4  #  zero, ra, sp, gp, tp
# x5 -x7  #  t0, t1, t2
# x8 -x9  #  fp/s0, s1
# x10-x17 #  a0, a1, a2, a3, a4, a5, a6, a7
# x18-x27 #  s2, s3, s4, s5, s6, s7, s8, s9, s10, s11
# x28-x31 #  t3, t4, t5, t6

#-----------constant-----------#
.global main
    .equ _SYS_WR, 64
    .equ _SYS_EX, 93

.section .rodata
	msg: .string "%d\n"

#-----------global symbol-----------#
.section .data
    vct0: .double 5, 2, 1, 6, 2
    scpd: .byte 48, '\n'
    num: .byte 0
    c: .space 1 #quanti byte vogliamo riservare

#-----------code-----------#
.section .text

#-----------#
#a0 = v
#a1 = n
sort:
    addi sp, sp, -8
    sd ra, 0(sp)
    li t0, 5
    li a1, 4
    addi t3, a1, -1
forSort1:
    beq t0, a1, exas
    addi t1, t0, 1
    addi a0, a0, 1
    ld t4, 0(a0)
forSort2:    
    beq t1, t3, ex2
    ld t5, 8(a0)
    bge t4, t5, go
    addi t6, t4, 0
    addi t4, t5, 0
    addi t5, t6, 0  
go:
    addi t1, t1, 1
    j forSort2
ex2:
    addi t0, t0, 1
    j forSort1
exas:
    ld ra, 0(sp)
    addi sp, sp, 8
    jalr zero, ra

#Codice assembly
.section .text
main:
	la a0, num
    li a1, 4
    jal ra, sort

    li t0, 0
    la a0, num
    li a1, 4
# for:
#     # slli app, index, shift
#     # user code
#     la a0, msg
# 	addi a1, a1, 1
# 	jal  ra, printf
    
#     bge t0, a1, exitFor
#         addi t0, t0, 1
#         jal zero, for
# exitFor:
	li a7, 93
	ecall
	
_end:
li a7, _SYS_EX
ecall
