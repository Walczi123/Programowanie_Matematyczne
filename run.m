function run(A,b)
    clc;
    n=10;
    p1 = -10;
    p2 = 10;

    [A,b] = generate(n, p1, p2);
    
    A_ = A;
    b_ = b;

    f = @(x) 1/2*x' * A_* x - b_' * x;
    g = @(x) A_ * x - b_;
    h = @(x) A_;

    alpha0 = 0;
    x0 = zeros(n,1);
    d0 = -g(x0);
%     alpha_max = 0.01; % TODO
    
%     F = @(x, a) f(x0 + a * d0);
    alpha_max = alfa_max(@(a) f(x0 + a * d0), alpha0, 1e-4);
    
%     [X,FVAL,EXITFLAG] = fminbnd(F,alpha0,alpha_max,optimset('Display','iter'));
%     [my_X, my_it] = gold(F, alpha0, alpha_max, 1e-4)
%     fplot(F,[alpha0, alpha_max]);
%     X = X
%     my_X = my_X

%     [alfa_armijo,it] = armijo(f, g, x0, d0, alpha_max, 1e-4);

% 
%     X = X
%     alfa_armijo = alfa_armijo
    
    xExact = A' \ b;

%     options = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'Display', 'iter', 'CheckGradients', true);
%     [x,fval,exitflag,output,grad,hessian] = fminunc(f,x0,options) 

%     DFP_min_fun = @(alpha0, alpha_max, e) gold(F, alpha0, alpha_max, e)
    xExact =xExact
    [xDFP,fval,it] = DFP(f, g, x0, 1e-4, A, 'gold')
%     [xDFP,fval,it] = DFP_ala(f, x0, 1e-4, g, A, 'gold')

    disp(norm(xExact-xDFP))
end