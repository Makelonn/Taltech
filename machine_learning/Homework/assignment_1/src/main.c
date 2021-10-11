#include <stdio.h>
#include <stdlib.h>
#include "neural_networks.h"


#define PRINT_ALL			1 //If = 0, will only print the cost, otherwise print everything
// Size of the layers
#define NUM_OF_FEATURES   	3  	// input values
#define NUM_OF_HID1_NODES	5
#define NUM_OF_HID2_NODES 	4
#define NUM_OF_OUT_NODES	1	// output classes
#define DATASET_SIZE		3
#define NUM_EPOCHS		500
double learning_rate=0.015;

/*Input layer to hidden layer*/
double a1[DATASET_SIZE][NUM_OF_HID1_NODES];	// activation function
double b1[NUM_OF_HID1_NODES];		// bias
double z1[DATASET_SIZE][NUM_OF_HID1_NODES];	// output vector

// Input layer to hidden layer weight matrix
double w1[NUM_OF_HID1_NODES][NUM_OF_FEATURES] =    {{0.25, 0.5,   0.05},   	//hid[0]
													{0.8,  0.82,  0.3},     //hid[1]
													{0.5,  0.45,  0.19}, 	//hid[2]
													{0.4,  0.8,   0.3 }, 	//hid[3]
													{0.7,  0.6,   0.18}};   //hid[4]

//Hidden 1 to hidden 2
double a2[DATASET_SIZE][NUM_OF_HID2_NODES];
double b2[NUM_OF_HID2_NODES];
double z2[DATASET_SIZE][NUM_OF_HID2_NODES];
double w2[NUM_OF_HID2_NODES][NUM_OF_HID1_NODES] =  {{0.25, 0.5,   0.05, 0.1, 0.53},  	//hid[0]
													{0.8,  0.82,  0.3,  0.5, 0.13},   	//hid[1]
													{0.5,  0.45,  0.19, 0.8, 0.57},		//hid[2]
													{0.4,  0.26,  0.87, 0.45,0.62}}; 	//hid[3]	

/*Hidden layer to output layer*/
double b3[NUM_OF_OUT_NODES];
double z3[DATASET_SIZE][NUM_OF_OUT_NODES];	// Predicted output vector

// Hidden layer to output layer weight matrix
double w3[NUM_OF_OUT_NODES][NUM_OF_HID2_NODES] =    {{0.48, 0.73, 0.03, 0.52}};

// Predicted values
double yhat[DATASET_SIZE][NUM_OF_OUT_NODES];
double yhat_eg[NUM_OF_OUT_NODES];	// Predicted yhat

// Training data
double train_x[DATASET_SIZE][NUM_OF_FEATURES];				// Training data after normalization
double train_y[DATASET_SIZE][NUM_OF_OUT_NODES] = {{1}, {0}, {1}};// The expected (training) y values

//Backward propagation
double dW1[NUM_OF_HID1_NODES][NUM_OF_FEATURES] = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}};
double dW2[NUM_OF_HID2_NODES][NUM_OF_HID1_NODES] = {{0, 0, 0, 0, 0}, {0, 0, 0, 0, 0}, {0, 0, 0, 0, 0}, {0, 0, 0, 0, 0}};
double dW3[NUM_OF_OUT_NODES][NUM_OF_HID1_NODES] = {{0, 0, 0}};

double dA1[DATASET_SIZE][NUM_OF_HID1_NODES] = {{0, 0, 0, 0, 0},{0, 0, 0, 0, 0},{0, 0, 0, 0, 0}};
double dA2[DATASET_SIZE][NUM_OF_HID2_NODES] = {{0, 0, 0, 0},{0, 0, 0, 0},{0, 0, 0, 0}};
double dA3[DATASET_SIZE][NUM_OF_OUT_NODES] = {{0},{0},{0}};

double dZ1[DATASET_SIZE][NUM_OF_HID1_NODES] = {{0, 0, 0, 0, 0},{0, 0, 0, 0, 0},{0, 0, 0, 0, 0}};
double dZ2[DATASET_SIZE][NUM_OF_HID2_NODES] = {{0, 0, 0, 0},{0, 0, 0, 0},{0, 0, 0, 0}};
double dZ3[DATASET_SIZE][NUM_OF_OUT_NODES] = {{0},{0},{0}};

