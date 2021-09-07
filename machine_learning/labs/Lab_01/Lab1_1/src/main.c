/*
 ============================================================================
 Name        : Lab1_single_in_single_out.c
 Author      : Mairo Leier
 Version     :
 Copyright   : TalTech
 Description : Single in, single out in C, Ansi-style
 ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include "simple_neural_networks.h"

int32_t temperature[] = {12, 23, 47};
int32_t weight[] = {-3, 2, 3};

int main(void) {

	printf("The first predicted value is %d\r\n",single_in_single_out_nn(temperature[0],weight[0]));
	printf("The second predicted value is %d\r\n",single_in_single_out_nn(temperature[1],weight[1]));
	printf("The third predicted value is %d\r\n",single_in_single_out_nn(temperature[2],weight[2]));
	return 0;
}
