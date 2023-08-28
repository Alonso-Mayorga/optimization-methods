% coordenadas_ciclicas - Cyclical Coordinate Descent Optimization Algorithm
%
% This function implements the Cyclical Coordinate Descent algorithm to optimize a given function
% within the given lower and upper bounds, starting from the initial point x1, and using a specified
% tolerance 'e' and penalty parameter 'lambda'.
%
% Input:
%   f: Objective function to be optimized.
%   l: Lower bounds for optimization variables.
%   u: Upper bounds for optimization variables.
%   x1: Initial point for optimization.
%   e: Tolerance level for stopping the optimization.
%   lambda: Penalty parameter for the optimization.
%
% Output:
%   x: Optimal solution.
%   fx: Value of the objective function at the optimal solution.

function [x, fx] = coordenadas_ciclicas(f, l, u, x1, e, lambda)
    xc = x1;         % Initialize the current point as x1
    fc = f(xc);      % Calculate the value of the objective function at xc
    x = xc;          
    
    while lambda > e
        m = 0;  % Initialize the flag for movement
        
        for j = 1:length(l)
            x(j) = min(xc(j) + lambda, u(j));  % Move in positive direction
            fx = f(x);
            
            if fx < fc
                while fx < fc
                    xc(j) = x(j);   % Update current point
                    fc = fx;
                    x(j) = min(xc(j) + lambda, u(j));  % Continue moving in positive direction
                    fx = f(x);
                end
                m = 1;  % Set the movement flag
            else
                x(j) = max(xc(j) - lambda, l(j));  % Move in negative direction
                fx = f(x);
                
                if fx < fc
                    while fx < fc
                        xc(j) = x(j);   % Update current point
                        fc = fx;
                        x(j) = max(xc(j) - lambda, l(j));  % Continue moving in negative direction
                        fx = f(x);
                    end
                    m = 1;  % Set the movement flag
                end
            end
            
            x(j) = xc(j);  % Reset the j-th variable to its original value
        end
        
        if m < 1         
            lambda = lambda / 2;  % Reduce lambda if no movement occurred
        end
    end
    
    x = xc;   % Set the final optimal solution
    fx = f(x);  % Set the value of the objective function at the optimal solution
end
