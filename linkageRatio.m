
function y = linkageRatio(x)

	a = linkVect(x)-linkVect(0);
	y = sqrt(a(1)^2+a(2)^2);
end
