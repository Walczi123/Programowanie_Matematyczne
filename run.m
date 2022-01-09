function run()
    size_n=10;
    size_m=5;

%     f = @(x, p) sum((x-p).^2);
    
    x0 = zeros([size_n,1]);

    [A, b, p] = generate(size_n, size_m);
    D = 2*eye(size_n);
    c = -2 * p;  
    f = @(x) 1/2 * x' * D * x + c' * x;

    [ZFK_x, ZFK_exitflag, ZFK_iter] = ZFK(D, c, A, b, x0, 1, 5, 1e-4, 'DFP');
    ZFK_fval = f(ZFK_x);

      
    [quadprog_x, ~, quadprog_exitflag, quadprog_output, lambda] = quadprog(D,c,[],[],A,b);    
    quadprog_iter = getfield(quadprog_output,"iterations");
    quadprog_fval = f(quadprog_x);

    eqlin = getfield(lambda,"eqlin")';
    if ~isempty(eqlin)
        eqlin
    end
    WKT(A, b, D, c, ZFK_x, eqlin', 1e-4)
end

