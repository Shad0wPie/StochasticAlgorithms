function mutatedChromosome = Mutate(chromosome, mutationProbability, nOperators, nVariableRegisters, nConstantRegisters)

    nGenes = size(chromosome, 2);
    mutatedChromosome = chromosome;
    for iCurrentGene = 1:nGenes
        if (rand < mutationProbability)
            if mod(iCurrentGene,4) == 1
                range = nOperators;
            elseif mod(iCurrentGene,4) == 2
                range = nVariableRegisters;
            elseif mod(iCurrentGene,4) == 3 || mod(iCurrentGene,4) == 0
                range = nVariableRegisters + nConstantRegisters;
            end
            mutatedChromosome(iCurrentGene) = 1 + fix(rand * range);
        end
    end

end

