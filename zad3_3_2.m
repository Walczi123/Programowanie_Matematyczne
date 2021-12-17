function zad3_3(A, b)
    clc;
    n=30;
    p1 = -10;
    p2 = 10;    

    clus = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55];
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
    [A,b] = generate2(v, p1, p2)

    f = @(x) 1/2*x' * A* x - b' * x;
    g = @(x) A * x - b;
    x0 = zeros(n,1);
        
    xExact = A' \ b;

    [analitical_xDFP,analitical_fval,analitical_it] = DFP(f, g, x0, 1e-4, A, 'analitical',1);
    saveas(gcf,sprintf('pics/analytical-%d-%d.png',n,k));
    figure();
    [gold_xDFP,gold_fval,gold_it] = DFP(f, g, x0, 1e-4, A, 'gold',1);
    saveas(gcf,sprintf('pics/gold-%d-%d.png',n,k));
    figure();
    [armijo_xDFP,armijo_fval,armijo_it] = DFP(f, g, x0, 1e-4, A, 'armijo',1);
    saveas(gcf,sprintf('pics/armijo-%d-%d.png',n,k));
   
end