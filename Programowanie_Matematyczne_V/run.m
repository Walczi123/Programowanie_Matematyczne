function run()
    x = [0,0];
    y = [10, 10];
%     [P,r]=dane(x);
%     [Q,s]=dane(y);

    [P, Q, r, s] = generate_polygons(x, y)

    C = [P -Q];
    D = C'*C;
    m = r + s;
    A = [ones(1,r) zeros(1, s); zeros(1,r) ones(1, s)];
    b = [1;1];

    [x,fval,exitflag,output,lambda] = quadprog(2*D,[],[],[],A,b ,zeros(m,1),[]);
    eqlin = getfield(lambda,"eqlin")';
    ineqlin = getfield(lambda,"ineqlin")';
    lower = getfield(lambda,"lower")';
    upper = getfield(lambda,"upper")';
    
%     disp(x)
%     disp(lambda)
    l = x(1:r);
    p = P * l;
    m = x(r+1:end);
    q = Q * m;
    
    x0 = [ones(r,1)/r; ones(s,1)/s];
    y0 = [1;1];
    z0 =  (2 * D) * x0 - A'*y0;

    x0 = ones(r+s,1);
    y0 = [1;1];
    z0 = ones(r+s,1);
    [RO, f_opt, exitflag, it, LL_eqlin, LL_lower] = IPM(2*D, A, b, x0, y0, z0, 1e-6, 1e+3, 1e+3);

     RO = RO
     x = x
    o = RO(1:r);
    p1 = P * o;
    i = RO(r+1:end);
    q1 = Q * i;

    fill(P(1,:), P(2,:),'r')
    hold on
    fill(Q(1,:), Q(2,:),'b')
    hold on
    line([p(1), q(1)],[p(2), q(2)],'color', 'b')
    line([p1(1), q1(1)],[p1(2), q1(2)],'color', 'g')
    p1 = p1
    q1 = q1
    p = p
    q = q
    hold off
end