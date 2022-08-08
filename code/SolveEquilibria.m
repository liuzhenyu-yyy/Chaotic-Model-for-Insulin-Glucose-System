function equi = SolveEquilibria(p)
% solve equilibrias under given parameter set p
% returns the coordinates of equilibria, saved in rows
    
    %create symbolic expressions
    syms x y z;
    eq1 = -p(1)*x + p(2)*x*y + p(3)*y*y + p(4)*y*y*y + p(5)*z + p(6)*z*z + p(7)*z*z*z + p(20);
    eq2 = -p(8)*x*y - p(9)*x*x - p(10)*x*x*x + p(11)*y*(1-y) - p(12)*z - p(13)*z*z - p(14)*z*z*z + p(21);
    eq3 = p(15)*y + p(16)*y*y + p(17)*y*y*y - p(18)*z - p(19)*y*z;
    
    % solve equilibrias using built-in solve function
    [x,y,z] = solve(eq1,eq2,eq3,'x,y,z');
     
    % convert symbolic expressions into complex number
    x = double(x);
    y = double(y);
    z = double(z);
    
    % filter reasonable solutions: positive and real
    x_select = (real(x)>0) & (imag(x)==0);
    y_select = (real(y)>0) & (imag(y)==0);
    z_select = (real(z)>0) & (imag(z)==0);

    select = x_select & y_select & z_select;

    x = x(select);
    y = y(select);
    z = z(select);
    
    % generate output: coordinates of equilibrias
    equi = [x,y,z];