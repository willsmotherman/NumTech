function dydt=func(t,y)%,a,b,c,alpha,beta)
%function for num method
%IT'S A SYSTEM SO Y IS AN ARRAY!
dydt=zeros(2,1);
dydt(1) = y(2);
dydt(2) = 2*t.*y(1);  

end