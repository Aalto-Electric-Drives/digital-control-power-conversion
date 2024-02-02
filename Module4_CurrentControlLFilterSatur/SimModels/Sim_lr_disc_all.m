clear; close all; fig_settings;

%% Actual system parameters
%RAct = 3; SAct = 5; c0Act = 1/.17; cSAct = 0;  % Constant inductance
RAct = 3; SAct = 5; c0Act = 2.5; cSAct = 1.4;   % Nonlinear inductor

% H-bridge converter
Udc = 350; uMax = Udc;  % 
%Ts = 200e-6; Tsw = 2*Ts;
Ts = 400e-6; Tsw = Ts;
% Current measurement noise
sigmaNoise = 0*.01;     % Standard deviation
TNoise = Ts;            % Correlation time

%% Parameter estimates for the controller
% Current control bandwidth
alphac = 2*pi*300;

% No parameter errors
R = RAct; S = SAct; c0 = c0Act; cS = cSAct;
% Parameter errors
%R = .8*RAct; S = SAct+1; c0 = .7*c0Act;  cS = .8*cSAct;

% Saturation data (iData,invLData) for the controller
%psiData = 0:.1:1.5; 
psiData = [0 .5 .7 .9 1.1 1.3 1.5]; 
iData = (c0 + cS*abs(psiData).^S).*psiData;
invLData = c0 + cS*abs(psiData).^S; 
% Plot 
figure(1); subplot(2,1,1);
plot(iData,1./invLData,'-ob'); axis([0 20 0 0.5]); ylabel('$L$ (H)');
subplot(2,1,2);
plot(iData,invLData,'-ob'); axis([0 20 0 15]); 
xlabel('$i$ (A)'); ylabel('$L^{-1}$ (H$^{-1}$)');
set(gcf,'Position',[5 5 width_sq height_sq]);
%tightfig; export_fig invL.pdf -transparent -dpdf;

%% Simulate and plot figures
sim('lr_disc_all');

figure(2); 
subplot(2,1,1); hold on;
plot(iRef,'k--','linewidth',0.5); plot(iAct,'b','linewidth',0.5); plot(iMeas,'r');
axis([0 .04 0 12.5]);
legend('$i_\mathrm{ref}(k)$', '$i$', '$i(k)$', 'Location', 'SouthEast');
ylabel('$i$ (A)');
subplot(2,1,2); hold on;
plot(eAct,'r','linewidth',0.5); plot(uRef,'b'); 
axis([0 .04 0 400]); set(gca, 'YTick', [0 200 400]);
legend('$e$', '$u_\mathrm{ref}(k)$', 'Location', 'NorthEast');
xlabel('$t$ (s)'); ylabel('$u$ (V)');
set(gcf,'Position',[5 5 width_sq height_sq]);
%tightfig; print -dpdf intro2.pdf
%tightfig; export_fig ex2.pdf -transparent -dpdf;