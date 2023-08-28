% saltos_aleatorios - Random Jumps Optimization Algorithm
%
% This function implements the Saltos Aleatorios (Random Jumps) optimization algorithm to find an optimal solution
% of a given function within a specified interval [l, u]. The algorithm performs random jumps in the solution space,
% repeatedly generating random points and evaluating the objective function to improve the solution.
%
% Input:
%   f: Objective function to be optimized.
%   l, u: Lower and upper bounds for optimization.
%   e: Tolerance level for stopping the optimization.
%   it: Number of random jumps to perform in each iteration.
%
% Output:
%   x: Optimal solution.
%   fx: Value of the objective function at the optimal solution.

function [x, fx] = saltos_aleatorios(f, l, u, e, it)
    xc = (l + u) / 2;  % Initialize the current point xc
    fc = f(xc);  % Calculate the value of the objective function at xc
    D = inf;  % Initialize the difference between current and previous points
    
    while D > e
        x0 = xc;  % Store the current point xc
        for i = 1:it
            for j = 1:length(l)
                lj = rand();  % Generate a random value between 0 and 1
                x(j) = l(j) + lj * (u(j) - l(j));  % Generate a random point within the bounds
            end
            fx = f(x);  % Calculate the value of the objective function at the new point
            
            if fx < fc
                xc = x;  % Update the current point and objective function value
                fc = fx;
            end
        end
        D = norm(xc - x0);  % Calculate the Euclidean distance between current and previous points
    end
    
    x = xc;  % Set the optimal solution
    fx = fc;  % Set the value of the objective function at the optimal solution
end
