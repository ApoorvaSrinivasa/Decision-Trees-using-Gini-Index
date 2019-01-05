# Decision Trees using Gini Index

A classification framework is built to implement the decision tree algorithm with Gini-index as the attribute selection measure.

In the training dataset, the data format is

label index1:value1 index2:value2 ...

Each line contains an instance and is ended by a '\n' character. <label> is an integer indicating the class label. The pair <index>:<value> gives a feature (attribute) value: <index> is a non-negative integer and <value> is a number (we only consider categorical attributes in this assignment). Each attribute may have more than 2 possible values i.e. it is a multi-valued categorical attribute.

In the testing dataset, the data format is

index1:value1 index2:value2 ...

It will no longer have the <label> in each line.

In the output file - "result.txt", each line contains one integer representing the predicted label of a testing sample.
