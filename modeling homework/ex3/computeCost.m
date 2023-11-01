function J = computeCost(params, t, z)
    % Extract parameters from input
    k1 = params(1);
    k2 = params(2);

    % Compute predicted values using the provided nonlinear function
    z_pred = k1 * (1 - exp(k2 * t));

    % Compute the sum of squared errors
    J = sum((z_pred - z).^2);
end