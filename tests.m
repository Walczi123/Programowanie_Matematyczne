function tests(n, err_bound)
    if ~exist('n','var')
          n = 100;
    end

    if ~exist('err_bound','var')
          err_bound = 1e-4;
    end   

    counert_exitflag = 0;
    counert_fval = 0;
    counert_det = 0;
    counert_iter_eq= 0;
    counert_iter_gt = 0;
    counert_iter_lt = 0;
    counert_x = 0;
    counert_wkt_quad = 0;
    counert_wkt_imp = 0;

    for i = 1:n
        x = [randi([0,5]), randi([0,5])];
        y = [randi([15,20]), randi([15,20])];

        [P, Q, r, s] = generate_polygons(x, y, [20,50], [3,7]);
    
        C = [P -Q];
        D = C'*C;
        m = r + s;
        A = [ones(1,r) zeros(1, s); zeros(1,r) ones(1, s)];
        b = [1;1];
    
        [quadprog_x, quadprog_fval, quadprog_exitflag, quadprog_output, quadprog_lambda] = quadprog(2*D,[],[],[],A,b,zeros(m,1),[]);
        quadprog_iter = getfield(quadprog_output,"iterations");
        quadprog_eqlin = getfield(quadprog_lambda,"eqlin");
        quadprog_lower = getfield(quadprog_lambda,"lower");
        
        x0 = ones(r+s,1);
        y0 = [1;1];
        z0 = ones(r+s,1);


        [IPM_x, IPM_fval, IPM_exitflag, IPM_iter, IPM_eqlin, IPM_lower] = IPM(2*D, A, b, x0, y0, z0, 1e-5, 1e+9, 1e+4);

        if IPM_iter == quadprog_iter
            counert_iter_eq = counert_iter_eq + 1;
        elseif IPM_iter > quadprog_iter
            counert_iter_gt = counert_iter_gt + 1;
        else
            counert_iter_lt = counert_iter_lt + 1;
        end

        if (quadprog_exitflag == 1 && IPM_exitflag == 1) || (quadprog_exitflag ~= 1 && IPM_exitflag ~= 1)
            counert_exitflag = counert_exitflag + 1;
            if quadprog_exitflag == 1
                counert_det = counert_det + 1;
                norm_fval = norm(quadprog_fval - IPM_fval);
                disp(norm_fval)
                if norm_fval < err_bound
                    counert_fval = counert_fval + 1;
                end
                norm_x = norm(quadprog_x - IPM_x);
                if norm_x < err_bound
                    counert_x = counert_x + 1;
                end
                if all(abs(2*D*quadprog_x + A'*quadprog_eqlin - quadprog_lower) < err_bound) & all(abs(A*quadprog_x - b) < err_bound) & all(abs(-quadprog_x'*quadprog_lower) < err_bound) & all(min(quadprog_x) >= 0) & (min(quadprog_lower) >= 0)
                    counert_wkt_quad = counert_wkt_quad + 1;
                end
                if all(abs(2*D*IPM_x + A'*IPM_eqlin - IPM_lower) < err_bound) & all(abs(A*IPM_x - b) < err_bound) & all(abs(-IPM_x'*IPM_lower) < err_bound) & all(min(IPM_x) >= 0) & (min(IPM_lower) >= 0)
                    counert_wkt_imp = counert_wkt_imp + 1;
                end
            end
        end
    end
    disp('===========================')
   fprintf('quadprog and my IPM get the same exitflag in %0.2f %%\n', counert_exitflag/n * 100);
    fprintf('quadprog and my IPM get the different exitflag in %0.2f %%\n', (1 - counert_exitflag/n) * 100);
    fprintf('The number of iterations was the same in %0.2f %%\n', counert_iter_eq/n * 100);
    fprintf('The number of iterations was greater in IPM alg. in %0.2f %%\n', counert_iter_gt/n * 100);
    fprintf('The number of iterations was less in IPM alg. in %0.2f %%\n', counert_iter_lt/n * 100);
    disp('When both get the same exit flag:');
    fprintf('The value of the function was the same in %0.2f %%\n',counert_fval/counert_det * 100);
    fprintf('The variables was the same in %0.2f %%\n', counert_x/counert_det * 100);
    fprintf('The quadprog result meet the assumptions WKT in %0.2f %%\n', counert_wkt_quad/counert_det * 100);
    fprintf('The IMP result meet the assumptions WKT in %0.2f %%\n', counert_wkt_imp/counert_det * 100);
    disp('===========================')
end