function zad1()
    clc;
    n=10;
    p1 = -10;
    p2 = 10;

    [A,b] = generate(n, p1, p2);
    f = @(x) 1/2*x' * A* x - b' * x;
    x0 = zeros(n,1);
        
    xExact = A' \ b;

    options = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'Display', 'iter', 'CheckGradients', true);
    [xFminunc,fval,exitflag,output,grad,hessian] = fminunc(f,x0,options);

    norm(xExact-xFminunc)
end