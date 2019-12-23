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
    msgStart: .string "Il numero da trovare e`: %d\n" 
	msg: .string "%d\n"

#-----------global symbol-----------#
.section .data
    array: .double 10, 15, 21, 23, 27, 31, 39, 40, 47, 50
    num: .byte 27
    len: .byte 10

#-----------code-----------#
.section .text

#-----------#
#a0 = v
#a1 = n
l1:


#Codice assembly
.section .text
main:
	la a0, msgStart
    li a1, 30
    jal ra, printf

  	
_end:
    li a7, _SYS_EX
    ecall
