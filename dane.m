function [T,n]=dane(s)
%% s - punkt zaczepienia wielok�ta
%  T - tablica wierzcho�k�w wielok�ta wypuk�ego
%%

    r=5;
    start=1/randi([10,20],1,1);
    krok=2*start;
    t = (start:krok:1)'*2*pi;
    
    T(1,:) = s(1)+r*cos(t);    %x
    T(2,:) = s(2)+r*sin(t);    %y
    n = size(T);
    n = n(2);
end