#include <stdio.h>
#include <stdlib.h>

void vector_producto(float *A, float *v1, float *v2, int matriz_m){
	for(int i = 0; i < matriz_m; i++){
		float sum = 0.0f;
		for(int j = 0; j < matriz_m; j++){
			sum += A[i * matriz_m +j] * v1[j];
		}
		v2[i] = sum;
	}
}

int main(){
	float *A, *v1, *v2;
	int matriz_m = 40000;

	A = (float *)malloc(matriz_m * matriz_m * sizeof(float));
	v1 = (float *)malloc(matriz_m * sizeof(float));
	v2 = (float *)malloc(matriz_m * sizeof(float));

	for(int i = 0; i < matriz_m; i++){
		for(int j = 0; j < matriz_m; j++){
			A[i * matriz_m + j] = (float) i * matriz_m + j;
			//printf("A[i] = %.2f\n", A[i * matriz_m + j]);
		}
	}

	for(int i = 0; i < matriz_m; i++){
		v1[i] = (float) i;
		//printf("v1[i] = %.2f\n", v1[i]);
	}
	vector_producto(A, v1, v2, matriz_m);

	for(int i = 0; i < matriz_m; i ++){
		printf("v2 = %.2f\n", v2[i]);
	}

	free(A);
	free(v1);
	free(v2);

	return 0;
}
