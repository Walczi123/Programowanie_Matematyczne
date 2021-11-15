function [c, A, cB, b, x_base] = prepare_parameters(in_c, in_A, in_b, in_d)
% Funkcja sprowadzająca parametry wejsciowe do postaci akceptowalnej przez
% algorytm sympleks.
% Input
% in_c - wektor współczynników funkcji celu
% in_A - macierz współczynników
% in_b - wektor wartości odpowiadających wierszom z macierzy A
% in_d - ograniczenia dolne parametrów
% Ouput
% c - wektor współczynników funkcji celu
% A - macierz współczynników
% cB - wektor wartości dla wektora bazowego
% b - wektor wartości odpowiadających wierszom z macierzy A
% x_base - wektor indeksów parametrów bazowych
    Z = zeros(5,5);
    I = eye(5,5);
    
    c = [in_c, -in_c, zeros(1, 10)];
    A = [ in_A, -in_A, I, Z;
        -I, I, Z, I];
    cB = zeros(10,1);
    b = [in_b; -in_d'];
    x_base = (11:20);
end