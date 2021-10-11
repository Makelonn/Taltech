#include "neural_networks.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double single_in_single_out_nn(double  input, double weight) {
	return input*weight;
}

double weighted_sum(double * input, double * weight, uint32_t INPUT_LEN) {
	double output = 0;
	int i = 0;
	for(i=0; i<	INPUT_LEN; i++){
		output += (*(input+i))*(*(weight+i));
	}
 	return output;
}


double multiple_inputs_single_output_nn(double * input, double *weight, uint32_t INPUT_LEN) {
	double predicted_value = 0;
	predicted_value=weighted_sum(input, weight, INPUT_LEN);
	return predicted_value;
}


void elementwise_multiple( double input_scalar, double *weight_vector, double *output_vector, double VECTOR_LEN) {
	int i=0;
	for(i=0; i<VECTOR_LEN; i++){
		*(output_vector+i) = single_in_single_out_nn(input_scalar,(*(weight_vector+i)));
	}
}


void single_input_multiple_output_nn(double input_scalar, double *weight_vector, double *output_vector, double VECTOR_LEN){
  elementwise_multiple(input_scalar, weight_vector,output_vector,VECTOR_LEN);
}


void matrix_vector_multiplication(double * input_vector, uint32_t INPUT_LEN, double * output_vector,
		uint32_t OUTPUT_LEN, double weights_matrix[OUTPUT_LEN][INPUT_LEN]) {
			int i,j;
	for(i=0; i<OUTPUT_LEN; i++){
	//For each output calculate the weighted some of all input
		*(output_vector+i) = 0;
	for(j=0; j<INPUT_LEN; j++){
			*(output_vector+i) += *(input_vector+j)*weights_matrix[i][j];
		}
	}
}

void linear_forward_nn(double *input_vector, uint32_t INPUT_LEN,
						double *output_vector, uint32_t OUTPUT_LEN,
						double weights_matrix[OUTPUT_LEN][INPUT_LEN], double *weights_b) {

	matrix_vector_multiplication(input_vector,INPUT_LEN, output_vector,OUTPUT_LEN,weights_matrix);
	
	for(int k=0;k<OUTPUT_LEN;k++){
		output_vector[k]+=weights_b[k];
	}
}


double relu(double x){
	if(x>=0) return x;
	else return 0;
}


void vector_relu(double *input_vector, double *output_vector, uint32_t LEN) {
	  for(int i =0;i<LEN;i++){
		  output_vector[i] =  relu(input_vector[i]);
		}
}


double sigmoid(double x) {
	double result =  1 / (1+exp(-x));
	return result;
}


void vector_sigmoid(double * input_vector, double * output_vector, uint32_t LEN) {
	for (int i = 0; i < LEN; i++) {
		output_vector[i] = sigmoid(input_vector[i]);
	}
}


double compute_cost(uint32_t m, double yhat[m][1], double y[m][1]) {
	double cost = 0;
	for(int i=0; i<m; i++)
    {
    	cost += y[i][0] * log(yhat[i][0]) + ( (1 - y[i][0]) * log(1 - yhat[i][0]) );
    }
    cost = -cost/m;
	return cost;
}


void normalize_data_2d(uint32_t ROW, uint32_t COL, double input_matrix[ROW][COL], double output_matrix[ROW][COL]){
	double max =  -99999999;
	for(int i =0;i<ROW;i++){
	  for(int j =0;j<COL;j++){
		  if(input_matrix[i][j] >max){
			  max = input_matrix[i][j];
			}
		}
	}

	for(int i=0;i<ROW;i++){
		for(int j=0;j<COL;j++){
	    output_matrix[i][j] =  input_matrix[i][j]/max;
		}
	}
}


// Use this function to print matrix values for debugging
void matrix_print(uint32_t ROW, uint32_t COL, double A[ROW][COL]) {
	for(int i=0; i<ROW; i++){
			for(int j=0; j<COL; j++){
				printf(" %f ", A[i][j]);
			}
			printf("\n");
	}
	printf("\n\r");
}


void weights_random_initialization(uint32_t HIDDEN_LEN, uint32_t INPUT_LEN, double weight_matrix[HIDDEN_LEN][INPUT_LEN]) {
	double d_rand;

	/*Seed random number generator*/
	srand(1);

	for (int i = 0; i < HIDDEN_LEN; i++) {
		for (int j = 0; j < INPUT_LEN; j++) {
			/*Generate random numbers between 0 and 1*/
			d_rand = (rand() % 10);
			d_rand /= 10;
			weight_matrix[i][j] = d_rand;
		}
	}
}


