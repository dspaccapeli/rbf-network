# Classification using Radial Basis Function Network
In this project, the task is the classification of breast cancer as benign or malignant using Radial Basis Function Network. The RBFN was implemented __from scratch__ without the assistance of the Matlab toolbox, following the description given in the course’s material.

## Parameter selection
The radial basis function chosen is the "classic" gaussian function, which is localized. The parameter σ here indicates the spread of the Gaussian, it basically indicates the "area of influence" of each center.

The selected __range of sigma__ on which the search of the optimal parameter was taken mainly based on the perceived effect that the sigma have, as well as by looking at previous attempts in some papers.
The search range for the __number of centers__ progressively grows from 1 center per category to the maximum number of center per category possible given the training set.

_Cross validation_ is used to find the best parameters’ pair. Both 2-fold cross validation and a version of the hold-out method are employed.

## Results

To select the optimal parameters here an appropriate performance measure for the classifier must had been devised. It was decided to use the __F-measure__, this choice was made because the F-measure takes into consideration the sensitivity (or recall), which is an important measure in medical tests.

_Here the confusion matrix when the test size is 20% of the dataset:_

|         | Predicted | Condition |
|---------|-----------|-----------|
|True     | 83        |    1      |
|Condition| 1         |    54     |
