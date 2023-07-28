function [A,b] = generate(n, p1, p2)
    A = 0;
    while det(A) == 0
        A = randi([p1, p2],[n,n]);
    end
    A = A + A';
    A = A * A';

    b = randi([p1, p2],[n,1]);
end