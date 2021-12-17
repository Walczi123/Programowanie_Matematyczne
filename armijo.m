function [alfa_armijo,it] = armijo(f, g, x, d, epsilon)  
    F0 = f(x);
    F0I = g(x)' * d;

    it = 1;
    K = 2;
    a = 1;
    p = 0.2;
    F = @(a) f(x + a*d);
    Fp = @(a) F0 + p * a * F0I;
    while F(a) > Fp(a)
        a = (1/K) * a;
        it = it + 1;
        if a < epsilon
            break;
        end
    end
    alfa_armijo = a;
end