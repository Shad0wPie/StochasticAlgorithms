function x = GradientDescent( startingPoint, mu, stepLength, threshold )

    x = startingPoint;

    bReachedThreshold = false;
    while ~bReachedThreshold
        gradient = Gradient(x(1),x(2),mu);
        if norm(gradient) < threshold
            bReachedThreshold = true;
        end
        x = x - stepLength * gradient;
        % I hit cases where x became NaN because of overshoot with a large
        % gradient. This checks stops the iteration to prevent the program
        % from hanging
        if isnan(x(1)) || isnan(x(2))
            break
        end
    end
    
end

