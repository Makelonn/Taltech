#include "simple_neural_networks.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double single_in_single_out_nn(double input, double weight)
{
	// TODO: Return the result of multiplication of input and its weight.
	return input * weight;
}

double weighted_sum(double *input, double *weight, uint32_t INPUT_LEN)
{
	double output = 0;
	// TODO: Use for loop to multiply all inputs with their weights
	for (int i = 0; i < INPUT_LEN; i++)
	{
		output += single_in_single_out_nn(input[i], weight[i]);
	}
	return output;
}

double multiple_inputs_single_output_nn(double *input, double *weight, uint32_t INPUT_LEN)
{
	double predicted_value = weighted_sum(input, weight, INPUT_LEN);
	// TODO: Use weighted_sum function to calculate the output
	return predicted_value;
}

void elementwise_multiple(double input_scalar, double *weight_vector, double *output_vector, double VECTOR_LEN)
{
	// TODO: Use for loop to calculate output_vector
	for (int i = 0; i < VECTOR_LEN; i++)
	{
		output_vector[i] = input_scalar * weight_vector[i];
	}
}

void single_input_multiple_output_nn(double input_scalar, double *weight_vector, double *output_vector, double VECTOR_LEN)
{
	elementwise_multiple(input_scalar, weight_vector, output_vector, VECTOR_LEN);
}

void matrix_vector_multiplication(double *input_vector, uint32_t INPUT_LEN, double *output_vector,
								  uint32_t OUTPUT_LEN, double weights_matrix[OUTPUT_LEN][INPUT_LEN])
{
	// TODO: Use two for loops to calculate output vector based on the input vector and weights matrix
	for (int j = 0; j < OUTPUT_LEN; j++)
	{
		for (int i = 0; i < INPUT_LEN; i++)
		{
			output_vector[j] += weights_matrix[j][i] * input_vector[i];
		}
	}
}

void multiple_inputs_multiple_outputs_nn(double *input_vector, uint32_t INPUT_LEN, double *output_vector,
										 uint32_t OUTPUT_LEN, double weights_matrix[OUTPUT_LEN][INPUT_LEN])
{
	matrix_vector_multiplication(input_vector, INPUT_LEN, output_vector, OUTPUT_LEN, weights_matrix);
}

void hidden_nn(double *input_vector, uint32_t INPUT_LEN,
			   uint32_t HIDDEN_LEN, double in_to_hid_weights[HIDDEN_LEN][INPUT_LEN],
			   uint32_t OUTPUT_LEN, double hid_to_out_weights[OUTPUT_LEN][HIDDEN_LEN], double *output_vector)
{
	/* TODO: Use matrix_vector_multiplication to calculate values for hidden_layer. Make sure that when you initialize
           hidden_pred_vector variable then zero its value with for loop */
	double hidden_pred_vector[HIDDEN_LEN];
	multiple_inputs_multiple_outputs_nn(input_vector, INPUT_LEN, hidden_pred_vector, OUTPUT_LEN, in_to_hid_weights);
	// TODO: Use matrix_vector_multiplication to calculate output layer values from hidden layer
	multiple_inputs_multiple_outputs_nn(hidden_pred_vector, HIDDEN_LEN, output_vector, OUTPUT_LEN, hid_to_out_weights);
}

// Calculate the error using yhat (predicted value) and y (expected value)
double find_error(double yhat, double y)
{
	// TODO: Use math.h functions to calculate the error with double precision
	return pow(yhat - y, 2.0);
}

void linear_forward_nn(double *input_vector, uint32_t INPUT_LEN,
					   double *output_vector, uint32_t OUTPUT_LEN,
					   double weights_matrix[OUTPUT_LEN][INPUT_LEN], double *weights_b)
{

	matrix_vector_multiplication(input_vector, INPUT_LEN, output_vector, OUTPUT_LEN, weights_matrix);
	for (int k = 0; k < OUTPUT_LEN; k++)
	{
		output_vector[k] += weights_b[k];
	}
}

double relu(double x)
{
	// TODO: Calculate ReLu based on its mathematical formula
	return x >= 0 ? x : 0;
}

