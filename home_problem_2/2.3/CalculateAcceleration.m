function acceleration = CalculateAcceleration(slopeAngle, gear, brakePressure, brakeTemperature, maxBrakeTemperature, truckMass, gravityConstant, engineBrakeForces)

    gravityAcceleration = gravityConstant * sind(slopeAngle);
    brakeAcceleration = gravityConstant / 20 * brakePressure;
    if brakeTemperature > maxBrakeTemperature - 100
        brakeAcceleration = brakeAcceleration * exp(-(brakeTemperature-(maxBrakeTemperature-100))/100);
    end
    engineBrakeAcceleration = engineBrakeForces(gear)/truckMass;
    acceleration = gravityAcceleration - brakeAcceleration - engineBrakeAcceleration;
