function [distance, time] = RunTruckSimulation(networkWeights, networkBiases, timeStep, iSlope, iDataSet)

    % Constants that are fixed by the assignment
    gravityConstant = 9.82;  % m/s^2
    truckMass = 20000;  % kg
    maxVelocity = 25;  % m/s
    minVelocity = 1;  % m/s
    startingVelocity = 20; % m/s
    maxSlopeAngle = 10;  % degrees
    slopeLength = 1000;  % m
    startingGear = 7;
    minTimeBetweenGearShifts = 2;  % s
    ambientTemperature = 283;  % K
    maxBrakeTemperature = 750;  % K
    startingBrakeTemperature = 500;
    coolingFactor = 30;  % s
    heatingConstant = 40;  % K/s
    engineBrakeForces = [7, 5, 4, 3, 2.5, 2, 1.6, 1.4, 1.2, 1] * 3000;  % N (by gear)
    
    bSimulationEnded = false;
    time = 0;
    timeSinceLastGearShift = Inf;
    distance = 0;
    velocity = startingVelocity;
    gear = startingGear;
    brakeTemperature = startingBrakeTemperature;
    while ~bSimulationEnded
        time = time+timeStep;
        timeSinceLastGearShift = timeSinceLastGearShift + timeStep;
        slopeAngle = GetSlopeAngle(distance, iSlope, iDataSet);
        
        %validation
        if slopeAngle > maxSlopeAngle || slopeAngle < 0
            disp('Invalid slopeAngle')
            disp(slopeAngle)
        end
        
%         networkInputs = [currentVelocity/maxVelocity, slopeAngle/maxSlopeAngle, brakeTemperature/maxBrakeTemperature];
%         outputs = EvaluateNetwork(networkInputs, networkWeights, biases, beta);
        outputs = [0.05,-1];
        brakePressure = outputs(1);
        gearDelta = outputs(2);
        if gearDelta ~= 0 && timeSinceLastGearShift > minTimeBetweenGearShifts
            if ~(gearDelta == -1 && gear == 1) && ~(gearDelta == 1 && gear == length(engineBrakeForces))
                gear = gear + gearDelta;
                timeSinceLastGearShift = 0;
            end
        end
        acceleration = CalculateAcceleration(slopeAngle, gear, brakePressure, brakeTemperature, maxBrakeTemperature, truckMass, gravityConstant, engineBrakeForces);
        velocity = velocity + timeStep * acceleration;
        brakeTemperatureChange = CalculateBrakeTemperatureChange(brakePressure, brakeTemperature, ambientTemperature, heatingConstant, coolingFactor);
        brakeTemperature = brakeTemperature + brakeTemperatureChange;
        distance = distance + timeStep * velocity;
        
        if distance >= slopeLength || velocity > maxVelocity || velocity < minVelocity || brakeTemperature > maxBrakeTemperature
            bSimulationEnded = true;
            disp(distance);
            disp(velocity);
            disp(brakeTemperature);
        end
    end

end