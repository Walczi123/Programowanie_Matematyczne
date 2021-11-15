function [c, A, b, d] = run()
% Funckja testowa, generująca losowe dane (zgodne z treścią zadania
% laboratoryjnego), uruchamiająca algorytm linprog oraz sympleks. Następnie
% wyświetlająca otrzymane rezultaty.
% Ouput - w celu odtworzenia wyniku
% c - wektor współczynników funkcji celu
% A - macierz współczynników
% b - wektor wartości odpowiadających wierszom z macierzy A
% d - ograniczenia dolne parametrów

    [c, A, b, d] = generate_instance();
    [linprog_x, linprog_fval, linprog_exitflag, ~, ~] = linprog(-c, A, b, [], [], d);
    [symplex_x, symplex_fval, symplex_exitflag] = symplex(c, A, b, d, 0);

    linprog_x
    symplex_x

    linprog_fval
    symplex_fval

    linprog_exitflag
    symplex_exitflag
end