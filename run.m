function run()
    [c, A, b, d] = generate_instance();
%     [linprog_x, linprog_fval, linprog_exitflag, output, lambda] = linprog(-c, A, b, [], [], d);
    [d_c, d_A, d_b, d_d] = transform_to_dual(c, A, b, d);
%     [linprog2_x, linprog2_fval, linprog2_exitflag, output2, lambda2] = linprog(d_c, d_A, d_b, [], []);
    [x, y, exitflag, i] = sympleks(-d_c, d_A, d_b, 0)

%     linprog_fval
%     linprog2_fval
%     lambda
%     linprog_iter = getfield(lambda,"lower");
%     linprog_iter = getfield(lambda,"uper");
%     linprog_iter = getfield(lambda,"eqlin");
%     linprog_iter = getfield(lambda,"ineqlin");
    
end