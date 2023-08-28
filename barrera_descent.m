% barrera_descent - Constrained Optimization using Barrier Function Approach with Steepest Descent
%
% This function implements a constrained optimization technique using the barrier function approach,
% enhanced with the use of steepest descent optimization. Given an objective function, lower and
% upper bounds, an initial point, a tolerance level, a penalty parameter, a set of constraint functions,
% and a gradient step size 'delta', this function aims to find an optimal solution while satisfying
% the constraints by iteratively modifying the objective function with barrier terms and utilizing
% steepest descent optimization.
%
% Input:
%   f: Objective function to be optimized.
%   l: Lower bounds for optimization variables.
%   u: Upper bounds for optimization variables.
%   x1: Initial point for optimization.
%   e: Tolerance level for stopping the optimization.
%   lambda: Penalty parameter for the barrier function approach.
%   rest: Cell array containing constraint functions.
%   delta: Gradient step size.
%
% Output:
%   xsol: Optimal solution.
%   fxsol: Value of the objective function at the optimal solution.

function [xsol, fxsol] = barrera_descent(f, l, u, x1, e, lambda, rest, delta)
    [x, fx] = steepest_descent(f, l, u, x1, e, lambda, delta);  % Calculate optimal step using steepest descent
    mu = 100;   % Initialize barrier parameter
    i = 0;      % Counter for consecutive iterations with no improvement
    
    while i < 5
        fh = f;          % Copy of the objective function
        current_rest = rest;  % Store the initial set of constraint functions
        
        % Incorporate barrier terms for each constraint function
        for j = 1:length(current_rest)
            fh = @(u) fh(u) + mu * current_rest{j}(u);
        end
        
        [xh, fxh] = steepest_descent(fh, l, u, x1, e, lambda, delta); % Calculate optimal step with barriers using steepest descent
        
        % Check the conditions for increasing the counter i
        if mu == 100 || fh(x) - fxh < e
            i = i + 1;
        else
            x = xh;     % Update x with the new solution
            fx = fxh;   % Update fx with the new function value
            i = 0;      % Reset the consecutive non-improvement count
        end
        
        mu = mu / 10;   % Decrease the barrier parameter
        
        % Check if the barrier parameter has become too small
        if mu < 10^-50
            break;      % Exit the loop if the parameter becomes too small
        end
        
        if length(l) == 2
            % If optimizing in 2D, visualize the function and the current optimal point
            rx = [l(1), u(1)];
            ry = [l(2), u(2)];
            
            ffh = @(u) f(u);
            for j = 1:length(current_rest)
                ffh = @(u) ffh(u) + mu * current_rest{j}(u);
            end
            
            % Draw the function and the optimal point for a short period
            dibujar_funcion(ffh, rx, ry, 250, [x(2)], [x(1)]);
            pause(0.5);
            
            if i < 5
                clf;  % Clear the drawing except for the last step
            end
        end
    end
    
    xsol = x;   % Set the final optimal solution
    fxsol = fx; % Set the value of the objective function at the optimal solution
end
