function [xx, exitflag, it] = ZFK(A, p, x0, r, w, e, min_type)
    f = @(x) sum((x-p).^2);
    P = @(x, r) r * (sum((A*x).^2));

    exitflag = -1;
    x = x0;
    it = 0;
    options = optimoptions('fminunc', 'CheckGradients', true, 'OptimalityTolerance', 1e-8, 'StepTolerance', 1e-8);
    while true
        it = it + 1;
        F = @(x) f(x) + P(x,r);
        switch min_type
            case 'DFP'
                G = @(x) sum(2*x - 2*p) + r * (sum(2*A*x));
                [x, ~, ~] = DFP(F, G, x, 1e-4, A, 'analitical');
            case 'fminunc'
                x = fminunc(F, x, options);
            otherwise
                error("invalid min type")
        end      
        if P(x,r) < e
            break;
        end
        r = w*r;
    end
    exitflag = 1;
    xx = x;
end