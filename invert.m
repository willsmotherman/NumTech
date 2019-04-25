function y = invert(x)
	xAbs = x;
	xInit = x;
	y1 = 0;
	y2 = 51;
	x1 = linkageRatio(y1);
	x2 = linkageRatio(y2);
	ymid = (y1+y2)/2;
	xmid = linkageRatio(ymid);
	n = 1;
	while(n <18)
			if x>xmid
				y1 = ymid;
				x1 = xmid;
				ymid = (y1+y2)/2;
				xmid = linkageRatio(ymid);
			elseif x == xmid
				break
			else
				y2 = ymid;
				x2 = xmid;
				ymid = (y1+y2)/2;
				xmid = linkageRatio(ymid);
			end
			n = n+1;
	end
	y = ymid;



end