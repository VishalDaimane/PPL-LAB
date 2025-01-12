#include <stdio.h>

__global__ void printMessage(int n) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n) {
        printf("Welcome to Parallel Programming\n");
    }
}

int main() {
    int N, threadsPerBlock, blocksPerGrid;

    // Get user input for N (number of prints), threads per block, and blocks per grid
    printf("Enter the number of times to print the message: ");
    scanf("%d", &N);
    printf("Enter the number of threads per block: ");
    scanf("%d", &threadsPerBlock);
    printf("Enter the number of blocks per grid: ");
    scanf("%d", &blocksPerGrid);

    // Launch the kernel
    printMessage<<<blocksPerGrid, threadsPerBlock>>>(N);

    // Wait for GPU to finish before accessing on host
    cudaDeviceSynchronize();

    return 0;
}
