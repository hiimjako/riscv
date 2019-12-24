.include "functions.s" 

#-----------constant-----------#
.global main
    .equ _SYS_WR, 64
    .equ _SYS_EX, 93

.section .rodata
    msgStart: .string "numero da cercare: %d, len di array %d\n"
    msgend: .string "Il numero trovato e' in posizione: a[%d]\n"
    msgerr: .string "Numero non presente nell' array\n"

#-----------global symbol-----------#
.section .data
    array: .byte 11, 15, 21, 23, 27, 31, 39, 40, 47, 50
    num: .byte 50
    len: .byte 10

#-----------code-----------#
#Codice assembly
.section .text
main:

    #Messaggio iniziale
    la a0, msgStart
    la t1, num
    lb a1, 0(t1)
    la t2, len
    lb a2, 0(t2)
    jal ra, printf 
	 
    #chiamo la funzione: sequential_search
    la a0, array #address array
    la t1, num
    lb a1, 0(t1) #numero da cercare
    la t2, len
    lb a2, 0(t2) #lunghezza array
    jal ra, sequential_search
    
    #fine funzione sequential_search, stampo risultato
    beq a1, zero, else
        mv a1, a0
        la a0, msgend
        jal ra, printf
    beq zero, zero, _end

else:
    la a0, msgerr
    jal ra, printf

_end:
    li a7, _SYS_EX
    ecall
