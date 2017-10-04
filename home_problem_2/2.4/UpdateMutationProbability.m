function mutationProbability = UpdateMutationProbability(mutationProbability, population, mutationMultiplier, diversityThreshold, nOperators, nVariableRegisters, nConstantRegisters)

    nChromosomes = length(population);

    diversity = 0;
    
    ranges = [nOperators, nVariableRegisters, nVariableRegisters + nConstantRegisters, nVariableRegisters + nConstantRegisters];
    meanRange = mean(ranges);
    
    for i = 1:nChromosomes
        for j = i+1:nChromosomes
            chromosome1 = population(i).Chromosome;
            chromosome2 = population(j).Chromosome;
            l1 = length(chromosome1);
            l2 = length(chromosome2);
            if l1 + l2 == 0
                continue
            elseif l1 > l2
                maxNGenes = l1;
                chromosome2(l1) = 0;
            elseif l2 > l1
                maxNGenes = l2;
                chromosome1(l2) = 0;
            else
                maxNGenes = l1;
            end
            diversity = diversity + sum(abs(chromosome1 - chromosome2)) / maxNGenes / meanRange;  
        end
    end
    
    diversity = 2/(nChromosomes * (nChromosomes-1)) * diversity
    if diversity < diversityThreshold
        mutationProbability = mutationProbability * mutationMultiplier;
    else
        mutationProbability = mutationProbability / mutationMultiplier;
    end
    
end
