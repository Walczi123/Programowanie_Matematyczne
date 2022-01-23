function [dx, dy, dz] = direction(D, A, b, x, y, z, r)
    X = diag(x);
    Y = diag(y);
    Z = diag(z);
    LM = [ -(inv(X) * Z + D), A'; A, zeros(2,2)];
    RM = [ -A'*y-r*diag(inv(X))+D*x ; b - A*x + r*diag(inv(Y))];
    D = LM \ RM;

    dx = D(1:size(A,2));
    dy = D(size(A,2)+1:end); 
    dz = inv(X) * (r * ones(size(x,1), 1) - X*diag(Z) - Z*dx);
end