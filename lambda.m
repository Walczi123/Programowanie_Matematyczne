function lambda()
    [c, A, b, d] = generate_instance();
    [linprog_x, linprog_fval, linprog_exitflag, output, lambda] = linprog(-c, A, b, [], [], d);
    [d_c, d_A, d_b, d_d] = transform_to_dual(c, A, b, d);
    [linprog2_x, linprog2_fval, linprog2_exitflag, output2, lambda2] = linprog(d_c, [], [], d_A, d_b, d_d);

%     linprog_fval
%     linprog2_fval
% 
%     linprog_x
%     linprog2_x
%     lambda
%     if linprog_exitflag == 1
% %         lower = getfield(lambda,"lower")
% %         upper = getfield(lambda,"upper")
%         eqlin = getfield(lambda,"eqlin")
%         ineqlin = getfield(lambda,"ineqlin")
%     end
% 
%     if linprog2_exitflag == 1
% %         lower2 = getfield(lambda2,"lower")
% %         upper2 = getfield(lambda2,"upper")
%         eqlin2 = getfield(lambda2,"eqlin")
%         ineqlin2 = getfield(lambda2,"ineqlin")
%     end

    
end