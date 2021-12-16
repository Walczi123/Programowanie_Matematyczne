function [A,b] = generate2(v, p1, p2)
    [n, ~] = size(v);
    D = diag(v);
    V = 0;
    while det(V) == 0
        V = randi([p1, p2],[n,n]);
    end

    A = V*D*V';
    b = randi([p1, p2],[n,1]);
end