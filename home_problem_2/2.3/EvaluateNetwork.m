function [outputs] = EvaluateNetwork(inputs, weights, biases, beta)

    layerInputs = inputs;
    for iLayer = 1:size(weights,2)
        outputs = layerInputs * weights{iLayer}' - biases{iLayer};
        outputs = ActivationFunction(outputs, beta);
        layerInputs = outputs;
    end
end
