#include <stdio.h>

// Kernel function
__global__ void addNumbers(int a, int b, int *result) {
    *result = a + b;
}

int main() {
    int a = 5, b = 7, result;     // Host variables
    int *d_result;                // Device result

    cudaMalloc(&d_result, sizeof(int));                    // Allocate memory on GPU
    addNumbers<<<1, 1>>>(a, b, d_result);                  // Launch kernel
    cudaMemcpy(&result, d_result, sizeof(int), cudaMemcpyDeviceToHost); // Copy result back

    printf("Sum: %d\n", result);                           // Output result
    cudaFree(d_result);                                    // Free GPU memory
    return 0;
}
