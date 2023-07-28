function zad3_1_test()
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
            v = zeros(n);
            while v == zeros(size(v))
                c = randi([p1, p2]);
                v = c(ones(n, 1));
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


    plot([10: 10: n_max], analitical_its);
    title('analitical')
    figure()
    plot([10: 10: n_max], gold_its);
    title('gold')
    figure()
    plot( [10: 10: n_max], armijo_its);
    title('armijo')
   
end