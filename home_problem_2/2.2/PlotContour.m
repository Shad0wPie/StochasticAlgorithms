x = linspace(-5,5,300);
y = linspace(-5,5,300);
[X,Y] = meshgrid(x,y);
Z = log(0.01 + EvaluateFunction(X,Y));

contour(X,Y,Z, 10)
