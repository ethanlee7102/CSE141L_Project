#include <stdio.h>
#include <stdint.h>

// Function to perform double-precision multiplication using shift-and-add
int32_t multiply(int16_t a, int16_t b) {
    int32_t product = 0;
    int16_t multiplier = b;
    int shift_count = 0;

    while (multiplier != 0) {
        if (multiplier & 1) {
            product += (int32_t)a << shift_count;
        }
        shift_count++;
        multiplier >>= 1;
    }
    
    return product;
}

int main() {
    int16_t a[16] = { /* MSB of operand A */ };
    int16_t b[16] = { /* LSB of operand A */ };
    int16_t c[16] = { /* MSB of operand B */ };
    int16_t d[16] = { /* LSB of operand B */ };

    uint8_t memory[128] = {0};

    for (int i = 0; i < 16; i++) {
        int16_t operandA = (a[i] << 8) | b[i];
        int16_t operandB = (c[i] << 8) | d[i];
        int32_t product = multiply(operandA, operandB);

        printf("Product of %d and %d: %d\n", operandA, operandB, product);

        // Storing the result in memory locations 64-127
        memory[64 + 4*i + 0] = (product >> 24) & 0xFF; // MSB
        memory[64 + 4*i + 1] = (product >> 16) & 0xFF;
        memory[64 + 4*i + 2] = (product >> 8) & 0xFF;
        memory[64 + 4*i + 3] = product & 0xFF; // LSB
    }

    return 0;
}