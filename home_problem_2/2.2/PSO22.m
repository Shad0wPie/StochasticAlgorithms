swarmSize = 100;
nIterations = 2000;
cognitiveComponent = 2;
socialComponent = 2;
timeStep = 0.1;
nVariables = 2;
alpha = 1;
xMax = 5;
xMin = -5;
maxVelocity = (xMax-xMin)/timeStep;

inertiaWeight = 1.5;
inertiaReductionFactor = 0.99;
inertiaLowerBound = 0.4;

particlePositions = InitializeSwarmPositions(swarmSize, nVariables, xMax, xMin);
particleVelocities = InitializeSwarmVelocities(swarmSize, nVariables, xMax, xMin, alpha, timeStep);
particleBestPositions = particlePositions;
particleBestValues = zeros(1,swarmSize) + inf;
swarmBestPosition = zeros(1,nVariables);
swarmBestValue = inf;

for iIteration = 1:nIterations
    for iParticle = 1:swarmSize
        position = particlePositions(iParticle, :);
        newValue = EvaluateFunction(position(1),position(2));
        if newValue < particleBestValues(iParticle)
            particleBestPositions(iParticle,:) = position;
            particleBestValues(iParticle) = newValue;
            if newValue < swarmBestValue
                swarmBestPosition = position;
                swarmBestValue = newValue;
            end
        end
    end
    
    particleVelocities = UpdateVelocities(particleVelocities, particlePositions, particleBestPositions, swarmBestPosition, cognitiveComponent, socialComponent, timeStep, maxVelocity, inertiaWeight);
    particlePositions = UpdatePositions(particleVelocities, particlePositions, timeStep);
    
    if inertiaWeight > inertiaLowerBound
        inertiaWeight = inertiaWeight * inertiaReductionFactor;
    end
end

fprintf('Optimum position:\n(%.6f, %.6f)\n', swarmBestPosition)
fprintf('Optimum value:\n%.6f\n', swarmBestValue)