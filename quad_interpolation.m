% quad_interpolation - Quadratic Interpolation Optimization Algorithm
%
% This function implements the Quadratic Interpolation optimization algorithm to find an optimal solution of a given
% function within a specified interval [a, b]. The algorithm iteratively performs quadratic interpolation to find a
% better estimate of the optimal solution.
%
% Input:
%   f: Objective function to be optimized.
%   a, b: Interval for optimization.
%   e: Tolerance level for stopping the optimization.
%   d: Step size for calculating xd during interpolation.
%
% Output:
%   x: Optimal solution.
%   fx: Value of the objective function at the optimal solution.

function [x, fx] = quad_interpolation(f, a, b, e, d)
    x1 = a; f1 = f(x1); x3 = b; f3 = f(x3); D = inf;
    xg = a; fg = f(xg); x2 = b; f2 = f3;
    
    while D > e
        if xg < x2
            if fg < f2
                x3 = x2; f3 = f2;
            else
                x1 = xg; f1 = fg;
            end
        elseif xg > x2
            if fg < f2
                x1 = x2; f1 = f2;
            else
                x3 = xg; f3 = fg;
            end
        else
            xd = x2 + d; fd = f(xd);
            
            if f2 <= fd
                x3 = xd; f3 = fd;
            else
                x1 = x2; f1 = f2;
            end
        end
        
        x2 = (x1 + x3) / 2;  % Calculate the midpoint of x1 and x3
        f2 = f(x2);  % Calculate the value of the objective function at x2
        
        while f2 >= (f1 + f3) / 2
            if f1 < f3
                x3 = x2; f3 = f2;
            else
                x1 = x2; f1 = f2;
            end
            
            x2 = (x1 + x3) / 2;  % Update x2 using quadratic interpolation
            f2 = f(x2);  % Calculate the value of the objective function at the updated x2
        end
        
        % Perform quadratic interpolation to estimate a new point xg
        xg = (f1 * (x2^2 - x3^2) + f2 * (x3^2 - x1^2) + f3 * (x1^2 - x2^2)) / (2 * (f1 * (x2 - x3) + f2 * (x3 - x1) + f3 * (x1 - x2)));
        fg = f(xg);  % Calculate the value of the objective function at xg
        
        % Calculate the curvature for stopping condition
        gg = ((f1 * (x2 - x3)^2 - f2 * (x3 - x1)^2 + f3 * (x1 - x2)^2)^2 - 4 * f1 * f3 * (x1 - x2)^2 * (x2 - x3)^2) / (4 * (x1 - x2) * (x2 - x3) * (x3 - x1) * (f1 * (x2 - x3) + f2 * (x3 - x1) + f3 * (x1 - x2)));
        
        D = abs(gg / fg - 1);  % Update the curvature for stopping condition
    end
    
    x = xg;  % Set the optimal solution
    fx = f(xg);  % Calculate the value of the objective function at the optimal solution
end
