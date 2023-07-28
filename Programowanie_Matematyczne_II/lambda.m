function lambda()
% Funkcja generuje nowe losowe parametry ZP, przekształca do ZD,
% dla których uruchamia algorytmy linprog
% i wyświetla mnożniki Langrang'a wraz z wynikowymi wektorami zmiennych.
    clc;
    [c, A, b, d] = generate_instance();
    [linprog_zp_x, linprog_zp_fval, linprog_zp_exitflag, output, lambda] = linprog(-c, A, b, [], [], d);
    [d_c, d_A, d_b, d_d] = transform_to_dual(c, A, b, d);
    [linprog_zd_x, linprog_zd_fval, linprog_zd_exitflag, output2, lambda2] = linprog(d_c, [], [], d_A, d_b, d_d);

    

    if linprog_zp_exitflag == 1
        linprog_zp_x = linprog_zp_x'

%         lower = getfield(lambda,"lower");
%         if ~isempty(lower)
%             lower= lower'
%         end
%         upper = getfield(lambda,"upper");
%         if ~isempty(upper)
%             upper = upper'
%         end
        eqlin = getfield(lambda,"eqlin")';
        if ~isempty(eqlin)
            eqlin
        end
        ineqlin = getfield(lambda,"ineqlin")';
        if ~isempty(ineqlin)
            ineqlin
        end
    end

    if linprog_zd_exitflag == 1
         linprog_zd_x = linprog_zd_x'

%         lower2 = getfield(lambda2,"lower");
%         if ~isempty(lower2)
%             lower2 = lower2'
%         end
%         upper2 = getfield(lambda2,"upper");
%         if ~isempty(upper2)
%             upper2 = upper2'
%         end
        eqlin2 = getfield(lambda2,"eqlin")';
        if ~isempty(eqlin2)
            eqlin2
        end
        ineqlin2 = getfield(lambda2,"ineqlin")';
        if ~isempty(ineqlin2)
            ineqlin2
        end
    end

    
end