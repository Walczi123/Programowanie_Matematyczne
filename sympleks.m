function [x, y, exitflag, i] = sympleks(in_c, in_A, in_b, in_d, show)
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
          show = 1;
    end
    

    x = -inf;
    y = -inf;
    exitflag = -3;
    round_param = 5;

    [c, A, cB, b, x_base] = prepare_parameters(in_c, in_A, in_b, in_d);

    i = 1;
    while true

        z = cB' * A;
        zc = z - c;
        zc = round(zc, round_param);
        [zc_min_val, k] = min(zc);

        if show == 1
            disp('=========')
            i
            disp('A')
            disp(A)
            disp('x_base')
            disp(x_base)
            disp('b')
            disp(b')
            disp('z-c')
            disp(zc)
%             disp('cB')
%             disp(cB')
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
%         res = round(res, round_param);
        res(isnan(res) |  isinf(res)) = Inf;
        [res_min_val, r]  = min(res);
    
        if isempty(res_min_val) || res_min_val == inf
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
%         b = round(b, round_param);
        
        A2 = A - ((A(r,:)/ark) .* A(:,k));
        A2(r,:) = A(r,:)/ark;
        A = A2;
%         A = round(A, round_param);
        
        i = i + 1;
    end
    if show == 1
        disp('end')
    end
end