function Phi = calculate_phi( X, sigma, Centers )
% CALCULATE_PHI Compute the Phi matrix .
%
%   Parameters
%     x      - Sample vector.
%     center - Center from which you got to calculate the distance.
%     sigma  - Spread of the Gaussian.
%
%   Returns
%     The return value for the RBF (phi) function, applied to two vectors.

% Set 'nSamples' to the number of data points.
nSamples = size(X, 1);
% Create the phi matrix row-by-row.
Phi = [];
for(r = 1 : nSamples)
    % Pre-allocate the rth row.
    row = [];
    for(c = 1:size(Centers, 1))
        % Calculate phi(x(r), center_c).
        row = [row, calculate_rbf(X(r, :), Centers(c, :), sigma)];
    end
    % Add the row to the return matrix.
    Phi = [Phi; row];
end

end

