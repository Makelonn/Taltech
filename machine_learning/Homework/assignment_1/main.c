#include <stdio.h>
#include <stdlib.h>
#include "neural_networks.h"

// Size of the layers
#define NUM_OF_FEATURES   	3  	// Input values
#define NUM_OF_HID1_NODES	5	// Hidden layer
#define NUM_OF_HID2_NODES   4
#define NUM_OF_OUT_NODES	1	// Output classes

double learning_rate=0.01;

/*Input layer to hidden layer*/
double a1[1][NUM_OF_HID1_NODES];	// Input vector
double b1[NUM_OF_HID1_NODES];		// Weights
double z1[1][NUM_OF_HID1_NODES];	// Output vector

// Input layer to hidden layer weight matrix;
double w1[NUM_OF_HID1_NODES][NUM_OF_FEATURES] =    {{0.25, 0.5,   0.05},   	 //hid[0]
													{0.8,  0.82,  0.3 },     //hid[1]
													{0.5,  0.45,  0.19}};   //hid[2]

/*Hidden layer to output layer*/
double b2[NUM_OF_OUT_NODES];
double z2[1][NUM_OF_OUT_NODES];	// Predicted output vector

// Hidden layer to output layer weight matrix
double w2[NUM_OF_OUT_NODES][NUM_OF_OUT_NODES] =    {{0.48, 0.73, 0.03}};

// Predicted values
double yhat[1][NUM_OF_OUT_NODES];

// Training data
double train_x[1][NUM_OF_FEATURES];
double train_y[1][NUM_OF_OUT_NODES] = {{1}};  	// The expected (training) y values


void main(void) {
	double raw_x[1][NUM_OF_FEATURES] = {{23.0, 40.0, 100.0}};	// temp, hum, air_q input values

	normalize_data_2d(1, NUM_OF_FEATURES, raw_x, train_x);
	printf("train_x \n");
	matrix_print(1, NUM_OF_FEATURES, train_x);

	// Lab 3.1
	linear_forward_nn(train_x, NUM_OF_FEATURES, z1[0], NUM_OF_HID1_NODES, w1, b1);
	printf("Output vector (z1): %f\n", z1[0][0]);
	printf("Output vector (z1): %f\n", z1[0][1]);
	printf("Output vector (z1): %f\n", z1[0][2]);

	vector_relu(z1[0],a1[0],NUM_OF_HID1_NODES);

	linear_forward_nn(a1[0], NUM_OF_HID1_NODES, z2[0], NUM_OF_OUT_NODES, w2, b2);
	printf("Output vector (z2): %f\n", z2[0][0]);

	/*compute yhat*/
	vector_sigmoid(z2[0],yhat[0], NUM_OF_OUT_NODES);
	printf("Loss yhat:  %f\n", yhat[0][0]);

	double cost = compute_cost(1, yhat, train_y);
	printf("cost: %f\n", cost);
}
