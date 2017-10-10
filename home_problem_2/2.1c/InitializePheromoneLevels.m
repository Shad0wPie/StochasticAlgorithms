function pheromoneLevels = InitializePheromoneLevels(numberOfCities, tau_0)

    pheromoneLevels = zeros(numberOfCities,numberOfCities) + tau_0;

end
