function y = foo(x)
    r = leverageCurve(linspace(x-.001,x+.001,21));
    y = r(11);
end

