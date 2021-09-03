# Notes on TD1 : basics of R

> R is case sensitive (x != X)

> NaN : Not a number

> [Documentation](https://www.rdocumentation.org)

> [Great tutorial](https://swcarpentry.github.io/r-novice-inflammation/)

## Help menus

Manual:

    help.start()
    help(fonction)
    example(fonction)

Searching man for a fct° containning a string :

    apropos("string")

## Variables

    x <- 3
    x = "string"
    x <- TRUE

`1/0` and `-1/0` will return infinites values: `inf` and `-inf`

## R objects

    objects()
    rm(name_of_object)

`objects()` equivalents to  `ls()` 

Clear the workspace is `rm(list = ls())`

## Directories 

    getwd()
    setwd()

## Loops & evrthing

    for (i in seq(along=1:10)){
    instructions
    }

    while(y>0){
    instructions
    }

## Matrices

    B=matrix(c(4,9),nrow=2,ncol=1)
    D=t(B)
    determinant = det(D)

To select more than one row or column :

    B[c(1,5,6),c(10,12)]

Will select cols 10 & 12 from rows 1, 5 and 6

You can also use slices as in python

To address cols by name (either name from the csv or the name auto-given which is V1 ... V10 ... VX for a csv)

    B$name
    B[, 'name']

Access to an element / line / row :

`R
    F[1,2] #Element
    F[,2] #Row
`
Carefull, in R it start at 1 so it's like :

| [1,1] | [1,2] | [1,3]
| :--: | :--:| :--:|
| [2,1] | [2,2] | [2,3] |


### Summary function

Give : min, max, first quartile, median, third quartile, and mean

### Other usefull fct°

* `apply` : repeat a function on all rows (MARGIN =1) or cols (=2)
### Concatenation

Concatener A :

| 1 | 2 |
| :--: | :--: |
| 1 | 2 |

and B :

| 3 |
| :--: |
| 3 |

Doing `C=cbind(A,B)` will give :

| 1 | 2 | 3 |
| :--: | :--: | :--: | 
| 1 | 2 | 3 | 

### Multiplication

 P = G %*% C

 Carefull G must be `m*n` and C `n*p`

## Ploting

    plot(x_axis, y_axis)

Can also add parameters as `l` for linear or `s` for seuil (i guess ??) like this :

    plot(x_axis, y_axis, type="l")

## Import data & library 

    library(XLConnect)
    install.packages('XLConnect', dependencies = TRUE)
    install.packages("openxlsx", dependencies = TRUE)
    library(openxlsx)
    library(readxl)

    wb <- loadWorkbook("Book1.xlsx")

    mydata<-readWorksheetFromFile(wb,sheet="Sheet1")
    mydata2 = read_excel("Book1.xlsx")
    mydata3 = read.xlsx2("Book1.xlsx", 1, rep("numeric", 3))

    new_matrix <- as.matrix(mydata2)

    AA<- matrix(, nrow=4,ncol=3)
    AA<-as.matrix(mydata2)

## Functions

To define :

    myfct<-function(param1, param2){
        instructions
        return(result_var)
    }

To use :

    myfct(1 ,2)

If return statement is not defined, the last line variable will be returned

## On data 

Can use `min`, `max`, `mean`, `median`, `sd`(which is the standard deviation)

Carefull bc some function dont automatically convert to numerical variable