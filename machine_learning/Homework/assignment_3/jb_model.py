import tensorflow as tf
import numpy as np
import os.path
import matplotlib.pyplot as plt

# Load and prepare MNIST dataset
mnist = tf.keras.datasets.mnist

# Normalize dataset
(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train = x_train / 255.0
x_test = x_test / 255.0


# Building & training sequential model and use the results of the question 2 to optimize the architecture and hyper-parameters
# LEARNING_RATE = 0.05
N_HIDDEN_LAYERS = 3
N_HIDDEN_LAYERS_NEURONS = 100
ACTIVATION_FUNCTIONS = "relu"
DROPOUT_PERCENTAGE = 0.25
OPTIMIZER_ALGORITHM = "adam"
EPOCHS = 50
BATCH_SIZE = 128

############# MODEL BUILDING ################

model = tf.keras.models.Sequential()
model.add(tf.keras.layers.Flatten(input_shape=(28, 28)))
for i in range(N_HIDDEN_LAYERS):
    model.add(
        tf.keras.layers.Dense(N_HIDDEN_LAYERS_NEURONS, activation=ACTIVATION_FUNCTIONS)
    )
model.add(tf.keras.layers.Dropout(DROPOUT_PERCENTAGE))
model.add(tf.keras.layers.Dense(10))
model.summary()
loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)
model.compile(optimizer=OPTIMIZER_ALGORITHM, loss=loss_fn, metrics=["accuracy"])

model.fit(x_train, y_train, epochs=EPOCHS)

model.evaluate(x_test, y_test, verbose=2)

model.save("JB_model")
converter = tf.lite.TFLiteConverter.from_keras_model(model)
converter.target_spec.supported_ops = [
  tf.lite.OpsSet.TFLITE_BUILTINS, # enable TensorFlow Lite ops.
  tf.lite.OpsSet.SELECT_TF_OPS # enable TensorFlow ops.
]

tflite_model = converter.convert()

directory = os.path.abspath(os.getcwd())
with open(os.path.join(directory,'jb_model.tflite'), 'wb') as f:
  f.write(tflite_model)