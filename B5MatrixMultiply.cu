#include <stdio.h>

#define N 3 // Size of the matrices (N x N)

// Kernel function for matrix multiplication
__global__ void matrixMultiply(int *a, int *b, int *c, int n) {
    int row = threadIdx.y; // Row index of the thread
    int col = threadIdx.x; // Column index of the thread
    int sum = 0;

    if (row < n && col < n) {
        for (int k = 0; k < n; k++) {
            sum += a[row * n + k] * b[k * n + col];
        }
        c[row * n + col] = sum;
    }
}

int main() {
    int a[N][N] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
    int b[N][N] = {{9, 8, 7}, {6, 5, 4}, {3, 2, 1}};
    int c[N][N] = {0};

    int *d_a, *d_b, *d_c;
    int size = N * N * sizeof(int);

    cudaMalloc(&d_a, size);
    cudaMalloc(&d_b, size);
    cudaMalloc(&d_c, size);

    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

    dim3 threadsPerBlock(N, N); // Launch N x N threads
    matrixMultiply<<<1, threadsPerBlock>>>(d_a, d_b, d_c, N);

    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

    printf("Resultant Matrix:\n");
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            printf("%d ", c[i][j]);
        }
        printf("\n");
    }

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}
