function chromosome = InitializeChromosome(nInstructions, nOperators, nVariableRegisters, nConstantRegisters)

    nGenes = nInstructions * 4;
    chromosome = zeros(1,nGenes);
    
    for i = 1:nGenes
        if mod(i,4) == 1
            chromosome(i) = 1 + fix(rand*nOperators);
        elseif mod(i,4) == 2
            chromosome(i) = 1 + fix(rand*nVariableRegisters);
        elseif mod(i,4) == 3 || mod(i,4) == 0
            chromosome(i) = 1 + fix(rand*(nVariableRegisters + nConstantRegisters));
        end
    end
    
end