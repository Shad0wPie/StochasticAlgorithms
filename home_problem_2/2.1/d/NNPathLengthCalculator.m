clearvars

cityLocation = LoadCityLocations();

nCities = size(cityLocation,1);
visitedCities = zeros(1,nCities) * NaN;

pathLength = 0;
currentCity = 1 + fix(rand * nCities);
visitedCities(1) = currentCity;
for iVisitedCity = 2:nCities
    shortestDistance = inf;
    closestNeighbour = NaN;
    for iCity = 1:nCities
        if any(visitedCities==iCity)
            continue
        end
        distance = norm(cityLocation(currentCity,:) - cityLocation(iCity,:));
        if distance < shortestDistance
            shortestDistance = distance;
            closestNeighbour = iCity;
        end
    end
    pathLength = pathLength + shortestDistance;
    visitedCities(iVisitedCity) = closestNeighbour;
    currentCity = closestNeighbour;
end
returnToStartDistance = norm(cityLocation(visitedCities(1),:) - cityLocation(visitedCities(end),:));
pathLength = pathLength + returnToStartDistance;

disp('Path length:')
disp(pathLength)