function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)

    nCities = size(pheromoneLevel,1);
    path = zeros(1,nCities);
    
    firstCity = 1 + fix(rand * nCities);
    path(1) = firstCity;
    
    for i=2:nCities
        tabuList = path(path~=0);
        nextCity = GetNextCity(tabuList, pheromoneLevel, visibility, alpha, beta);
        path(i) = nextCity;
    end
    
end
