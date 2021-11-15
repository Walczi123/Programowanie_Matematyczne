function [base, op, point, opt] = simplex_iter(c, base, op, point)
    c_base = c(base);
    z = op' * c_base;
    zmc = z - c;

    if all(zmc >= 0)
        opt = 1;
        return;
    end
    opt = 0;

    [~, i] = min(zmc);

    dv = point ./ op(:,i);
    dv(dv <= 0) = NaN;
    dv = abs(dv);

    if all(isnan(dv) | isinf(dv))
        opt = -1;
        return;
    end
       
    [v, j] = min(dv);

    op(j,:) = op(j,:) / op(j,i);
    point(j) = v;
    point(1:height(op) ~= j) = point(1:height(op) ~= j) - op(1:height(op) ~= j, i) * point(j);

    for n = 1:height(op)
        if n == j
            continue;
        end
        op(n,:) = op(n,:) - op(j,:) * op(n,i);
    end

    base(j) = i;
end

