function x = DecodeChromosome(chromosome, numVariables, variableRange)

    nGenes = size(chromosome,2);
    geneLength = nGenes / numVariables;
    
    x = zeros(numVariables,1);
    for i=1:numVariables
        variableStartGene = (i-1) * geneLength;
        for j=1:geneLength
            currentGeneIndex = variableStartGene + j;
            x(i) = x(i) + chromosome(currentGeneIndex) * 2^(-j);
        end
        x(i) = -variableRange + 2*variableRange*x(i)/(1-2^(-geneLength));
    end
    
end