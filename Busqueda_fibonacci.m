% Busqueda_fibonacci - Fibonacci Search Algorithm
%
% This function implements the Fibonacci search algorithm to find an approximate minimum of a given function
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

function [x, fx] = Busqueda_fibonacci(f, a, b, e, d)
    L = b - a;  % Initial interval length
    F = [1 1];  % Initialize the Fibonacci sequence
    
    I = 2;
    while F(I) < L / e
        I = I + 1;
        F(I) = F(I - 1) + F(I - 2);  % Generate Fibonacci sequence
    end
    
    i = 1;  % Initialize the iteration count
    
    if I > 2
        xa = a + F(I - 2) / F(I) * (b - a);  % Calculate xa using Fibonacci ratio
        fa = f(xa);
        xb = b - F(I - 2) / F(I) * (b - a);  % Calculate xb using Fibonacci ratio
        fb = f(xb);
        
        while i < I - 3
            if fa < fb
                b = xb;
                xb = xa;
                fb = fa;
                xa = a + F(I - i - 2) / F(I - i) * (b - a);
                fa = f(xa);
            elseif fa > fb
                a = xa;
                xa = xb;
                fa = fb;
                xb = b - F(I - i - 2) / F(I - i) * (b - a);
                fb = f(xb);
            else
                a = xa;
                b = xb;
                i = i + 2;
                
                if i < I - 2
                    xa = a + F(I - i - 2) / F(I - i) * (b - a);
                    fa = f(xa);
                    xb = b - F(I - i - 2) / F(I - i) * (b - a);
                    fb = f(xb);
                end
            end
            
            i = i + 1;
        end
        
        if i == I - 2
            if fa < fb
                b = xb;
                i = i + 1;
            elseif fa > fb
                a = xa;
                i = i + 1;
            else
                a = xa;
                b = xb;
                i = i + 2;
            end
        end
    end
    
    if i == I - 1
        xa = (a + b - d) / 2;
        xb = (a + b + d) / 2;
        
        if f(xa) <= f(xb)
            b = xb;
        else
            a = xa;
        end
    end
    
    x = (a + b) / 2;  % Calculate the approximation of the minimum
    fx = f(x);        % Calculate the value of the function at the approximate minimum
end
