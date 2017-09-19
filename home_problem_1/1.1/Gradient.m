function gradient = Gradient(x1, x2, mu)

    gradient = [2*(x1 -1), 4*(x2-2)];

    if (x1^2 + x2^2 >= 1)
        gradient = gradient + 4*mu*(x1^2 + x2^2 -1) * [x1, x2];
    end

end

