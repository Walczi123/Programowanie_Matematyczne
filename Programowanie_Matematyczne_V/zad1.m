function zad1()
    x = [0,0];
    y = [30, 10];

    [P, Q, r, s] = generate_polygons(x, y, [10,20], [5,10]);

    C = [P -Q];
    D = C'*C;
    m = r + s;
    A = [ones(1,r) zeros(1, s); zeros(1,r) ones(1, s)];
    b = [1;1];
    
    options = optimoptions('quadprog','ConstraintTolerance', 1e-10, 'OptimalityTolerance', 1e-10);
    [x,fval,exitflag,output,lambda] = quadprog(2*D,[],[],[],A,b ,zeros(m,1),[],[], options);
%     eqlin = getfield(lambda,"eqlin")';
%     ineqlin = getfield(lambda,"ineqlin")';
%     lower = getfield(lambda,"lower")';
%     upper = getfield(lambda,"upper")';
    
    l = x(1:r);
    p = P * l;
    m = x(r+1:end);
    q = Q * m;

    fill(P(1,:), P(2,:),'r')
    hold on
    fill(Q(1,:), Q(2,:),'b')
    line([p(1), q(1)],[p(2), q(2)],'color', 'b')
    hold off
end