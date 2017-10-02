function visibility = GetVisibility(cityLocation)

    nCities = size(cityLocation,1);
    visibility = zeros(nCities,nCities);
    for iSourceCity = 1:nCities
        for iDestinationCity = 1:nCities
            distance = norm(cityLocation(iSourceCity,:) - cityLocation(iDestinationCity,:));
            visibility(iDestinationCity, iSourceCity) = 1/distance;
        end
    end

end
