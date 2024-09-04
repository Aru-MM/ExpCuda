#include <stdio.h>
#include <cuda.h>

__global__ void printKernel(){
        printf("Hola CUDA\n");
	printf("ID Bloque X: %d, ID Bloque Y: %d, ID Hilo X: %d, ID Hilo Y: %d\n", blockIdx.x, blockIdx.y, threadIdx.x, threadIdx.y);
}       

int main(){
	// <<<Bloque,Hilo>>>
        printKernel<<<2,2>>>();
	cudaDeviceSynchronize();
	return 0;
}  
