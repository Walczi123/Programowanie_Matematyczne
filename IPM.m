function [RO, f_opt, exitflag, it, LL_eqlin, LL_lower] = IPM(D, A, b, x0, y0, z0, e, max_it, M)
    exitflag = -1;
    RO = nan;
    LL_eqlin=nan;
    LL_lower=nan;
    f_opt = nan;

    x = x0;
    y = y0;
    z = z0;
    n = size(x,1);
    m = size(y,1);
    sigma = 0.1; 
    k = 1; %0.2;
    it = 0;
    LL_eqlin=0;
    LL_lower=0;
    while true
        if sum(abs(b-A*x)) < e & sum(abs(-A'*y - z + D * x)) <e & z' *x < e
            break;
        end
        if max_it < it
            exitflag = 0;
            return;
        end
        if max(abs(x)) > M
            exitflag = -2;
            return;
        end
        if max(abs(y)) > M
            exitflag = -3;
            return;
        end

        r = sigma * ((z' * x)/(n+m));
        sigma = sigma * k;

        [dx, dy, dz] = direction(D, A, b, x, y, z, r);
        a = step_lenght(x, y, z, dx, dy, dz);

        x = x + a * dx;
        y = y + a * dy;
        z = z + a * dz;
        it = it + 1;
    end
    RO = x;
    LL_eqlin=-y;
    LL_lower=z;
    f_opt = 1/2 * RO' * D * RO;
    exitflag = 1;
end