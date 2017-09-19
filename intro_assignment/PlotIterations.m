function PlotIterations( polynomialCoefficients, iterates )
%PlotIterations Visually displays the result of Newton-Raphson optimisation

x = linspace(min(iterates), max(iterates));
y = zeros(size(x));
for i = 1:numel(x)
    y(i) = Polynomial(x(i), polynomialCoefficients);
end

iterateYValues = zeros(size(iterates));
for i = 1:numel(iterates)
    iterateYValues(i) = Polynomial(iterates(i), polynomialCoefficients);
end

hold on
plot(x,y)
plot(iterates, iterateYValues, 'ro')