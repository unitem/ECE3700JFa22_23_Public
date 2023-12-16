.data
str: .string "VE370lab1"
#stored as static data at 0x10000000

.text
    #get string addr
    lui x10, 0x10000
    
    #set destination addr
    lui x11, 0x10000
    addi x11, x11, 0x100
    
    #save the length
    addi x9, x9, 9
    
    #load string and write by loop
    add x8, x0, x0 #set the index
Loop:
    add x12, x8, x10 #get byte addr
    lb x5, 0(x12) #load this byte
    add x13, x8, x11 #get destination addr
    sb x5, 0(x13) #store this byte
    beq x8, x9, Exit #complete storage
    addi x8, x8, 1 #increase index
    beq x0, x0, Loop #back to the Loop label
    
Exit:
    add x8, x0, x0