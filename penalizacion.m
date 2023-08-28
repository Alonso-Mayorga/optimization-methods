% penalizacion - Constrained Optimization using Penalty Function Approach
%
% This function implements a constrained optimization technique using the penalty function approach.
% Given an objective function, lower and upper bounds, a tolerance level, a penalty parameter, a set
% of constraint functions, and the number of iterations, this function aims to find an optimal
% solution while satisfying the constraints by iteratively modifying the objective function with
% penalty terms.
%
% Input:
%   f: Objective function to be optimized.
%   l: Lower bounds for optimization variables.
%   u: Upper bounds for optimization variables.
%   e: Tolerance level for stopping the optimization.
%   lambda: Penalty parameter for the penalty function approach.
%   rest: Cell array containing constraint functions.
%   it: Number of iterations.
%
% Output:
%   x: Optimal solution.
%   fx: Value of the objective function at the optimal solution.

function [x, fx] = penalizacion(f, l, u, e, lambda, rest, it)
    [x, fx] = random_walk(f, l, u, e, lambda, it);  % Initialize x and fx using random_walk function
    mu = 0.01;  % Initialize penalty parameter
    i = 0;      % Counter for consecutive iterations with no improvement
    
    while i < 5
        fh = f;          % Copy of the objective function
        current_rest = rest;  % Store the initial set of constraint functions
        
        % Incorporate penalty terms for each constraint function
        for j = 1:length(current_rest)
            fh = @(u) fh(u) + mu * current_rest{j}(u);
        end
        
        [xh, fxh] = random_walk(fh, l, u, e, lambda, it);  % Optimize the modified function
        
        if abs(fh(x) - fxh) < e
            i = i + 1;  % Increase the consecutive non-improvement count
        else
            x = xh;     % Update x with the new solution
            fx = fxh;   % Update fx with the new function value
            i = 0;      % Reset the consecutive non-improvement count
        end
        
        mu = mu * 10;   % Increase the penalty parameter
        
        % Check if the penalty parameter has grown too large
        if mu > 10^50
            break;      % Exit the loop if the parameter becomes too large
        end
        
        if length(l) == 2
            % If optimizing in 2D, visualize the function and the current optimal point
            rx = [l(1), u(1)];
            ry = [l(2), u(2)];
            
            ffh = @(u) f(u);
            for j = 1:length(current_rest)
                ffh = @(u) min(ffh(u) + mu * min(current_rest{j}(u), 1), mu);
            end
            
            % Draw the function and the optimal point for a short period
            dibujar_funcion(ffh, rx, ry, 250, [x(2)], [x(1)]);
            pause(0.5);
            
            if i < 5
                clf;  % Clear the drawing except for the last step
            end
        end
    end
end
