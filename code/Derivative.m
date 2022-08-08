function Deriv = Derivative(t, loc, p)
% compute derivative for the X, Y and Z over t
    x= loc(1);
    y= loc(2);
    z= loc(3);
    Deriv = zeros(3,1);
    dxdt = -p(1)*x + p(2)*x*y + p(3)*y*y + p(4)*y*y*y + p(5)*z + p(6)*z*z + p(7)*z*z*z + p(20);
    dydt = -p(8)*x*y - p(9)*x*x - p(10)*x*x*x + p(11)*y*(1-y) - p(12)*z - p(13)*z*z - p(14)*z*z*z + p(21);
    dzdt = p(15)*y + p(16)*y*y + p(17)*y*y*y - p(18)*z - p(19)*y*z;
    Deriv = [dxdt; dydt; dzdt];

