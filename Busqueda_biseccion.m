% Busqueda_biseccion - Bisection Search Algorithm
%
% This function implements the bisection search algorithm to find an approximate root of a given function
% within a given interval [a, b], up to a specified tolerance 'epsilon'.
%
% Input:
%   f: Objective function for which the root is sought.
%   a: Lower bound of the interval.
%   b: Upper bound of the interval.
%   epsilon: Tolerance level ε > 0.
%
% Output:
%   x: Approximation of the root of the function.
%   fx: Value of the function at the approximate root.

function [x, fx] = Busqueda_biseccion(f, a, b, epsilon)
    L = b - a;  % Initial interval length
    
    while L > epsilon
        c = (a + b) / 2;  % Calculate the midpoint of the interval
        
        % Calculate the derivative approximation at c using finite differences
        fp = (f(c + epsilon) - f(c - epsilon)) / (2 * epsilon);
        
        if fp > 0
            b = c;  % Update the interval upper bound
        elseif fp < 0
            a = c;  % Update the interval lower bound
        else
            break;  % Exit the loop if derivative approximation is zero
        end
        
        L = b - a;  % Update the interval length
    end
    
    x = (a + b) / 2;  % Calculate the approximation of the root
    fx = f(x);        % Calculate the value of the function at the approximate root
end
