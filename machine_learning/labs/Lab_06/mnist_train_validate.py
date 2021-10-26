import tensorflow as tf
import pathlib
import os.path
import numpy as np
import cv2 as cv

LEARNING_RATE = 0.001
EPOCHS = 50
OPTIMIZER = 'adam'
ACTIVATION = 'elu'
PRINT = 0


### ------ PREPARING DATA ------- ###
# Export saved model
export_dir = 'mymodel'
# Load and prepare MNIST dataset
mnist = tf.keras.datasets.mnist
# Normalize dataset
(x_train, y_train) , (x_test, y_test) = mnist.load_data()
x_train = x_train / 255.0
x_test = x_test / 255.0

## Personnal data

data_directory = os.path.abspath(os.getcwd())
data_directory = os.path.join(data_directory,"data_2")

#my_data_y = np.array([0,1,2,3,4,5,6,7,8,9]) #Labels for each
filenames = [file for file in os.listdir(data_directory)]

my_data_x = []
my_data_y = []
for filename in filenames:
    path = os.path.join(data_directory, filename)
    my_data_x.append(cv.cvtColor(cv.imread(path), cv.COLOR_BGR2GRAY))
    my_data_y.append(int(filename[0]))

"""my_data_x = [
             cv.cvtColor(cv.imread(path), cv.COLOR_BGR2GRAY) for path in filenames
            ]"""

my_data_x = np.array(my_data_x).astype(np.float32)
my_data_x = 255-my_data_x #To read it in negative 
my_data_x /= 255 #normalization
my_data_y = np.array(my_data_y)

# Build sequential model by stacking layers, choose optimizer and loss function
model = tf.keras.models.Sequential()
model.add(tf.keras.layers.Flatten(input_shape=(28, 28)))
model.add(tf.keras.layers.Dense(80, activation=ACTIVATION))
model.add(tf.keras.layers.Dense(60, activation=ACTIVATION))
model.add(tf.keras.layers.Dropout(LEARNING_RATE))
model.add(tf.keras.layers.Dense(10))
model.summary()

predictions = model(x_train[:1]).numpy()
predictions_prob = tf.nn.softmax(predictions).numpy()
print ('Probabilities for each class: ' + str(predictions_prob))

# Take a vector of logits and True index and return scalar loss for each example
# This loss is equal to the negative log probability of the true class: It is zero if the model is sure of the correct class.
loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)
loss_initial = loss_fn(y_train[:1], predictions).numpy()
print('Untrained model inital loss: ' + str(loss_initial))

# Train model
model.compile(optimizer=OPTIMIZER, loss=loss_fn, metrics=['accuracy'])

# Adjust model parameters to minimize the loss and train it
model.fit(x_train, y_train, epochs=EPOCHS, verbose=PRINT)

# Evaluate model performance
#print(x_test[0], y_test[0])
model.evaluate(x_test, y_test, verbose=2)

# Loading my data


print("Results :")
model.evaluate(my_data_x, my_data_y, verbose=2)

### TEST  1 ### 
"""
my_data_x = []
my_data_y = []
for i in range(1,10):
    filename = str(i) + ".png"
    file = os.path.join(data_directory, filename)
    image = cv.imread(file, cv.IMREAD_GRAYSCALE)
    #Resizing our image and normalizing
    image = cv.resize(image, (28, 28))
    image = image.astype('float64')
    #image = image.reshape(1, 28, 28, 1)
    #image = 255-image
    image /= 255
    #print(image)
    my_data_x.append(image) #Appening our float
    my_data_y.append([i])

my_data_y = np.array(my_data_y)
#my_data_y = my_data_y.astype('uint8')

test = model.evaluate(my_data_x, my_data_y, verbose=2)
#my_data_y = np.array(my_data_y).astype('float32')

print("X size ", len(my_data_x), len(my_data_x[0]), len(my_data_x[0][0]))
print("Y size ", len(my_data_y))

my_data_y = np.array(my_data_y)
my_data_y = my_data_y.astype('uint8')
print(len(y_test))
print(len(x_test))
print(len(my_data_x))
print(len(my_data_y))
for i in range(len(my_data_y)):
    test = model.evaluate(my_data_x[i], my_data_y[i])
print("------------------\n", test)

x_perso, y_perso = load_images(os.path.join(current_directory, "my_data"), x_test, y_test)
model.evaluate(x_perso, y_perso, verbose = 2)"""

