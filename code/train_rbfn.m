function [ weight, Centers ] = train_rbfn( X_train, y_train, sigma, centersPerCategory )
% TRAIN_RBFN Compute weight vector and centers for the RBFN.
%
%   Parameters
%     X_train            - Training dataset.
%     y_train            - Desired output. The values MUST be non-zero.
%     sigma              - Spread of the Gaussian.
%     centersPerCategory - How many centers to use per each category.
%
%   Returns
%     Two elements. The weight vector of the RBFN and the centers.

% Create the matrix which will contain the centers.
Centers = rand_center_selection(X_train, y_train, centersPerCategory);
% Calculate the Phi matrix.
Phi = calculate_phi(X_train, sigma, Centers);
% Compute the weights with the closed-form equation.
weight = pinv(Phi)*y_train;

end

