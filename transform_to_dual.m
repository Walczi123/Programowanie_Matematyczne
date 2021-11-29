function [c_out, A_out, b_out, d_out] = transform_to_dual(c, A, b, d)
    A_out = [A', - eye(5,5)];
    c_out = [b, -d];
    b_out = c;
    d_out = zeros(10,1);
end