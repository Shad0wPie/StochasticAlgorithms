function value = EvaluateFunction(x,y)
    
    part1 = (x.^2 + y - 11).^2;
    part2 = (x + y.^2 - 7).^2;
    value = part1 + part2;

end

