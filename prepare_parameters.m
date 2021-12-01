function [c, A, cB, b, x_base, artificials, c_a] = prepare_parameters(in_c, in_A, in_b)
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
c_a = zeros(1,10);
A = in_A;
b = in_b;
cB = zeros(5,1);
x_base = zeros(5,1);

artificials = [];
counter = 11;
for i = 1:5
    if in_b(i) < 0
        A(i,:) = -A(i,:);
        b(i) = - in_b(i);
        j = i + 5;
    else
        A = [A, zeros(5,1)];
        A(i, counter) = 1;
        c = [c, 0];
        c_a = [c_a, -1];
        j = counter;
        counter = counter + 1;
        artificials = [artificials, j];
    end
    x_base(i) =  j;
    cB(i) = c(j);
end

end