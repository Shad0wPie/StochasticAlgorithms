polynomialCoefficients = [2,1,1];
startingPoint = 2;
tolerance = 0.0001;
iterationValues = NewtonRaphson(polynomialCoefficients, startingPoint, tolerance);
if ~isnan(iterationValues(end))
    PlotIterations(polynomialCoefficients,iterationValues);
    disp("HI")
    fprintf("Convergence at: %d", iterationValues(end));
end