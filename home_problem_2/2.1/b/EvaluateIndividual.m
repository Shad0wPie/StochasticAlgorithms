function fitness = EvaluateIndividual(travelOrder, cityLocations)

    totalDistance = CalculateTotalDistance(travelOrder, cityLocations);
    fitness = 1/totalDistance;
end