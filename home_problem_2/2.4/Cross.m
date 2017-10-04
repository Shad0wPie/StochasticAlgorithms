function newChromosomePair = Cross(chromosome1, chromosome2)
    
    nInstructions1 = length(chromosome1)/4;    
    crossoverPoints1 = [4*fix(rand*(nInstructions1+1)), 4*fix(rand*(nInstructions1+1))];
    crossoverPoints1 = sort(crossoverPoints1);
    
    nInstructions2 = length(chromosome2)/4;    
    crossoverPoints2 = [4*fix(rand*(nInstructions2+1)), 4*fix(rand*(nInstructions2+1))];
    crossoverPoints2 = sort(crossoverPoints2);
    
    newChromosome1 = [chromosome1(1:crossoverPoints1(1)), chromosome2(crossoverPoints2(1)+1:crossoverPoints2(2)), chromosome1(crossoverPoints1(2)+1:end)];
    newChromosome2 = [chromosome2(1:crossoverPoints2(1)), chromosome1(crossoverPoints1(1)+1:crossoverPoints1(2)), chromosome2(crossoverPoints2(2)+1:end)];

    newChromosomePair = [struct('Chromosome',newChromosome1), struct('Chromosome',newChromosome2)];

end

