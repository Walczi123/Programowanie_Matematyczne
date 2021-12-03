function test(n, err_bound)
% Funkcja testująca/porównująca otrzymane wyniki dla algortymów linprog
% oraz własnej implementacji algorytmu sympleks
% Input
% n - liczba iteracj (domyślnie 100)
% err_bound - pomijalny błąd (domyślnie 0.000001)
    if ~exist('n','var')
          n = 100;
    end

    if ~exist('err_bound','var')
          err_bound = 0.000001;
    end
    
    counert_exitflag = 0;
    counert_fval = 0;
    counert_det = 0;
    counert_iter_eq= 0;
    counert_iter_gt = 0;
    counert_iter_lt = 0;
    counert_x = 0;
    for i = 1:n
        [c, A, b, d] = generate_instance();
        [linprog_x, linprog_fval, linprog_exitflag, output, ~] = linprog(-c, A, b, [], [], d);

        [d_c, d_A, d_b, ~] = transform_to_dual(c, A, b, d);
        [ROx, ~, sympleks_exitflag, sympleks_iter] = sympleks(-d_c, d_A, d_b, 0);
        sympleks_fval = c * ROx';

        linprog_iter = getfield(output,"iterations");

        if sympleks_iter == linprog_iter
            counert_iter_eq = counert_iter_eq + 1;
        elseif sympleks_iter > linprog_iter
            counert_iter_gt = counert_iter_gt + 1;
        else
            counert_iter_lt = counert_iter_lt + 1;
        end

        if (linprog_exitflag == 1 && sympleks_exitflag == 1) || (linprog_exitflag ~= 1 && sympleks_exitflag ~= 1)
            counert_exitflag = counert_exitflag + 1;
            if linprog_exitflag == 1
                counert_det = counert_det + 1;
                error_fval = abs(linprog_fval)-abs(sympleks_fval);
                if abs(error_fval) < err_bound
                    counert_fval = counert_fval + 1;
                end
                error_x = abs(linprog_x) - abs(ROx');
                error_x(c == 0) = 0;
                if error_x < err_bound
                    counert_x = counert_x + 1;
                end
            end
        end
    end
    disp('===========================')
    fprintf('Linprog and my simplex get the same exitflag in %0.2f %%\n', counert_exitflag/n * 100);
    fprintf('Linprog and my simplex get the different exitflag in %0.2f %%\n', (1 - counert_exitflag/n) * 100);
    fprintf('The number of iterations was the same in %0.2f %%\n', counert_iter_eq/n * 100);
    fprintf('The number of iterations was greater in simplex alg. in %0.2f %%\n', counert_iter_gt/n * 100);
    fprintf('The number of iterations was less in simplex alg. in %0.2f %%\n', counert_iter_lt/n * 100);
    disp('When both get the same result:');
    fprintf('The value of the function was the same in %0.2f %%\n',counert_fval/counert_det * 100);
    fprintf('The variables was the same in %0.2f %%\n', counert_x/counert_det * 100);
    disp('===========================')
end