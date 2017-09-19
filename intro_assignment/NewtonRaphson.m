function [ iterates ] = NewtonRaphson( polynomialCoefficients, startingPoint, tolerance )
%NewtonRaphson Finds the minumum of a polynomial function
%   Uses the Newton-Raphson method to compute a minimum (not necessarily
%   global) of a polynomial function with the given coefficients.

firstDerivativeCoefficients = PolynomialDifferentiation(polynomialCoefficients, 1);
secondDerivativeCoefficients = PolynomialDifferentiation(polynomialCoefficients, 2);
iterates = startingPoint;
hasNotReachedTolerance = true;
while hasNotReachedTolerance
    x = iterates(end);
    firstDerivative = Polynomial(x, firstDerivativeCoefficients);
    secondDerivative = Polynomial(x, secondDerivativeCoefficients);
    newX = NewtonRaphsonStep(x, firstDerivative, secondDerivative);
    iterates = [iterates, newX];
    if isnan(newX)
        disp("Can't continue with NewtonRapshon method. Second derivative is zero!");
        break
    end
    hasNotReachedTolerance = abs(x - newX) > tolerance;
end
end

