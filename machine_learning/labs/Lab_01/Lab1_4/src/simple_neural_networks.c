#include "simple_neural_networks.h"

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
	// TODO: Use two for loops to calculate output vector based on the input vector and weights matrix
	int i,j;
	for(i=0; i<OUTPUT_LEN; i++){
		//For each output calculate the weighted some of all input
		*(output_vector+i) = 0;
		for(j=0; j<INPUT_LEN; j++){
			*(output_vector+i) += *(input_vector+j)*weights_matrix[i][j];
		}
	}
}


void multiple_inputs_multiple_outputs_nn(double * input_vector, uint32_t INPUT_LEN, double * output_vector,
		uint32_t OUTPUT_LEN, double weights_matrix[OUTPUT_LEN][INPUT_LEN]) {
	matrix_vector_multiplication(input_vector,INPUT_LEN,output_vector,OUTPUT_LEN,weights_matrix);
}
