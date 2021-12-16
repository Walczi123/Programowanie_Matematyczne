function a_max = alfa_max(F, a0, delta)
    a1 = a0;
    a3 = a1 + delta;
        
    a = a1 + delta;
    if F(a1) <= F(a)
        a3 = a;
        a2 = (a1+a3)/2;
        while F(a1) < F(a2) || F(a2) > F(a3)
            a3 = a2;
            a2 = (a1+a2)/2;
        end
    else
        a2 = a;
        a3 = a2 + delta;
        while (F(a1) < F(a2)) || (F(a2) > F(a3))
            delta = 2 * delta;
            a3 = a2 + delta;
        end
    end
    a_max = a3;
end