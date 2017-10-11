timeStep = 0.25;
nHiddenNeurons = 7;
nInputNeurons = 3;
nOutputNeurons = 2;

% Change these to modify which slop to run!
iDataSet = 2;
iSlope = 2;

bestChromosome = load('bestChromosome.mat');
bestChromosome = bestChromosome.bestValidationChromosome;

weights = DecodeChromosome(bestChromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons);

VisualizeIndividual(bestChromosome, nInputNeurons, nHiddenNeurons, nOutputNeurons, timeStep, iSlope, iDataSet);