clearvars, close all

cityLocations = LoadCityLocations();

populationSize = 100;
mutationProbability = 2/50;
tournamentSelectionParameter = 0.7;    
tournamentSize = 2;
numberOfGenerations = 50000;
elitismParameter = 1;

nCities = size(cityLocations,1);

tspFigure = InitializeTspPlot(cityLocations,[0 20 0 20]); 
connection = InitializeConnections(cityLocations); 

population = InitializePopulation(populationSize, nCities);

fitness = zeros(populationSize,1);

bestFitness = 0;
bestPath = zeros(1,nCities);
bestDistance = 0;

for iGeneration = 1:numberOfGenerations
    maximumFitness = 0.0;
    bestTravelOrder = zeros(1,nCities);
    bestIndividualIndex = 0;
    for i = 1:populationSize
        chromosome = population(i,:);
        travelOrder = chromosome;
        fitness(i) = EvaluateIndividual(travelOrder, cityLocations);
        if fitness(i) > maximumFitness
            maximumFitness = fitness(i);
            bestIndividualIndex = i;
            bestTravelOrder = travelOrder;
        end
    end

    tempPopulation = population;

    for i = 1:2:populationSize
        i1 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
        i2 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
        chromosome1 = population(i1, :);
        chromosome2 = population(i2, :);
        tempPopulation(i,:) = chromosome1;
        tempPopulation(i+1,:) = chromosome2;
    end

    for i = 1:populationSize
        originalChromosome = tempPopulation(i,:);
        mutatedChromosome = Mutate(originalChromosome,mutationProbability);
        tempPopulation(i,:) = mutatedChromosome;
    end

    bestIndividual = population(bestIndividualIndex,:);
    population = InsertBestIndividual(tempPopulation, bestIndividual, elitismParameter);
    
    if maximumFitness > bestFitness
        bestFitness = maximumFitness;
        bestPath = bestTravelOrder;
        bestDistance = CalculateTotalDistance(bestTravelOrder, cityLocations);
        fprintf('Generation %d. Best Distance: %.4f\n', iGeneration, bestDistance);
        PlotPath(connection, cityLocations, bestTravelOrder);
    end
end

fprintf('Length of shortest path: %d\n', bestDistance);
fprintf('Fitness of shortest path: %d\n', maximumFitness);
