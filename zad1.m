function run()
    [A, b] = generate(8);
    x = quadprog(H,f,A,b,Aeq,beq,lb,ub,x0,options);
end