void vector_relu(double *input_vector, double *output_vector, uint32_t LEN)
{
	for (int i = 0; i < LEN; i++)
	{
		output_vector[i] = relu(input_vector[i]);
	}
}

double sigmoid(double x)
{
	// TODO: Calculate sigmoid based on its mathematical formula
	double result = 1 / (1 + exp(-x));
	return result;
}

void vector_sigmoid(double *input_vector, double *output_vector, uint32_t LEN)
{
	for (int i = 0; i < LEN; i++)
	{
		output_vector[i] = sigmoid(input_vector[i]);
	}
}

//yhat (predicted value) and y (expected value)
double compute_cost(uint32_t m, double yhat[m][1], double y[m][1])
{
	double cost = 0;
	for (int i = 0; i < m; i++)
	{
		cost += (y[i][0] * log2(yhat[i][0]) + (1 - y[i][0]) * log2(1 - yhat[i][0]));
	}
	cost = -1 * (cost / m);
	// TODO: Calculate cost based on mathematical cost function formula
	return cost;
}

void normalize_data_2d(uint32_t ROW, uint32_t COL, double input_matrix[ROW][COL], double output_matrix[ROW][COL])
{
	double max = -99999999;
	for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			if (input_matrix[i][j] > max)
			{
				max = input_matrix[i][j];
			}
		}
	}

	for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			output_matrix[i][j] = input_matrix[i][j] / max;
		}
	}
}

// Use this function to print matrix values for debugging
void matrix_print(uint32_t ROW, uint32_t COL, double A[ROW][COL])
{
	for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			printf(" %f ", A[i][j]);
		}
		printf("\n");
	}
	printf("\n\r");
}

void weights_random_initialization(uint32_t HIDDEN_LEN, uint32_t INPUT_LEN, double weight_matrix[HIDDEN_LEN][INPUT_LEN])
{
	double d_rand;

	/*Seed random number generator*/
	srand(1);

	for (int i = 0; i < HIDDEN_LEN; i++)
	{
		for (int j = 0; j < INPUT_LEN; j++)
		{
			/*Generate random numbers between 0 and 1*/
			d_rand = (rand() % 10);
			d_rand /= 10;
			weight_matrix[i][j] = d_rand;
		}
	}
}

void weightsB_zero_initialization(double *weightsB, uint32_t LEN)
{
	memset(weightsB, 0, LEN * sizeof(weightsB[0]));
}

void relu_backward(uint32_t m, uint32_t LAYER_LEN, double dA[m][LAYER_LEN], double Z[m][LAYER_LEN], double dZ[m][LAYER_LEN])
{
	//TODO: implement derivative of relu function  You can can choose either to calculate for all example at the same time
	//or make iteratively. Check formula for derivative lecture 5 on slide 24
	for (int j = 0; j < m; j++)
	{
		for (int i = 0; i < LAYER_LEN; i++)
		{
			if (Z[j][i] > 0)
				dZ[j][i] = dA[j][i];
			else
				dZ[j][i] = 0;
		}
	}
}

void linear_backward(uint32_t LAYER_LEN, uint32_t PREV_LAYER_LEN, uint32_t m, double dZ[m][LAYER_LEN],
					 double A_prev[m][PREV_LAYER_LEN], double dW[LAYER_LEN][PREV_LAYER_LEN], double db[LAYER_LEN])
{
	// TODO: implement linear backward. You can can choose either to calculate for all example at the same time (dw= 1/m *A_prev[T]*dZ;)
	//or make iteratively  (dw_iter= A_prev[T]*dZ;)

	// Weights
	double dZ_T[LAYER_LEN][m];
	matrix_transpose(LAYER_LEN, m, dZ, dZ_T);
	matrix_matrix_multiplication(LAYER_LEN, m, PREV_LAYER_LEN, dZ_T, A_prev, dW);
	for (int j = 0; j < LAYER_LEN; j++)
	{
		for (int i = 0; i < PREV_LAYER_LEN; i++)
		{
			dW[j][i] *= (double)(1 / m);
		}
	}
	// Bias
	double dz_sum[LAYER_LEN];
	for (int j = 0; j < LAYER_LEN; j++)
	{
		dz_sum[j] = 0; // init sum for each node
		for (int i = 0; i < m; i++)
		{
			dz_sum[j] += dZ[i][j];
		}
	}
	for (int i = 0; i < LAYER_LEN; i++)
	{
		db[i] = ((double)1 / m) * dz_sum[i];
	}
}

