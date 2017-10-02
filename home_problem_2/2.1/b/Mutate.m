function mutatedChromosome = Mutate(chromosome, mutationProbability)

    nGenes = size(chromosome, 2);
    mutatedChromosome = chromosome;
    for iCurrentGene = 1:nGenes
        r = rand;
        tempMutatedChromosome = mutatedChromosome;
        if (r < mutationProbability)
            otherGeneIndex = 1 + fix(rand*nGenes);
            mutatedChromosome(iCurrentGene) = tempMutatedChromosome(otherGeneIndex);
            mutatedChromosome(otherGeneIndex) = tempMutatedChromosome(iCurrentGene);
        end
    end

end

