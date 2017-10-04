function fitness = EvaluateIndividual(chromosome, functionData, constantRegisters, nVariableRegisters, maxChromosomeLength, fitnessPenalty)

    xValues = functionData(:,1);
    yValues = functionData(:,2);
    nPoints = length(xValues);
    
    estimatedValues = DecodeChromosome(chromosome, xValues, constantRegisters, nVariableRegisters);

    differenceSquared = (estimatedValues-yValues).^2;
    error = sqrt(sum(differenceSquared)/nPoints);

    fitness = 1/error;
    chromosomeLength = length(chromosome);
    if chromosomeLength > maxChromosomeLength
        fitness = fitness * fitnessPenalty;
    end
    
end