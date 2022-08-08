function J = Jacobian(loc, p)
% compute Jacobian at certain point under given parameters
    x= loc(1);
    y= loc(2);
    z= loc(3);
    J = zeros(3,3);
    
    J(1,1) = -p(1) + p(2)*y;
    J(1,2) = p(2)*x + 2*p(3)*y + 3*p(4)*y*y;
    J(1,3) = p(5) + 2*p(6)*z + 3*p(7)*z*z;
    J(2,1) = -p(8)*y - 2*p(9)*x - 3*p(10)*x*x;
    J(2,2) = -p(8)*x + p(11)*(1-2*y);
    J(2,3) = -p(12)- 2*p(13)*z - 3*p(14)*z*z;
    J(3,1) = 0;
    J(3,2) = p(15) + 2*p(16)*y + 3*p(17)*y*y - p(19)*z;
    J(3,3) = -p(18) - p(19)*y;
    
    
