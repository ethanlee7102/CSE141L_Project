# Define the instruction sets
R_TYPE = {
    'ADD': '000',
    'SL': '001',
    'SR': '010',
    'NAND': '011',
    'SUB': '100'
}

I_TYPE = {
    'LD': '101',
    'ST': '110',
    'BZ': '1110',
    'ADDI': '1111'
}

# Define the register binary representations
REGISTERS = {
    'R0': '000',
    'R1': '001',
    'R2': '010',
    'R3': '011',
    'R4': '100',
    'R5': '101',
    'R6': '110',
    'R7': '111'
}

def parse_instruction(instruction):
    parts = instruction.split()
    opcode = parts[0]

    if opcode in R_TYPE:
        regA = REGISTERS[parts[1].rstrip(',')]
        regB = REGISTERS[parts[2]]
        binary_instruction = R_TYPE[opcode] + regA + regB
    elif opcode in I_TYPE:
        if opcode in ['BZ', 'ADDI']:
            immediate = format(int(parts[1].rstrip(',')), '02b') 
            regB = REGISTERS[parts[2]]
            binary_instruction = I_TYPE[opcode] + immediate + regB
        else:
            regA = REGISTERS[parts[1].rstrip(',')]
            regB = REGISTERS[parts[2]]
            binary_instruction = I_TYPE[opcode] + regA + regB
    else:
        raise ValueError(f"Unknown opcode: {opcode}")

    return binary_instruction

def assemble_file(input_file, output_file):
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        for line in infile:
            instruction = line.strip()
            if instruction:  # Ignore empty lines
                try:
                    binary_instruction = parse_instruction(instruction)
                    outfile.write(binary_instruction + '\n')
                except ValueError as e:
                    print(f"Error parsing instruction '{instruction}': {e}")

if __name__ == "__main__":
    input_file = 'assembly_instructions.txt'
    output_file = 'machine_code_copy.txt'
    assemble_file(input_file, output_file)
    print(f"Assembly completed. Machine code written to {output_file}.")


# ADD R1, R2  //  r2 = r1 + r2
# SL R3, R4   //  r4 = <<r3
# SR R5, R6   //  r6 = r5>>
# NAND R7, R0 //  r0 = nand(r7, r0)
# SUB R1, R2  //  r2 = r2 - r1
# LD R3, R4   //  r4 = datamem[r3]
# ST R5, R6   //  datamem[r5] = r6
# BZ 2, R1    //  if r1 =/= 0  jump to LUT[2]
# ADDI 3, R2  //  r2 = r2 + 3

# addi 3, r0
# addi 3, r0
# add r0, r0   r0=6
# add r0, r0   r0=12