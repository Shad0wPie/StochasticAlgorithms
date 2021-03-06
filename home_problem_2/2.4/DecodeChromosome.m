function estimatedValues = DecodeChromosome(chromosome, x, constantRegisters, nVariableRegisters)
    
    cMax = 1e10;
    
    nValues = length(x);
    
    registers = [x zeros(nValues, nVariableRegisters), ones(nValues,1) * constantRegisters];

    nInstructions = length(chromosome) / 4;
    
    for iInstruction = 1:nInstructions
        instructionFirstGene = 1 + (iInstruction-1) * 4;
        operator = chromosome(instructionFirstGene);
        destination = chromosome(instructionFirstGene + 1);
        operand1 = chromosome(instructionFirstGene + 2);
        operand2 = chromosome(instructionFirstGene + 3);

        if operator == 1
            registers(:,destination) = registers(:,operand1) + registers(:,operand2);
        elseif operator == 2 
            registers(:,destination) = registers(:,operand1) - registers(:,operand2);
        elseif operator == 3 
            registers(:,destination) = registers(:,operand1) .* registers(:,operand2);
        elseif operator == 4
            operand2IsZero = registers(:,operand2)==0;
            registers(:,destination) = registers(:,operand1) ./ registers(:,operand2);
            registers(operand2IsZero,destination) = cMax;
        end
        
        registers(registers(:,destination)==Inf, destination) = cMax;
        registers(registers(:,destination)==-Inf, destination) = -cMax;
    end
    
    estimatedValues = registers(:,1);
    
end
