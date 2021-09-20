# Notes de CM4 - Dataset & tools for machine learning

## Dataset labelling

80% of AI project time is spent gathering/labelling data

* Labelled data -> data marked up which is what we want the model to predict
* Labelling -> is ready for processing
* Annotation -> processing of labeling data 

*Label* is the info identified

* well labeled -> ground truth for testing models
* accuracy -> how close to ground truth
* quality -> accuracy across overall dataset

Low quality data = bad model training, bad predictions

## Data augmentation

Increase diversity of training by applying random&realistic (at the same time) transfo

* before training model
* offline augmentation
  * extra disk space
  * augmented image is part of training set
* online augmentation
  * not saved on the disk
  * model sees diferent images each epoch
* better generalization with online augmentation because image is different each time

Somes techniques :
* flip, rotate, shear, crop, zoom +/-, brightness and contrast modif
* noise injection, shifting time, chaning pitch, pitch (audio)
* synonym, random insertion, randow swap, random deletation (langage)

*Population based training* : try the hyperparam to find the best ones -> other way to augmnent data

## Dataset reparation

* LabelIMG
* Labelbox
* Lionbridge AI
* LabelMe
* YOLO_Label

other on diapo 12/48 CM 4

How to store images ?
* png 
* LMDB (lightining memory mapped database)
  * not loaded into memory
  * suitable for large dataset
  * tree-like graph structured in memory
* HDF5 (Hierarchial data format)
  * 2 type of obj: dataset or gorups
  * always read entirely into memory
  * array dim and type have to be uniform within a dataset

HDF5 and LMBD take more place than png on disk

LMDB : efficienccy gained form caching and taking advantages of os page sizes

*Resumé*
* **PNG**
  * complete concurrrency
  * nothing prevent reading several img at one from diff threads / write multiple files
* **LMDB**
  * multiple readers at the same time
  * only one writer
  * writer NOT block readers
* **HDF5**
  * parallel i/o
  * but write block is held and access is sequential (unless having // file syst)
  * dataset must be divided in multiple hdf5 files

## Model development

MNIST dataser -> handwritting imagery

