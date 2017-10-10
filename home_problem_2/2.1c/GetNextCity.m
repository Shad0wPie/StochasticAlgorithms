function nextCity = GetNextCity(tabuList, pheromoneLevel, visibility, alpha, beta)

    nCities = size(pheromoneLevel,1);
    
    startingCity = tabuList(end);
    
    cityStrength = zeros(1,nCities);
    for i=1:nCities
        if any(tabuList==i)
            cityStrength(i) = 0;
        else
            cityStrength(i) = pheromoneLevel(i,startingCity).^alpha.*visibility(i,startingCity).^beta;
        end
    end
    nextCity = RandomWeightedSelection(cityStrength);
    
end
