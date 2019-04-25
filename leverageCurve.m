
function dy = leverageCurve(x)
	for n = 1:length(x)
        y(n) = linkageRatio(x(n));
    end
	dy = diff(y)./.01;
    
end