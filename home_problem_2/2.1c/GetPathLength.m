function pathLength = GetPathLength( path, cityLocation )

    nCities = length(path);

    pathLength = 0;
    for iCity = 1:nCities
        firstCityIndex = path(iCity);
        if iCity == nCities
            secondCityIndex = path(1);
        else
            secondCityIndex = path(iCity+1);
        end
        firstPosition = cityLocation(firstCityIndex,:);
        secondPosition = cityLocation(secondCityIndex,:);
        distance = norm(secondPosition-firstPosition);
        pathLength = pathLength + distance;
    end
    
end

