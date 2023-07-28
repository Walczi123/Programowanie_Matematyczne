function [xx, exitflag, it] = ZFK(D, c, A, b, x0, r, w, e, min_type)
    f = @(x) 1/2 * x' * D * x + c' * x;
    P = @(x, r) r * (sum((A*x-b).^2));

    exitflag = -1;
    x = x0;
    pp = 0;
    px = 0;
    it = 0;
    options = optimoptions('fminunc', 'CheckGradients', true, 'OptimalityTolerance', 1e-8, 'StepTolerance', 1e-8);
    while true
        it = it + 1;
        F = @(x) f(x) + P(x,r);
        switch min_type
            case 'DFP'
                G = @(x) D*x + c + 2 * r * A.'*(A*x-b);
                H = @(x) D+2*r*(A.'*A);
                [x, ~, ~] = DFP(F, G, x, 1e-4, H, 'analitical');
            case 'fminunc'
                x = fminunc(F, x, options);
            otherwise
                error("invalid min type")
        end
        p = P(x,r);
        if p <= e
            break;
        end
        if it~=1 && p > pp
            x = px;
            break;
        end
        pp = p;
        px = x;
        r = w*r;
    end
    exitflag = 1;
    xx = x;
end