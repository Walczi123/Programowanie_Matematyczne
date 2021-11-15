function [x, y] = calculate_solution(x_base, b, c, show)
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
        disp('calculate_solution')
    end
    [~,c_size] = size(c);
    [b_size,~] = size(b);
    x = zeros(c_size, 1);
   
    for i = 1:b_size
        x(x_base(i)) = b(i);
    end
    y = c * x;
    x = x(1:5) - x(6:10);
end