void weightsB_zero_initialization(double * weightsB, uint32_t LEN){
	memset(weightsB, 0, LEN*sizeof(weightsB[0]));
}


void relu_backward(uint32_t m, uint32_t LAYER_LEN, double dA[m][LAYER_LEN], double Z[m][LAYER_LEN], double dZ[m][LAYER_LEN]) {
	int i, j;
	for(i = 0; i < m ; i++)
	{
		for(j = 0; j < LAYER_LEN; j++)
		{
			if(Z[i][j] > 0) dZ[i][j] = dA[i][j];
			else dZ[i][j] = 0;
		}
	}
}

void linear_backward(uint32_t LAYER_LEN, uint32_t PREV_LAYER_LEN, uint32_t m, double dZ[m][LAYER_LEN],
		double A_prev[m][PREV_LAYER_LEN], double dW[LAYER_LEN][PREV_LAYER_LEN], double * db ){
	int i, j;
	//Transpose dZ
	double t_dZ[LAYER_LEN][m];
	matrix_transpose(LAYER_LEN, m, dZ, t_dZ);

	//Bias 
	double dz_sum[LAYER_LEN];

	matrix_matrix_multiplication(LAYER_LEN, m, PREV_LAYER_LEN, t_dZ, A_prev, dW);

	double m_inverse = (double)1/m;
	for(i = 0; i < LAYER_LEN; i++)
	{
		for(j = 0; j < PREV_LAYER_LEN; j++)
		{
			dW[i][j] = (double)(m_inverse*dW[i][j]);
		}
	}

	//matrix_print(LAYER_LEN, )
	for(i = 0; i < LAYER_LEN; i++)
	{
		//bias
		dz_sum[i] = 0; //init sum i
		for(j = 0; j < m; j++)
		{
			dz_sum[i] += dZ[j][i];
		}
	}
	
	for(i = 0; i < LAYER_LEN; i++)
	{
		db[i] = (double)(m_inverse * dz_sum[i]);
	}
}


void matrix_matrix_multiplication(uint32_t MATRIX1_ROW, uint32_t MATRIX1_COL, uint32_t MATRIX2_COL,
									double input_matrix1[MATRIX1_ROW][MATRIX1_COL],
									double input_matrix2[MATRIX1_COL][MATRIX2_COL],
									double output_matrix[MATRIX1_ROW][MATRIX2_COL]) {

	for(int k=0;k<MATRIX1_ROW;k++){
		 memset(output_matrix[k], 0, MATRIX2_COL*sizeof(output_matrix[0][0]));
	}
	double sum=0;
	for (int c = 0; c < MATRIX1_ROW; c++) {
	      for (int d = 0; d < MATRIX2_COL; d++) {
	        for (int k = 0; k < MATRIX1_COL; k++) {
	          sum += input_matrix1[c][k]*input_matrix2[k][d];
	        }
	        output_matrix[c][d] = sum;
	        sum = 0;
	      }
	 }
}


void matrix_matrix_sub(uint32_t MATRIX_ROW, uint32_t MATRIX_COL,
									double input_matrix1[MATRIX_ROW][MATRIX_COL],
									double input_matrix2[MATRIX_ROW][MATRIX_COL],
									double output_matrix[MATRIX_ROW][MATRIX_COL]) {
	for (int c = 0; c < MATRIX_ROW; c++) {
	      for (int d = 0; d < MATRIX_COL; d++) {
	        output_matrix[c][d] = input_matrix1[c][d]-input_matrix2[c][d];
	      }
	 }
}


void weights_update(uint32_t MATRIX_ROW, uint32_t MATRIX_COL, double learning_rate,
									double dW[MATRIX_ROW][MATRIX_COL],
									double W[MATRIX_ROW][MATRIX_COL]) {
	//TODO: implement weights_update function
	int i, j;
	for(i=0; i<MATRIX_ROW; i ++)
	{
		for(j=0; j<MATRIX_COL; j++)
		{
			W[i][j] = W[i][j] - (dW[i][j] * learning_rate);
		}
	}
}


void matrix_transpose(uint32_t ROW, uint32_t COL, double A[ROW][COL], double A_T[COL][ROW]) {
	for(int i=0; i<ROW; i++){
		for(int j=0; j<COL; j++){
			A_T[j][i]=A[i][j];
		}
	}
}
