function particlePositions = InitializeSwarmPositions(swarmSize, nVariables, xMax, xMin)

    particlePositions = xMin + rand(swarmSize, nVariables)*(xMax-xMin);

end