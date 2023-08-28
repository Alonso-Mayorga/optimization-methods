% newton_raphson - Newton-Raphson Optimization Algorithm
%
% This function implements the Newton-Raphson optimization algorithm to find an optimal solution of a given function
% using symbolic differentiation. The algorithm starts from an initial point x1 and aims to find a point where
% the derivative of the function approaches zero.
%
% Input:
%   f: Objective function to be optimized.
%   x1: Initial guess for optimization.
%   e: Tolerance level for stopping the optimization.
%   max_I: Maximum number of iterations.
%
% Output:
%   x: Optimal solution.
%   fx: Value of the objective function at the optimal solution.

function [x, fx] = newton_raphson(f, x1, e, max_I)
    syms x  % Define a symbolic variable x
    
    df = diff(f);  % Calculate the first derivative of the function
    ddf = diff(df);  % Calculate the second derivative of the function
    
    i = 1;  % Initialize the iteration counter
    c = x1;  % Initialize the current point as x1
    f1 = subs(df, x, c);  % Calculate the value of the first derivative at c
    
    while i <= max_I && abs(f1) > e
        f2 = subs(ddf, x, c);  % Calculate the value of the second derivative at c
        
        if abs(f2) > e
            c = c - (f1 / f2);  % Update the current point using the Newton-Raphson formula
            f1 = subs(df, x, c);  % Calculate the value of the first derivative at the updated point
        else
            error('error 1');  % If the second derivative is close to zero, raise an error
        end
        
        i = i + 1;  % Increment the iteration counter
    end
    
    if i > max_I
        error('error 2');  % If the maximum number of iterations is reached, raise an error
    else
        x = c;  % Set the optimal solution
        fx = subs(f, x);  % Calculate the value of the objective function at the optimal solution
    end
end
