% Busqueda_aurea - Golden Section Search Algorithm
%
% This function implements the golden section search algorithm to find the minimum of a given function
% within a given interval [a, b], up to a specified tolerance 'e'.
%
% Input:
%   f: Objective function to be minimized.
%   a: Lower bound of the interval.
%   b: Upper bound of the interval.
%   e: Tolerance level for stopping the search.
%
% Output:
%   x: Estimated location of the minimum.
%   fx: Value of the objective function at the estimated minimum.

function [x, fx] = Busqueda_aurea(f, a, b, e)
    phi = (1 + sqrt(5)) / 2;  % Golden ratio
    L = (b - a) / phi;  % Initial interval length
    
    if L * phi > e
        xa = b - L; fa = f(xa);  % Calculate the function value at xa
        xb = a + L; fb = f(xb);  % Calculate the function value at xb
    end
    
    while L > e
        L = L / phi;  % Reduce the interval length
        
        if fa < fb
            b = xb; xb = xa; fb = fa;  % Update interval boundaries and function values
            xa = b - L; fa = f(xa);     % Calculate the function value at xa
        elseif fa > fb
            a = xa; xa = xb; fa = fb;  % Update interval boundaries and function values
            xb = a + L; fb = f(xb);     % Calculate the function value at xb
        else
            a = xa; b = xb; L = L / (phi^2);  % Update interval boundaries and reduce interval length
            if L * phi > e
                xa = b - L; fa = f(xa);  % Calculate the function value at xa
                xb = a + L; fb = f(xb);  % Calculate the function value at xb
            end
        end
    end
    
    if L * phi > e
        if fa <= fb
            b = xb;  % Choose the new interval boundary based on function values
        else
            a = xa;  % Choose the new interval boundary based on function values
        end
    end
    
    x = (a + b) / 2;  % Calculate the estimated location of the minimum
    fx = f(x);        % Calculate the value of the objective function at the estimated minimum
end
