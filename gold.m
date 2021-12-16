function [alfa_gold,it] = gold(f, alpha0, alpha_max, e)
    a = alpha0;
    b = alpha_max;
    c = 1 / ((1 + sqrt(5)) / 2);
    
    x1 = b - c * (b - a);       
    x2 = a + c * (b - a);
    f_x1 = f(x1);
    f_x2 = f(x2);

    it = 0;
    while abs(b-a)>=e
        if f_x2 > f_x1
            b = x2;
            x2 = x1;
            f_x2 = f_x1;
            x1 = b - c*(b-a);
            f_x1 = f(x1);
        else
            a  = x1;
            x1 = x2;
            f_x1 = f_x2;
            x2 = a + c*(b-a);
            f_x2 = f(x2);
        end
        it = it + 1;
    end
    alfa_gold = (a+b)/2;
end