# Notes sur le CM 5

## Forward propagation

We take all the input for this node, and we multiply by weight

Then we applu relu or another non-linear fct° for all node of the layer

we can also apply sigmoid to the last layer ! (for exemple if we wait for true or false)

## Backpropagation of a node

dL/dz is the "enter value"

df/dx and df/dy only depend of f (you derive it as usual)

For the output you multiplu `dL/dz` by `df/dy` or `df/dx`

## Exemple of the slides

Backprogation for x1

* (1-0.730)*0.730 = 0.2
* 0.2*1
* 0.1*1
* 0.2*1*1*2

m: nb of training of the network (nb of time we put an input knowing the output we should have had)