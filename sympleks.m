function [ROx, ROy, exitflag, iter] = sympleks(in_c, in_A, in_b, show)
% Funkcja implementująca dwufazowy algorytm sympleks dla zadania laboratoryjnego.
% Przyjmuje parametry opisane w zadaniu.
% Input
% in_c - wektor współczynników funkcji celu
% in_A - macierz współczynników
% in_b - wektor wartości odpowiadających wierszom z macierzy A
% in_d - ograniczenia dolne parametrów
% show - parametr określający wyświetalnie kolejnych iteracji algorytmu
% (domyślnie 1, czyli wyświetla)
% Output
% ROx - wektor parametrów wynikowych dl zadania prymalnego
% ROy - wektor parametrów wynikowych dl zadania dualnego
% exitflag - flaga oznaczająca znalezienie rozwiązania (jak linprog)
% iter - ilość iteracji przeprowadzonych przez alg
    if ~exist('show','var')
          show = 0;
    end

    exitflag = -1;
    ROx = -inf;
    ROy = -inf;
    iter = 0;
 
    % Przygotowanie parametrów do obliczeń w algorymnie sympleks
    [c, A, cB, b, x_base, artificials, c_a, cB_a] = prepare_parameters(in_c, in_A, in_b);
    base = x_base;

    % Jezeli istnieją zmienne sztuczne to przejdz to pierwej fazy alg.
    len_artificials = length(artificials);
    if len_artificials > 0
        [y1, ~, exitflag1, iter, A, x_base, ~, b] = sympleks_part(c_a, A, cB_a, b', x_base, show);
        b = b';
        if exitflag1 < 0
             disp('---NO RO---')
             return
        end
        for i = 1:len_artificials
            a = artificials(i);
            if y1(a) ~= 0
                disp('---NO RO---')
                return
            end   
        end

        for j = 1:5
            cB(j) = c(x_base(j));
        end
    end
    
    % Druga faza algorytmu sympleks po wyeliminowaniu zmiennych sztucznych.
    [ROy, ~, exitflag, it, out_A, ~, cB, ~] = sympleks_part(c, A, cB, b', x_base, show, artificials);
    iter = iter + it;

    if exitflag < 0
         disp('---NO RO---')
         return
    end
     
    % Obliczanie rozwiązania zadania prymalnego
    ROx = calculate_rox(cB, out_A, in_b, base, show);
    exitflag = 1;

    return;
end