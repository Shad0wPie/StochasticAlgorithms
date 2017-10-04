function PlotAll(population, functionData, constantRegisters, nVariableRegisters)
    xValues = functionData(:,1);
    yValues = functionData(:,2);
    plot(xValues, yValues)
    hold on
    
    for i=1:length(population)
        estimatedValues = arrayfun(@(x) DecodeChromosome(population(i).Chromosome, x, constantRegisters, nVariableRegisters), xValues);
        plot(xValues, estimatedValues, 'r--');
    end
    hold off
    axis([-5,5,-1.5,1.5])
    drawnow
end

