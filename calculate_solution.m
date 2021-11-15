function [x, y] = calculate_solution(x_base, b, c, show)
    if show == 1
        disp('calculate_solution')
    end
    [~,c_size] = size(c);
    [b_size,~] = size(b);
    x = zeros(c_size, 1);
   
    for i = 1:b_size
        x(x_base(i)) = b(i);
    end
%     x;
    y = c * x;
    x = x(1:5) - x(6:10);
end