#include <stdio.h>
#include <omp.h>

#define N 3 // Size of the matrices

int main() {
    int A[N][N], B[N][N], C[N][N];
    int i, j, k;

    // Initialize matrices A and B
    printf("Matrix A:\n");
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            A[i][j] = i + j + 1; // Example initialization
            printf("%d ", A[i][j]);
        }
        printf("\n");
    }

    printf("\nMatrix B:\n");
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            B[i][j] = (i + 1) * (j + 1); // Example initialization
            printf("%d ", B[i][j]);
        }
        printf("\n");
    }

    // Initialize matrix C to 0
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            C[i][j] = 0;
        }
    }

    // Parallel matrix multiplication
    #pragma omp parallel for private(i, j, k) shared(A, B, C)
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            for (k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    // Print the result matrix C
    printf("\nResultant Matrix C (A x B):\n");
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            printf("%d ", C[i][j]);
        }
        printf("\n");
    }

    return 0;
}
