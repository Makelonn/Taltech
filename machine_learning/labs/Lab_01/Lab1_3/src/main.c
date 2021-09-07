/*
 ============================================================================
 Name        : Lab1_single_in_multiple_out.c
 Author      : Mairo Leier
 Version     :
 Copyright   : TalTech
 Description : Single in, multiple out in C, Ansi-style
 ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include "simple_neural_networks.h"

#define SAD   0.9		// TODO: Find appropriate sad value

#define TEMPERATURE_PREDICTION_IDX  0
#define HUMIDITY_PREDICTION_IDX 	1
#define AIR_QUALITY_PREDICTION_IDX  2

#define OUT_LEN     3


double predicted_results[3];
double weights[3] = {-20.2, 95, 201.0};	// Weights for each input: temp, hum, air_quality

void main(void) {

	single_input_multiple_output_nn(SAD, weights, predicted_results, OUT_LEN);

	printf("Predicted temperature is : %f\n", predicted_results[TEMPERATURE_PREDICTION_IDX]);
	printf("Predicted humidity is : %f\n", predicted_results[HUMIDITY_PREDICTION_IDX]);
	printf("Predicted air quality is : %f\n", predicted_results[AIR_QUALITY_PREDICTION_IDX]);
}

