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

x_own = x_own.reshape(x_own.shape[0], 28, 28, 1).astype(np.float32)
y_own = np_utils.to_categorical(y_own, 10)

def relu_max_6(tens):
    return back.relu(tens, max_value=6.0)


def bottleneck(
    inputs, output_dimension, conv_size, expansion_factor, stride, residuals=False
):
    """Bottleneck module for mobilenetV2"""
    expansion_channel = back.int_shape(inputs)[CHANNEL_AXIS] * expansion_factor

    # Convolution block
    tens = Conv2D(expansion_channel, (1, 1), strides=(1, 1), padding="same")(inputs)
    tens = BatchNormalization(axis=CHANNEL_AXIS)(tens)
    tens = Activation(relu_max_6)(tens)

    tens = DepthwiseConv2D(
        conv_size, strides=(stride, stride), padding="same", depth_multiplier=1
    )(tens)
    tens = BatchNormalization(axis=CHANNEL_AXIS)(tens)
    tens = Activation(relu_max_6)(tens)

    tens = Conv2D(output_dimension, (1, 1), strides=(1, 1), padding="same")(tens)
    tens = BatchNormalization(axis=CHANNEL_AXIS)(tens)

    if residuals:
        tens = Add()([tens, inputs])

    return tens


def inverted_block(inputs, dim_output, conv_size, expansion_factor, strides, n):

    tens = bottleneck(inputs, dim_output, conv_size, expansion_factor, strides)

    for _ in range(1, n):
       tens  = bottleneck(tens, dim_output, conv_size, expansion_factor, 1, residuals=True)

    return tens


## Mobilenet implementation

inputs = Input(shape=(28, 28, 1))
first_filter = 64
conv_size = (3, 3)

# Convolution block
tenser = Conv2D(64, (3, 3), padding="same", strides=(2, 2))(inputs)
tenser = BatchNormalization(axis=CHANNEL_AXIS)(tenser)
tenser = Activation(relu_max_6)(tenser)

output_dimension_list = [16, 24, 32, 64, 96, 160, 320]
expansion_factor_list = [1, 6, 6, 6, 6, 6, 6]
stride_list = [1, 2, 2, 2, 1, 2, 1]
n_list = [1, 2, 3, 4, 3, 3, 1]


# tenser = inverted_block(tenser, 16, conv_size, expansion_factor=1, strides=1, n=1)

for i in range(len(stride_list)):
    tenser = inverted_block(
        tenser,
        output_dimension_list[i],
        conv_size,
        expansion_factor=expansion_factor_list[i],
        strides=stride_list[i],
        n=n_list[i],
    )

# Convolution block
last_filters = 1280 
tenser = Conv2D(last_filters, (1,1), padding="same", strides=(1,1))(tenser)
tenser = BatchNormalization(axis=CHANNEL_AXIS)(tenser)
tenser = Activation(relu_max_6)(tenser)

tenser = GlobalAveragePooling2D()(tenser)
tenser = Reshape((1,1, last_filters))(tenser)
tenser = Dropout(0.3, name="Dropout")(tenser)
tenser = Conv2D(10, (1,1), padding="same")(tenser)
tenser = Activation('softmax', name='softmax_activation')(tenser)
output = Reshape((10,))(tenser)

mobilenet = Model(inputs, output)

mobilenet.summary()

mobilenet.compile(optimizer=OPTIMIZER, loss='categorical_crossentropy', metrics=['accuracy'])
mobilenet.fit(x_train, y_train, epochs=EPOCHS, batch_size=BATCH_SIZE)

mobilenet.evaluate(x_test, y_test, verbose=1)
mobilenet.evaluate(x_own, y_own, verbose=1)