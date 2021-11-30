import tensorflow as tf
import os.path
import numpy as np
import cv2 as cv

LEARNING_RATE = 0.05
EPOCHS = 30
OPTIMIZER = 'adam'
ACTIVATION = 'relu'
PRINT = 0


### Building the model ###
# Build sequential model by stacking layers, choose optimizer and loss function
model = tf.keras.models.Sequential()
model.add(tf.keras.layers.Flatten(input_shape=(28, 28)))
model.add(tf.keras.layers.Dense(110, activation=ACTIVATION)) #80
model.add(tf.keras.layers.Dense(100, activation=ACTIVATION)) #was not here 70
model.add(tf.keras.layers.Dense(90, activation=ACTIVATION)) #60
model.add(tf.keras.layers.Dropout(LEARNING_RATE))
model.add(tf.keras.layers.Dense(10))
model.summary()

loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)
model.compile(optimizer=OPTIMIZER, loss=loss_fn, metrics=["accuracy"])

### Training the model ###
# Load and prepare MNIST dataset
mnist = tf.keras.datasets.mnist
# Normalize dataset
(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train = x_train / 255.0
x_test = x_test / 255.0

model.fit(x_train, y_train, epochs=EPOCHS, verbose=PRINT)
model.evaluate(x_test, y_test, verbose=2)

### Converting the model to tflite ###
converter = tf.lite.TFLiteConverter.from_keras_model(model)
converter.target_spec.supported_ops = [
  tf.lite.OpsSet.TFLITE_BUILTINS, # enable TensorFlow Lite ops.
  tf.lite.OpsSet.SELECT_TF_OPS # enable TensorFlow ops.
]

tflite_model = converter.convert()

directory = os.path.abspath(os.getcwd())
with open(os.path.join(directory,'lebaron_maelie_model.tflite'), 'wb') as f:
  f.write(tflite_model)
