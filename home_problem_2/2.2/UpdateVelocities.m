function newVelocities = UpdateVelocities(particleVelocities, particlePositions, particleBestValues, swarmBestValue, cognitiveComponent, socialComponent, timeStep, maxVelocity, inertiaWeight)

    nParticles = size(particleVelocities,1);
    nDimensions = size(particleVelocities,2);
    randR = rand(nParticles,nDimensions);
    randQ = rand(nParticles,nDimensions);
    
    cognitivePart = cognitiveComponent * randR.*(particleBestValues-particlePositions)/timeStep;
    socialPart = socialComponent * randQ.*(swarmBestValue-particlePositions)/timeStep;
    
    newVelocities = inertiaWeight*particleVelocities + cognitivePart + socialPart;
    
    newVelocities = max(min(newVelocities, maxVelocity), -maxVelocity);
end