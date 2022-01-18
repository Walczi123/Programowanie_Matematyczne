function run()
    x = [0,0];
    y = [10, 10];
    [P,r]=dane(x);
    [Q,s]=dane(y);

    C = [P -Q];
    D = C'*C;
    m = r + s;

    [x,fval,exitflag,output,lambda] = quadprog(2*D,[],[],[],[ones(1,r) zeros(1, s); zeros(1,s) ones(1, r)],[1;1],zeros(m,1),[])
    disp(x)
    disp(lambda)
    l = x(1:r)
    p = P * l
    m = x(r+1:end)
    q = Q * m
    
    fill(P(1,:), P(2,:),'r')
    hold on
    fill(Q(1,:), Q(2,:),'b')
    hold on
    p = p
    q = q
    line([p(1), q(1)],[p(2), q(2)],'color', 'b')
    hold off
end