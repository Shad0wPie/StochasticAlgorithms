function population = InitializePopulation(populationSize, nInputNeurons, nHiddenNeurons, nOutputNeurons, weightInitializingInterval)

    population = [];
    for i = 1:populationSize
        weights = InitializeWeights(weightInitializingInterval, nInputNeurons, nHiddenNeurons, nOutputNeurons);
        chromosome = [reshape(weights{1},1,nInputNeurons*nHiddenNeurons), reshape(weights{2},1,nHiddenNeurons*nOutputNeurons)];
        tmpIndividual = struct('Chromosome',chromosome);
        population = [population tmpIndividual];
    end
end