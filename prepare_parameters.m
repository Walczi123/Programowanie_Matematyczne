function [c, A, cB, b, x_base] = prepare_parameters(in_c, in_A, in_b)
% Funkcja sprowadzająca parametry wejsciowe do postaci akceptowalnej przez
% algorytm sympleks.
% Input
% in_c - wektor współczynników funkcji celu
% in_A - macierz współczynników
% in_b - wektor wartości odpowiadających wierszom z macierzy A
% Ouput
% c - wektor współczynników funkcji celu
% A - macierz współczynników
% cB - wektor wartości dla wektora bazowego
% b - wektor wartości odpowiadających wierszom z macierzy A
% x_base - wektor indeksów parametrów bazowych
c = in_c;
A = in_A;
b = in_b;
cB = zeros(5,1);
x_base = zeros(5,1);

counter = 11;
for i = 1:5
    if in_b(i) < 0
        A(i,:) = -A(i,:);
        j = i;
    else
        A = [A, zeros(5,1)];
        A(i, counter) = 1;
        j = counter;
        counter = counter + 1;
        c = [c, 0];
    end
    x_base(i) = j;
    cB(i) = c(j);
end

end