FACT:
    addi sp sp -8
    sw x1 4(sp)
    sw x12 0(sp)
    addi x5 x0 2
    bge x12 x5 L1
    addi x10 x0 1
    addi sp sp 8
    jalr x0 x1(0) #jalr x0 0(x1)
L1:
    addi x12 x12 -1
    jal x1 FACT
    lw x12 0(sp)
    lw x1 4(sp)
    addi sp sp 8
    mul x10 x10 x12
    jalr x0 x1(0) #jalr x0 0(x1)