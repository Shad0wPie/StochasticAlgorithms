function VisualizeIndividual(chromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons, timeStep, iSlope, iDataSet)

    weights = DecodeChromosome(chromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons);

    [~, ~, extraMetrics] = RunTruckSimulation(weights, timeStep, iSlope, iDataSet, true);
       
    subplot(2,3,1)
    plot(extraMetrics.distances, extraMetrics.slopeAngles)
    title('Slope Angle')
    xlabel('distance')
    ylabel('angle (degrees)')
    subplot(2,3,2)
    plot(extraMetrics.distances, extraMetrics.velocities)
    title('Velocity')
    xlabel('distance')
    ylabel('velocity (m/s)')
    subplot(2,3,3)
    plot(extraMetrics.distances, extraMetrics.brakeTemperatures)
    title('BrakeTemperature')
    xlabel('distance')
    ylabel('temperature (K)')
    subplot(2,3,4)
    plot(extraMetrics.distances, extraMetrics.brakePressures)
    title('Brake Pressure')
    xlabel('distance')
    ylabel('pressure (dimensionless)')
    subplot(2,3,5)
    plot(extraMetrics.distances, extraMetrics.gears)
    title('Active Gear')
    xlabel('distance')
    ylabel('gear number')

    drawnow
end
