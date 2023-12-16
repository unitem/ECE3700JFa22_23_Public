    addi t0 x0 0x193
    nop
    nop
    add t1 t0 t0
    nop
    nop
    sub t2 x0 t1
    and t3 t0 t1
    addi t3 x0 2
    nop
    nop
    sll t1 t1 t3
    nop
    nop
    or t2 t2 t1
    nop
    nop
    andi t4 t2 0x732
    nop
    nop
    srli t4 t4 0x5
    nop
    nop
    srl t2 t2 t3
    nop
    nop
    slli t2 t2 0x10
    nop
    nop
    sra t2 t2 t3
    bne t0 t1 right_branch_1 # should branch
    nop
    nop
    add t2 x0 x0
right_branch_1:
    beq t2 x0 error1 # shouldn't branch
    nop
    nop
    bge t2 t4 error1 # shouldn't branch
    nop
    nop
    add t0 t2 x0
    nop
    nop
    blt t2 t4 right_branch_2 # should branch
    nop
    nop
error1:
    add t0 x0 x0
right_branch_2:
    bne t2 t0 error2 # shouldn't branch
    nop
    nop
    beq t2 t0 right_branch_3 # should branch
    nop
    nop
error2:
    add t1 x0 x0
right_branch_3:
    blt t1 t4 error3 #shouldn't branch
    nop
    nop
    bge t1 t3 right_branch_4 # should branch
    nop
    nop
error3:
    add t3 x0 x0
right_branch_4:
    add t4 x0 x0
    # now t0=t2=0xffcd8000, t1=0x00000c98, t3=0x00000002, t4=0x0
    jal x1 memory_test # ra=0x000000bc
    nop
    nop
    beq t0 t2 exit # should branch
    nop
    nop
memory_test:
    sw t0 0(sp)
    sb t1 4(sp)
    lw t4 0(sp)
    lb t4 4(sp)
    lbu t4 4(sp)
    jalr x0 x1 0
    nop
    nop
error5:
    add x1 x0 x0
exit:
    add t2 x0 x0
    # final results:
    # ra = 0x000000fc, t0 = 0xffcd8000, t1 = 0x00000c98, t2 = 0x00000000, t3 = 0x00000002, t4 = 0x00000098