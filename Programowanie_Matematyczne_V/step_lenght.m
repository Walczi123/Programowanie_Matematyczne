function a = step_lenght(x, y, z, dx, dy, dz)
    beta = 0.999;
    X =  -beta * x./dx;
    X(dx>=0) = 1;
    Z = -beta * z./dz;
    Z(dz>=0) = 1;
    a = min([1, min(X), min(Z)]);
end