%sag

function y = sag(m,k)

x = [0:.0001:.051];
dy = leverageCurve(x);
initGuess = m*2.2*9.81/k;
n = find(abs(x-initGuess) < 0.00004);
%assuming that one iteration is good enough
g1 = m*dy(n)*9.81/k;
n = find(abs(x-g1)<.00004);
y = linkageRatio(x(n));



end
