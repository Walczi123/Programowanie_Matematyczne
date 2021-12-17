function [alfa_gold,it] = gold(F, alfa0, alfa_max, e)
    a = alfa0;
    b = alfa_max;
    c = 1 / ((1 + sqrt(5)) / 2);
    
    x1 = b - c * (b - a);       
    x2 = a + c * (b - a);
    F_x1 = F(x1);
    F_x2 = F(x2);

    it = 0;
    while abs(b-a)>=e
        if F_x2 > F_x1
            b = x2;
            x2 = x1;
            F_x2 = F_x1;
            x1 = b - c*(b-a);
            F_x1 = F(x1);
        else
            a  = x1;
            x1 = x2;
            F_x1 = F_x2;
            x2 = a + c*(b-a);
            F_x2 = F(x2);
        end
        it = it + 1;
    end
    alfa_gold = (a+b)/2;
end