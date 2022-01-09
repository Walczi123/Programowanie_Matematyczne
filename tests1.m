function tests1(n, err_bound)
    if ~exist('n','var')
          n = 100;
    end

    if ~exist('err_bound','var')
          err_bound = 1e-5;
    end
    
    size_n=10;
    size_m=7;

    counert_exitflag = 0;
    counert_fval = 0;
    counert_det = 0;
    counert_iter_eq= 0;
    counert_iter_gt = 0;
    counert_iter_lt = 0;
    counert_x = 0;
    counert_wkt_zfk_x = 0;
    counert_wkt_quad_x = 0;

    f = @(x, p) sum((x-p).^2);
    x0 = zeros([size_n,1]);
    for i = 1:n
        [A, b, p] = generate(size_n, size_m);
        D = 2*eye(size_n);
        c = -2 * p;  
        
        [ZFK_x, ZFK_exitflag, ZFK_iter] = ZFK(D, c, A, b, x0, 1, 5, 1e-8, 'fminunc');
        ZFK_fval = f(ZFK_x, p);
 
        [quadprog_x, ~, quadprog_exitflag, quadprog_output, lambda] = quadprog(D,c,[],[],A,b);
        quadprog_iter = getfield(quadprog_output,"iterations");
        quadprog_fval = f(quadprog_x, p);

        if ZFK_iter == quadprog_iter
            counert_iter_eq = counert_iter_eq + 1;
        elseif ZFK_iter > quadprog_iter
            counert_iter_gt = counert_iter_gt + 1;
        else
            counert_iter_lt = counert_iter_lt + 1;
        end

        if (quadprog_exitflag == 1 && ZFK_exitflag == 1) || (quadprog_exitflag ~= 1 && ZFK_exitflag ~= 1)
            counert_exitflag = counert_exitflag + 1;
            if quadprog_exitflag == 1
                counert_det = counert_det + 1;
                error_fval = abs(quadprog_fval)-abs(ZFK_fval);
                if abs(error_fval) < err_bound
                    counert_fval = counert_fval + 1;
                end
                error_x = abs(quadprog_x) - abs(ZFK_x);
                if abs(error_x) < err_bound
                    counert_x = counert_x + 1;
                end
                eqlin = getfield(lambda,"eqlin")';
                if WKT(A, b, D, c, ZFK_x, eqlin', err_bound)
                    counert_wkt_zfk_x = counert_wkt_zfk_x + 1;
                end
                if WKT(A, b, D, c, quadprog_x, eqlin', err_bound)
                    counert_wkt_quad_x = counert_wkt_quad_x + 1;
                end
            end
        end
    end
    disp('===========================')
   fprintf('quadprog and my ZFK get the same exitflag in %0.2f %%\n', counert_exitflag/n * 100);
    fprintf('quadprog and my ZFK get the different exitflag in %0.2f %%\n', (1 - counert_exitflag/n) * 100);
    fprintf('The number of iterations was the same in %0.2f %%\n', counert_iter_eq/n * 100);
    fprintf('The number of iterations was greater in ZFK alg. in %0.2f %%\n', counert_iter_gt/n * 100);
    fprintf('The number of iterations was less in ZFK alg. in %0.2f %%\n', counert_iter_lt/n * 100);
    disp('When both get the same exit flag:');
    fprintf('The value of the function was the same in %0.2f %%\n',counert_fval/counert_det * 100);
    fprintf('The variables was the same in %0.2f %%\n', counert_x/counert_det * 100);
    fprintf('The quadprog result meet the assumptions WKT in %0.2f %%\n', counert_wkt_quad_x/counert_det * 100);
    fprintf('The ZFK result meet the assumptions WKT in %0.2f %%\n', counert_wkt_zfk_x/counert_det * 100);
    disp('===========================')
end