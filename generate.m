function [A,b, p] = generate(n,m)
    A = 0;
    while m ~= rank(A)
        A = randi([-5, 5],[m,n]);
    end
    
    b = randi([-5, 5],[m,1]);
    p = randi([-5, 5],[n,1]);
end