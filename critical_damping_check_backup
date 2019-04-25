function [cc] = critical_damping_check(y0,m,k)
% Critical Damping Check; the last part of the code
%   Detailed explanation

global dampingConstant

criteria = 0;
tau = 2*pi*sqrt(m/k); %solve for period of oscillation
tspan = [0 2*tau]; %timespan is two periods
phi = (1+sqrt(5))/2; %our golden ratio
cL = 0; %initial guesses
cU = 1000;
tol = 0.01*y0; %our tolerance?!

while criteria == 0
    d = (phi-1)*(cU-cL); %our golden ratio-using value
    c1 = cL + d; %like x1
    c2 = cU - d; %like x2 from the book
    dampingConstant = c1; %apply c1 to our linkageEQ
    [t1,y1] = ode23(@linkageEQ,tspan,y0);
    TF1 = islocalmin(y1(:,2)); %locate the local minumums
    TF1first = find(TF1==1,1,'First'); %locate the first local minumum
    scalarcheck1 = isscalar(TF1first); %checks if c1 is overdamped
    if scalarcheck1 == 1;
        y_1 = y1(round(0.5*length(y1(:,2))),2); %observes c1 response at one period of oscillation
        dampingConstant = c2; %apply c2 to our linkageEQ
        [t2,y2] = ode23(@linkageEQ,tspan,y0);
        TF2 = islocalmin(y2(:,2)); %locate the local minimums
        TF2first = find(TF2~=0,1,'First'); %locate the first local minimum
        y_2 = y2(TF2first,2);
        if y_1 < abs(y_2)
            cU = c1;
        else
            cL = c2;
        end
    end
    dampingConstant = c2; %apply c2 to our linkageEQ
    [t2,y2] = ode23(@linkageEQ,tspan,y0);
    TF2 = islocalmin(y2(:,2)) %locate the local minimums
    TF2first = find(TF2~=0,1,'First') %locate the first local minimum
    scalarcheck2 = isscalar(TF2first);
    if scalarcheck2 == 1 %c2 is overdamped
        y_1 = y1(TF1first,2);
        y_2 = y2(round(0.5*length(y2(:,2))),2);
        if y_2 < abs(y_1)
            cL = c2;
        else
            cU = c1;
        end
    end
    if scalarcheck1 == 0 & scalarcheck2 == 0 %both systems are underdamped
        cL = cL + 1000;
        cU = cU + 1000;
    end
    
    if abs(y_1) < tol %close enough to critical damping
         criteria = 1; %end the while loop; c1 is the critical damping
    elseif abs(y_2) < tol
        criteria = 2; %end the while loop; c2 is the critical damping
    end
end

if criteria == 1
    axis = zeros(length(t1));
    plot(t1,y1(:,2),t1,axis,'--');
elseif criteria == 2
    axis = zeros(length(t2));
    plot(t2,y2(:,2),t2,axis,'--');
end
end
