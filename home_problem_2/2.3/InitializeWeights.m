function weights = InitializeWeights(interval, nInputs, nHiddenNeurons, nOutputs)
%InitializeWeights: Creates a matrix with weights with a uniform 
%distribution on the interval (interval = [-x, +x]).
%
%layerDimensions: list of the number of neurons in each layer (input first)    
    % If we have no hidden neurons, we create weights directly to the
    % output layer
    if nHiddenNeurons == 0
        nFirstLayer = nOutputs;
        nSecondLayer = 0;
        weights = cell(1,1);
    else
        nFirstLayer = nHiddenNeurons;
        nSecondLayer = nOutputs;
        weights = cell(1,2);
    end
    
    weights{1} = zeros(nFirstLayer, nInputs);
    for i=1:nFirstLayer
        for j=1:nInputs
            weights{1}(i,j) = interval(1)+(interval(2)-interval(1))*rand;
        end
    end
    
    if nSecondLayer > 0
        weights{2} = zeros(nSecondLayer, nFirstLayer);
        for i=1:nSecondLayer
            for j=1:nFirstLayer
                weights{2}(i,j) = interval(1)+(interval(2)-interval(1))*rand;
            end
        end
    end
end

