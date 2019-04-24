function [cc] = critical_damping_check(y0,m,k)
% Critical Damping Check; the last part of the code
%   Detailed explanation

criteria = 0;
n = 0;
tau = 2*pi*sqrt(m/k); %solve for period of oscillation
tspan = [0 tau];

phi = (1+sqrt(5))/2;
cL = 0;
cU = 2;

while criteria = 0
    d = (phi-1)*(cU-cL);
    c1 = cL + d;
    c2 = cU - d;
    n = n + 1;
    [t1,y1] = ode23([some function],tspan,y0);
    [t2,y2] = ode23([some other function],tspan,y0);
    response1(n) = y1;
    response2(n) = y2;
    if [requirements for y1 and y2 to both be over or underdamped] %both estimates are either underdamped or overdamped
        cL = cL + 2;
        cU = cU + 2;
    elseif y1 < y2
        cU = c2;
    elseif y2 > y1
        cL = c1;
    end
        
    if y1 < [tolerance] || y2 < [tolerance] %close enough to critical damping; displacement after reaching equilibrium does not go too far past zero
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

