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
    msgPreStart: .string "numero da cercare: %d, len di array %d\n"
    msgend: .string "Il numero trovato e' in posizione: %d\n"
    msgerr: .string "Numero non presente nell' array\n"

#-----------global symbol-----------#
.section .data
    array: .byte 11, 15, 21, 23, 27, 31, 39, 40, 47, 50
    num: .byte 22
    len: .byte 9

#-----------code-----------#
.section .text

#-----------#
#a0 = array
#a1 = numero da cercare
#a2 = len array
fun:
    li t1, 0 #i
    lb t2, 0(a0) #a[i]
l1:
    bge t1, a2, el1	
    beq t2, a1, el2
    addi t1, t1, 1
    add t3, a0, t1
    lb t2, 0(t3)
    beq zero, zero, l1
el1:
    li a0, -1
    jalr zero, ra 
el2:
    mv a0, t1
    jalr zero, ra

#Codice assembly
.section .text
main:

    la a0, msgPreStart
    la t1, num
    lb a1, 0(t1)
    la t2, len
    lb a2, 0(t2)
    jal ra, printf 
	
    #chiamo la funzione
    la a0, array
    la t1, num
    lb a1, 0(t1)
    la t2, len
    lb a2, 0(t2)
    jal ra, fun
    
    #fine funzione, stampo risultato
    li t1, -1
    beq a0, t1, else
    addi a1, a0, 0
    la a0, msgend
    jal ra, printf
else:
    la a0, msgerr
    jal ra, printf

_end:
    li a7, _SYS_EX
    ecall
