function weights = DecodeChromosome(chromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons)
    
    if nHiddenNeurons > 0
        weights = cell(1,2);
        weights{1} = reshape(chromosome(1:(nInputNeurons+1)*nHiddenNeurons), nHiddenNeurons, nInputNeurons+1);
        weights{2} = reshape(chromosome((nInputNeurons+1)*nHiddenNeurons+1:end), nOutputNeurons, nHiddenNeurons+1);
    else
        weights = cell(1,1);
        weights{1} = reshape(chromosome, nOutputNeurons, nInputNeurons+1);
    end
end
