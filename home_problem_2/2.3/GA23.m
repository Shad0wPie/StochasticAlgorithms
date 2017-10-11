% Tweakable parameters
nHiddenNeurons = 7;
weightInitializingInterval = [-7 7];
timeStep = 0.25;
populationSize = 100;
mutationProbabilityFactor = 2;
creepRate = 1;
crossoverProbability = 0.8;
tournamentSelectionParameter = 0.75;
tournamentSize = 2;
elitismParameter = 2;
maxGenerationsWithoutValidationFitnessIncrease = 100;

% Fixed parameters
nInputNeurons = 3;
nOutputNeurons = 2;
iTrainingSet = 1;
nTrainingSlopes = 10;
iValidationSet = 2;
nValidationSlopes = 5;
iTestSet = 3;
nTestSlopes = 5;

population = InitializePopulation(populationSize, nInputNeurons, nHiddenNeurons, nOutputNeurons, weightInitializingInterval);
mutationProbability = mutationProbabilityFactor/length(population(1).Chromosome);

fitness = zeros(populationSize,1);

bestFitness = 0;
bestOverallChromosome = [];
bestValidationChromosome = [];
bestValidationFitness = 0;

trainingFitnesses = [];
validationFitnesses = [];

bStartedOverfitting = false;
iGeneration = 0;
generationsSinceValidationFitnessIncrease = 0;
while ~bStartedOverfitting
    iGeneration = iGeneration + 1;
    generationsSinceValidationFitnessIncrease = generationsSinceValidationFitnessIncrease + 1;
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
            
    validationFitness = EvaluateIndividual(bestChromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons, timeStep, nValidationSlopes, iValidationSet);
    trainingFitnesses = [trainingFitnesses, maximumFitness];
    validationFitnesses = [validationFitnesses, validationFitness];
    
    if maximumFitness > bestFitness
        bestFitness = maximumFitness;
        if validationFitness > bestValidationFitness
            bestValidationChromosome = bestChromosome;
            bestValidationFitness = validationFitness;
            generationsSinceValidationFitnessIncrease = 0;
        end
        fprintf('Generation %d. New best! Training fitness: %.4f. Validation fitness: %.4f\n', iGeneration, bestFitness, validationFitness);
        bestOverallChromosome = bestChromosome;
    end
    if generationsSinceValidationFitnessIncrease > maxGenerationsWithoutValidationFitnessIncrease
        bStartedOverfitting = true;
    end
end

hold on
generations = 1:iGeneration;
plot(generations, trainingFitnesses);
plot(generations, validationFitnesses);
legend('training fitness', 'validation fitness');
title('Fitness over generations')

testFitness = EvaluateIndividual(bestValidationChromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons, timeStep, nTestSlopes, iTestSet);
fprintf('\nValidation fitness: %.4f, test fitness: %.4f', bestValidationFitness, testFitness)
