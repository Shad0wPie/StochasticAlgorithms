function VisualizeIndividual(chromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons, timeStep, iSlope, iDataSet)

    weights = DecodeChromosome(chromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons);

    [~, ~, extraMetrics] = RunTruckSimulation(weights, timeStep, iSlope, iDataSet, true);
       
    subplot(2,3,1)
    plot(extraMetrics.distances, extraMetrics.slopeAngles)
    title('Slope Angle')
    subplot(2,3,2)
    plot(extraMetrics.distances, extraMetrics.velocities)
    title('Velocity')
    subplot(2,3,3)
    plot(extraMetrics.distances, extraMetrics.brakeTemperatures)
    title('BrakeTemperature')
    subplot(2,3,4)
    plot(extraMetrics.distances, extraMetrics.brakePressures)
    title('Brake Pressure')
    subplot(2,3,5)
    plot(extraMetrics.distances, extraMetrics.gears)
    title('Active Gear')

    drawnow
end

