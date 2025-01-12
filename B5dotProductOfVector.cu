#include <stdio.h>

#define N 5 // Size of the vectors

__global__ void dotProduct(int *a, int *b, int *result, int n) {
    int idx = threadIdx.x;
    int sum = 0;
    if (idx < n) {
        sum = a[idx] * b[idx];
    }
    atomicAdd(result, sum); // Add the result atomically
}

int main() {
    int a[N] = {1, 2, 3, 4, 5};
    int b[N] = {5, 4, 3, 2, 1};
    int result = 0;

    int *d_a, *d_b, *d_result;
    cudaMalloc(&d_a, N * sizeof(int));
    cudaMalloc(&d_b, N * sizeof(int));
    cudaMalloc(&d_result, sizeof(int));

    cudaMemcpy(d_a, a, N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_result, &result, sizeof(int), cudaMemcpyHostToDevice);

    dotProduct<<<1, N>>>(d_a, d_b, d_result, N);

    cudaMemcpy(&result, d_result, sizeof(int), cudaMemcpyDeviceToHost);

    printf("Dot Product: %d\n", result);

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_result);

    return 0;
}
