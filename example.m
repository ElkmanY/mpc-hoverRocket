clear all;
clc;
%% System
T = 0.2; % Sampling intervel [s]
m = 2.5; % Mess of the rocket [kg]
g = 9.8; % Acceleration of gravity [m/(s^2)] 
A = [ 1 T
      0 1 ];
B = [ 0
      T/m ];
C = [ 1 0 ];
D = 0;
d = [ 0 
      0 ]; % Disturbance
x0 = [ 0.2
         0 ]; % Initial state
psys = idss(A,B,C,D,d,x0,T); % state-space model for prediction
%% MPC controller
p = 10; % Prediction horizon 
fmax = 100; % Maximum thrust [N]
eta = 0.6*T; % Rate factor 
ulmt = [ -m*g fmax-m*g ]; % Amplitude constraint of the control input [N]
dulmt = [-Inf eta*fmax ]; % Rate constraint of the control input [N/T]
lmt = struct('Min',ulmt(1),'Max',ulmt(2),'RateMin',dulmt(1),'RateMax',dulmt(2)); % Set constraints: amplitude and rate of the control input
setmpc = mpc(psys,T,p,[],[],lmt); % Set MPC controller
%% Simulation
r = 20; % Reference
st = 20; % Stop time of the simulation
open_system('mpc_example'); % Open the simulation file
sim('mpc_example',[0,st]); % Run the simulation
%% Plot simulation results
figure(1)
subplot(2,1,1);
stairs(u.Time,u.Data,'r','LineWidth',2); % Control input
title('Control Input','FontName','Times New Roman');
xlabel( 'Time [s]','FontName','Times New Roman');
ylabel( '{\it u} [N]','FontName','Times New Roman');
set(gca,'FontName','Times New Roman');
subplot(2,1,2);
plot(y.Time,r*ones(length(y.Time),1),'b--','LineWidth',2); % Reference
hold on
stairs(y.Time,y.Data,'r','LineWidth',2); % Output
hold off
legend( 'Reference', 'Output', 'Location','best');
title('Output','FontName','Times New Roman');
ylabel( '{\it y} [m]','FontName','Times New Roman');
xlabel( 'Time [s]','FontName','Times New Roman');
set(gca,'FontName','Times New Roman');