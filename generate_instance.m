function [c, A, b, d] = generate_instance()
    n = 5;
    m = 5;
    
    c = randi([-2, 2], 1, m);
    A = randi([-2, 2], n, m);
    b = randi([1, 5], n, 1);
    d = randi([-5, -1], 1, m);
end