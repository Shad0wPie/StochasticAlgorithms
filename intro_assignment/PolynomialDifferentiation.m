function [ derivativeCoefficients ] = PolynomialDifferentiation( coefficients, degree )
%PolynomialDifferentiation calculates the derivative of a given polynomial

if degree == 0
    derivativeCoefficients = coefficients;
elseif length(coefficients) == 1
    derivativeCoefficients = 0;
else
    constantFactor = linspace(1,length(coefficients)-1, length(coefficients)-1);
    tempCoefficients = coefficients(2:end).*constantFactor;
    derivativeCoefficients = PolynomialDifferentiation(tempCoefficients, degree-1);
end
end
