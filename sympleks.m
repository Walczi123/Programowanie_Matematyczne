function [ROx, ROy, exitflag, iter] = sympleks(in_c, in_A, in_b, show)
% Funkcja implementująca algorytm sympleks dla zadania laboratoryjnego.
% Przyjmuje parametry opisane w zadaniu.
% Używa funkcji "prepare_parameters" oraz "calculate_solution" aby
% przetwożyć dane wejściowe na akceptowalne przez algorytm, a następnie
% zwrócić przeliczone wartości.
% Input
% in_c - wektor współczynników funkcji celu
% in_A - macierz współczynników
% in_b - wektor wartości odpowiadających wierszom z macierzy A
% in_d - ograniczenia dolne parametrów
% show - parametr określający wyświetalnie kolejnych iteracji algorytmu
% (domyślnie 1, czyli wyświetla)
% Output
% x - wektor parametrów wynikowych
% y - wartośc funkcji dla x
% exitflag - flaga oznaczająca znalezienie rozwiązania (jak linprog)
% i - ilość iteracji przeprowadzonych przez alg
    if ~exist('show','var')
          show = 0;
    end

    exitflag = -1;
    ROx = -inf;
    ROy = -inf;
 
    % Przygotowanie parametrów do obliczeń w algorymnie sympleks
    [c, A, cB, b, x_base, artificials, c_a] = prepare_parameters(in_c, in_A, in_b);
    
    len_artificials = length(artificials);
    if len_artificials > 0
        [y1, ~, exitflag1, iter, ~, x_base1, cB, b] = sympleks_part(c_a, A, cB, b, x_base, show);
        if exitflag1 < 0
             disp('---NO RO---')
             return
        end
        for i = 1:len_artificials
            a = artificials(i);
            if y1(a) > 0
                disp('---NO RO---')
                return
            end    
        end
          A(:,a) = [];
        c(a) = [];
        artificials = artificials - 1;
    end
    
    [ROx, ~, exitflag, it, out_A, ~, cB, ~] = sympleks_part(c, A, cB, b, x_base1, show);
    iter = iter + it;

    if exitflag < 0
         disp('---NO RO---')
         return
    end
    
    
    ROy = calculate_rox(cB, out_A, show);
    exitflag = 1;

    return;
end