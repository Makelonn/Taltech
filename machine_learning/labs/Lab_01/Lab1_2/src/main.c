/*
 ============================================================================
 Name        : Lab1_multiple_in_single_out.c
 Author      : Mairo Leier
 Version     :
 Copyright   : TalTech
 Description : Multiple in, single out in C, Ansi-style
 ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include "simple_neural_networks.h"

#define NUM_OF_INPUTS 	3

double temperature[5] = {12,23,50,-10,16};
double humidity[5] =    {60,67,45,65,63};
double air_quality[5] = {60,47,157,187,94};
double weight[3] = 		{-2,2,1};	// Weights for each input

void main(void) {

	int i;
	// Our sample size is 5
	for (i=0; i < 5; i++) {
		double training_eg1[3] = {temperature[i],humidity[i], air_quality[i]};

		printf("Prediction from training example %d is : %f\n ", i+1,
				multiple_inputs_single_output_nn(training_eg1, weight, NUM_OF_INPUTS));
	}
}

