function [brakePressure, gearDelta] = ParseNNOutputs(outputs)

    brakePressure = (outputs(1) + 1) / 2;
    brakePressure = min(max(brakePressure,0),1);

    gearDelta = outputs(2);
    if abs(gearDelta) < 1/3
        gearDelta = 0;
    else
        gearDelta = sign(gearDelta);
    end