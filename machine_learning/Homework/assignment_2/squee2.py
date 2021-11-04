from keras.layers.normalization.batch_normalization import BatchNormalization
import numpy as np
from keras.layers.convolutional import MaxPooling2D, Convolution2D
from keras.layers import Input, core, concatenate
from keras.models import Model
from keras.datasets import mnist
from keras.utils import np_utils
from os import path, getcwd, listdir
import cv2 as cv

#K.image_data_format = 'channels_first'

BATCH_SIZE = 4
EPOCHS = 1
ACTIVATION = 'relu'
OPTIMIZER='adadelta'

# Prepare dataset
(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train = x_train.reshape(x_train.shape[0],28,28,1).astype(np.float32)
x_test = x_test.reshape(x_test.shape[0],28,28,1).astype(np.float32)

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


def fire(layer_input, param1, param2, act=ACTIVATION):
    layer_fire_squeeze = Convolution2D(param1,(1,1), activation=act, padding='valid')(layer_input)
    #layer_fire_squeeze = BatchNormalization()(layer_fire_squeeze)
    layer_fire_expand1 = Convolution2D(param2,(1,1), activation=act, padding='valid')(layer_fire_squeeze)
    layer_fire_expand2 = Convolution2D(param2,(3,3), activation=act, padding='same')(layer_fire_squeeze)

    #merge_1 = merge(inputs=[layer_fire_expand1, layer_fire_expand2], mode="concat", concat_axis=1)
    merge_1 = concatenate([layer_fire_expand1, layer_fire_expand2], axis=1)
    layer_fire = core.Activation("linear")(merge_1)

    return(layer_fire)

# Implementing squeezeNet
# STEP : Convolution | layer 1

#Shape is 1,28,28 because 28x28pixels in grayscale
layer_input = Input(shape=(28,28,1), name="Input")

layer_1_conv = Convolution2D(filters=64,kernel_size=(3,3), activation=ACTIVATION, strides=(2,2), input_shape=(28,28,1) ,padding='valid', name="Layer_1_conv")(layer_input) #,border_mode='valid') dilation_rate=(2,2)
maxpool_1 = MaxPooling2D(pool_size=(2,2))(layer_1_conv)

# STEP : Fire | layer 2

layer_2_fire = fire(maxpool_1, 16, 64)
layer_3_fire = fire(layer_2_fire, 16, 64)
layer_4_fire = fire(layer_3_fire, 32, 128)

maxpool_2 = MaxPooling2D((2,2))(layer_4_fire)

layer_5_fire = fire(maxpool_2, 32,128)
layer_6_fire = fire(layer_5_fire, 48,192)
layer_7_fire = fire(layer_6_fire, 48,192)
layer_8_fire = fire(layer_7_fire, 64,256)

maxpool_3 = MaxPooling2D((2,2))(layer_8_fire)

layer_9_fire = fire(maxpool_3, 64,256)
layer_9_firedroupout = core.Dropout(0.5)(layer_9_fire)
layer_10_conv = Convolution2D(10,1,1, padding='valid')(layer_9_firedroupout)


flat = core.Flatten()(layer_10_conv)

# 10 = 10 digits || classes
soft_max = core.Dense(10, activation='softmax')(flat)

model = Model(inputs=layer_input, outputs=soft_max)
model.summary()

model.compile(optimizer=OPTIMIZER, loss='categorical_crossentropy', metrics=['accuracy'])
model.fit(x_train, y_train, epochs=EPOCHS, batch_size=BATCH_SIZE)

model.evaluate(x_test, y_test, verbose=1)
model.evaluate(x_own, y_own, verbose=1)