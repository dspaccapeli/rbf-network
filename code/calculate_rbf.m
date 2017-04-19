function sol = calculate_rbf( x, center, sigma )
% CALCULATE_RBF Compute the radial basis function between two vectors.
%
%   Parameters
%     x      - Sample vector.
%     center - Center from which you got to calculate the distance.
%     sigma  - Spread of the Gaussian.
%
%   Returns
%     The return value for the RBF (phi) function, applied to two vectors.

% Calculate the difference element-by-element.
diff = bsxfun(@minus, x, center);
% Square the L2 norm.
distSquared = sum(diff .^ 2, 2);
% Apply the Gaussian function for the given sigma (spread).
sol = exp(distSquared ./ (sigma .^ 2));

end

