function [xBest, maximumFitness] = RunGeneticAlgorithm(populationSize, crossoverProbability, mutationProbability, tournamentSelectionParameter, tournamentSize)

    % fixed parameters for this GA
    numberOfGenerations = 200;
    numberOfGenes = 50;
    numberOfVariables = 2;
    variableRange = 5.0;
    elitismParameter = 1;

    fitness = zeros(populationSize,1);

    population = InitializePopulation(populationSize, numberOfGenes);

    for iGeneration = 1:numberOfGenerations

        maximumFitness = 0.0;
        xBest = zeros(1,2);
        bestIndividualIndex = 0;
        for i = 1:populationSize
            chromosome = population(i,:);
            x = DecodeChromosome(chromosome, numberOfVariables, variableRange);
            fitness(i) = EvaluateIndividual(x);
            if fitness(i) > maximumFitness
                maximumFitness = fitness(i);
                bestIndividualIndex = i;
                xBest = x;
            end
        end

        tempPopulation = population;

        for i = 1:2:populationSize
            i1 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
            i2 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
            chromosome1 = population(i1, :);
            chromosome2 = population(i2, :);

            r = rand;
            if (r < crossoverProbability)
                newChromosomePair = Cross(chromosome1, chromosome2);
                tempPopulation(i,:) = newChromosomePair(1,:);
                tempPopulation(i+1,:) = newChromosomePair(2,:);
            else
                tempPopulation(i,:) = chromosome1;
                tempPopulation(i+1,:) = chromosome2;
            end
        end

        for i = 1:populationSize
            originalChromosome = tempPopulation(i,:);
            mutatedChromosome = Mutate(originalChromosome,mutationProbability);
            tempPopulation(i,:) = mutatedChromosome;
        end

        bestIndividual = population(bestIndividualIndex,:);
        population = InsertBestIndividual(tempPopulation, bestIndividual, elitismParameter);

    end
    
end

