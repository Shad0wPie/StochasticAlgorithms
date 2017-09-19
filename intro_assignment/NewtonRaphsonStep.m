function [ newX ] = NewtonRaphsonStep( xValue, firstDerivative, secondDerivative )
%NewtonRaphsonStep Carries out a single Newton-Raphson iteration

if secondDerivative == 0
    newX = NaN;
else
    newX = xValue - firstDerivative / secondDerivative;
end
end

