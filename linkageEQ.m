%diff eq of bike
function ydot = linkageEQ(t,y)
	m = 60; %kg
	%175.1 N/m = 1 lb/in
	k = 60000; %N/m
	global dampingConstant 
	%global sag = 
    %dampingConstant = 5000;
	force = m*9.81; %i think this would take into account sag

	xdot = y(1);
	x = y(2);

	%xdotdot is axle travel, xdot and x are shaft travel
	%xdotdot = (force - dampingConstant.*xdot - k.*x)./m;
	%xdotdot = %TODO write this, need leverage curve as actual leverage curve as function of wheel travel
	xdotdot = (force - dampingConstant.*xdot/foo(invert(x)) - k.*invert(x))./m;
	% should k also take into acount outside force, ie gravity/sag?
	%could the initial position be set to sag, but idk how to make a bump then, maybe the initail is just a value we add to x?

	ydot = [xdotdot ; xdot];
end


