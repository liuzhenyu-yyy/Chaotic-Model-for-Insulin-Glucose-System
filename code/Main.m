%% 	Mathematical Modeling in the Life Sciences -- Final Project
% Main function: A Chaotic Model for Insulin-Glucose System
% 
% @author: Zhen-Yu Liu (¡ı’Ò”Ó)
% @student ID: 1700017853
% @time: 2020.5.20
% 

%% 1. initialize parameters
p = [2.04 0.1 1.09 -1.08 0.03 -0.06 2.01 0.22 -3.84 -1.2 0.3 1.37 -0.3 0.22 0.3 -1.35 0.5 -0.42 -0.15 -0.19 -0.56];

%% 2. Time series and state space
initial_loc = [0.53, 1.31, 1.03];

% numeriacl simulation for the trajectory

% a1 = 3
p(1) = 3;
options = odeset('RelTol',1e-5); 
[t,loc] = ode45(@Derivative, [0, 200], initial_loc, options, p);

subplot(3,1,1)
plot(t,loc(:,1),'-b')
xlim([180,200]); ylim([0.4,0.8]);ylabel('X');
subplot(3,1,2)
plot(t,loc(:,2),'-r')
xlim([180,200]); ylim([0.5,1.5]);ylabel('Y');
subplot(3,1,3)
plot(t,loc(:,3),'-k')
xlim([180,200]); ylim([0.9,1.1]);ylabel('Z');xlabel('Time');

% a1 = 2.04
p(1) = 2.04;
options = odeset('RelTol',1e-5); 
[t,loc] = ode45(@Derivative, [0, 200], initial_loc, options, p);

subplot(3,1,1)
plot(t,loc(:,1),'-b')
xlim([180,200]); ylim([0,1.5]);ylabel('X');
subplot(3,1,2)
plot(t,loc(:,2),'-r')
xlim([180,200]); ylim([0,2]);ylabel('Y');
subplot(3,1,3)
plot(t,loc(:,3),'-k')
xlim([180,200]); ylim([0.5,1.5]);ylabel('Z');xlabel('Time');

% visulize trajectory and attractor
plot3(loc(:,1),loc(:,2),loc(:,3))
subplot(1,3,1)
plot(loc(:,1),loc(:,2),'-k');xlabel('X');ylabel('Y');
subplot(1,3,2)
plot(loc(:,1),loc(:,3),'-k');xlabel('X');ylabel('Z');
subplot(1,3,3)
plot(loc(:,2),loc(:,3),'-k');xlabel('Y');ylabel('Z');

%% 3. Equilibria and Stability analysis
% solve equilibria
equi_loc = SolveEquilibria(p);   % 2 equilibria

% calculate Jacobians
J1 = Jacobian(equi_loc(1,:),p);
J2 = Jacobian(equi_loc(2,:),p);

% calculate eigenvalue and eigenvectors for Jacobians
[V1, D1] = eig(J1);
[V2, D2] = eig(J2);

D1 = diag(D1);
D2 = diag(D2);

%% 4. Bifurcation diagrams and relevant desease
initial_loc = [0.53, 1.31, 1.03];
N_peroid = 30000;

% bifurcation diagram of a_8
Bifurcation(8, 0.4, 2, 0.002, initial_loc, N_peroid, p)
% bifurcation diagram of a_1
Bifurcation(1, 2.2, 3.3, 0.002, initial_loc, N_peroid, p)
% bifurcation diagram of a_7
Bifurcation(7, 1.2, 2.1, 0.002, initial_loc, N_peroid, p)
% bifurcation diagram of a_15
Bifurcation(15, 0.3, 0.4, 0.0002, initial_loc, N_peroid, p)

%% 5. Lyapunov Exponents and chaotic behavior

% Dynamics of Lyapunov exponents under initial parameters
p(1) = 2.04;
[T,Res]=lyapunov(3,@lorenz_ext,@ode45,0,0.5,500,initial_loc,10);
plot(T,Res);
title('Dynamics of Lyapunov exponents with a_1 = 2.04');
xlabel('Time'); ylabel('Lyapunov exponents');

p(1) = 2.85;
[T,Res]=lyapunov(3,@lorenz_ext,@ode45,0,0.5,500,initial_loc,10);
plot(T,Res);
title('Dynamics of Lyapunov exponents with a_1 = 2.85');
xlabel('Time'); ylabel('Lyapunov exponents');

% Lyapunov Exponents of peroidic orbits under different a_1 parameter
delta_a1 = 0.002;
LyapunovExp = [];

for a = 2.2:delta_a1:3.3
    p(1)=a;
    [T,Res]=lyapunov(3,@lorenz_ext,@ode45,0,0.5,300,initial_loc,0);
    disp(['current value of a1 is '  num2str(a)]);
    LyapunovExp = [LyapunovExp;Res(end, :)];
end
p(1) = 2.04;

plot(2.2:delta_a1:3.3,LyapunovExp);
title('Lyapunov exponent diagram based on a_1');
xlabel('a_1'); ylabel('¶À');

%% 6. Sensitivity to initial condition
initial_loc_1 = [0.53, 1.31, 1.03];
initial_loc_2 = [0.54, 1.31, 1.03];

