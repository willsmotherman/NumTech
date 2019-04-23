function dydt=fun(t,y)%,a,b,c,alpha,beta)
%ODE function to be solved by solver
%t,y are independent variables

dydt = zeros(2,1);
dydt(1) = y(2);
dydt(2) = 2*t.*y(1);    % forcing function here

end