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
| BZ        | 111      | 0(00)         | rB         |  
| ADDI       | 111      | 1(00)         | rB         |  


 **For BZ**  
(00) how high for lookup table)   
 **For ADDI** 
(00) is the immediate 
eg. 111 1(10) 001 = [r1 = r1 + 2]
