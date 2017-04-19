function [ fmeasure, Matrix ] = confusion_mat( y_test, y_out )
% CONFUSION_MAT Compute the confusion matrix between two vectors.
%
%   Parameters
%     y_test - Test vector. All elements must be either '0' or '1'.
%     y_out  - Classifier's output. All elements must be either '0' or '1'.
%
%   Returns
%     Accuracy of the classifier and confusion matrix.

% Here we assume that label '1' indicates
% positives and '0' negatives.
% Count the positives and the negatives.
p = sum(y_test == 1);
n = sum(y_test == 0);
% Find the True Positives, when you predicted correctly the positives.  
% The value '64' is meant as placeholder, since the categories' value 
% are only meant to be '0' or '1' any other number would suffice.
y_test(y_test == 0) = 64;
temp = eq(y_test, y_out);
tp = sum(temp == 1);
y_test(y_test == 64) = 0;
% Find the True Negatives, when you predicted correctly the negatives.   
y_test(y_test == 1) = 64;
temp = eq(y_test, y_out);
tn = sum(temp == 1);
% Re-establish the correst test vector.
y_test(y_test == 64) = 1;
% Calculate the FP and FN via the known relationships.
fp = n - tn;
fn = p - tp;
% Form the confusion matrix.
Matrix = [tp fn; fp tn];
% Calculate f-measure.
precision = tp/(tp+fp);
recall = tp/(tp+fn);
fmeasure = 2*(precision*recall)/(precision+recall);

end

