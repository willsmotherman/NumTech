
function dy = leverageCurve()
	x = [0:.01:51];
	%y = linkageRatio(x);
    for n = 1:length(x)
        y(n) = linkageRatio(x(n));
    end
	dy = diff(y)./.01;
    plot(y(1:length(x)-1),dy)
end