options = odeset('RelTol',1e-5); 
[t_1,loc_1] = ode45(@Derivative, [0, 200], initial_loc_1, options, p);
[t_2,loc_2] = ode45(@Derivative, [0, 200], initial_loc_2, options, p);

plot(t_1,loc_1(:,2))
hold on
plot(t_2,loc_2(:,2))
xlim([0,30]); ylim([0.4,2]);ylabel('Glucose');xlabel('Time');
legend('x_0 = 0.53','x_0 = 0.54')

%% 7.Performance on intravenous glucose tolerance test (IVGTT)

% physiological condition
p(1) = 3;
options = odeset('RelTol',1e-5); 
[t,loc] = ode45(@Derivative, [0, 200], initial_loc, options, p); 

% adjust for units
Y_inject = 0.33/180.16*1000/(0.08/1.053); % unit: mmol/L
Y_max = max(loc(end-1000:end,2));
Y_min = min(loc(end-1000:end,2));
ratio = (Y_max-Y_min)/(6.1-3.9);
Y_inject = Y_inject * ratio; %Y_inject = 4.4417

% rapid injection of glucose (IVGTT) at the maximum value of Y
find(loc(:,2)==Y_max) % 4011
t_1 = t(1:4011);
loc_1 = loc(1:4011,:);

temp_loc = loc_1(end,:);
temp_loc(2) = temp_loc(2) + 0.65; % maximum tolerance for the model
[t_2,loc_2] = ode45(@Derivative, [0, 200], temp_loc, options, p);

plot(t_2,loc_2(:,2),'-b')

t_2 = t_2 + t_1(end);
t_all = [t_1(end-400:end); t_2(1:1000)];
loc_all = [loc_1(end-400:end,:); loc_2(1:1000,:)];

subplot(3,1,1)
plot(t_all,loc_all(:,1),'-b'); line([164 164],[0,1.35],'Color','red');
xlim([150,200]); ylim([0,1.35]);ylabel('X'); 
subplot(3,1,2)
plot(t_all,loc_all(:,2),'-r'); line([164 164],[0,2.3],'Color','red');
xlim([150,200]);  ylim([0,2.3]); ylabel('Y');
subplot(3,1,3)
plot(t_all,loc_all(:,3),'-k');line([164 164],[0.6,1.5],'Color','red');
xlim([150,200]);  ylim([0.6,1.5]); ylabel('Z');xlabel('Time');

% rapid injection of glucose (IVGTT) at the minumum value of Y
find(loc(:,2)==Y_min) % 4844
t_1 = t(1:4844);
loc_1 = loc(1:4844,:);

temp_loc = loc_1(end,:);
temp_loc(2) = temp_loc(2) + 1.3; % maximum tolerance for the model
[t_2,loc_2] = ode45(@Derivative, [0, 200], temp_loc, options, p);

plot(t_2,loc_2(:,2),'-b')

t_2 = t_2 + t_1(end);
t_all = [t_1(end-400:end); t_2(1:1000)];
loc_all = [loc_1(end-400:end,:); loc_2(1:1000,:)];

subplot(3,1,1)
plot(t_all,loc_all(:,1),'-b'); line([198.1 198.1],[0,1.35],'Color','red');
xlim([190,225]); ylim([0,1.35]);ylabel('X'); 
subplot(3,1,2)
plot(t_all,loc_all(:,2),'-r'); line([198.1 198.1],[0,2.3],'Color','red');
xlim([190,225]);  ylim([0,2.3]); ylabel('Y');
subplot(3,1,3)
plot(t_all,loc_all(:,3),'-k');line([198.1 198.1],[0.6,1.5],'Color','red');
xlim([190,225]);  ylim([0.6,1.5]); ylabel('Z');xlabel('Time');

%% 8.Performance on oral glucose tolerance test (OGTT)
% physiological condition
p(1) = 3;
options = odeset('RelTol',1e-5); 
[t,loc] = ode45(@Derivative, [0, 200], initial_loc, options, p); 

t_1 = t(1:4011);
loc_1 = loc(1:4011,:);

temp_loc = loc_1(end,:);
[t_2,loc_2] = ode45(@Derivative_OGTT, [0, 33], temp_loc, options, p); 

t_2 = t_2 + t_1(end);

temp_loc = loc_2(end,:);
[t_3,loc_3] = ode45(@Derivative, [0, 40], temp_loc, options, p); 

t_3 = t_3 + t_2(end);


t_all = [t_1(end-400:end); t_2; t_3];
loc_all = [loc_1(end-400:end,:); loc_2;loc_3];

subplot(3,1,1)
plot(t_all,loc_all(:,1),'-b'); line([164 164],[0,1.35],'Color','red');
line([197 197],[0,1.35],'Color','blue');
xlim([150,220]); ylim([0,1.35]);ylabel('X'); 
subplot(3,1,2)
plot(t_all,loc_all(:,2),'-r'); line([164 164],[0,2.3],'Color','red');
line([197 197],[0,2.3],'Color','blue');
xlim([150,220]);  ylim([0,2.3]); ylabel('Y');
subplot(3,1,3)
plot(t_all,loc_all(:,3),'-k');line([164 164],[0.6,1.5],'Color','red');
line([197 197],[0.6,1.5],'Color','blue');
xlim([150,220]);  ylim([0.6,1.5]); ylabel('Z');xlabel('Time');