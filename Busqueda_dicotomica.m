% Busqueda_dicotomica - Dichotomous Search Algorithm
%
% This function implements the dichotomous search algorithm to find an approximate minimum of a given function
% within a given interval [a, b], up to a specified tolerance 'e'.
%
% Input:
%   f: Objective function for which the minimum is sought.
%   a: Lower bound of the interval.
%   b: Upper bound of the interval.
%   e: Tolerance level for stopping the search.
%   d: Initial interval length.
%
% Output:
%   x: Approximation of the minimum of the function.
%   fx: Value of the function at the approximate minimum.

function [x, fx] = Busqueda_dicotomica(f, a, b, e, d)
    L = b - a;  % Initial interval length
    
    while L > e
        xa = (a + b - e) / 2;  % Calculate xa as left endpoint of new interval
        xb = (a + b + e) / 2;  % Calculate xb as right endpoint of new interval
        
        if f(xa) < f(xb)
            b = xb;  % Update the interval upper bound
        else
            a = xa;  % Update the interval lower bound
        end
        
        L = (L + d) / 2;  % Update the interval length
    end
    
    x = (a + b) / 2;  % Calculate the approximation of the minimum
    fx = f(x);        % Calculate the value of the function at the approximate minimum
end
