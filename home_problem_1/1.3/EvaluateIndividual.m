function fitness = EvaluateIndividual(x)
    
    f = EvaluateFunction(x);    
    fitness = 1/f;
end