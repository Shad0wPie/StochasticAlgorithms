timeStep = 0.25;
nHiddenNeurons = 7;
nInputNeurons = 3;
nOutputNeurons = 2;

iDataSet = 3;
iSlope = 1;

bestChromosome = load('bestChromosome.mat');
bestChromosome = bestChromosome.bestValidationChromosome;

weights = DecodeChromosome(bestChromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons);

VisualizeIndividual(bestChromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons, timeStep, iSlope, iDataSet);