import tensorflow as tf
import pathlib
import os.path
import numpy as np
import cv2 as cv

LEARNING_RATE = 0.05
EPOCHS = 30
OPTIMIZER = 'adam'
ACTIVATION = 'gelu'
PRINT = 0

# Build sequential model by stacking layers, choose optimizer and loss function
model = tf.keras.models.Sequential()
model.add(tf.keras.layers.Flatten(input_shape=(28, 28)))
model.add(tf.keras.layers.Dense(110, activation=ACTIVATION)) #80
model.add(tf.keras.layers.Dense(100, activation=ACTIVATION)) #was not here 70
model.add(tf.keras.layers.Dense(90, activation=ACTIVATION)) #60
#model.add(tf.keras.layers.Dropout(LEARNING_RATE))
model.add(tf.keras.layers.Dense(10))
model.summary()

loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)

model.compile(optimizer=OPTIMIZER, loss=loss_fn, metrics=["accuracy"])


converter = tf.lite.TFLiteConverter.from_keras_model(model)
converter.target_spec.supported_ops = [
  tf.lite.OpsSet.TFLITE_BUILTINS, # enable TensorFlow Lite ops.
  tf.lite.OpsSet.SELECT_TF_OPS # enable TensorFlow ops.
]

tflite_model = converter.convert()

directory = os.path.abspath(os.getcwd())
with open(os.path.join(directory,'lebaron_maelie_model1.tflite'), 'wb') as f:
  f.write(tflite_model)
