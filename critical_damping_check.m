function [outputArg1] = critical_damping_check(inputArg1)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = inputArg1;
criteria = 0;
k = 0;
%y0 = [initial displacement from equilibrium... input?]
while criteria = 0
    k = k + 1;
    tau = 2*pi*sqrt(m/k); %solve for period of oscillation
    tspan = [0 tau]; %tspan is the length of time for an oscillation- the period!
    [t,y] = ode23(ODEFUN,tspan,y0);
    time(k) = t;
    response(k) = y;
    if %close enough to critical damping; velocity at equilibrium is less than a certain portion of initial velocity
        critera = 1;
    end
end
%plot(time,response);
end

