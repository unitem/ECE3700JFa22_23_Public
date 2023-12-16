    addi t1 x0 0x399
    sw t1 4(x0)
    lb t0 4(x0)             # t0 = 0xffff_ff99
    sw t0 0(x0)
    beq t1 x0 wrong_branch  # should not branch
    lw t3 0(x0)             # t3 = 0xffff_ff99
    bne t0 t3 wrong_branch  # should not branch
    add t2 t0 t3            # t2 = 0xffff_ff32
    and t1 t2 t3            # t1 = 0xffff_ff10
    andi t1 t2 0            # t1 = 0x0
    sub t0 t1 x0            # t0 = 0x0
    bge t0 t1 right_branch  # should branch
wrong_branch:
    add t2 x0 x0
right_branch:
    jal x1 jump_test
    jal x1 Exit
    add t3 x0 x0
jump_test:
    or t3 t3 t2
    jalr x0 x1 0
    addi t1 x0 0x48
Exit:
    addi t0 x0 0xac
# x1 = 3c, t0 = 0x0000_00ac, t2 = 0xffff_ff32, t3=0xffff_ffbb, all other registers 0