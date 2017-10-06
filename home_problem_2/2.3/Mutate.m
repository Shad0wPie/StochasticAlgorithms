function mutatedChromosome = Mutate(chromosome, mutationProbability, creepRate)
% We don't need to restrict the new mutated values to the original
% initialization range, since weights that are larger (or smaller) than
% that still make sense
    nGenes = size(chromosome, 2);
    mutatedChromosome = chromosome;
    for iCurrentGene = 1:nGenes
        if (rand < mutationProbability)
            mutatedChromosome(iCurrentGene) = mutatedChromosome(iCurrentGene) - creepRate/2 + rand*creepRate;
        end
    end

end

