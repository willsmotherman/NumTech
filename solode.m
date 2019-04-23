function Y=solode()%,a,b,c)
%solving ode

%Y0=[y0;dy0];  % initial conditions: [y0,dy0]'
Y0=[1;1];
Tspan=0:.1:1; % time span
options=odeset('RelTol',1e-5,'AbsTol',1e-5,'Stats','on');
[T,Y]=ode23(@(t,y) fun(t,y),Tspan,Y0,options);   % @(t,y) fun(t,y) abc should be input to fun %@(t,y) odefcn(t,y,A,B)
plot(T,Y)

end

