.data
testArray: .word -55, -98, 67, 51, -76, 81, 0, 29, 64, 12, -66, -7, -37, 57, 1, -93, 8, 33, -38, -71
#1,20,3,-4,0,-1,2,4,1,0,1,-2,3,5,1,0,-1,-2,-100,23
size: .word 20
    
.text
    main:
        #save addr of testArray at x9, size at x18
        lui x9 0x10000
        lw x18 size
        #3 modes
        addi x25 x0 1
        addi x26 x0 -1
        addi x27 x0 0
        #boolean results
        addi x23 x0 1 #true
        #positive count
        add x10 x9 x0
        add x11 x18 x0
        add x12 x0 x25
        jal x1 countArray
        add x19 x10 x0 #store PosCnt at x19
        #negtive count
        add x10 x9 x0
        add x11 x18 x0
        add x12 x0 x26
        jal x1 countArray
        add x20 x10 x0 #store NegCnt at x20
        #zero count
        add x10 x9 x0
        add x11 x18 x0
        add x12 x0 x27
        jal x1 countArray
        add x21 x10 x0 #store ZeroCnt at x21
        #sum
        add x10 x9 x0
        add x11 x18 x0
        jal x1 sumArray
        add x22 x10 x0 #store SumCnt at x22
        beq x0 x0 Exit
    
    countArray:
        #cnt at x5, i at x6
        addi sp sp -24
        sw x1 20(sp) #save return addr
        sw x10 16(sp) #save addr of A[]
        sw x12 12(sp) #save cntType
        addi x5 x0 0 #cnt=0
        addi x6 x0 0 #i=0
    Loop:
        slli x7 x6 2
        lw x10 16(sp)
        add x7 x7 x10 
        lw x7 0(x7) #x7 save A[i]
        bge x6 x11 End
        sw x5 4(sp)
        sw x6 0(sp)
        
        bne x12 x25 Else1
        #call isPos
        sw x7 8(sp)
        addi x10 x7 0 #pass arguments
        jal x1 isPos
        lw x7 8(sp) #get A[i] back, still need to use
        addi x8 x10 0 #x8 save the function result
        beq x8 x23 addCnt
    Else1:
        lw x12 12(sp)
        bne x12 x26 Else2
        #call isNeg
        sw x7 8(sp)
        addi x10 x7 0 #pass arguments
        jal x1 isNeg
        lw x7 8(sp) #get A[i] back, still need to use
        addi x8 x10 0 #x8 save the function result
        beq x8 x23 addCnt
    Else2:
        lw x12 12(sp)
        bne x12 x27 add_i
        #call isZero
        addi x10 x7 0 #pass arguments
        jal x1 isZero
        addi x8 x10 0 #x8 save the function result
        beq x8 x23 addCnt
        beq x0 x0 add_i
    addCnt:
        lw x5 4(sp)
        addi x5 x5 1
    add_i:
        lw x6 0(sp)
        addi x6 x6 1
        beq x0 x0 Loop
    End:
        addi x10 x5 0 #return cnt
        lw x1 20(sp)
        addi sp sp 24
        jalr x0 x1(0)
        
    isPos:
        blt x10 x0 PosFalse
        beq x10 x0 PosFalse
        add x10 x0 x23 
        jalr x0 x1(0)
    PosFalse:
        add x10 x0 x0
        jalr x0 x1(0)
    
    isNeg:
        blt x10 x0 NegTrue
        bge x10 x0 NegFalse
    NegTrue:
        add x10 x0 x23
        jalr x0 x1(0)
    NegFalse:
        add x10 x0 x0
        jalr x0 x1(0)
        
    isZero:
        bne x10 x0 ZeroFalse
        add x10 x0 x23
        jalr x0 x1(0)
    ZeroFalse:
        add x10 x0 x0
        jalr x0 x1(0)
        
    sumArray:
        addi x5 x0 0 #sum in x5
        addi x6 x0 0 #i in x6
    sumLoop:
        bge x6 x11 endLoop
        slli x7 x6 2
        add x7 x7 x10
        lw x7 0(x7)
        add x5 x5 x7
        addi x6 x6 1
        beq x0 x0 sumLoop
    endLoop:
        addi x10 x5 0
        jalr x0 x1(0)

Exit:
    add x0 x0 x0