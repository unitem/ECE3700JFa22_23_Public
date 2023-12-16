        addi t0 x0 -10
        add t1 t0 t0
        sub t2 t0 t1
        and t3 t1 x0
        or t4 t1 t0
        sw t4 0(x0)
        sw t0 4(x0)
        beq t0 x0 L1
        add t4 t1 x0 # possible error
L1:     bne t1 t4 error1
        bne t1 t3 L2
error1: add t2 x0 x0
L2:     lw s0 0(x0)
        lw s1 4(x0)
        addi s1 s1 8
        beq s0 s1 L3
error2: add t2 x0 x0
L3:     add t2 t2 t2



