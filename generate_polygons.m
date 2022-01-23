function [P, Q, r, s]=generate_polygons(p, q, n_range, r_range)
    if ~exist('n_range','var')
          n_range = [6, 12];
    end
    if ~exist('r_range','var')
          r_range = [3, 6];
    end

    r1 = randi(r_range);
    n1 = randi(n_range);
    t1 = (0:1/n1:1)'*2*pi;
    t1 = t1 + rand();
    P(1,:) = p(1)+r1*cos(t1);    %x
    P(2,:) = p(2)+r1*sin(t1);    %y
    r = n1 + 1;

    r2 = randi(r_range);
    n2 = randi(n_range) ;
    t2 = (0:1/n2:1)'*2*pi;
    t2 = t2 + rand();
    Q(1,:) = q(1)+r2*cos(t2);    %x
    Q(2,:) = q(2)+r2*sin(t2);    %y
    s = n2 + 1;
end