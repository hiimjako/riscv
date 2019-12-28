#a0 = array
#a1 = numero da cercare
#a2 = len array
#t1 = index

sequential_search:
    li t1, 0 #i
    lb t2, 0(a0) #a[i]

ls1:
    bge t1, a2, els_err	
        beq t2, a1, els2
            addi t1, t1, 1
            add t3, a0, t1
            lb t2, 0(t3)
    beq zero, zero, ls1

els_err:
    #valore non trovato 
    li a1, 0
    jalr zero, ra 

els2:
    mv a0, t1
    li a1, 1
    jalr zero, ra

#a0 = array
#a1 = numero da cercare
#a2 = low == 0
#a3 = high == len -1
#t1 = index
#t3 = a[mid]
binary_search:
    addi sp, sp, -8
    sd ra, 0(sp)   
    blt a3, a2, elb_err 
        add t2, a2, a3
        srli t1, t2, 1
        add t2, a0, t1 #addr aggiustato
        lb t3, 0(t2)  #a[mid]
    bgt t3, a1, else1
    blt t3, a1, else2  
    #svuota stack  
    mv a0, t1 #ritorno
    li a1, 1 #flag di buon fine
    ld ra, 0(sp)
    addi sp, sp, 8
    jalr zero, ra #sono arrivato alla fine ed ho trovato il valore

else1:
    #a0 e` gia giusto
    #a1 e` sempre quello
    #a2 e` lo stesso
    #a3 diventa mid -1
    addi a3, t1, -1
    jal ra, binary_search
    #return mid -1
    beq zero, zero, ret
else2:
    #a0 e` gia giusto
    #a1 e` sempre quello
    #a2 diventa mid +1
    #a3 rimane high
    addi a2, t1, 1
    jal ra, binary_search
    #return mid+1

ret: 
    ld ra, 0(sp)
    addi sp, sp, 8
    jalr zero, ra

elb_err: 
    #valore non trovato 
    # la a0, msgend
    # mv a1, a2
    # jal ra, printf
    li a1, 0
    jalr zero, ra 



# la a0, msgend
# mv a1, a3
# jal ra, printf


