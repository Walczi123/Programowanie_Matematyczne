function ROx = calculate_rox(cB, AB, show)
% Funkcja wylicza pierwotne wartości x oraz wylicza wartośc funkcji celu,
% dla wprowadzonych parametrów.
% Input
% x_base - wektor bazowy
% b - wektor wartości wynikowych
% c - wektor współczynników funkcji celu
% show - parametr wyświetlania, jak w funkcji simpleks
% Output
% x - wektor parametrów wynikowych
% y - wartość funkcji celu dla x
    if show == 1
        disp('calculate_rox')
    end
    
    ROx = cB' * AB;
end