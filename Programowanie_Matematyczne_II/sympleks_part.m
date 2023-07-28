function [x, y, exitflag, i, A, x_base, cB, b] = sympleks_part(c, A, cB, b, x_base, show, omit_zc)
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
% omit_zc - lista omijanych wartości zc (dla drugiej fazy alg, nie bierzemy
% zmiennych sztucznych pod uwage.

% Output
% x - wektor parametrów wynikowych
% y - wartośc funkcji dla x
% exitflag - flaga oznaczająca znalezienie rozwiązania (jak linprog)
% i - ilość iteracji przeprowadzonych przez alg
% A - macierz współczynników po zakończeniu obliczeń
% x_base - lista wektorów bazowych
% cB - wartości funkcji celu dla wektora bazowego
% b - wektor wartości odpowiadających wierszom z macierzy A po zakończeniu
% obliczeń

    if ~exist('omit_zc','var')
          omit_zc = [];
    end

    if ~exist('show','var')
          show = 1;
    end
    

    x = -inf;
    y = -inf;
    exitflag = -3;
    round_param = 5;

    i = 1;
    while true

        z = cB * A;
        zc = z - c;
        zc(omit_zc) = [];
        zc = round(zc, round_param);
        [zc_min_val, k] = min(zc);

        if show == 1
            disp('=========')
            i
            print_table(c,A,b,cB, x_base, z, zc);
            disp('=========')
        end
    
        if zc_min_val >= 0
            if show == 1
                disp('---optimum RO---')
            end
            [x, y] = calculate_solution(x_base, b, c, show);
            exitflag = 1;
            return;
        end
        
        tmp_A = max(A,0);
        tmp_Ak = tmp_A(:, k);
        res = b./tmp_Ak;
        res(isnan(res) |  isinf(res)) = Inf;
        [res_min_val, r]  = min(res);
    
        if isempty(res_min_val) | res_min_val == inf
            if show == 1
                disp('---NO RO---')
            end
            return;
        end
        
        ark = A(r, k);
        x_base(r) = k;
        cB(r) = c(k);
    
        b2 = b - ((A(:,k)/ark)*b(r));
        b2(r) = b(r)/ark;
        b = b2;
        
        A2 = A - ((A(r,:)/ark) .* A(:,k));
        A2(r,:) = A(r,:)/ark;
        A = A2;
        
        i = i + 1;
    end
end