function zad2()
    n=10;
    m=5;

    [A, b, p] = generate(n, m);
    x0 = zeros([n,1]);
    [xx1, exitflag1, it1] = ZFK(A, p, x0, 1, 10, 1e-6, 'fminunc');

    [xx2, exitflag2, it2] = ZFK(A, p, x0, 1, 10, 1e-6, 'DFP');

    H = 2*eye(n);
    f = -2 * p;

    x = quadprog(H,f,[],[],A,b);

    disp(xx1)
    disp(A*xx1)

    disp(xx2)
    disp(A*xx2)

    disp(x)
    disp(A*x)

end
