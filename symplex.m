function [x, y, exitflag] = symplex(in_c, in_A, in_b, in_d, show)
% rozwiązanie zadania zadania dla linproga
%     clc;
%     clear;
    %     format compact;
    if ~exist('show','var')
          show = 1;
    end
    

    x = -inf;
    y = -inf;
    exitflag = -3;

    [c, A, cB, b, x_base] = prepare_parameters(in_c, in_A, in_b, in_d);

    for i = 1:100

        z = cB' * A;
        zc = z - c;
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
        
        A2 = A - ((A(r,:)/ark) .* A(:,k));
        A2(r,:) = A(r,:)/ark;
        A = A2;
        
    end
    if show == 1
        disp('end')
    end
end