function f=lorenz_ext(t,X)
%
%   adapted from 
%   Vasiliy Govorukhin (2020). Calculation Lyapunov Exponents for ODE 
%   (https://www.mathworks.com/matlabcentral/fileexchange/4628-calculation-lyapunov-exponents-for-ode), 
%   MATLAB Central File Exchange. Retrieved June 15, 2020.
%

%%  
    global p;
    x=X(1); y=X(2); z=X(3);
    Y= [X(4), X(7), X(10);
    X(5), X(8), X(11);
    X(6), X(9), X(12)];
    f=zeros(9,1);
    
    % ODE equation
    f(1) = -p(1)*x + p(2)*x*y + p(3)*y*y + p(4)*y*y*y + p(5)*z + p(6)*z*z + p(7)*z*z*z + p(20);
    f(2) = -p(8)*x*y - p(9)*x*x - p(10)*x*x*x + p(11)*y*(1-y) - p(12)*z - p(13)*z*z - p(14)*z*z*z + p(21);
    f(3) = p(15)*y + p(16)*y*y + p(17)*y*y*y - p(18)*z - p(19)*y*z;
    
    %Linearized system
     Jac=Jacobian(X, p);
     
     %Variational equation   
    f(4:12)=Jac*Y;
    %Output data must be a column vector