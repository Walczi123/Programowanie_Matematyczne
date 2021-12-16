function accuracy_test()
    clc;

    p1 = -10;
    p2 = 10;
       
    iter = 3;
    n_max =200;

    epsilon = 1e-6;
    error = 1e-4;

    analitical_x_part = 0;
    gold_x_part = 0;
    armijo_x_part = 0;

    analitical_f_part = 0;
    gold_f_part = 0;
    armijo_f_part = 0;
    
    x_part = 0;

    for n = 10: 10: n_max

        for j = 1:iter
            [A,b] = generate(n, p1, p2);
            f = @(x) 1/2*x' * A* x - b' * x;
            g = @(x) A * x - b;
            x0 = zeros(n,1);
                
            xExact = A' \ b;
            Exact_f_val = f(xExact);
        
            [analitical_xDFP,analitical_fval, analitical_it] = DFP(f, g, x0, epsilon, A, 'analitical');
            [gold_xDFP,gold_fval, gold_it] = DFP(f, g, x0, epsilon, A, 'gold');
            [armijo_xDFP,armijo_fval, armijo_it] = DFP(f, g, x0, epsilon, A, 'armijo');
        
            if norm(xExact - analitical_xDFP) < error
                analitical_x_part = analitical_x_part + 1;
            end

            if norm(xExact - gold_xDFP) < error
                gold_x_part = gold_x_part + 1;
            end

            if norm(xExact - armijo_xDFP) < error
                armijo_x_part = armijo_x_part + 1;
            end

            if abs(Exact_f_val - analitical_fval) < error
                analitical_f_part = analitical_f_part + 1;
            end

            if norm(Exact_f_val - gold_fval) < error
                gold_f_part = gold_f_part + 1;
            end

            if norm(Exact_f_val - armijo_fval) < error
                armijo_f_part = armijo_f_part + 1;
            end

            x_part =x_part + 1;
        end
    end

    disp('===========================')
    fprintf('NO iteratrions %f \n', x_part);
    disp('===========================')
    fprintf('DFP analitic accuracy (x) is equal %0.2f %%\n', analitical_x_part/x_part * 100);
    fprintf('DFP gold accuracy (x) is equal %0.2f %%\n', gold_x_part/x_part * 100);
    fprintf('DFP armijo accuracy (x) is equal %0.2f %%\n', armijo_x_part/x_part * 100);
    disp('===========================')
    fprintf('DFP analitic accuracy (fval) is equal %0.2f %%\n', analitical_f_part/x_part * 100);
    fprintf('DFP gold accuracy (fval) is equal %0.2f %%\n', gold_f_part/x_part * 100);
    fprintf('DFP armijo accuracy (fval) is equal %0.2f %%\n', armijo_f_part/x_part * 100);
    disp('===========================')
   
end