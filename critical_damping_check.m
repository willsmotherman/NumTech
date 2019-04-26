function [cc] = critical_damping_check(y0,m,k)
% Critical Damping Check; the last part of the code
%   Detailed explanation

global dampingConstant

criteria = 0;
tau = 2*pi*sqrt(m/k); %solve for period of oscillation
tspan = [0 2*tau]; %timespan is two periods
phi = (1+sqrt(5))/2; %our golden ratio
cL = 0; %initial guesses
cU = 10000;
tol = 0.002*y0(2); %our tolerance?!
n = 0;
while criteria == 0
    n = n + 1;
    d = (phi-1)*(cU-cL); %our golden ratio-using value
    c1 = cL + d; %like x1
    c2 = cU - d; %like x2 from the book
    dampingConstant = c1; %apply c1 to linkageEQ
    [t1,y1] = ode23(@linkageEQ,tspan,y0); %run ODE23 for c1
    TF1 = islocalmin(y1(:,2)); %locate the local minima
    TF1first = find(TF1==1,1,'First'); %locate the first local minimum
    scalarcheck1 = isscalar(TF1first); %checks if c1 is overdamped/has a local minimum
    dampingConstant = c2; %apply c2 to linkageEQ
    [t2,y2] = ode23(@linkageEQ,tspan,y0); %run ODE23 for c2
    TF2 = islocalmin(y2(:,2)); %locate the local minima
    TF2first = find(TF2==1,1,'First'); %locate the first local minimum
    scalarcheck2 = isscalar(TF2first); %checks if c2 is overdamped/has a local minimum
    if scalarcheck1 == 0 %if c1 is overdamped:
        y_1 = y1(round(0.5*length(y1(:,2))),2); %observes c1 response at one period of oscillation
        %dampingConstant = c2; %apply c2 to our linkageEQ
        %[t2,y2] = ode23(@linkageEQ,tspan,y0);
        %TF2 = islocalmin(y2(:,2)); %locate the local minimums
        %TF2first = find(TF2~=0,1,'First'); %locate the first local minimum
        %scalarcheck2 = isscalar(TF2first);
        %if scalarcheck2 == 0
         %   y_2 = y2(round(0.5*length(y2(:,2))),2);
        %else
         %   y_2 = y2(TF2first,2);
        %end
        %if abs(y_1) < abs(y_2)
         %   cU = c1;
        %else
         %   cL = c2;
        %end
    else
        y_1 = y1(TF1first,2);
         %dampingConstant = c2; %apply c2 to our linkageEQ
        %[t2,y2] = ode23(@linkageEQ,tspan,y0);
        %TF2 = islocalmin(y2(:,2)); %locate the local minimums
        %TF2first = find(TF2~=0,1,'First'); %locate the first local minimum
        %scalarcheck2 = isscalar(TF2first);
         %if scalarcheck2 == 0 %c2 is overdamped
          %  y_1 = y1(TF1first,2)
           % y_2 = y2(round(0.5*length(y2(:,2))),2)
            %if abs(y_2) < abs(y_1)
             %    cL = c2;
            %else            
             %    cU = c1;
            %end
         %end
    end
    if scalarcheck2 == 0 %if c2 is overdamped/has no local minimum
        y_2 = y2(round(0.5*length(y2(:,2))),2);
    else
        y_2 = y2(TF2first,2);
    end
    if abs(y_1) < tol %close enough to critical damping
         criteria = 1; %end the while loop; c1 is the critical damping
    elseif abs(y_2) < tol
        criteria = 2; %end the while loop; c2 is the critical damping
    end
    if abs(y_1) < abs(y_2)
        cL = c2;
    else
        cU = c1;
    end
    if n == 50
        if abs(y1(TF1first,2)) < abs(y2(TF2first,2))
            y_1 = y1(TF1first,2);
            critera = 1;
        else
            y_2 = y2(TF2first,2);
            criteria = 2;
        end
    end
    
if criteria == 1
    plot(t1,y1(:,2));
    title('Response vs. Time');
    xlabel('Time (sec)');
    ylabel('Response (mm)');
    fprintf('The critical damping is approximately %f.',c1);
elseif criteria == 2
    plot(t2,y2(:,2));
    title('Response vs. Time');
    xlabel('Time (sec)');
    ylabel('Response (mm)');
    fprintf('The critical damping is approximately %f.',c2);
end
end
