#include <stdio.h>
#include <stdint.h>
#include <limits.h>
#include <stdlib.h>

int main() {
    int16_t array[32] = { /* 32 half-word integers */ };
    int16_t min_diff = INT16_MAX;
    int16_t max_diff = INT16_MIN;

    for (int i = 0; i < 32; i++) {
        for (int j = i + 1; j < 32; j++) {
            int16_t diff = abs(array[i] - array[j]);
            if (diff < min_diff) {
                min_diff = diff;
            }
            if (diff > max_diff) {
                max_diff = diff;
            }
        }
    }

    printf("Minimum absolute difference: %d\n", min_diff);
    printf("Maximum absolute difference: %d\n", max_diff);

    // Store the results in memory locations 66-69
    uint8_t memory[70] = {0};
    memory[66] = (min_diff >> 8) & 0xFF;  // MSB of minimum difference
    memory[67] = min_diff & 0xFF;         // LSB of minimum difference
    memory[68] = (max_diff >> 8) & 0xFF;  // MSB of maximum difference
    memory[69] = max_diff & 0xFF;         // LSB of maximum difference

    return 0;
}