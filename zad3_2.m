function test2(A, b)
    clc;
    n=20;
    p1 = -10;
    p2 = 10;

    c = randi([p1, p2]);
    v = c(ones(n, 1));
    v(end) = randi([10*p2, 20*p2]);
    [A,b] = generate2(v, p1, p2);

    f = @(x) 1/2*x' * A* x - b' * x;
    g = @(x) A * x - b;
    x0 = zeros(n,1);
        
    xExact = A' \ b;

    [analitical_xDFP,analitical_fval,analitical_it] = DFP(f, g, x0, 1e-4, A, 'analitical');
    [gold_xDFP,gold_fval,gold_it] = DFP(f, g, x0, 1e-4, A, 'gold');
    [armijo_xDFP,armijo_fval,armijo_it] = DFP(f, g, x0, 1e-4, A, 'armijo');
   
end