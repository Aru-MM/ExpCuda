#include <stdio.h>
#include <stdlib.h>

void vector_producto(float *A, float *B, float *C, int matriz_m){
	for(int i = 0; i < matriz_m; i++){
		C[i] = A[i] + B[i];
	}
}

int main(int argc, char **argv){
	float *A;
	float *B;
	float *C;

	int matriz_m = 4;
	
	A = (float *)malloc(matriz_m * sizeof(float));
	B = (float *)malloc(matriz_m * sizeof(float));
	C = (float *)malloc(matriz_m * sizeof(float));

	printf("A = ");
	for(int i = 0; i < matriz_m; i++){
		A[i] = (float) i;
		printf("%.2f ", A[i]);
	}
	printf("\n");

	printf("B = ");
	for(int i = 0; i < matriz_m; i++){
		B[i] = (float) i;
		printf("%.2f ", B[i]);
	}
	printf("\n");

	vector_producto(A, B, C, matriz_m);

	printf("C = ");
	for(int i = 0; i < matriz_m; i ++){
		printf("%.2f ", C[i]);
	}
	printf("\n");

	free(A);
	free(B);
	free(C);

	return 0;
}
