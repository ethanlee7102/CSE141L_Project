regs = {
    'R0' : '000',
    'R1' : '001',
    'R2' : '010',
    'R3' : '011',
    'R4' : '100',
    'R5' : '101',
    'R6' : '110',
    'R7' : '111'
}

#define opcodes and 
op_ADD = '000'      # ADD rA, rB ; rB = rA + rB
op_SL = '001'       # SL rA, rB ; rB = rA << 1
op_SR = '010'       # SR rA, rB ; rB = rA >> 1
op_NAND = '011'     # NAND rA, rB ; rB = ~(rA & rB)
op_SUB = '100'      # SUB rA, rB ; rB = rB - rA
op_LD = '101'       # LD rA, rB ; rB = Mem[rA]
op_ST = '110'       # ST rA, rB ; Mem[rB] = rA
op_BZ = '1110'      # BZ imm, rB ; if rB == 0, PC = PC + imm
op_ADDI = '1111'    # ADDI imm, rB ; rB = rB + imm
