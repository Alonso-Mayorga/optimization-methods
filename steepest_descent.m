% steepest_descent - Steepest Descent Optimization Algorithm
%
% This function implements the Steepest Descent optimization algorithm to find an optimal solution of a given function
% within the given lower and upper bounds, starting from the initial point x1, and using a specified
% tolerance 'e', penalty parameter 'lambda', and delta value for finite differences.
%
% Input:
%   f: Objective function to be optimized.
%   l: Lower bounds for optimization variables.
%   u: Upper bounds for optimization variables.
%   x1: Initial point for optimization.
%   e: Tolerance level for stopping the optimization.
%   lambda: Penalty parameter for the optimization.
%   delta: Delta value for finite differences.
%
% Output:
%   xsol: Optimal solution.
%   fxsol: Value of the objective function at the optimal solution.

function [xsol, fxsol] = steepest_descent(f, l, u, x1, e, lambda, delta)
    m = 1;  % Initialize the flag for new direction
    xc = x1;  % Initialize the current point as x1
    fc = f(xc);  % Calculate the value of the objective function at xc
    n = length(l);  % Number of optimization variables
    
    while lambda > e
        if m > 0
            for j = 1:n
                o = zeros(1, n);
                o(j) = 1;
                d(j) = -1 * (f(xc + delta * o) - f(xc - delta * o)) / (2 * delta);
            end
            
            d = d / norm(d);  % Normalize the direction vector
            m = 0;
        end
        
        for j = 1:n
            x(j) = min(max(xc(j) + lambda * d(j), l(j)), u(j));  % Update each variable
        end
        
        fx = f(x);  % Calculate the value of the objective function at the updated point
        
        if fx < fc
            while fx < fc
                xc = x;  % Update the current point
                fc = fx;
                
                for j = 1:n
                    x(j) = min(max(xc(j) + lambda * d(j), l(j)), u(j));  % Update each variable
                end
                
                fx = f(x);  % Calculate the value of the objective function at the updated point
            end
            m = 1;  % Set the flag for new direction
        else
            lambda = lambda / 2;  % Reduce lambda if no improvement
        end
    end
    
    xsol = xc;  % Set the final optimal solution
    fxsol = f(xsol);  % Set the value of the objective function at the optimal solution
end
