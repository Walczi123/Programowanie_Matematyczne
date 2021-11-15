function [c, A, b, d] = generate_instance()
% Funkcja generująca paramtery losowe ograniczone jak w zadaniu
% laboratoryjnym (n = m = 5).
% Output
% c - wektor współczynników funkcji celu - [-2, 2]
% A - macierz współczynników - [-2, 2]
% b - wektor wartości odpowiadających wierszom z macierzy A - [1, 5]
% d - ograniczenia dolne parametrów - [-5, -1]
    n = 5;
    m = 5;
    
    c = randi([-2, 2], 1, m);
    A = randi([-2, 2], n, m);
    b = randi([1, 5], n, 1);
    d = randi([-5, -1], 1, m);
end