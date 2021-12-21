function run()
    n=10;
    m=5;

    [A, b, p] = generate(n, m)
%     f = @(x) sum(power((x-p),2));
    H = 2*eye(n);
    f = -2 * p;

    x = quadprog(H,f,[],[],A,b)
end
