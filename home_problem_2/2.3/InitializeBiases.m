function biases = InitializeBiases(interval, nHiddenNeurons, nOutputs)
    % If we have no hidden neurons, we create weights directly to the
    % output layer
    if nHiddenNeurons == 0
        nFirstLayer = nOutputs;
        nSecondLayer = 0;
        biases = cell(1,1);
    else
        nFirstLayer = nHiddenNeurons;
        nSecondLayer = nOutputs;
        biases = cell(1,2);
    end
    
    biases{1} = zeros(1,nFirstLayer);
    for i=1:nFirstLayer
        biases{1}(1,i) = interval(1)+(interval(2)-interval(1))*rand;
    end
    if nSecondLayer > 0
        biases{2} = zeros(1,nSecondLayer);
        for i=1:nSecondLayer
            biases{2}(1,i) = interval(1)+(interval(2)-interval(1))*rand;
        end
    end
end

