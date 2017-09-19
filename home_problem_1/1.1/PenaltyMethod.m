stepLength = 1e-6;
threshold = 1e-5;
mu_values = [1, 10, 100, 1e3, 1e4, 1e5];
startingPoint = [1,2];

minima = zeros(numel(mu_values),4);
for i = 1:numel(mu_values)
    minima(i,1) = mu_values(i);
    x = GradientDescent(startingPoint, mu_values(i), stepLength, threshold);
    minima(i,2:3) = x;
    minima(i,4) = norm(x);
end

array2table(minima, 'VariableNames', {'mu', 'x1', 'x2', 'length'})