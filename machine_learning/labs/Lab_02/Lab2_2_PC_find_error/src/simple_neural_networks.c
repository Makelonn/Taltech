#include "simple_neural_networks.h"
#include <math.h>

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


void multiple_inputs_multiple_outputs_nn(double * input_vector, uint32_t INPUT_LEN, double * output_vector,
		uint32_t OUTPUT_LEN, double weights_matrix[OUTPUT_LEN][INPUT_LEN]) {
	matrix_vector_multiplication(input_vector,INPUT_LEN,output_vector,OUTPUT_LEN,weights_matrix);
}


void hidden_nn( double *input_vector, uint32_t INPUT_LEN,
				uint32_t HIDDEN_LEN, double in_to_hid_weights[HIDDEN_LEN][INPUT_LEN],
				uint32_t OUTPUT_LEN, double hid_to_out_weights[OUTPUT_LEN][HIDDEN_LEN], double *output_vector) {
	//initialize hidden
	int i=0;
	double hidden_pred_vector[INPUT_LEN];
	for(i=0; i<INPUT_LEN; i++) hidden_pred_vector[i] = 0.0;

	//matrix vector multiplication
	matrix_vector_multiplication(input_vector, INPUT_LEN, hidden_pred_vector, OUTPUT_LEN, in_to_hid_weights);
	matrix_vector_multiplication(hidden_pred_vector, INPUT_LEN, output_vector, OUTPUT_LEN, hid_to_out_weights);

}



// Calculate the error using yhat (predicted value) and y (expected value)
double find_error(double yhat, double y) {
	// TODO: Use math.h functions to calculate the error with double precision
	double error = pow(yhat-y,2);
	return error;
}

