#include <stdio.h>

__global__ void vectorAdd(int *a, int *b, int *c, int n) {
    int idx = threadIdx.x; // Thread index
    if (idx < n) {
        c[idx] = a[idx] + b[idx];
    }
}

int main() {
    int n = 5;
    int a[] = {1, 2, 3, 4, 5}, b[] = {10, 20, 30, 40, 50}, c[5];

    int *d_a, *d_b, *d_c;
    cudaMalloc(&d_a, n * sizeof(int));
    cudaMalloc(&d_b, n * sizeof(int));
    cudaMalloc(&d_c, n * sizeof(int));

    cudaMemcpy(d_a, a, n * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, n * sizeof(int), cudaMemcpyHostToDevice);

    vectorAdd<<<1, n>>>(d_a, d_b, d_c, n); // Launch kernel with n threads

    cudaMemcpy(c, d_c, n * sizeof(int), cudaMemcpyDeviceToHost);

    printf("Result: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", c[i]);
    }
    printf("\n");

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}
