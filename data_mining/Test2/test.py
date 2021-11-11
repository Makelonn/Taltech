import random
import pandas as pd
from math import log
import matplotlib.pyplot as plt
#Gini Function
#a and b are the quantities of each class. Base is the log base input.
def entropy(base,a,b):
    try:
        var =  abs(((a)/(a+b)) * log(((a)/(a+b)),base)) - (((b)/(a+b)) * log(((b)/(a+b)),base))
        return var
    except (ValueError):
        return 0

#Gini Function
#a and b are the quantities of each class
def gini(a,b):
    a1 = (a/(a+b))**2
    b1 = (b/(a+b))**2
    return 1 - (a1 + b1)

#Blank lists
ent_list = []
gin_list = []
blue_list = []
red_list = []
blue_prob_list = []#Loop with log base 2
for x in range (10000):
    blue = random.uniform(0, 4)
    red = abs(4-blue)
    a = entropy(2,red,blue)
    b = blue/(blue+red)
    ent_list.append(a)
    gin_list.append(gini(red, blue))
    blue_list.append(blue)
    red_list.append(red)
    blue_prob_list.append(b)


df = pd.DataFrame({"Blue": blue_list, "Red": red_list,"Entropy": ent_list, "Gini index": gin_list, "Probability of Blue": blue_prob_list})
df = df[['Red', 'Blue', 'Probability of Blue', 'Entropy']]
df

plt.plot(blue_prob_list,gin_list)
plt.xlabel("Probability of Blue Gumball %")
plt.ylabel("Gini")
plt.title("Gini Curve")
