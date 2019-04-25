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
    TF1first = find(TF1==1,1,'First') %locate the first local minumum
    dampingConstant = c2; %apply c2 to our linkageEQ
    [t2,y2] = ode23(@linkageEQ,tspan,y0);
    TF2 = islocalmin(y2(:,2)); %locate the local minimums
    TF2first = find(TF2~=0,1,'First') %locate the first local minimum
    y1(TF1first,2)
    y2(TF2first,2)
    
    if y1(TF1first,2) < -1*tol & y2(TF2first,2) < -1*tol %both estimates are underamped
        cL = cL + 1000 %shift the guesses to the right
        cU = cU + 1000
    elseif abs(y1(TF1first,1)) < abs(y2(TF2first,2)) %c1 is closer to critical than c2
        cU = c1 %set c1 as the new upper boundary, keep lower boundary
    elseif abs(y2(TF2first,2)) < abs(y1(TF1first,1)) %c2 is closer to critical than c1
        cL = c2 %set c2 as the new lower boundary, keep upper boundary
    end

    if abs(y1(TF1first,2)) < tol %close enough to critical damping
        %while criteria == 0
            %n = n + 1;
            %dampingConstant = c1;
            %[t,y] = ode23(linkageEQ,tspan,y0);
             %TF = islocalmin(y(:,2));
             %TFfirst = find(TF~=0,1,'First');
              %  if abs(y(TFfirst,2)) < tol
               % criteria = 1;
                %end
         %end
         criteria = 1; %end the while loop; c1 is the critical damping
    elseif abs(y2(TF2first,2)) < tol
        %while criteria == 0
            %n = n + 1;
            %dampingConstant = c2;
            %[t,y] = ode23(linkageEQ,tspan,y0);
            %TF = islocalmin(y(:,2));
            %TFfirst = find(TF~=0,1,'First');
            %if y(TFfirst,2) < tol
                %criteria = 1;
            %end
        %end
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
