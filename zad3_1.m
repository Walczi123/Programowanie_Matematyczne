function zad3_1()
    clc;

    p1 = -10;
    p2 = 10;
    n = 10;
    
    v = zeros(n);
    while v == zeros(size(v))
        c = randi([p1, p2]);
        v = c(ones(n, 1));
    end

    [A,b] = generate2(v, p1, p2);

    f = @(x) 1/2*x' * A* x - b' * x;
    g = @(x) A * x - b;
    x0 = zeros(n,1);

    [analitical_xDFP,analitical_fval,analitical_it] = DFP(f, g, x0, 1e-4, A, 'analitical',1);
    figure();
    [gold_xDFP,gold_fval,gold_it] = DFP(f, g, x0, 1e-4, A, 'gold',1);
    figure();
    [armijo_xDFP,armijo_fval,armijo_it] = DFP(f, g, x0, 1e-4, A, 'armijo',1);
end