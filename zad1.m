function zad1()
    n=10;
    m=5;

    [A, b, p] = generate(n, m);
    %     f = @(x) sum(power((x-p),2));
    H = 2*eye(n);
    f = -2 * p;

    [quadprog_x, quadprog_fval, quadprog_exitflag, quadprog_output] = quadprog(H,f,[],[],A,b)
    p
end
