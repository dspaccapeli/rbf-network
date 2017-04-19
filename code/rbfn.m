function [sigma, centersPerCategory, confusion, fmeasure ] = rbfn(X, y, testRatio)
% RBFN Compute weight vector and phi matrix for the RBFN.
%
% THIS IS THE MAIN FUNCTION.
%
%   Parameters
%     X            - Input.
%     y            - Output.
%     testRatio    - Ratio of Holdout set.
%
%   Returns
%     The optimal parameter after model selection, the confusion matrix
%     and the F-measure used to select the best parameters.
%
%                 ---------------------------------
%                |        Confusion Matrix         |
%                |---------------------------------|
%                |      TP       |       FN        |
%                |      FP       |       TN        |
%                 ---------------------------------
%
%---------------------------------------------------

% FUNCTION SETUP.
% Select only the first column, they give the same information.
y = y(:, 1:1);
% THE METHOD TRAIN_RBFN REQUIRES IT. Substitute zero values w/ max_val + 1.
y(y == 0) = max(y) + 1;
% Set 'nSamples' to the number of data points.
nSamples = size(X, 1);
%---------------------------------------------------
% HOLDOUT CROSS-VALIDATION.
% Select appropriate variables for the data selection.
testSize = floor(nSamples*testRatio);
permutation = randperm(nSamples, nSamples);
testPerm = permutation(:, 1:testSize);
trainPerm = permutation(:, (testSize+1):end);
% Divide the dataset in train and test sets.
X_train = X(trainPerm, :);
X_test = X(testPerm, :);
y_train = y(trainPerm, :);
y_test = y(testPerm, :);
% Maximum number of samples to be taken as centers.
maxCenters = floor(length(y_train)/2);
for(category = 1 : size(unique(y_train), 1))
    % Select the training vectors for category 'c'.
    Xc = X_train((y_train == category), :);
    maxCenters = min([length(Xc), maxCenters]);
end
%---------------------------------------------------
% VARIABLES TO BE DETERMINED VIA CROSS-VALIDATION.
% Spread value candidates. len=9
sigma_c = [0.2; 0.5; 0.7; 1; 2; 6; 8];
% Number of centers to be used,
% they divide the data more or less uniformly. len=9
centersPerCategory_c = [1; 2; floor(maxCenters*0.25); floor(maxCenters*0.5); floor(maxCenters*0.7); floor(maxCenters*0.9); maxCenters];
%---------------------------------------------------
% MODEL SELECTION.
% Pre-allocate the confusion matrix and f-measure.
fmeasure = 0;
confusion = [];
centersPerCategory = 0;
sigma = 0;
% Find the best performing parameters.
for(s=1:length(sigma_c))
    for(c=1:length(centersPerCategory_c))
        % Learn the weights from the training set for the given
        % parameter choice.
        [weight, Centers] = train_rbfn( X_train, y_train, sigma_c(s, 1), centersPerCategory_c(c, 1));
        % Calculate the output for the rbf using the trained weights.
        y_out = calculate_phi(X_test, sigma_c(s, 1), Centers)*weight;
        % Prepare the rbfn output for the performance measurement.
        y_out = round(y_out);
        y_out(y_out < 1) = 1;
        y_out(y_out > 2) = 2;
        y_out(y_out == 2) = 0;
        % Prepare the test vector for the performance measurement.
        y_test(y_test == 2) = 0;
        % Calculate f-measure and confusion matrix for the current
        % parameters.
        [fm, cm] = confusion_mat(y_test, y_out);
        % Update the return values if the new parameters perform better.
        if(fm > fmeasure)
            confusion = cm;
            fmeasure = fm;
            sigma = sigma_c(s, 1);
            centersPerCategory = centersPerCategory_c(c, 1);
        end
    end
end

end
