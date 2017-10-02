function selectedIndex = RandomWeightedSelection(weights)

    nWeights = length(weights);
    
    totalWeight = sum(weights);
    
    if totalWeight == 0
        selectedIndex = 1 + fix(rand*nWeights);
        return
    end
    
    probabilities = zeros(1,nWeights);
    cumulativeProbability = 0;
    
    for i= 1:nWeights
        probability = weights(i)/totalWeight;
        cumulativeProbability = cumulativeProbability + probability;
        probabilities(i) = cumulativeProbability;
    end
    selectedIndex = find(probabilities >= rand, 1);
end
