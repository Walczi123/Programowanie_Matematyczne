function [X, y, opt] = my_linprog(c, A, b, d)
    w_count = 2 * width(A) + height(A) + height(d);
    h_count = height(A) + height(d);
    
    op = zeros(h_count, w_count);

    op(1:height(A), 2*(1:width(A)) - 1) = A;
    op(1:height(A), 2*(1:width(A))) = -A;

    for i = 1:height(d)
        op(height(A)+i, (2*i-1):(2*i)) = [-1 1];
    end

    op(:,(2 * width(A) + 1):w_count) = eye(height(A) + height(d));

    point = [b; -d];

    c2 = zeros(w_count,1);
    c2((1:height(c))*2 - 1) = c;
    c2((1:height(c))*2) = -c;

    base = (2 * width(A) + 1):w_count;
    opt = 0;

    it = 0
    op

    while opt == 0
        [base, op, point, opt] = simplex_iter(c2, base, op, point);
        it = it + 1
    end

    result = zeros(w_count, 1);
    result(base) = point;

    X = result((2 * (1:width(A))) - 1) - result((2 * (1:width(A))));
    y = c' * X;
end