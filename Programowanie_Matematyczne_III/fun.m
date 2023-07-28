A_ = A;
b_ = b;

% A_ = A' * A;
% b_ = A' * b;

f = @(x) 1/2*x' * A_* x - b_' * x;
g = @(x) A_ * x - b_;
h = @(x) A_;