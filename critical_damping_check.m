function [cc] = critical_damping_check([initial displacement],m,k)
% Critical Damping Check; the last part of the code
%   Detailed explanation

criteria = 0;
n = 0;
tau = 2*pi*sqrt(m/k); %solve for period of oscillation
tspan = [0 tau]; %tspan is the length of time for an oscillation- the period!
%y0 = [initial displacement from equilibrium... input?]

while criteria = 0
    n = n + 1;
    [t,y] = ode23(solode,tspan,y0);
    time(k) = t;
    response(k) = y;
    if y == 0 %close enough to critical damping; displacement after reaching equilibrium does not go too far past zero
        while critera = 0
            n = n + 1;
            [t,y] = ode23(solode,tspan,y0);
            time(n) = t;
            response(n) = y;
            if y > abs([portion of initial displacement])
                criteria = 1;
            end
        end
    end
end
%plot(time,response);
end

