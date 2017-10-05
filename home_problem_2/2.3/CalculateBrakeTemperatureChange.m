function temperatureChange = CalculateBrakeTemperatureChange(brakePressure, brakeTemperature, ambientTemperature, heatingConstant, coolingFactor)

    if brakePressure < 0.01
        deltaT = brakeTemperature - ambientTemperature;
        temperatureChange = -deltaT/coolingFactor;
    else
        temperatureChange = heatingConstant * brakePressure;
    end