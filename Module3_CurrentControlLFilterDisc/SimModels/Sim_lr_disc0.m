clear; close all; fig_settings;

%% Actual system parameters
RAct = 3; LAct = .17; 

% H-bridge converter
Udc = 350; uMax = Udc;  
Ts = 200e-6; Tsw = 2*Ts;
%Ts = 400e-6; Tsw = Ts;
% Current measurement noise
sigmaNoise = 0*.01;     % Standard deviation
TNoise = Ts;            % Correlation time

%% Controller parameter
% Current control bandwidth
alphac = 2*pi*300;

% No parameter errors
R = RAct; L = LAct;
% Parameter errors
%R = .8*RAct; L = 1.2*LAct;

%% Simulate and plot figures
sim('lr_disc0');

figure(2); 
subplot(2,1,1); hold on;
plot(iRef,'k--','linewidth',0.5); plot(iAct,'b','linewidth',0.5); 
plot(iMeas,'r'); 
axis([0 .04 0 12.5]);
legend('$i_\mathrm{ref}(k)$', '$i$', '$i(k)$', 'Location', 'SouthEast');
ylabel('$i$ (A)');
subplot(2,1,2); hold on;
plot(eAct,'r','linewidth',0.5); plot(uRef,'b'); 
axis([0 .04 -100 400]); set(gca, 'YTick', [0 200 400]);
legend('$e$', '$u_\mathrm{ref}(k)$', 'Location', 'NorthEast');
xlabel('$t$ (s)'); ylabel('$u$ (V)');
set(gcf,'Position',[5 5 width_sq height_sq]);
%tightfig; print -dpdf ex.pdf
%tightfig; export_fig ex.pdf -transparent -dpdf;