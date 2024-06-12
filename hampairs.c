#include <stdio.h>
#include <stdint.h>
#include <limits.h>

// Function to calculate the Hamming distance between two 16-bit integers
int hamming_distance(int16_t a, int16_t b) {
    int16_t x = a ^ b;
    int distance = 0;
    while (x) {
        distance += x & 1;
        x >>= 1;
    }
    return distance;
}

int main() {
    int16_t array[32] = { /* 32 half-word integers */ };
    int min_distance = INT_MAX;
    int max_distance = 0;

    for (int i = 0; i < 32; i++) {
        for (int j = i + 1; j < 32; j++) {
            int distance = hamming_distance(array[i], array[j]);
            if (distance < min_distance) {
                min_distance = distance;
            }
            if (distance > max_distance) {
                max_distance = distance;
            }
        }
    }

    printf("Minimum Hamming distance: %d\n", min_distance);
    printf("Maximum Hamming distance: %d\n", max_distance);

    // Store the results in memory locations 64 and 65
    uint8_t memory[70] = {0};
    memory[64] = min_distance;
    memory[65] = max_distance;

    return 0;
}