function [c, A, cB, b, x_base, artificials, c_a, cB_a] = prepare_parameters(in_c, in_A, in_b)
% Funkcja sprowadzająca parametry wejsciowe do postaci akceptowalnej przez
% algorytmy sympleks.
% Input
% in_c - wektor współczynników funkcji celu ZD
% in_A - macierz współczynników ZD
% in_b - wektor wartości odpowiadających wierszom z macierzy A ZD
% Ouput
% c - wektor współczynników funkcji celu ZD (przekształcony)
% A - macierz współczynników (przekształcona)
% cB - wektor wartości dla wektora bazowego (przekształcony)
% b - wektor wartości odpowiadających wierszom z macierzy A (przekształcony)
% x_base - wektor indeksów parametrów bazowych
% artificials - wektory zmiennych sztucznych
% c_a - wektor współczynników funkcji celu dla pierwszej fazy algorytmu
% cB_a - wektor wartości dla wektora bazowego dla pierwszej  fazy algortymu (przekształcony)

c = in_c;
c_a = zeros(1,10);
A = in_A;
b = in_b;
cB = zeros(1,5);
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
    cB_a(i) = c_a(j);
end

end