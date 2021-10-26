import tensorflow as tf
import pathlib
import os.path
import numpy as np
import cv2 as cv

LEARNING_RATE_LIST = [0.1,0.2,0.01,0.02,0.05,0.001,0.005]
EPOCHS_LIST = [10,20,30,40,50]
OPTIMIZER_LIST = ['adam', 'SGD', 'RMSprop', 'adadelta', 'adagrad', 'nadam', 'Ftrl']
ACTIVATION_LIST = ['elu', 'exponential','gelu', 'sigmoid', 'linear', 'selu', 'tanh']
PRINT = 0

directory = os.path.abspath(os.getcwd())
result_file = open(os.path.join(directory, "results.txt"), 'x')
### ------ PREPARING DATA ------- ###
# Export saved model
export_dir = 'mymodel'
# Load and prepare MNIST dataset
#mnist = tf.keras.datasets.mnist

## TRAIN DATA
data_directory = os.path.join(directory,"data_2")
filenames = [file for file in os.listdir(data_directory)]

x_train = []
y_train = []
for filename in filenames:
    path = os.path.join(data_directory, filename)
    x_train.append(cv.cvtColor(cv.imread(path), cv.COLOR_BGR2GRAY))
    y_train.append(int(filename[0]))

x_train = np.array(x_train).astype(np.float32)
x_train = 255-x_train #To read it in negative 
x_train /= 255 #normalization
y_train = np.array(y_train)


## TEST DATA 
data_directory = os.path.join(directory,"data_2_test")
filenames = [file for file in os.listdir(data_directory)]

x_test = []
y_test = []
for filename in filenames:
    path = os.path.join(data_directory, filename)
    x_test.append(cv.cvtColor(cv.imread(path), cv.COLOR_BGR2GRAY))
    y_test.append(int(filename[0]))

x_test = np.array(x_test).astype(np.float32)
x_test = 255-x_test #To read it in negative 
x_test /= 255 #normalization
y_test = np.array(y_test)

for lr  in LEARNING_RATE_LIST :
    for epo in EPOCHS_LIST:
        for act in ACTIVATION_LIST:
            for opti in OPTIMIZER_LIST :
                # Build sequential model by stacking layers, choose optimizer and loss function
                model = tf.keras.models.Sequential()
                model.add(tf.keras.layers.Flatten(input_shape=(28, 28)))
                model.add(tf.keras.layers.Dense(80, activation=act))
                model.add(tf.keras.layers.Dense(60, activation=act))
                model.add(tf.keras.layers.Dropout(lr))
                model.add(tf.keras.layers.Dense(10))
                model.summary()

                predictions = model(x_train[:1]).numpy()
                predictions_prob = tf.nn.softmax(predictions).numpy()
                #print ('Probabilities for each class: ' + str(predictions_prob))

                # Take a vector of logits and True index and return scalar loss for each example
                # This loss is equal to the negative log probability of the true class: It is zero if the model is sure of the correct class.
                loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)
                loss_initial = loss_fn(y_train[:1], predictions).numpy()
                #print('Untrained model inital loss: ' + str(loss_initial))

                # Train model
                model.compile(optimizer=opti, loss=loss_fn, metrics=['accuracy'])

                # Adjust model parameters to minimize the loss and train it
                model.fit(x_train, y_train, epochs=epo, verbose=PRINT)

                # Evaluate model performance
                #print(x_test[0], y_test[0])
                r = model.evaluate(x_test, y_test, verbose=2)
                my_string = "LR:{lr}\tepochs:{epo}\tactivation:{activation}\toptimizer:{optim}\tresults:{res}\n".format(lr=lr, epo=epo, activation=act, optim=opti, res=r)
                result_file.write(my_string)