function [distance, time, extraMetrics] = RunTruckSimulation(networkWeights, timeStep, iSlope, iDataSet, bStoreExtraMetrics)

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
    
    extraMetrics = struct('distances', [], 'velocities', [], 'slopeAngles',[], ...
        'brakeTemperatures',[],'brakePressures',[],'gears',[]);

    bSimulationEnded = false;
    time = 0;
    timeSinceLastGearShift = Inf;
    distance = 0;
    velocity = startingVelocity;
    gear = startingGear;
    brakeTemperature = startingBrakeTemperature;
    iIteration = 0;
    while ~bSimulationEnded
        iIteration = iIteration + 1;
        time = time+timeStep;
        timeSinceLastGearShift = timeSinceLastGearShift + timeStep;
        slopeAngle = GetSlopeAngle(distance, iSlope, iDataSet);        
        
        %validation
        if slopeAngle > maxSlopeAngle || slopeAngle < 0
            disp('Invalid slopeAngle')
            disp(slopeAngle)
        end
        
        networkInputs = [velocity/maxVelocity, slopeAngle/maxSlopeAngle, brakeTemperature/maxBrakeTemperature, 1];  % the 1 represents the bias
        outputs = EvaluateNetwork(networkInputs, networkWeights);
%         outputs = [0.05,-1];
        [brakePressure, gearDelta] = ParseNNOutputs(outputs);
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
            distance = min(distance,1000);
%             disp(distance);
%             disp(velocity);
%             disp(brakeTemperature);
        end
        
        if bStoreExtraMetrics
            extraMetrics.distances = [extraMetrics.distances distance];
            extraMetrics.velocities = [extraMetrics.velocities velocity];
            extraMetrics.slopeAngles = [extraMetrics.slopeAngles slopeAngle];
            extraMetrics.brakeTemperatures = [extraMetrics.brakeTemperatures brakeTemperature];
            extraMetrics.brakePressures = [extraMetrics.brakePressures brakePressure];
            extraMetrics.gears = [extraMetrics.gears gear];
        end
    end

end