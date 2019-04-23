%leverage ratio
%all non-shock values are estimated
%lower link
%leverage curve is derivative of axle movement as a function of shaft movement
function y = leverageCurve(x)
	y = -0.004*x.^2 + .2*x+1; %place holder for all the actual code
end
theta0 = 30; %deg, down from -x axis
length = 50; %mm


%shock

stroke = 51; %mm
e2e = 200; %mm
dStroke = 0; %mm Chnage as goes deeper in stroke, do as matrix or for loop
spos = e2e - dStroke; %mm.

%upper link

lengthToShock = 70; %mm
lengthToTri = 75;%mm
lengthBetween = 35; %mm
%calculate thetaUp based on law of cosines
thetaUp = 1; %rad

%rear triangle

lengthBetweenPivots = 280; %mm

%relationships

betweenUpAndShock = 225; %mm
betweenLowPivAndRearTop = 200; %mm (initial value, will change as moves through travel)
%

theta1Init = acos((betweenUpAndShock^2+lengthToShock^2-e2e.^2+)/(2*betweenUpAndShock*lengthToShock));
theta1 = acos((betweenUpAndShock^2+lengthToShock^2-spos.^2+)/(2*betweenUpAndShock*lengthToShock)); %theta1 as a relation of spos
dTheta1 = %TODO write this

theta2Init = thetaUp + theta1Init;
theta2 = thetaUp + theta1;

rearTopInit = [lengthToTri*cos(-theta2Init),lengthToTri*sin(-theta2Init)]
reatTop = [lengthToTri*cos(-theta2),lengthToTri*sin(-theta2)] - rearTopInit; %mm [i,j] 0,0 is defined as the resting position
%dRearTop = [-dTheta1*lengthToTri*sin(thetaUp+Theta1),-dTheta1*lengthToTri*cos(thetaUp+Theta1)]; % mm/s [i,j] THis may nit be right

lowPivotInit = 1;%TODO write this


