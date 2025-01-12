#include <stdio.h>

__global__ void matrixAdd(int *a, int *b, int *c, int size) {
    int idx = threadIdx.x + blockIdx.x * blockDim.x; // Calculate global thread index
    if (idx < size) c[idx] = a[idx] + b[idx];
}

int main() {
    int rows = 2, cols = 3, size = rows * cols;
    int a[] = {1, 2, 3, 4, 5, 6}, b[] = {10, 20, 30, 40, 50, 60}, c[size];

    int *d_a, *d_b, *d_c;
    cudaMalloc(&d_a, size * sizeof(int));
    cudaMalloc(&d_b, size * sizeof(int));
    cudaMalloc(&d_c, size * sizeof(int));

    cudaMemcpy(d_a, a, size * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size * sizeof(int), cudaMemcpyHostToDevice);

    matrixAdd<<<1, size>>>(d_a, d_b, d_c, size); // Single block, one thread per element

    cudaMemcpy(c, d_c, size * sizeof(int), cudaMemcpyDeviceToHost);

    for (int i = 0; i < size; i++) printf("%d ", c[i]);
    printf("\n");

    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);
    return 0;
}
