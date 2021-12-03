function test_without_ro(n, err_bound)
% Funkcja testująca/porównująca otrzymane wyniki dla algortymów linprog
% oraz własnej implementacji algorytmu sympleks dla przyjkładów
% nieposiadających rozwiązanie
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
    while iter < n
        [c, A, b, d] = generate_instance();
        [linprog_x, linprog_fval, linprog_exitflag, ~, ~] = linprog(-c, A, b, [], [], d);
        if linprog_exitflag < 0
            iter = iter + 1;
            [d_c, d_A, d_b, ~] = transform_to_dual(c, A, b, d);
            [ROx, ~, sympleks_exitflag, ~] = sympleks(-d_c, d_A, d_b, 0);
            if sympleks_exitflag < 0
                counert_exitflag = counert_exitflag + 1;
            end
        end
    end
    
    
    disp('===========================')
    fprintf('Linprog and my simplex get the same exitflag in %0.2f %%\n', counert_exitflag/n * 100);
    fprintf('Linprog and my simplex get the different exitflag in %0.2f %%\n', (1 - counert_exitflag/n) * 100);
    disp('===========================')
end