tic
minChromosomeInstructions = 1;
maxChromosomeInstructions = 100;
maxChromosomeLength = 100 * 4;
fitnessPenalty = 0.9;
populationSize = 50;
mutationProbabilityFactor = 1;
% mutationProbability = 0.05;
% mutationMultiplier = 1.01;
% diversityThreshold = 0.42;
crossoverProbability = 0.7;
numberOfGenerations = 100000;
tournamentSelectionParameter = 0.8;
tournamentSize = 4;
elitismParameter = 4;
nOperators = 4;
nVariableRegisters = 4;
constantRegisters = [1,2,3,10];

functionData = LoadFunctionData();
nConstantRegisters = length(constantRegisters);

population = InitializePopulation(populationSize, minChromosomeInstructions, maxChromosomeInstructions, nOperators, nVariableRegisters, nConstantRegisters);

previousBestChromosome = load('bestChromosome.mat');
population(1).Chromosome = previousBestChromosome.bestChromosome;

fitness = zeros(populationSize,1);

bestFitness = 0;
bestOverallChromosome = [];

for iGeneration = 1:numberOfGenerations
    maximumFitness = 0.0;
    bestChromosome = [];
    bestIndividualIndex = 0;
    for i = 1:populationSize
        chromosome = population(i).Chromosome;
        fitness(i) = EvaluateIndividual(chromosome, functionData, constantRegisters, nVariableRegisters, maxChromosomeLength, fitnessPenalty);
        if isnan(fitness(i))
            disp('warning')
            raise
        end
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
            tempPopulation(i).Chromosome = newChromosomePair(1).Chromosome;
            tempPopulation(i+1).Chromosome = newChromosomePair(2).Chromosome;
        else
            tempPopulation(i).Chromosome = chromosome1;
            tempPopulation(i+1).Chromosome = chromosome2;
        end
    end

    for i = 1:populationSize
        originalChromosome = tempPopulation(i).Chromosome;
        mutationProbability = mutationProbabilityFactor/length(originalChromosome);
        mutatedChromosome = Mutate(originalChromosome, mutationProbability, nOperators, nVariableRegisters, nConstantRegisters);
        tempPopulation(i).Chromosome = mutatedChromosome;
    end

    bestIndividual = population(bestIndividualIndex).Chromosome;
    population = InsertBestIndividual(tempPopulation, bestIndividual, elitismParameter);
        
%     mutationProbability = UpdateMutationProbability(mutationProbability, population, mutationMultiplier, diversityThreshold, nOperators, nVariableRegisters, nConstantRegisters);
%     disp(mutationProbability)
    
    if mod(iGeneration, 1000) == 0
        toc
        tic
        totalLength = 0;
        medianError = median(1./fitness);
        for iChromosome = 1:populationSize
            totalLength = totalLength + length(population(iChromosome).Chromosome);
        end
        meanLength = totalLength / populationSize;
        fprintf('Generation %d. Median error: %.4f. Average chromosome length: %.1f\n', iGeneration, medianError, meanLength);
        figure(2)
        PlotAll(population, functionData, constantRegisters, nVariableRegisters);
    end

    if maximumFitness > bestFitness
        bestFitness = maximumFitness;
        fprintf('Generation %d. Best error: %.4f. Chromosome length: %d\n', iGeneration, 1/bestFitness, length(bestChromosome));
        bestOverallChromosome = bestChromosome;
%         disp(bestOverallChromosome);
        figure(1)
        PlotAll(population(1), functionData, constantRegisters, nVariableRegisters);
    end
end
