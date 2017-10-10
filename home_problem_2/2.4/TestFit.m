functionData = LoadFunctionData();

xValues = functionData(:,1);
yValues = functionData(:,2);
nPoints = length(xValues);

estimatedValues = BestFitFunction(xValues);

differenceSquared = (estimatedValues-yValues).^2;
error = sqrt(sum(differenceSquared)/nPoints);

hold on
plot(xValues, yValues)
plot(xValues, estimatedValues, 'r--')
legend('original data', 'approximation')
title('Comparison between original data and best approximation')
xlabel('x')
ylabel('y')

fprintf('Error: %s\n', error)