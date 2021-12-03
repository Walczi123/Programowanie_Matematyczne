function print_table(c,A,b,cB, x_base, z, zc)
% Funkcja wyświetlająca tablekę algorytmu sympleks dla podanych wartości.

    fprintf('\n');
    space_v = " | ";
    space_h = "-------";
    len_c = length(c);

    fprintf('       c  | ');
    for i = 1:len_c
        if c(i) >= 0
            fprintf(' ');
        end
        fprintf('%d ' + space_v, c(i));
    end
    fprintf('\n');
    for i = 1:len_c
        fprintf('' + space_h);
    end
    fprintf('\n');

    fprintf(' cB' + space_v);
    fprintf('   ' + space_v);
    for i = 1:len_c
        if i < 10
            fprintf(' ');
        end
        fprintf('x%d' + space_v, i);
    end
    fprintf(' b' + space_v, i);
    fprintf('\n');

    for i = 1:len_c
        fprintf('' + space_h);
    end
    fprintf('\n');
    
    size_a = size(A);
    for i = 1:size_a(1)
        if cB(i) >= 0
            fprintf(' ');
        end
        fprintf(' %d' + space_v, cB(i));
        if x_base(i) < 10
            fprintf(' ');
        end
        fprintf('x%d' + space_v, x_base(i));
        for j = 1:size_a(2)
            if A(i,j) >= 0
                fprintf(' ');
            end
            fprintf('%d ', A(i,j));
            fprintf('' + space_v);
        end
        if b(i) >= 0
            fprintf(' ');
        end
        fprintf('%d' + space_v, b(i));
        fprintf('\n');
    end
    for i = 1:len_c
        fprintf("=======");
    end
    fprintf('\n');

    fprintf('   ' + space_v);
    fprintf(' z ' + space_v);
    for i = 1:len_c
        if z(i) >= 0
            fprintf(' ');
        end
        fprintf('%d ' + space_v, z(i));
    end
    fprintf('\n');

    fprintf('   ' + space_v);
    fprintf('z-c' + space_v);
    len_zc = length(zc);
    for i = 1:len_c
        if zc(i) >= 0
            fprintf(' ');
        end
        if len_zc < i
            fprintf('%d ' + space_v, zc(i));
        else
            fprintf('  ' + space_v);
        end
    end
    fprintf('\n');

end