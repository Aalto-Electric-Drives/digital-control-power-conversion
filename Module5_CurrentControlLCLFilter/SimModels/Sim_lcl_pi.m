clear; close all; fig_settings;  

%% Actual system parameters
ug0Act = 300;                                   % Initial value
LfcAct = 3e-3; CfAct = 10e-6; LfgAct = 2e-3;    % LCL filter

% H-bridge converter
Udc = 350; uMax = Udc; 
Ts = 150e-6; 
Tsw = Ts;       % Single-update PWM
%Tsw = 2*Ts;    % Double-update PWM
% Current measurement noise
sigmaNoise = 0*.1;   % Standard deviation
TNoise = Ts;        % Correlation time

%% Parameter estimates and gains for the controller
Lfc = LfcAct; ug0 = ug0Act;

% Calculate the gains
% Tuning parameters
alphac = 2*pi*600;  % Controller: bandwidth
beta = exp(-alphac*Ts);

% Discrete-time plant
a = 1; b = Ts;  

% Gains
kt = (1 - beta)*Lfc/b; 
k2 = -2*beta + a + 1; 
k1 = (beta^2 - a*(1 - k2) + k2)*Lfc/b; 
ki = k1 - k2*a*Lfc/b;
ui0 = ug0 + k2*ug0; 

%% Simulate and plot figures
sim('lcl_pi');

figure(1); 
subplot(2,1,1); hold on; grid on;
plot(icRef,'k--','linewidth',0.5); plot(icMeas,'r');
%plot(icAct,'b','linewidth',0.5); plot(igAct,'m','linewidth',0.5); 
axis([0 .03 0 25]); 
legend('$i_\mathrm{c,ref}$', '$i_\mathrm{c}$', 'Location', 'NorthWest');
ylabel('$i_\mathrm{c}$ (A)');

subplot(2,1,2); hold on; grid on;
plot(ucRef,'b'); plot(ugAct,'r','linewidth',0.5);
xlabel('$t$ (s)'); ylabel('$u_\mathrm{c}$ (V)');
axis([0 .03 -400 400]); set(gca, 'YTick', [-400 0 400]);
legend('$u_\mathrm{c,ref}$', '$u_\mathrm{g}$', 'Location', 'SouthWest');
set(gcf,'Position',[5 5 width_sq height_sq]);
%tightfig; print -dpdf ex1.pdf
%tightfig; export_fig ex.pdf -transparent -dpdf;
