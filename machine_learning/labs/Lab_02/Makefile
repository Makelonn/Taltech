lab1 :
	gcc -Wall -c ./Lab2_1_PC_hidden_layer/src/main.c -o ./Lab2_1_PC_hidden_layer/bin/main.o
	gcc -Wall -c ./Lab2_1_PC_hidden_layer/src/simple_neural_networks.c -o ./Lab2_1_PC_hidden_layer/bin/simple_neural_networks.o
	gcc -Wall -o ./Lab2_1_PC_hidden_layer/bin/lab1 ./Lab2_1_PC_hidden_layer/bin/main.o ./Lab2_1_PC_hidden_layer/bin/simple_neural_networks.o

lab2 :
	gcc -Wall -c ./Lab2_2_PC_find_error/src/main.c -o ./Lab2_2_PC_find_error/bin/main.o -lm
	gcc -Wall -c ./Lab2_2_PC_find_error/src/simple_neural_networks.c -o ./Lab2_2_PC_find_error/bin/simple_neural_networks.o -lm
	gcc -Wall -o ./Lab2_2_PC_find_error/bin/lab2 ./Lab2_2_PC_find_error/bin/main.o ./Lab2_2_PC_find_error/bin/simple_neural_networks.o -lm

lab3 :
	gcc -Wall -c ./Lab2_3_PC_bruteforce_learning/src/main.c -o ./Lab2_3_PC_bruteforce_learning/bin/main.o -lm
	gcc -Wall -c ./Lab2_3_PC_bruteforce_learning/src/simple_neural_networks.c -o ./Lab2_3_PC_bruteforce_learning/bin/simple_neural_networks.o -lm
	gcc -Wall -o ./Lab2_3_PC_bruteforce_learning/bin/lab3 ./Lab2_3_PC_bruteforce_learning/bin/main.o ./Lab2_3_PC_bruteforce_learning/bin/simple_neural_networks.o -lm


all :
	gcc -Wall -c ./Lab2_1_PC_hidden_layer/src/main.c -o ./Lab2_1_PC_hidden_layer/bin/main.o
	gcc -Wall -c ./Lab2_1_PC_hidden_layer/src/simple_neural_networks.c -o ./Lab2_1_PC_hidden_layer/bin/simple_neural_networks.o
	gcc -Wall -c ./Lab2_2_PC_find_error/src/main.c -o ./Lab2_2_PC_find_error/bin/main.o -lm
	gcc -Wall -c ./Lab2_2_PC_find_error/src/simple_neural_networks.c -o ./Lab2_2_PC_find_error/bin/simple_neural_networks.o -lm
	gcc -Wall -c ./Lab2_3_PC_bruteforce_learning/src/main.c -o ./Lab2_3_PC_bruteforce_learning/bin/main.o -lm
	gcc -Wall -c ./Lab2_3_PC_bruteforce_learning/src/simple_neural_networks.c -o ./Lab2_3_PC_bruteforce_learning/bin/simple_neural_networks.o -lm
	gcc -Wall -o ./Lab2_1_PC_hidden_layer/bin/lab1 ./Lab2_1_PC_hidden_layer/bin/main.o ./Lab2_1_PC_hidden_layer/bin/simple_neural_networks.o
	gcc -Wall -o ./Lab2_2_PC_find_error/bin/lab1 ./Lab2_2_PC_find_error/bin/main.o ./Lab2_2_PC_find_error/bin/simple_neural_networks.o -lm
	gcc -Wall -o ./Lab2_3_PC_bruteforce_learning/bin/lab1 ./Lab2_3_PC_bruteforce_learning/bin/main.o ./Lab2_3_PC_bruteforce_learning/bin/simple_neural_networks.o -lm

clean : 
	rm */bin/*.o

clear :
	rm */bin/*