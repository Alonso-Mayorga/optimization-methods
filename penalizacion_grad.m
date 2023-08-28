% penalizacion_grad - Constrained Optimization using Penalty Function Approach with Gradient
%
% This function implements a constrained optimization technique using the penalty function approach,
% enhanced with the use of gradient information. Given an objective function, lower and upper bounds,
% an initial point, a tolerance level, a penalty parameter, a set of constraint functions, and a
% gradient step size 'delta', this function aims to find an optimal solution while satisfying the
% constraints by iteratively modifying the objective function with penalty terms and utilizing
% gradient conjugate optimization.
%
% Input:
%   f: Objective function to be optimized.
%   l: Lower bounds for optimization variables.
%   u: Upper bounds for optimization variables.
%   x1: Initial point for optimization.
%   e: Tolerance level for stopping the optimization.
%   lambda: Penalty parameter for the penalty function approach.
%   rest: Cell array containing constraint functions.
%   delta: Gradient step size.
%
% Output:
%   xh: Optimal solution.
%   fxh: Value of the objective function at the optimal solution.

function [xh, fxh] = penalizacion_grad(f, l, u, x1, e, lambda, rest, delta)
    [x, fx] = gradiente_conj(f, l, u, x1, e, lambda, delta);  % Calculate initial optimal step using gradient conjugate
    mu = 0.01;  % Initialize penalty parameter
    i = 0;
    a = 1; % Active while the effect of constraints is significant, our chosen stopping criterion
    
    while a == 1
        fh = f;  % Copy of the objective function
        
        % Create a new function with added penalties for constraints
        for j = 1:length(rest)
            fh = @(u) fh(u) + mu * rest{j}(u);
        end
        
        [xh, fxh] = gradiente_conj(fh, l, u, x1, e, lambda, delta); % Calculate optimal step with penalties using gradient conjugate
        
        x = xh; fx = fxh;
        mu = mu * 10;   % Increase the penalty parameter
        
        % Check if the penalty parameter has grown too large
        if mu > 10^50
            break;  % Exit the loop if the parameter becomes too large
        end
        
        a = 0; % Assume that the effect of constraints is not significant
        
        % Check if the effect of constraints is significant for stopping
        for j = 1:length(rest)
            if rest{j}(x) > e / length(rest)
                a = 1;
            end
        end
        
        if length(l) == 2
            % If optimizing in 2D, visualize the function and the current optimal point
            rx = [l(1), u(1)];
            ry = [l(2), u(2)];
            
            ffh = @(u) f(u);
            for j = 1:length(rest)
                ffh = @(u) min(ffh(u) + mu * min(rest{j}(u), 1), mu);
            end
            
            % Draw the function and the optimal point for a short period
            dibujar_funcion(ffh, rx, ry, 100, [x(2)], [x(1)]);
            pause(0.5);
            
            if a == 1
                clf;  % Clear the drawing except for the last step
            end
        end
    end
end
