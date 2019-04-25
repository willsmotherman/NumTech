function [cc] = critical_damping_check(y0,m,k)
% Critical Damping Check; the last part of the code
%   Detailed explanation

global dampingConstant

criteria = 0;
n = 0;
tau = 2*pi*sqrt(m/k); %solve for period of oscillation
tspan = [0 2*tau]; %timespan is two periods
tstep = tspan/72; %there are 72 columns produced in ODE23
phi = (1+sqrt(5))/2; %our golden ratio
cL = 0; %initial guesses
cU = 1000;
tol = 0.01*y0;

while criteria == 0
    d = (phi-1)*(cU-cL);
    c1 = cL + d;
    c2 = cU - d;
    n = n + 1;
    dampingConstant = c1;
    [t1,y1] = ode23(@linkageEQ,tspan,y0);
    tstep1 = tspan/length(t1);
    TF1 = islocalmin(y1(:,2));
    TF1first = find(TF1~=0,1,'First');
    dampingConstant = c2;
    [t2,y2] = ode23(@linkageEQ,tspan,y0);
    tstep2 = tspan/length(t2);
    TF2 = islocalmin(y2(:,2));
    TF2first = find(TF2~=0,1,'First');
    
    if y1(TF1first,2) < -1*tol & y2(TF2first,2) < -1*tol %both estimates are underamped
        cL = cL + 1000
        cU = cU + 1000
    elseif y1(TF1first,1) < y2(TF2first,2) %c1 is closer to critical than c2
        cU = c1 %set c1 as the new upper boundary, keep lower boundary
    elseif y2(TF2first,2) < y1(TF1first,1) %c2 is closer to critical than c1
        cL = c2 %set c2 as the new lower boundary, keep upper boundary
    end

    if y1(TF1first,2) < tol %close enough to critical damping; displacement after reaching equilibrium does not go too far past zero
        while criteria == 0
            n = n + 1;
            dampingConstant = c1;
            [t,y] = ode23(linkageEQ,tspan,y0);
             TF = islocalmin(y(:,2));
             TFfirst = find(TF~=0,1,'First');
                if y(TFfirst,2) < tol
                criteria = 1;
                end
         end
    elseif y2(TF2first,2) < tol
        while criteria == 0
            n = n + 1;
            dampingConstant = c2;
            [t,y] = ode23(linkageEQ,tspan,y0);
            TF = islocalmin(y(:,2));
            TFfirst = find(TF~=0,1,'First');
            if y(TFfirst,2) < tol
                criteria = 1;
            end
        end
    end
end

xaxis = zeros(length(y1));
figure(1)
plot(t1,y1(:,2),t1,xaxis,'--');
xaxis2 = zeros(length(y2));
figure(2)
plot(t2,y2(:,2),t2,xaxis2,'--');
axis = zeros(length(y));
plot(t,y,t,axis,'--');

end

