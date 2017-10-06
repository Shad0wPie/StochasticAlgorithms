function fitness = EvaluateIndividual(chromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons, timeStep, nSlopes, iDataSet)

    weights = DecodeChromosome(chromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons);
    
    slopeFitness = zeros(1,nSlopes);
    for iSlope = 1:nSlopes
        [traveledDistance, simulationTime, ~] = RunTruckSimulation(weights, timeStep, iSlope, iDataSet, false);
        averageVelocity = traveledDistance / simulationTime;
        slopeFitness(iSlope) = traveledDistance + traveledDistance * (averageVelocity / 25);
    end
    fitness = min(slopeFitness) + mean(slopeFitness);
    
end