#include <stdio.h>

__global__ void vector_producto(float *A, float *B, float *C, int matriz_m){
//	printf("BId = %d BDm = %d HId = %d \n", blockIdx.x, blockDim.x, threadIdx.x);
	printf("BId = %d BDm = %d HId = %d \n", blockIdx.y, blockDim.y, threadIdx.y);
	int i = blockDim.x * blockIdx.x + threadIdx.x;
//	printf("i = %d\n", i);

	if(i < matriz_m){
		C[i] = A[i] + B[i];
		printf("C = %.2f\n", C[i]);
	}
}

int main(int argc, char **argv){
	
	//Numero de elementos y su tamaño
	int matriz_m = 4;

	// Variables de locales
	float *A = (float *)malloc(matriz_m * sizeof(float));
	float *B = (float *)malloc(matriz_m * sizeof(float));
	float *C = (float *)malloc(matriz_m * sizeof(float));

	//Inicializa vectores locales
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

	//Variables GPU
	float *A_gpu;
	float *B_gpu;
	float *C_gpu;

	cudaMalloc((void **) &A_gpu, matriz_m * sizeof(float));
	cudaMalloc((void **) &B_gpu, matriz_m * sizeof(float));
	cudaMalloc((void **) &C_gpu, matriz_m * sizeof(float));

	//Copia las variables locales a la gpu
	cudaMemcpy(A_gpu, A, matriz_m * sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(B_gpu, B, matriz_m * sizeof(float), cudaMemcpyHostToDevice);

	//Lanzar el kernel de suma
	dim3 block_shape = dim3(32,32);
	dim3 grid_shape = dim3(max(1.0, ceil((float)matriz_m / (float) block_shape.x)),
			max(1.0, ceil((float)matriz_m / (float) block_shape.x)));
	
	int hilosporbloque = 4;
	int bloquespormalla = (matriz_m + hilosporbloque - 1) / hilosporbloque;
	
	printf("BS = %d, %d, %d GS = %d, %d, %d\n", block_shape.x, block_shape.y, block_shape.z, grid_shape.x, grid_shape.y, grid_shape.z);
	printf("HB = %d BC = %d\n", hilosporbloque, bloquespormalla);

	cudaMemcpy(A_gpu, A, matriz_m * sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(B_gpu, B, matriz_m * sizeof(float), cudaMemcpyHostToDevice);
	//vector_producto<<<grid_shape, block_shape>>>(A_gpu, B_gpu, C_gpu, matriz_m);
	vector_producto<<<bloquespormalla, hilosporbloque>>>(A_gpu, B_gpu, C_gpu, matriz_m);

	//Copia las variables de la GPU a local
	cudaMemcpy(C, C_gpu, matriz_m * sizeof(float), cudaMemcpyDeviceToHost);

	printf("C = ");
	for(int i = 0; i < matriz_m; i ++){
		printf("%.2f ", C[i]);
	}
	printf("\n");

	//Libera la memoria local
	free(A);
	free(B);
	free(C);

	//Libera la memoria GPU
	cudaFree(A_gpu);
	cudaFree(B_gpu);
	cudaFree(C_gpu);

	return 0;
}
