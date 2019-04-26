
function dy = leverageCurve(x)
	for n = 1:length(x)
        y(n) = linkageRatio(x(n));
    end
	dy = diff(y)./(x(2)-x(1));
    plot(y(1:length(x)-1),dy)
    title('Leverage Curve')
    xlabel('Axle Position(m)')
    ylabel('Leverage ratio')
end