%leverage ratio
%all non-shock values are estimated
% this probably isn't a true leverage curve, but the axle position as a function of shaft position
%leverage curve is derivative of axle movement as a function of shaft movement
function y = leverageCurve(x)
	y = -0.004*x.^2 + .2*x+1; %place holder for all the actual code


%lower link
%theta0 = 30; %deg, down from -x axis
lengthLow = 50; %mm


%shock

stroke = 51; %mm
e2e = 200; %mm
dStroke = 0; %mm Chnage as goes deeper in stroke, do as matrix or for loop
spos = e2e - dStroke; %mm.
%sagPos = e2e - sag;%need to initilize sag somewhere, probably make global variable (UPDATE, i don't think i need this)

%upper link

lengthToShock = 70; %mm
lengthToTri = 75;%mm
lengthBetween = 35; %mm
%calculate thetaUp based on law of cosines
thetaUp = acos((lengthToTri^2+lengthToShock^2 - lengthBetween^2)/(2*lengthToShock*lengthToTri)); %rad

%rear triangle

lengthBetweenPivots = 280; %mm

%relationships

betweenUpAndOrigin = 225; %mm
%betweenLowPivAndRearTop = 200; %mm (initial value, will change as moves through travel)
betweenOriginAndLowPiv = 400; %mm
betweenUpAndLowPiv = 340;

thetaLowCor = acos((betweenUpAndOrigin^2 + betweenOriginAndLowPiv^2 - betweenUpAndLowPiv^2)/(2*betweenUpAndOrigin*betweenOriginAndLowPiv));

%

theta1Init = acos((betweenUpAndOrigin^2+lengthToShock^2 - e2e.^2+)/(2*betweenUpAndOrigin*lengthToShock));
%theta1Sag = acos((betweenUpAndOrigin^2+lengthToShock^2 - sagPos.^2+)/(2*betweenUpAndOrigin*lengthToShock)); %UPDATE, I don't think i need sag
theta1 = acos((betweenUpAndOrigin^2+lengthToShock^2 - spos.^2+)/(2*betweenUpAndOrigin*lengthToShock)); %theta1 as a relation of spos
%dTheta1 = %TODO write this

theta2Init = thetaUp + theta1Init;
theta2 = thetaUp + theta1;


%TODO: need to write part tomake rearTop absolute with refernce to origin( i think i did that now)
rearTopInit = [lengthToTri*cos(-theta2Init),lengthToTri*sin(-theta2Init)];
%reatTop = [lengthToTri*cos(-theta2),lengthToTri*sin(-theta2)] - rearTopInit; %mm [i,j] 0,0 is defined as the resting position
%dRearTop = [-dTheta1*lengthToTri*sin(thetaUp+Theta1),-dTheta1*lengthToTri*cos(thetaUp+Theta1)]; % mm/s [i,j] THis may nit be right
rearTop = [lengthToTri*cos(-theta2),lengthToTri*sin(-theta2)] + [-betweenUpAndOrigin,0]; %mm [i,j]

lowPivot = [betweenOriginAndLowPiv*cos(thetaLowCor),betweenOriginAndLowPiv*-1*sin(thetaLowCor)]; %mm [i,j]

betweenLowPivAndRearTop = lowPivot + rearTop; %mm [i,j]. this is NOT absolute, do not use is not a true value

thetaBottomLowTop = acos((betweenLowPivAndRearTop.^2+lengthLow^2-lengthBetweenPivots^2)./(2*betweenLowPivAndRearTop*lengthLow));
thetaTopLowX = atan(betweenLowPivAndRearTop(2)/betweenLowPivAndRearTop(1)); %should be positive

thetaLowPivot = thetaBottomLowTop+thetaTopLowX;
rearBottom = lowPivot + [lengthLow*cos(thetaLowPivot),lengthLow*sin(thetaLowPivot)];

%should now have rearBottom and rearTop in absolute coordinates [i,j]
%need to write part for axle travel based off of those positions

y = rearTop;

end