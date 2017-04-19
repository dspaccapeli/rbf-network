function Centers = rand_center_selection( X, y, centersPerCategory )
% RAND_CENTER_SELECTION Returns a subselection of the matrix X given 
%                       the return vector and the number of expected
%                       centers per category.
%
%   Parameters
%     X                   - Input matrix.
%     y                   - Result/category matrix.
%     centersPerCategory  - Number of desired centers per category.
%
%   Returns
%     A matrix containing a random center selection.

% Allocate the matrix
Centers = [];
% Number of unique categories in the dataset.
numCat = size(unique(y), 1);
% For each category [...]
for(category = 1 : numCat)
    % Select the training vectors for category 'c'.
    Xc = X((y == category), :);
    % Select a random subselection.
    Centers_c = Xc(randperm(size(Xc,1), centersPerCategory),:);
    % Add the centroids to the network.
    Centers = [Centers; Centers_c];
end

end

