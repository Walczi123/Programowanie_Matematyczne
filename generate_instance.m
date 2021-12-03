function [c, A, b, d] = generate_instance()
% Funkcja generuje parametry w wyznaczonych przedziałach.
% Output
% c - współczynniki funkcji celu
% A - pierwotna macierz współczynników nierówności
% b - pierwotne wartości ograniczające nierówności
% d - dolne ograniczenie zmiennych
    n = 5;
    m = 5;
    
    c = randi([-2, 2], 1, m);
    A = randi([-2, 2], n, m);
    b = randi([1, 5], 1, n);
    d = randi([-5, -1], 1, m);
end