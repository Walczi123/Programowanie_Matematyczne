function zad3_3_test()
    clc;

    p1 = -10;
    p2 = 10;

    analitical_its =  [];
    gold_its =  [];
    armijo_its =  [];
       
    iter = 5;
    n_max =200;
    for n = 10: 10: n_max
        analitical_its_part = 0;
        gold_its_part = 0;
        armijo_its_part = 0;
        for j = 1:iter
            clus = [10, 20, 30, 40, 50];
            [~, k] = size(clus);
        
            v = zeros(n);
            while v == zeros(size(v))
                v = [];
                for i = 1 : k
                    l = ceil((i-1) * (n/k));
                    up = ceil(i * (n/k));
                    c = clus(i);
                    v = [v; c(ones(up-l, 1))];
                end
            end
            [A,b] = generate2(v, p1, p2);
        
            f = @(x) 1/2*x' * A* x - b' * x;
            g = @(x) A * x - b;
            x0 = zeros(n,1);
        
            [analitical_xDFP,analitical_fval,analitical_it] = DFP(f, g, x0, 1e-4, A, 'analitical');
            [gold_xDFP,gold_fval,gold_it] = DFP(f, g, x0, 1e-4, A, 'gold');
            [armijo_xDFP,armijo_fval,armijo_it] = DFP(f, g, x0, 1e-4, A, 'armijo');
        
            analitical_its_part = analitical_its_part + analitical_it;
            gold_its_part = gold_its_part + gold_it;
            armijo_its_part = armijo_its_part + armijo_it;
        end

        analitical_its(end+1) = analitical_its_part/iter;
        gold_its(end+1) = gold_its_part/iter;
        armijo_its(end+1) = armijo_its_part/iter;
    end

    disp('plot')
    disp(analitical_its)
    disp(gold_its)
    disp(armijo_its)
    plot([10: 10: n_max], analitical_its, [10: 10: n_max], gold_its, [10: 10: n_max], armijo_its);
    legend({'analitical','gold', 'armijo'},'Location','northeast')
   
end