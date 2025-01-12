#include <stdio.h>
#include <omp.h>

int main() {
    #pragma omp parallel
    {
        int thread_id = omp_get_thread_num(); // Get thread ID
        if (thread_id == 0) { // Master thread
            printf("Number of threads: %d\n", omp_get_num_threads());
            printf("Max threads: %d\n", omp_get_max_threads());
            printf("Processors available: %d\n", omp_get_num_procs());
        }
        printf("Hello from thread %d\n", thread_id);
    }
    return 0;
}
