from os import path, listdir, getcwd
import numpy as np
import cv2 as cv
from keras.datasets import mnist
from keras.models import Model
from keras.utils import np_utils
from keras.layers import (
    Input,
    Conv2D,
    GlobalAveragePooling2D,
    Dropout,
    Activation,
    BatchNormalization,
    Add,
    Reshape,
    DepthwiseConv2D,
)
import keras.backend as back

BATCH_SIZE = 5
EPOCHS = 1
OPTIMIZER='adadelta'
CHANNEL_AXIS = -1

# Prepare dataset
(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train = x_train.reshape(x_train.shape[0], 28, 28, 1).astype(np.float32)
x_test = x_test.reshape(x_test.shape[0], 28, 28, 1).astype(np.float32)

x_train = x_train / 255.0
x_test = x_test / 255.0

y_train = np_utils.to_categorical(y_train, 10)
y_test = np_utils.to_categorical(y_test, 10)

## PERSONNAL DATA
x_own = []
y_own = []
directory = path.abspath(getcwd())
data_directory = path.join(directory, "data_2_test")
filenames = [file for file in listdir(data_directory)]

for filename in filenames:
    my_path = path.join(data_directory, filename)
    x_own.append(cv.cvtColor(cv.imread(my_path), cv.COLOR_BGR2GRAY))
    y_own.append(int(filename[0]))

x_own = np.array(x_own).astype(np.float32)
x_own = 255 - x_own  # To read it in negative
x_own /= 255  # normalization
y_own = np.array(y_own)


print(x_own.shape)
print(x_test.shape)
print(y_own.shape)
print(y_test.shape)
x_own = x_own.reshape(x_own.shape[0], 28, 28, 1).astype(np.float32)
y_own = np_utils.to_categorical(y_own, 10)
print("-------------------")
print(x_own.shape)
print(x_test.shape)
print(y_own.shape)
print(y_test.shape)