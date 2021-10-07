#include "simple_neural_networks.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

double single_in_single_out_nn(double  input, double weight) {
	// TODO: Return the result of multiplication of input and its weight.
	return input * weight;
}


double weighted_sum(double * input, double * weight, uint32_t INPUT_LEN) {
	double output = 0;
	// TODO: Use for loop to multiply all inputs with their weights
	int i = 0;
	for (i = 0; i < INPUT_LEN; i++) {
		output += (*(input + i)) * (*(weight + i));
	}
	return output;
}


double multiple_inputs_single_output_nn(double * input, double *weight, uint32_t INPUT_LEN) {
	double predicted_value = 0;
	// TODO: Use weighted_sum function to calculate the output
	predicted_value = weighted_sum(input, weight, INPUT_LEN);
	return predicted_value;
}


void elementwise_multiple( double input_scalar, double *weight_vector, double *output_vector, double VECTOR_LEN) {
	// TODO: Use for loop to calculate output_vector
	int i = 0;
	for (i = 0; i < VECTOR_LEN; i++) {
		output_vector[i] = single_in_single_out_nn(input_scalar, (weight_vector[i]));
	}
}


void single_input_multiple_output_nn(double input_scalar, double *weight_vector, double *output_vector, double VECTOR_LEN){
  elementwise_multiple(input_scalar, weight_vector,output_vector,VECTOR_LEN);
}


void matrix_vector_multiplication(double * input_vector, uint32_t INPUT_LEN, double * output_vector, uint32_t OUTPUT_LEN, double weights_matrix[OUTPUT_LEN][INPUT_LEN]) {
	// TODO: Use two for loops to calculate output vector based on the input vector and weights matrix
	int i, j;
	for (i = 0; i < OUTPUT_LEN; i++) {
		//For each output calculate the weighted some of all input
		*(output_vector + i) = 0;
		for (j = 0; j < INPUT_LEN; j++) {
			*(output_vector + i) += *(input_vector + j) * weights_matrix[i][j];
		}
	}
}


void multiple_inputs_multiple_outputs_nn(double * input_vector, uint32_t INPUT_LEN, double * output_vector, uint32_t OUTPUT_LEN, double weights_matrix[OUTPUT_LEN][INPUT_LEN]) {
	matrix_vector_multiplication(input_vector,INPUT_LEN,output_vector,OUTPUT_LEN,weights_matrix);
}


void hidden_nn( double *input_vector, uint32_t INPUT_LEN, uint32_t HIDDEN_LEN, double in_to_hid_weights[HIDDEN_LEN][INPUT_LEN], uint32_t OUTPUT_LEN, double hid_to_out_weights[OUTPUT_LEN][HIDDEN_LEN], double *output_vector) {
	/* TODO: Use matrix_vector_multiplication to calculate values for hidden_layer. Make sure that when you initialize
	   hidden_pred_vector variable then zero its value with for loop */

	// TODO: Use matrix_vector_multiplication to calculate output layer values from hidden layer
	int i = 0;
	double hidden_pred_vector[INPUT_LEN];
	for (i = 0; i < INPUT_LEN; i++) hidden_pred_vector[i] = 0.0;

	matrix_vector_multiplication(input_vector, INPUT_LEN, hidden_pred_vector, OUTPUT_LEN, in_to_hid_weights);
	matrix_vector_multiplication(hidden_pred_vector, INPUT_LEN, output_vector, OUTPUT_LEN, hid_to_out_weights);
}


double find_error(double yhat, double y) {
	// TODO: Use math.h functions to calculate the error with double precision
	return pow(y - yhat, 2);
}



void brute_force_learning( double input, double weight, double expected_value, double step_amount, uint32_t itr) {
   double prediction,error;
   double up_prediction, down_prediction, up_error, down_error;
   int i;
	 for(i=0;i<itr;i++){

		 prediction  = input * weight;
		 // TODO: Calculate the error
		 error = find_error(prediction, expected_value);

		 printf("Step: %d   Error: %f    Prediction: %f    Weight: %f\n", i, error, prediction, weight);

		 up_prediction =  input * (weight + step_amount);
		 up_error      =   powf((up_prediction - expected_value),2);

		 // TODO: Calculate down_prediction and down_error on the same way as up_prediction and up_error
		 down_prediction = input * (weight - step_amount);
		 down_error = powf((down_prediction - expected_value), 2);;

		 if(down_error <  up_error)
			 // TODO: Change weight value accordingly if down_error is smaller than up_error
			 weight = weight - step_amount;
		 if(down_error >  up_error)
			 // TODO: Change weight value accordingly if down_error is larger than up_error
			 weight = weight + step_amount;
	 }
}


void linear_forward_nn(double *input_vector, uint32_t INPUT_LEN, double *output_vector, uint32_t OUTPUT_LEN, double weights_matrix[OUTPUT_LEN][INPUT_LEN], double *weights_b) {

	matrix_vector_multiplication(input_vector,INPUT_LEN, output_vector,OUTPUT_LEN,weights_matrix);

	for(int k=0;k<OUTPUT_LEN;k++){
		output_vector[k]+=weights_b[k];
	}
}


double relu(double x){
	// TODO: Calculate ReLu based on its mathematical formula
	if (x < 0) {
		return 0;
	}
	else {
		return x;
	}
}


void vector_relu(double *input_vector, double *output_vector, uint32_t LEN) {
	  for(int i =0;i<LEN;i++){
		  output_vector[i] =  relu(input_vector[i]);
		}
}


double sigmoid(double x) {
	// TODO: Calculate sigmoid based on its mathematical formula
	 double result =  0;
	 double r = 1 + exp(-x);
	 result = 1 / r;
	 return result;
}


void vector_sigmoid(double * input_vector, double * output_vector, uint32_t LEN) {
	for (int i = 0; i < LEN; i++) {
		output_vector[i] = sigmoid(input_vector[i]);
	}
}


double compute_cost_old(uint32_t m, double yhat[m][1], double y[m][1]) {
	double cost = 0;
	double p = 1 / (1 + exp(-(yhat[m][1] * m + y[m][1])));
	cost = -log(p);
	// TODO: Calculate cost based on mathematical cost function formula
	return cost;
}

double compute_cost(uint32_t m, double yhat[m][1], double y[m][1]) {
	double cost = 0;
	// TODO: Calculate cost based on mathematical cost function formula
	int i;
	i = 0;
	while (i < m) {
		cost = cost + y[i][0] * log(yhat[i][0]) + (1 - y[i][0]) * log(1 - yhat[i][0]);
		i++;
	}
	cost = -(double)(1 / m) * cost;
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
