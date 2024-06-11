## Instruction Set R-Type
| R-Type        | 8:6         | 5:3         |2:0 | 
| ----------- | ----------- | ----------- | ----------- |
| ADD        | 000      | rA         | rB         |
| SL        | 001      | rA         | rB         |
| SR        | 010      | rA         | rB         |
| NAND       | 011      | rA         | rB         |
| SUB        | 100      | rA         | rB         |

## Instruction Set I-Type
| I-Type        | 8:6         | 5:3         |2:0 | 
| ----------- | ----------- | ----------- | ----------- |
| LD        | 101      | rA         | rB         |
| ST        | 110      | rA         | rB        |
| BZ        | 111      | 0(00)         | rA         |  
| ADDI       | 111      | 1(00)         | rB         |  


 **For BZ and BLT**  
(00) how high for lookup table)   
(make rA always be compared with data_mem[1] or smth)
