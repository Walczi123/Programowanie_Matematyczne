function [is_RO] = WKT(A, b, D, c, x, lambda, err_bound)
    if ~exist('err_bound','var')
          err_bound = 1e-4;
    end

    [d1, ~] = size(A);
    wktA = [D A'; A zeros(d1)];
    wktB = [- c; b];
    wktX = [x; lambda];


    result = wktA * wktX;
    is_RO = false;
    if abs(result - wktB) < err_bound
        is_RO = true;
    end
end