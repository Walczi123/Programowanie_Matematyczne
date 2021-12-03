function [c, A, b, d] = run(c, A, b, d)
% Funkcja testowa - stworzona do badania poprawności algortymu dla jednego
% przykładu.
%     [c, A, b, d] = generate_instance();
    [linprog_x, linprog_fval, linprog_exitflag, output, lambda] = linprog(-c, A, b, [], [], d);
    [d_c, d_A, d_b, d_d] = transform_to_dual(c, A, b, d);
    [linprog2_x, linprog2_fval, linprog2_exitflag, output2, lambda2] = linprog(d_c, [], [], d_A, d_b, d_d);
    [ROx, ROy, sympleks_exitflag, sympleks_iter] = sympleks(-d_c, d_A, d_b, 1);

    linprog_exitflag
    linprog2_exitflag
    sympleks_exitflag   

    linprog_x=linprog_x'
    linprog2_x=linprog2_x'
    sympleks_x = ROx'

    linprog_fval
    linprog2_fval
    sympleks_fval = c * sympleks_x
end