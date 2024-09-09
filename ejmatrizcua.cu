#include <stdio.h>
#include <cuda.h>

__global__ void summ(float A[], float B[], float C[], int N){
	int i = threadIdx.x;
//	C[i] = A[i] + B [i];
	printf("%d ", i);
	printf("%.2f \n", A[i]);
}

int main() {
	int N = 3;
	float A[N];
	float B[N];
	float C[N];

	// Inicializar la matriz A
	for (int i = 0; i < N; i++) {
		A[i] = i; // Asignar valores a cada elemento
    	}
	
	// Inicializar la matriz B
	for (int i = 0; i < N; i++) {
		B[i] = i; // Asignar valores a cada elemento
    	}


    	// Imprimir la matriz A
    	for (int i = 0; i < N; i++) {
		printf("%.2f ", A[i]);
    	}
	printf("\n");

	summ<<<2,N>>>(A, B, C, N);
	cudaDeviceSynchronize();

    	// Imprimir la matriz C
    	for (int i = 0; i < N; i++) {
		printf("%.2f ", C[i]);
    	}
	printf("\n");


    	return 0;
}

