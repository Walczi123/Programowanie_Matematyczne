function run()
    n=10;
    m=5;

    [A, b, p] = generate(n, m);
    x0 = zeros([n,1]);
    G = @(x) sum(2*x - 2*p) + 1 * (sum(2*A*x));
    G(x0)
end