double db1[NUM_OF_HID1_NODES] = {0, 0, 0, 0, 0};
double db2[NUM_OF_HID2_NODES] = {0, 0, 0, 0};
double db3[NUM_OF_OUT_NODES] = {0};

void main(void) {
	// Raw training data
	double raw_x[DATASET_SIZE][NUM_OF_FEATURES] = {{28, 45, 20}, {-30, 0, 500}, {35, 41, 25}};	// temp, hum, air_quality {-15, 70, 500}, {28, 40, 20}, {15, 15, 120}
	int i, j;
	normalize_data_2d(NUM_OF_FEATURES,DATASET_SIZE, raw_x, train_x);	// Data normalization
	if(PRINT_ALL){printf("train_x :\n");
	matrix_print(DATASET_SIZE, NUM_OF_FEATURES, train_x);}

	//Initialization
	weights_random_initialization(NUM_OF_HID1_NODES, NUM_OF_FEATURES, w1);
	weights_random_initialization(NUM_OF_HID2_NODES, NUM_OF_HID1_NODES, w2);
	weights_random_initialization(NUM_OF_OUT_NODES, NUM_OF_HID2_NODES, w3);
	weightsB_zero_initialization(b1, NUM_OF_HID1_NODES);
	weightsB_zero_initialization(b2, NUM_OF_HID2_NODES);
	weightsB_zero_initialization(b3, NUM_OF_OUT_NODES);

	for(j=0; j<NUM_EPOCHS; j++){
	// First forward propagation (input -> hidden 1)
	if(PRINT_ALL) printf("--------- First forward propagation (input -> hidden_1) --------- \n");
	for(i=0; i<DATASET_SIZE; i++){
		linear_forward_nn(train_x[i], NUM_OF_FEATURES, z1[i], NUM_OF_HID1_NODES, w1, b1);
		vector_relu(z1[i],a1[i],NUM_OF_HID1_NODES);

		if(PRINT_ALL){
		printf("Z1_1 : %f \t Z1_2 : %f \t Z1_3 : %f \n Z1_4 : %f \t Z1_5 : %f\n", z1[i][0], z1[i][1], z1[i][2], z1[i][3], z1[i][4]);
		printf("Relu a1 : \n");
		matrix_print(1, NUM_OF_HID1_NODES, a1);
		}
	}
		// Second forward propagation (hidden 1 -> hidden 2)
	if(PRINT_ALL)printf("------- Second forward propagation (hidden_2 -> hidden_1) ------- \n");
	for(i=0; i<DATASET_SIZE; i++){
			linear_forward_nn(a1[i], NUM_OF_HID1_NODES, z2[i], NUM_OF_HID2_NODES, w2, b2);
			vector_relu(z2[i],a2[i],NUM_OF_HID2_NODES);

			if(PRINT_ALL){
			printf("Z2_1 : %f \t Z2_2 : %f \t Z2_3 : %f \n Z2_4 : %f \n", z2[i][0], z2[i][1], z2[i][2], z2[i][3]);
			printf("Relu a2 : \n");
			matrix_print(1, NUM_OF_HID2_NODES, a2[i]);
			}
		}
		// Third forward propagation (hidden 2 -> output)
		if(PRINT_ALL) printf("--------- Third forward propagation (hidden_2 -> output) ---------- \n");
		for(i=0; i<DATASET_SIZE; i++){
			linear_forward_nn(a2[i], NUM_OF_HID2_NODES, z3[i], NUM_OF_OUT_NODES, w3, b3);
			/*compute yhat*/
			vector_sigmoid(z3[i],yhat[i], NUM_OF_OUT_NODES);
			
			//printf("Z3 : %f \n", z3[i][0]);
			if(PRINT_ALL) printf("> Yhat:  %f\t", yhat[i][0]);
		}
		double cost = compute_cost(DATASET_SIZE, yhat, train_y);
		if(PRINT_ALL) printf("> Cost:  %f\n", cost);
		else printf("%f\n", cost);
		if(PRINT_ALL) printf("-----------------------------------------------------------------\n\n");
		// BACKPROPAGATION


		/* Output layer */
		
		//dZ2 = A2-Y = yhat - y
		//TODO: calculate dZ2, use matrix_matrix_sub() function
		//matrix_matrix_sub(1, NUM_OF_OUT_NODES,z2,yhat,dZ2);
		if(PRINT_ALL) printf("-------- First backward propagation (output -> hidden 2) --------- \ndZ3 :\n");
		matrix_matrix_sub(DATASET_SIZE, 1, yhat, train_y, dZ3);
		if(PRINT_ALL) matrix_print(DATASET_SIZE, 1, dZ3);
		// TODO: Calculate linear backward for output layer, use linear_backward() function
		//check for formula on slide 31 (lecture 5)
		linear_backward(NUM_OF_OUT_NODES, NUM_OF_HID2_NODES, DATASET_SIZE, dZ3, a2, dW3, db3);

		if(PRINT_ALL){
		printf("db3 :\n");
		matrix_print(NUM_OF_OUT_NODES, 1, db3);}

		double W3_T[NUM_OF_HID2_NODES][NUM_OF_OUT_NODES] = {{0},{0},{0},{0}};

		// TODO: Make matrix transpose for output layer, use matrix_transpose() function
		matrix_transpose(NUM_OF_OUT_NODES, NUM_OF_HID2_NODES, w3, W3_T);
		if(PRINT_ALL){printf("> W3_T \n");
		matrix_print(NUM_OF_HID2_NODES, NUM_OF_OUT_NODES, W3_T);}

		// TODO: Make matrix matrix multiplication; use matrix_matrix_multiplication() function
		// Check for formula on slide 31 (lecture 5)
		matrix_matrix_multiplication(NUM_OF_HID2_NODES, NUM_OF_OUT_NODES, DATASET_SIZE, W3_T, dZ3, dA2);
		if(PRINT_ALL){printf("> dA2 :\n");
		matrix_print(1, NUM_OF_HID2_NODES, dA2);}

		//Hidden layer 
		if(PRINT_ALL) printf("-------- Second backward propagation (hidden 2 -> hidden 1) --------- \ndZ2 :\n");

		relu_backward(DATASET_SIZE, NUM_OF_HID2_NODES, dA2, z2, dZ2);


		if(PRINT_ALL) matrix_print(DATASET_SIZE, NUM_OF_HID2_NODES, dZ2);
		linear_backward(NUM_OF_HID2_NODES, NUM_OF_HID1_NODES, DATASET_SIZE, dZ2, dA2, dW2, db2);
		
		double W2_T[NUM_OF_HID2_NODES][NUM_OF_HID1_NODES] = {{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0}};
		matrix_transpose(NUM_OF_HID2_NODES, NUM_OF_HID1_NODES, w2, W2_T);
		matrix_matrix_multiplication(NUM_OF_HID2_NODES, NUM_OF_OUT_NODES, DATASET_SIZE, W2_T, dZ2, dA1);
		/* Input layer */
		if(PRINT_ALL) printf("-------- Third backward propagation (hidden 2 -> hidden 1) --------- \ndZ1 :\n");
		// TODO: Calculate relu backward for hidden layer, use relu_backward() function
		// Check for formula on slide 31 (lecture 5)
		relu_backward(DATASET_SIZE, NUM_OF_HID1_NODES, dA1, z1, dZ1);

		if(PRINT_ALL) matrix_print(DATASET_SIZE, NUM_OF_HID1_NODES, dZ1);

		// TODO: Calculate linear backward for hidden layer, use linear_backward() function
		// Check for formula on slide 31 (lecture 5)
		linear_backward(NUM_OF_HID1_NODES, NUM_OF_FEATURES, DATASET_SIZE, dZ1, train_x, dW1, db1);

		/*UPDATE PARAMETERS*/
		if(PRINT_ALL) printf("-----------------------------------------------------------------\n\n");
		if(PRINT_ALL) printf("---------------------- Update parameters ------------------------ \n");
		// W1 = W1 - learning_rate * dW1
		// TODO: update weights for W1, use weights_update() function
		weights_update(NUM_OF_HID1_NODES, NUM_OF_FEATURES, learning_rate, dW1, w1);
		if(PRINT_ALL) {printf("Updated W1 :\n");
		matrix_print( NUM_OF_HID1_NODES, NUM_OF_FEATURES, w1); }
		// b1 = b1 - learning_rate * db1
		// TODO: update bias for b1, use weights_update() function
		weights_update(NUM_OF_HID1_NODES, 1, learning_rate, db1, b1);
		if(PRINT_ALL){ printf("Updated b1 :\n\n");
		matrix_print(NUM_OF_HID1_NODES, 1, b1); }

		// W2 = W2 - learning_rate * dW2
		// TODO: update weights for W2, use weights_update() function
		weights_update(NUM_OF_HID2_NODES, NUM_OF_HID1_NODES, learning_rate, dW2, w2);
		if(PRINT_ALL){printf("Updated W2 :\n");
		matrix_print( NUM_OF_HID2_NODES, NUM_OF_HID1_NODES, w2);}
		// b2 = b2 - learning_rate * db2
		// TODO: update bias for b1, use weights_update() function
		weights_update(NUM_OF_HID2_NODES, 1, learning_rate, db2, b2);
		if(PRINT_ALL){printf("Updated b2 :\n\n");
		matrix_print(NUM_OF_HID2_NODES, 1, b2);}

		// W3 = W3 - learning_rate * dW3
		// TODO: update weights for W3, use weights_update() function
		weights_update(NUM_OF_OUT_NODES, NUM_OF_HID2_NODES, learning_rate, dW3, w3);
		if(PRINT_ALL){printf("Updated W3 : \n");
		matrix_print( NUM_OF_OUT_NODES, NUM_OF_HID2_NODES, w3);}
		// b3 = b3 - learning_rate * db3
		// TODO: update bias for b2, use weights_update() function
		weights_update(NUM_OF_OUT_NODES, 1, learning_rate, db3, b3);

		if(PRINT_ALL){printf("Updated b3 : \n\n");
		matrix_print( NUM_OF_OUT_NODES, 1, b3);}

		if(PRINT_ALL)printf("-----------------------------------------------------------------\n\n");
		/*PREDICT*/
		if(PRINT_ALL)printf("---------------------------- PREDICT ----------------------------\n");
		double input_x_eg[DATASET_SIZE][NUM_OF_FEATURES] = {{30, 40, 25}, {-20, 0, 500}, {31, 41, 24}};
		double input_x[DATASET_SIZE][NUM_OF_FEATURES] = {{0, 0, 0}, {0,0,0}, {0,0,0}};
		normalize_data_2d(DATASET_SIZE, NUM_OF_FEATURES, input_x_eg, input_x);
		for(i=0; i<DATASET_SIZE; i++){
			// Input -> hidden 1
			/*compute z1*/
			linear_forward_nn(input_x, NUM_OF_FEATURES, z1[i], NUM_OF_HID1_NODES, w1, b1);
			/*compute a1*/
			vector_relu(z1[i],a1[i],NUM_OF_HID1_NODES);
		
			// Hidden 1 -> Hidden 2
			//Compute z2
			linear_forward_nn(a1[i], NUM_OF_HID1_NODES, z2[i], NUM_OF_HID2_NODES, w2, b2);
			//Compute a2
			vector_relu(z1[i], a1[i], NUM_OF_HID2_NODES);

			//Hidden 2 -> Output
			/*compute z3*/
			linear_forward_nn(a2[i], NUM_OF_HID2_NODES, z3[i], NUM_OF_OUT_NODES, w3, b3);
			if(PRINT_ALL)printf("z3_eg%i:  %f \t",i,z3[i][0]);

			/*compute yhat*/
			vector_sigmoid(z3[i],yhat_eg, NUM_OF_OUT_NODES);
			if(PRINT_ALL)printf("predicted:  %f\n", yhat_eg[0]);
		}
		if(PRINT_ALL)printf("-----------------------------------------------------------------\n\n");
	}
}


