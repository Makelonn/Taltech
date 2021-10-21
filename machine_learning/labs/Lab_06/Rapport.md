# Lab 6 - Machine Learning

## Optimizing with different methods

| Learning rate | Epochs | Optimizer | Activation | Accuracy |
| :-----------: | :----: | :-------: | :--------: | :------: |
|      0.2      |   5    |   Adam    |    elu     |  0.9724  |
|     0.02      |   5    |   Adam    |    elu     |  0.9769  |
|     0.02      |   20   |   Adam    |    elu     |  0.9782  |
|     0.02      |   30   |   Nadam   |    elu     |  0.9774  |
|     0.02      |   30   |   Adam    |    relu    |  0.9783  |
|     0.001     |   50   |   adam    |    elu     |  0.9801  |
|     0.001     |   50   |   adam    |    relu    |  0.9768  |