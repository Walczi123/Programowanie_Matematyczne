function test_with_ro(n, err_bound)
% Funkcja testująca/porównująca otrzymane wyniki dla algortymów linprog
% oraz własnej implementacji algorytmu sympleks dla przyjkładów
% posiadających rozwiązanie
% Input
% n - liczba iteracj (domyślnie 100)
% err_bound - pomijalny błąd (domyślnie 0.000001)
    if ~exist('n','var')
          n = 100;
    end

    if ~exist('err_bound','var')
          err_bound = 0.000001;
    end

    iter = 0;
    counert_exitflag = 0;
    counert_fval = 0;
    counert_x = 0;
    while iter < n
        [c, A, b, d] = generate_instance();
        [linprog_x, linprog_fval, linprog_exitflag, ~, ~] = linprog(-c, A, b, [], [], d);
        if linprog_exitflag > 0
            iter = iter + 1;
            [d_c, d_A, d_b, ~] = transform_to_dual(c, A, b, d);
            [ROx, ~, sympleks_exitflag, ~] = sympleks(-d_c, d_A, d_b, 0);
            if sympleks_exitflag > 0
                counert_exitflag = counert_exitflag + 1;
                sympleks_fval = c * ROx';
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
    disp('When both get the same result:');
    fprintf('The value of the function was the same in %0.2f %%\n',counert_fval/n * 100);
    fprintf('The variables was the same in %0.2f %%\n', counert_x/n * 100);
    disp('===========================')
end