import os
from PIL import Image
import numpy as np

def load_images(path_to_image_directory, features_data, label_data):
    files = os.listdir(path_to_image_directory) #Listing all the file in the repository
    for file in files:
        image_file_name = os.path.join(path_to_image_directory, file) #Name
        if ".png" in image_file_name: #if image
            image_label = image_file_name[-4] #Remove png, title is the label
            img = Image.open(image_file_name).convert("L")
            img = np.resize(img, (28,28,1))
            im2arr = np.array(img) # Convert to an array
            im2arr = im2arr.reshape(1,28,28,1)
            print("feature data", features_data[0])
            print("im2arr", im2arr[0])
            features_data = np.append(features_data[0], im2arr, axis=0)
            label_data = np.append(label_data, [image_label], axis=0)
    return features_data, label_data