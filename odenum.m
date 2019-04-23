function [t,y]=odenum(y0,tspan)
%solve ode with numerical methods
%Y0 should be 2-1 array for second order ode
%dy=function(t,y)
%second row of y is dy
t=tspan;
dt=t(2)-t(1);
n=length(tspan);
y=zeros(2,n);
y(1,1)=y0(1);
y(2,1)=y0(2);
f=zeros(2,n);
for i=2:n
    f(:,i-1)=func(t(i-1),y(:,i-1));
    y(1,i)=y(1,i-1)+f(1)*dt;
    y(2,i)=y(2,i-1)+f(2)*dt;
end
plot(t,y)
end