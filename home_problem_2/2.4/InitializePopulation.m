function population = InitializePopulation(populationSize,minChromosomeInstructions,maxChromosomeInstructions, nOperators, nVariableRegisters, nConstantRegisters)

    population = [];
    for i = 1:populationSize
        nInstructions = minChromosomeInstructions + fix(rand*(maxChromosomeInstructions-minChromosomeInstructions+1));
        tmpChromosome = InitializeChromosome(nInstructions, nOperators, nVariableRegisters, nConstantRegisters);
        tmpIndividual = struct('Chromosome',tmpChromosome);
        population = [population tmpIndividual];
end