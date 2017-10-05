function [ fcnValue ] = ActivationFunction(neuronState)
    
    fcnValue = tanh(0.5*neuronState);

end
