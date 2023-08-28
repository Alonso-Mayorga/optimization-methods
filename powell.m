% powell - Powell's Method Optimization Algorithm
%
% This function implements Powell's Method optimization algorithm to find an optimal solution of a given
% function within a specified interval [l, u]. The algorithm iteratively performs conjugate directions search
% to find a better estimate of the optimal solution.
%
% Input:
%   f: Objective function to be optimized.
%   l, u: Lower and upper bounds for optimization.
%   x1: Initial point for optimization.
%   e: Tolerance level for stopping the optimization.
%   lambda: Step size for moving along the search direction.
%
% Output:
%   x: Optimal solution.
%   fx: Value of the objective function at the optimal solution.

function [x, fx] = powell(f, l, u, x1, e, lambda)
    J = 1;  % Initialize the index J
    xc = x1;  % Set the initial point xc
    fc = f(xc);  % Calculate the value of the objective function at xc
    n = length(l);  % Number of variables
    d = {};  % Initialize the set of search directions
    
    % Generate the set of search directions
    for i = 1:n
        nuevo = zeros(n, 1);
        nuevo(i) = 1;
        d{end+1} = nuevo;
    end
    
    while lambda > e
        m = 0; x0 = xc;
        for j = 1:n
            for k = 1:n
                x(k) = min(max(xc(k) + lambda * d{j}(k), l(k)), u(k));
            end
            fx = f(x);
            
            if fx < fc
                while fx < fc
                    xc = x; fc = fx;
                    for k = 1:n
                        x(k) = min(max(xc(k) + lambda * d{j}(k), l(k)), u(k));
                    end
                    fx = f(x);
                end
                m = 1;
            else
                for k = 1:n
                    x(k) = min(max(xc(k) - lambda * d{j}(k), l(k)), u(k));
                end
                fx = f(x);
                
                if fx < fc
                    while fx < fc
                        xc = x; fc = fx;
                        for k = 1:n
                            x(k) = min(max(xc(k) - lambda * d{j}(k), l(k)), u(k));
                        end
                        fx = f(x);
                    end
                    m = 1;
                end
            end
        end
        
        if m < 1         
            lambda = lambda / 2;
        else
            d{j} = (xc - x0) / norm(xc - x0);  % Update the search direction
            if J < n
                J = J + 1;
            else
                J = 1;
            end
        end
    end
    
    x = xc;  % Set the optimal solution
    fx = f(xc);  % Calculate the value of the objective function at the optimal solution
end
