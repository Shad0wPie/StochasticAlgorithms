function population = InitializePopulation(populationSize, nInputNeurons, nHiddenNeurons, nOutputNeurons, weightInitializingInterval)

    population = [];
    for i = 1:populationSize
        weights = InitializeWeights(weightInitializingInterval, nInputNeurons, nHiddenNeurons, nOutputNeurons);
        chromosome = [reshape(weights{1},1,(nInputNeurons+1)*nHiddenNeurons), reshape(weights{2},1,(nHiddenNeurons+1)*nOutputNeurons)];
        tmpIndividual = struct('Chromosome',chromosome);
        population = [population tmpIndividual];
    end
end