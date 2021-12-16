function test2(A, b)
    clc;
    n=20;
    p1 = -10;
    p2 = 10;    

    clus = [10, 20, 30, 40, 50];
    [~, k] = size(clus);

    v = [];
    for i = 1 : k
        l = ceil((i-1) * (n/k));
        up = ceil(i * (n/k));
        c = clus(i);
        v = [v; c(ones(up-l, 1))];
    end
    [A,b] = generate2(v, p1, p2);

    f = @(x) 1/2*x' * A* x - b' * x;
    g = @(x) A * x - b;
    x0 = zeros(n,1);
        
    xExact = A' \ b;

    [analitical_xDFP,analitical_fval,analitical_it] = DFP(f, g, x0, 1e-4, A, 'analitical');
    [gold_xDFP,gold_fval,gold_it] = DFP(f, g, x0, 1e-4, A, 'gold');
    [armijo_xDFP,armijo_fval,armijo_it] = DFP(f, g, x0, 1e-4, A, 'armijo');
   
end