void matrix_matrix_sum(uint32_t MATRIX_ROW, uint32_t MATRIX_COL,
					   double input_matrix1[MATRIX_ROW][MATRIX_COL],
					   double input_matrix2[MATRIX_COL][MATRIX_COL],
					   double output_matrix[MATRIX_ROW][MATRIX_COL])
{
	for (int c = 0; c < MATRIX_ROW; c++)
	{
		for (int d = 0; d < MATRIX_COL; d++)
		{
			output_matrix[c][d] = input_matrix1[c][d] + input_matrix2[c][d];
		}
	}
}

void matrix_divide_scalar(uint32_t MATRIX_ROW, uint32_t MATRIX_COL, double scalar,
						  double input_matrix[MATRIX_ROW][MATRIX_COL],
						  double output_matrix[MATRIX_ROW][MATRIX_COL])
{
	for (int c = 0; c < MATRIX_ROW; c++)
	{
		for (int d = 0; d < MATRIX_COL; d++)
		{
			output_matrix[c][d] = input_matrix[c][d] / scalar;
		}
	}
}

void matrix_matrix_multiplication(uint32_t MATRIX1_ROW, uint32_t MATRIX1_COL, uint32_t MATRIX2_COL,
								  double input_matrix1[MATRIX1_ROW][MATRIX1_COL],
								  double input_matrix2[MATRIX1_COL][MATRIX2_COL],
								  double output_matrix[MATRIX1_ROW][MATRIX2_COL])
{

	for (int k = 0; k < MATRIX1_ROW; k++)
	{
		memset(output_matrix[k], 0, MATRIX2_COL * sizeof(output_matrix[0][0]));
	}
	double sum = 0;
	for (int c = 0; c < MATRIX1_ROW; c++)
	{
		for (int d = 0; d < MATRIX2_COL; d++)
		{
			for (int k = 0; k < MATRIX1_COL; k++)
			{
				sum += input_matrix1[c][k] * input_matrix2[k][d];
			}
			output_matrix[c][d] = sum;
			sum = 0;
		}
	}
}

void matrix_matrix_sub(uint32_t MATRIX_ROW, uint32_t MATRIX_COL,
					   double input_matrix1[MATRIX_ROW][MATRIX_COL],
					   double input_matrix2[MATRIX_ROW][MATRIX_COL],
					   double output_matrix[MATRIX_ROW][MATRIX_COL])
{
	for (int c = 0; c < MATRIX_ROW; c++)
	{
		for (int d = 0; d < MATRIX_COL; d++)
		{
			output_matrix[c][d] = input_matrix1[c][d] - input_matrix2[c][d];
		}
	}
}

void weights_update(uint32_t MATRIX_ROW, uint32_t MATRIX_COL, double learning_rate,
					double dW[MATRIX_ROW][MATRIX_COL],
					double W[MATRIX_ROW][MATRIX_COL])
{
	//TODO: implement weights_update function
	for (int j = 0; j < MATRIX_ROW; j++)
	{
		for (int i = 0; i < MATRIX_COL; i++)
		{
			W[j][i] = W[j][i] - (learning_rate * dW[j][i]);
		}
	}
}

void matrix_multiply_scalar(uint32_t MATRIX_ROW, uint32_t MATRIX_COL, double scalar,
							double input_matrix[MATRIX_ROW][MATRIX_COL],
							double output_matrix[MATRIX_ROW][MATRIX_COL])
{
	for (int c = 0; c < MATRIX_ROW; c++)
	{
		for (int d = 0; d < MATRIX_COL; d++)
		{
			output_matrix[c][d] = input_matrix[c][d] * scalar;
		}
	}
}

void matrix_transpose(uint32_t ROW, uint32_t COL, double A[ROW][COL], double A_T[COL][ROW])
{
	for (int i = 0; i < ROW; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			A_T[j][i] = A[i][j];
		}
	}
}
