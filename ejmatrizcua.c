#include <stdio.h>

void summ(float A[], float B[], float C[], int N){
	for (int i = 0; i < N; i++){
		C[i] = A[i] + B [i];
	}
}

int main() {
	int N = 40;
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

	summ(A, B, C, N);

    	// Imprimir la matriz C
    	for (int i = 0; i < N; i++) {
		printf("%.2f ", C[i]);
    	}
	printf("\n");


    	return 0;
}

