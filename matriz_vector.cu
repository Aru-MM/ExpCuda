#include <stdio.h>
__global__ void vector_producto(float *A, float *v1, float *v2, int matriz_m){
	int fil = blockIdx.x * blockDim.x + threadIdx.x;
	int col = blockIdx.y * blockDim.y + threadIdx.y;

	if(col == 0 && fil < matriz_m){
		float sum = 0.0f;
		for(int i = 0; i < matriz_m; i++){
			sum += A[fil * matriz_m + i] * v1[i];
		}
		v2[fil] = sum;
	}
}

int main(int argc, char **argv){
	float *A, *A_gpu;
	float *v1, *v1_gpu;
	float *v2, *v2_gpu;

	int matriz_m = 40000;

	dim3 block_shape = dim3(32,32);
	dim3 grid_shape = dim3(max(1.0, ceil((float)matriz_m / (float) block_shape.x)),
			max(1.0, ceil((float)matriz_m / (float) block_shape.x)));
	
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

	cudaMalloc((void **) &A_gpu, matriz_m * matriz_m * sizeof(float));
	cudaMalloc((void **) &v1_gpu, matriz_m * sizeof(float));
	cudaMalloc((void **) &v2_gpu, matriz_m * sizeof(float));

	cudaMemcpy(A_gpu, A, matriz_m * matriz_m * sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(v1_gpu, v1, matriz_m * sizeof(float), cudaMemcpyHostToDevice);

	vector_producto<<<grid_shape, block_shape>>>(A_gpu, v1_gpu, v2_gpu, matriz_m);

	cudaMemcpy(v2, v2_gpu, matriz_m * sizeof(float), cudaMemcpyDeviceToHost);

	for(int i = 0; i < matriz_m; i ++){
		printf("v2 = %.2f\n", v2[i]);
	}

	free(A);
	free(v1);
	free(v2);

	cudaFree(A_gpu);
	cudaFree(v1_gpu);
	cudaFree(v2_gpu);

	return 0;
}
