function newPositions = UpdatePositions(particleVelocities, particlePositions, timeStep)

    newPositions = particlePositions + timeStep * particleVelocities;

end