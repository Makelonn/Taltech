import tensorflow as tf
import pathlib
import os.path
import numpy as np
import cv2 as cv

LEARNING_RATE = 0.1
EPOCHS = 30
OPTIMIZER = 'nadam'
ACTIVATION = 'gelu'
PRINT = 0

directory = os.path.abspath(os.getcwd())

### ------ PREPARING DATA ------- ###
export_dir = "mymodel"
# Load and prepare MNIST dataset
mnist = tf.keras.datasets.mnist
# Normalize dataset
(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train = x_train / 255.0
x_test = x_test / 255.0


## PERSONNAL DATA
x_own = []
y_own = []
data_directory = os.path.join(directory, "data_2_test")
filenames = [file for file in os.listdir(data_directory)]

for filename in filenames:
    path = os.path.join(data_directory, filename)
    x_own.append(cv.cvtColor(cv.imread(path), cv.COLOR_BGR2GRAY))
    y_own.append(int(filename[0]))

x_own = np.array(x_own).astype(np.float32)
x_own = 255 - x_own  # To read it in negative
x_own /= 255  # normalization
y_own = np.array(y_own)

r_moy = 0
r_own = 0

    ### Training the model with differents parameters ###
    # Build sequential model by stacking layers, choose optimizer and loss function
    #Original
"""
model = tf.keras.models.Sequential()
model.add(tf.keras.layers.Flatten(input_shape=(28, 28)))
model.add(tf.keras.layers.Dense(80, activation=ACTIVATION)) #80
model.add(tf.keras.layers.Dense(60, activation=ACTIVATION)) #was not here 70
model.add(tf.keras.layers.Dropout(LEARNING_RATE))
model.add(tf.keras.layers.Dense(10))"""

model = tf.keras.models.Sequential()
model.add(tf.keras.layers.Flatten(input_shape=(28, 28)))
model.add(tf.keras.layers.Dense(60, activation=ACTIVATION)) #80
model.add(tf.keras.layers.Dense(100, activation=ACTIVATION)) #was not here 70
model.add(tf.keras.layers.Dense(80, activation=ACTIVATION)) #60
model.add(tf.keras.layers.Dropout(LEARNING_RATE))
model.add(tf.keras.layers.Dense(10))

model.summary()

predictions = model(x_train[:1]).numpy()
predictions_prob = tf.nn.softmax(predictions).numpy()
    # print ('Probabilities for each class: ' + str(predictions_prob))

    # Take a vector of logits and True index and return scalar loss for each example
    # This loss is equal to the negative log probability of the true class: It is zero if the model is sure of the correct class.
loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)
loss_initial = loss_fn(y_train[:1], predictions).numpy()
    # print('Untrained model inital loss: ' + str(loss_initial))

    # Train model
model.compile(optimizer=OPTIMIZER, loss=loss_fn, metrics=["accuracy"])

    # Adjust model parameters to minimize the loss and train it
model.fit(x_train, y_train, epochs=EPOCHS, verbose=PRINT)

    # Evaluate model performance
    # print(x_test[0], y_test[0])
r = model.evaluate(x_test, y_test, verbose=2)
own = model.evaluate(x_own, y_own, verbose=1)
own = model.evaluate(x_own, y_own, verbose=2)
own2 = model.predict(x_own, verbose=2)

print("Validation data loss : ", r[0], "\t accuracy : ", r[1])
print("Personnal data loss : ", own[0], "\t accuracy : ", own[1])
#print("Predict :", own2)