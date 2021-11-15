function [c, A, b, d] = test(n, err_bound)
    if ~exist('n','var')
          n = 100;
    end

    if ~exist('err_bound','var')
          err_bound = 0.000001;
    end
    
    counert_exitflag = 0;
    exitflag_error = 0;
    counert_fval = 0;
    counert_det = 0;
    counert_x = 0;
    for i = 1:n
        [c, A, b, d] = generate_instance();

%         options = optimset(@linprog);
%         options = optimset(options, 'Algorithm', 'interior-point');
% 
%         [linprog_x, linprog_fval, linprog_exitflag, output, lambda] = linprog(-c, A, b, [], [], d, [], [], options);

        [linprog_x, linprog_fval, linprog_exitflag, output, lambda] = linprog(-c, A, b, [], [], d);
        [symplex_x, symplex_fval, symplex_exitflag] = symplex(c, A, b, d, 0);
        if (linprog_exitflag == 1 && symplex_exitflag == 1) || (linprog_exitflag ~= 1 && symplex_exitflag ~= 1)
            counert_exitflag = counert_exitflag + 1;
%             if linprog_fval == -symplex_fval
            if linprog_exitflag == 1
                counert_det = counert_det + 1;
                error_fval = linprog_fval+symplex_fval;
                if error_fval < err_bound
                    counert_fval = counert_fval + 1;
%                 else
%                     disp('fval error');
%                     disp(error_fval);
                end
                error_x = abs(linprog_x) - abs(symplex_x);
                error_x(c == 0) = 0;
                if error_x < err_bound
                    counert_x = counert_x + 1;
%                 else
%                     disp('x error')
%                     disp(error_x)
%                     disp('c')
%                     disp(c)
                end
            end
        else
            if (linprog_exitflag == -3 && symplex_exitflag == 1) || (linprog_exitflag == 1 && symplex_exitflag == -3)
                exitflag_error = exitflag_error + 1
                disp('linprog_exitflag');
                disp(linprog_exitflag);
                disp('symplex_exitflag');
                disp(symplex_exitflag);
%                 r=input('asd\n')
%                 disp(r)
%                 if r == 1
%                     return;
%                 end
            else
                disp('linprog_exitflag');
                disp(linprog_exitflag);
                disp('symplex_exitflag');
                disp(symplex_exitflag);
                input('asd')
            end
        end
    end
    disp('Result exitflag');
    disp(counert_exitflag/n);
    disp('Error exitflag');
    disp(exitflag_error/n);
    disp('Result fval');
    disp(counert_fval/counert_det);
    disp('Result x');
    disp(counert_x/counert_det);
end