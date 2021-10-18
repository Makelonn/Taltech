#ifndef __SIMPLE_NEURAL_NETWORK
#define __SIMPLE_NEURAL_NETWORK

#include <stdint.h>

double single_in_single_out_nn(double input, double weight);
double multiple_inputs_single_output_nn(double * input, double *weight, uint32_t INPUT_LEN);
void single_input_multiple_output_nn( double input_scalar, double *weight_vector, double *output_vector, double VECTOR_LEN);
void multiple_inputs_multiple_outputs_nn(double * input_vector, uint32_t INPUT_LEN, double * output_vector,
		uint32_t OUTPUT_LEN, double weights_matrix[OUTPUT_LEN][INPUT_LEN]);
void hidden_nn( double *input_vector, uint32_t INPUT_LEN, uint32_t HIDDEN_LEN, double in_to_hid_weights[HIDDEN_LEN][INPUT_LEN],
		uint32_t OUTPUT_LEN, double hid_to_out_weights[OUTPUT_LEN][HIDDEN_LEN], double *output_vector);

double find_error( double yhat, double y);
void brute_force_learning( double input, double weight, double expected_value, double step_amount, uint32_t itr);

void linear_forward_nn(double * input_vector, uint32_t INPUT_LEN, double * output_vector,
		uint32_t OUTPUT_LEN, double weights_matrix[OUTPUT_LEN][INPUT_LEN], double * weights_b);
double relu(double x);
void vector_relu(double * input_vector, double * output_vector, uint32_t LEN);
void vector_sigmoid(double * input_vector, double * output_vector, uint32_t LEN);
double sigmoid(double x);
double compute_cost(uint32_t m, double yhat[m][1], double y[m][1]);
void normalize_data_2d(uint32_t ROW, uint32_t COL, double input_matrix[ROW][COL], double output_matrix[ROW][COL]);
void matrix_print(uint32_t ROW, uint32_t COL, double A[ROW][COL]);


#endif
