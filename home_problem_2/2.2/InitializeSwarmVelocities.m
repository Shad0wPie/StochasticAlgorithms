function particleVelocities = InitializeSwarmVelocities(swarmSize, nVariables, xMax, xMin, alpha, timeStep)

    rndFactor = rand(swarmSize, nVariables);
    particleVelocities = alpha / timeStep * (-(xMax-xMin)/2 + rndFactor*(xMax-xMin));

end