function [invf,t]=inverse(k,m,a)
%find the inverse of toinv(functional input to this function)
syms x
p=-k/m*x;
invf=finverse(toinv(p));%rhs is the function I
t=double(subs(I,x,a));%substituting with specific number
end