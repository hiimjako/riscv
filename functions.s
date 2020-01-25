#function to find the index of a number in array sequentially
#-----inputs:
#a0 = array address,
#a1 = numbert to find,
#a2 = array len;
#-----outputs:
#a0 = index of the number
#-----used registers:
#t1 = index to scroll the array
#t2 = the value in a[t1]
#-----used labels:
#ls1 = loop to scroll array
#els_err = return if the number isn't in array
#sFound = return the index of the value
sequential_search:
    li t1, 0 
    lb t2, 0(a0) 
ls1:
    bge t1, a2, els_err	
        beq t2, a1, sFound
            addi t1, t1, 1
            add t2, a0, t1
            lb t2, 0(t2)
    beq zero, zero, ls1
els_err:
    li a0, -1
    jalr zero, ra 
sFound:
    mv a0, t1
    jalr zero, ra


#function to find the index of a number in array binary:
#a0 = array address,
#a1 = numbert to find,
#a2 = low 
#a3 = high 
#-----outputs:
#a0 = index of the number
#-----used registers:
#t1 = index to scroll the array
#t2 = the value in a[t1]
#-----used labels:
#elseLow = recall the function recursively if the value to find is lower than the a[i]
#elseGrt = recall the function recursively if the value to find is higher than the a[i]
#elb_err = return if the number isn't in array
binary_search:
    addi sp, sp, -8
    sd ra, 0(sp)   
    blt a3, a2, elb_err 
        add t2, a2, a3
        srli t1, t2, 1
        add t2, a0, t1 
        lb t3, 0(t2)  
        bgt t3, a1, elseLow
        blt t3, a1, elseGrt    
        mv a0, t1 
        ld ra, 0(sp)
        addi sp, sp, 8
        jalr zero, ra 
elseLow:
    addi a3, t1, -1
    jal ra, binary_search
    ld ra, 0(sp)
    addi sp, sp, 8
    jalr zero, ra
elseGrt:
    addi a2, t1, 1
    jal ra, binary_search
    ld ra, 0(sp)
    addi sp, sp, 8
    jalr zero, ra
elb_err:
    li a0, -1
    ld ra, 0(sp)
    addi sp, sp, 8
    jalr zero, ra 
    


