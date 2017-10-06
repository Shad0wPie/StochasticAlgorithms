tic
% Tweakable parameters
nHiddenNeurons = 7;
weightInitializingInterval = [-5 5];
timeStep = 0.3;
populationSize = 50;
mutationProbabilityFactor = 5;
creepRate = 0.25;
crossoverProbability = 0.8;
tournamentSelectionParameter = 0.75;
tournamentSize = 2;
elitismParameter = 1;
nGenerations = 100000;
iTrainingSet = 1;
nTrainingSlopes = 10;
iValidationSet = 2;
nValidationSlopes = 1;

% Fixed parameters (by the problem)
nInputNeurons = 4;  % 3 inputs + bias 
nOutputNeurons = 2;

population = InitializePopulation(populationSize, nInputNeurons, nHiddenNeurons, nOutputNeurons, weightInitializingInterval);
mutationProbability = mutationProbabilityFactor/length(population(1).Chromosome);

fitness = zeros(populationSize,1);

bestFitness = 0;
bestOverallChromosome = [];

% iGeneration = 0;
for iGeneration = 1:nGenerations
%     iGeneration = iGeneration + 1;
    maximumFitness = 0.0;
    bestChromosome = [];
    bestIndividualIndex = 0;
    for i = 1:populationSize
        chromosome = population(i).Chromosome;
        fitness(i) = EvaluateIndividual(chromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons, timeStep, nTrainingSlopes, iTrainingSet);
        if fitness(i) > maximumFitness
            maximumFitness = fitness(i);
            bestIndividualIndex = i;
            bestChromosome = chromosome;
        end
    end

    tempPopulation = population;

    for i = 1:2:populationSize
        i1 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
        i2 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
        chromosome1 = population(i1).Chromosome;
        chromosome2 = population(i2).Chromosome;
        
        r = rand;
        if (r < crossoverProbability)
            newChromosomePair = Cross(chromosome1, chromosome2);
            tempPopulation(i).Chromosome = newChromosomePair(1,:);
            tempPopulation(i+1).Chromosome = newChromosomePair(2,:);
        else
            tempPopulation(i).Chromosome = chromosome1;
            tempPopulation(i+1).Chromosome = chromosome2;
        end
    end

    for i = 1:populationSize
        originalChromosome = tempPopulation(i).Chromosome;
        mutatedChromosome = Mutate(originalChromosome, mutationProbability, creepRate);
        tempPopulation(i).Chromosome = mutatedChromosome;
    end

    bestIndividual = population(bestIndividualIndex).Chromosome;
    population = InsertBestIndividual(tempPopulation, bestIndividual, elitismParameter);
            
%     if mod(iGeneration, 1000) == 0
%         toc
%         tic
%         totalLength = 0;
%         medianError = median(1./fitness);
%         for iChromosome = 1:populationSize
%             totalLength = totalLength + length(population(iChromosome).Chromosome);
%         end
%         meanLength = totalLength / populationSize;
%         fprintf('Generation %d. Median error: %.4f. Average chromosome length: %.1f\n', iGeneration, medianError, meanLength);
%         figure(2)
%         PlotAll(population, functionData, constantRegisters, nVariableRegisters);
%     end

    if round(maximumFitness) > round(bestFitness)
        bestFitness = maximumFitness;
        validationFitness = EvaluateIndividual(chromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons, timeStep, nValidationSlopes, iValidationSet);
        fprintf('Generation %d. New best! Training fitness: %.4f. Validation fitness: %.4f\n', iGeneration, bestFitness, validationFitness);
        bestOverallChromosome = bestChromosome;
        VisualizeIndividual(bestChromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons, timeStep, 1, iValidationSet);
    end
end
