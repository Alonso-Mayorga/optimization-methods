% random_walk - Random Walk Optimization Algorithm
%
% This function implements the Random Walk optimization algorithm to find an optimal solution of a given
% function within a specified interval [l, u]. The algorithm iteratively takes random steps in different
% directions to explore the solution space.
%
% Input:
%   f: Objective function to be optimized.
%   l, u: Lower and upper bounds for optimization.
%   e: Tolerance level for stopping the optimization.
%   lambda: Initial step size for the random walk.
%   it: Maximum number of consecutive iterations without improvement.
%
% Output:
%   x: Optimal solution.
%   fx: Value of the objective function at the optimal solution.

function [x, fx] = random_walk(f, l, u, e, lambda, it)
    i = 1;  % Initialize the iteration counter
    xc = (l + u) / 2;  % Initialize the current point xc
    fc = f(xc);  % Calculate the value of the objective function at xc
    n = length(l);  % Number of variables
    
    while lambda > e
        % Generate a random direction vector d
        for j = 1:n
            d(j) = -1 + 2 * rand();
        end
        d = d / norm(d);
        
        % Calculate the new point x by taking a step in the random direction
        for j = 1:n
            x(j) = min(max(xc(j) + lambda * d(j), l(j)), u(j));
        end
        fx = f(x);
        
        if fx < fc
            while fx < fc
                xc = x; fc = fx;
                for j = 1:n
                    x(j) = min(max(xc(j) + lambda * d(j), l(j)), u(j));
                end
                fx = f(x);
            end
            i = 1;  % Reset the iteration counter
        else
            i = i + 1;  % Increment the iteration counter
            if i > it
                i = 1;  % Reset the iteration counter
                lambda = lambda / 2;  % Reduce the step size
            end
        end
    end
    
    x = xc;  % Set the optimal solution
    fx = f(xc);  % Calculate the value of the objective function at the optimal solution
end
