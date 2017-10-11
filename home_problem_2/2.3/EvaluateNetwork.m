function [outputs] = EvaluateNetwork(inputs, weights)

    % The added '1' corresponds to the bias
    layerInputs = [inputs 1];
    for iLayer = 1:size(weights,2)
        outputs = weights{iLayer} * layerInputs';
        outputs = tanh(outputs');
        layerInputs = [outputs 1];
    end
end
