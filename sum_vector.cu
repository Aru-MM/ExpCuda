#include <stdio.h>
__global__ void vector_producto(float *A, float *B, float *C, int matriz_m){
	printf("BId = %d BDm = %d HId = %d\n", blockIdx.x, blockDim.x, threadIdx.x);
	int i = threadIdx.x;

	C[i] = A[i] + B[i];
}

int main(int argc, char **argv){
	float *A, *A_gpu;
	float *B, *B_gpu;
	float *C, *C_gpu;

	int matriz_m = 4;

	dim3 block_shape = dim3(3,3);
	dim3 grid_shape = dim3(max(1.0, ceil((float)matriz_m / (float) block_shape.x)),
			max(1.0, ceil((float)matriz_m / (float) block_shape.x)));
	
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

	cudaMalloc((void **) &A_gpu, matriz_m * sizeof(float));
	cudaMalloc((void **) &B_gpu, matriz_m * sizeof(float));
	cudaMalloc((void **) &C_gpu, matriz_m * sizeof(float));

	cudaMemcpy(A_gpu, A, matriz_m * sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(B_gpu, B, matriz_m * sizeof(float), cudaMemcpyHostToDevice);

	vector_producto<<<2, 4>>>(A_gpu, B_gpu, C_gpu, matriz_m);

	cudaMemcpy(C, C_gpu, matriz_m * sizeof(float), cudaMemcpyDeviceToHost);

	printf("C = ");
	for(int i = 0; i < matriz_m; i ++){
		printf("%.2f ", C[i]);
	}
	printf("\n");

	free(A);
	free(B);
	free(C);

	cudaFree(A_gpu);
	cudaFree(B_gpu);
	cudaFree(C_gpu);

	return 0;
}
