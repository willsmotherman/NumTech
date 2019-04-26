%main file
%numtech project
%ode23(@linkageEQ,[0 .7],[0;0.05])
leverageCurve([0:.00001:.051])
[a] = critical_damping_check([0;.050],60,60000);