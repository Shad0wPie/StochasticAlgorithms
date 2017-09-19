function [ functionValue ] = Polynomial( xValue, coefficients )
%Polynomial Calculates the value of a polynomial given the coefficients

powerVector = linspace(0, length(coefficients)-1, length(coefficients));
functionValue = coefficients*(xValue.^powerVector)';

end
