function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)

    nCities = size(pathCollection,2);
    nAnts = size(pathCollection,1);
    
    deltaPheromoneLevel = zeros(nCities,nCities);
    
    for iAnt = 1:nAnts
        antDeltaTao = 1/pathLengthCollection(iAnt);
        for iStep = 1:nCities
            cityIndex = pathCollection(iAnt,iStep);
            if iStep == nCities
                nextCityIndex = pathCollection(iAnt, 1);
            else
                nextCityIndex = pathCollection(iAnt, iStep+1);
            end
            deltaPheromoneLevel(nextCityIndex, cityIndex) = deltaPheromoneLevel(nextCityIndex, cityIndex) + antDeltaTao;
        end
    end
end
