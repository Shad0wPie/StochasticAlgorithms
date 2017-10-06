function weights = DecodeChromosome(chromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons)
    
    if nHiddenNeurons > 0
        weights = cell(1,2);
        weights{1} = reshape(chromosome(1:nInputNeurons*nHiddenNeurons), nHiddenNeurons, nInputNeurons);
        weights{2} = reshape(chromosome(nInputNeurons*nHiddenNeurons+1:end), nOutputNeurons, nHiddenNeurons);
    else
        weights = cell(1,1);
        weights{1} = reshape(chromosome, nOutputNeurons, nInputNeurons);
    end
end
