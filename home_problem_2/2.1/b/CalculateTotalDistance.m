function totalDistance = CalculateTotalDistance(travelOrder, cityLocations)
    nCities = length(travelOrder);

    totalDistance = 0;
    for iCity = 1:nCities
        firstCityIndex = travelOrder(iCity);
        if iCity == nCities
            secondCityIndex = travelOrder(1);
        else
            secondCityIndex = travelOrder(iCity+1);
        end
        firstPosition = cityLocations(firstCityIndex,:);
        secondPosition = cityLocations(secondCityIndex,:);
        distance = norm(secondPosition-firstPosition);
        totalDistance = totalDistance + distance;
    end

end

