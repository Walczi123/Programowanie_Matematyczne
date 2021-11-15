function [c, A, cB, b, x_base] = prepare_parameters(in_c, in_A, in_b, in_d)
    Z = zeros(5,5);
    I = eye(5,5);
    
    c = [in_c, -in_c, zeros(1, 10)];
    A = [ in_A, -in_A, I, Z;
        -I, I, Z, I];
    cB = zeros(10,1);
    b = [in_b; -in_d'];
    x_base = (11:20);
end