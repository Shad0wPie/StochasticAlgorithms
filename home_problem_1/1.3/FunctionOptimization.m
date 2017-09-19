clear all

% Parameters that we are allowed to vary
populationSize = 20;
crossoverProbability = 0.8;
mutationProbability = 0.1;
tournamentSelectionParameter = 0.75;    
tournamentSize = 2;

numberOfRuns = 1;

xValues = zeros(numberOfRuns,2);
fValues = zeros(numberOfRuns,1);
for iRun = 1:numberOfRuns
    [xBest, maximumFitness] = RunGeneticAlgorithm(populationSize, crossoverProbability, mutationProbability, tournamentSelectionParameter, tournamentSize);
    xValues(iRun,:) = xBest;
    fValues(iRun) = EvaluateFunction(xBest);
end

if numberOfRuns == 1
    disp('Best point:')
    disp(xValues)
    disp('Function value in best point:')
    disp(fValues)
elseif numberOfRuns > 1
    xMean = mean(xValues);
    xMedian = median(xValues);
    xStandardDeviation = std(xValues);
    fMean = mean(fValues);
    fMedian = median(fValues);
    fStandardDeviation = std(fValues);

    disp('mean optimum location')
    disp(xMean)
    disp('median optimum location')
    disp(xMedian)
    disp('standard deviation of optimum location')
    disp(xStandardDeviation)
    disp('mean optimum value')
    disp(fMean)
    disp('median optimum value')
    disp(fMedian)
    disp('standard deviation of optimum value')
    disp(fStandardDeviation)
end