/*
 ============================================================================
 Name        : Lab2_PC_bruteforce_learning.c
 Author      : Mairo Leier
 Version     :
 Copyright   : TalTech
 Description : Bruteforce learning in C, Ansi-style

 If you get error during compilation:
 	 "undefined reference to `powf'	simple_neural_networks.c	/Lab3_2_PC_find_error/src	line 72	C/C++ Problem"
 Add: Project Properties -> C/C++ Build -> Settings -> Tool Settings -> GCC C Linker -> Miscellanous -> Linker flags: add "-lm -E"
 ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include "simple_neural_networks.h"

double weight  = 0.5;
double input = 0.5;
double expected_value  = 0.8;
// TODO: Try to find best step_amount value that minimizes number of epochs when training error decreases to zero.
double learning_rate = 0.001;
uint32_t epochs = 1500;

void main(void) {
	brute_force_learning(input,weight,expected_value,learning_rate,epochs);
}


