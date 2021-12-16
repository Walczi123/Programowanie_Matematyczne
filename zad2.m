function zad2()
    clc;
    n=10;
    p1 = -10;
    p2 = 10;

    [A,b] = generate(n, p1, p2);
    f = @(x) 1/2*x' * A* x - b' * x;
    g = @(x) A * x - b;
    x0 = zeros(n,1);
        
    xExact = A' \ b;

    [analitical_xDFP,analitical_fval,analitical_it] = DFP(f, g, x0, 1e-4, A, 'analitical');
    [gold_xDFP,gold_fval,gold_it] = DFP(f, g, x0, 1e-4, A, 'gold');
    [armijo_xDFP,armijo_fval,armijo_it] = DFP(f, g, x0, 1e-4, A, 'armijo');

    norm_analitical = norm(xExact-analitical_xDFP)
    norm_gold = norm(xExact-gold_xDFP)
    norm_armijo = norm(xExact-armijo_xDFP)
end