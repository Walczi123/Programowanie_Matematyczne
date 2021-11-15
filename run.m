function [c, A, b, d] = run()
    [c, A, b, d] = generate_instance();
    [linprog_x, linprog_fval, linprog_exitflag, output, lambda] = linprog(-c, A, b, [], [], d);
    [symplex_x, symplex_fval, symplex_exitflag] = symplex(c, A, b, d, 0);

    linprog_x
    symplex_x

    linprog_fval
    symplex_fval

    linprog_exitflag
    symplex_exitflag
end