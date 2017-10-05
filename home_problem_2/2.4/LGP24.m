syms x;
tic
minChromosomeInstructions = 1;
maxChromosomeInstructions = 20;
maxChromosomeLength = 50 * 4;
fitnessPenalty = 0.995;
populationSize = 100;
mutationProbabilityFactor = 2;
crossoverProbability = 0.6;
tournamentSelectionParameter = 0.9;
tournamentSize = 4;
elitismParameter = 4;
nOperators = 4;
nVariableRegisters = 6;
constantRegisters = [1,2,3];

functionData = LoadFunctionData();
nConstantRegisters = length(constantRegisters);

population = InitializePopulation(populationSize, minChromosomeInstructions, maxChromosomeInstructions, nOperators, nVariableRegisters, nConstantRegisters);

fitness = zeros(populationSize,1);

bestFitness = 0;
bestOverallChromosome = [];

iGeneration = 0;
while bestFitness < 100
    iGeneration = iGeneration + 1;
    maximumFitness = 0.0;
    bestChromosome = [];
    bestIndividualIndex = 0;
    for i = 1:populationSize
        chromosome = population(i).Chromosome;
        fitness(i) = EvaluateIndividual(chromosome, functionData, constantRegisters, nVariableRegisters, maxChromosomeLength, fitnessPenalty);
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
        figure(1)
        PlotAll(population(1), functionData, constantRegisters, nVariableRegisters);
        disp(simplify(DecodeChromosome(bestChromosome, x, constantRegisters, nVariableRegisters)))
    end
end
