function [xDFP,fval,it]=DFP(f, g, x0, epsilon, A, min_type, plot)
   if ~exist('plot','var')
          plot = 0;
    end

    n = size(x0);
    H = eye(n(1));
    it = 0;
    x = x0;
    g_norms = [];
    while norm(g(x)) > epsilon  
        g_norms(end + 1) = norm(g(x));
        d = - H * g(x);

        switch min_type
            case 'analitical'
                a = (-g(x)' * d) / (d' * A * d);
            case 'gold'
                alpha_max = alfa_max(@(a) f(x + a * d), 0, 1);
                [alfa_gold, ~] = gold(@(a) f(x + a * d), 0, alpha_max, 1e-4);
                a = alfa_gold;
            case 'armijo'
                [alfa_armijo, ~] = armijo(f, g, x, d, 1e-4);
                a = alfa_armijo;
            otherwise
                error("invalid min type")
        end

        x1 = x + a * d;
        s = x1 - x;
        r = g(x1) - g(x);
        dH = ((s * s') / (s' * r)) - ((H * r * r' * H) / (r' * H * r));
        H = H + dH;
        it = it + 1;
        x = x1;
    end
    g_norms(end + 1) = norm(g(x));
    xDFP = x;
    fval = f(x);

    if plot == 1
        plot([1:it + 1], g_norms);
    end 
end