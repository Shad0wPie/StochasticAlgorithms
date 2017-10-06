function [outputs] = EvaluateNetwork(inputs, weights)

    layerInputs = inputs;
    for iLayer = 1:size(weights,2)
        outputs = layerInputs * weights{iLayer}';
        outputs = tanh(outputs);
        layerInputs = outputs;
    end
end
