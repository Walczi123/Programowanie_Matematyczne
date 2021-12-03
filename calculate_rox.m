function ROx = calculate_rox(cB, A, b, base, show)
% Funkcja wylicza rozwiązanie optymalne zadania prymalnego na podstawie
% wyniku zadania dualnego.
% Input
% cB - wartości funkcji celu z ZD dla wektora bazowego
% A - ostateczna macierz współczynników po przekształceniach
% b - wektor wartości prawej storny układu równań ZD
% base - pierwotna baza ZD
% show - parametr wyświetlania, jak w funkcji simpleks
% Output
% ROx - wektor parametrów wynikowych
    if show == 1
        disp('calculate_rox')
    end

    AB = A(:,base);

    for i = 1:5
        if b(i) < 0
            AB(:,i) = - AB(:,i);
        end
    end

    ROx = cB * AB;
end