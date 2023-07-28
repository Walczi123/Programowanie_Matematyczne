function [T,n]=dane(s)
%% s - punkt zaczepienia wielok¹ta
%  T - tablica wierzcho³ków wielok¹ta wypuk³ego
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