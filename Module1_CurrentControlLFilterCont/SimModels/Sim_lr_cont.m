clc; clear; close all; fig_settings;  

%% System parameters
RAct = 3; LAct = .17; 
umax = 350;

%% Controller
R = RAct; L = LAct; 
%R = .5*RAct; L = .4*LAct; 
alphac = 2*pi*300;

switch 2
    case 1  % IMC-tuned PI controller        
        kt = alphac*L;
        ki = alphac*R;
        k1 = kt;        
    case 2  % State-feedback controller
        k1 = 2*alphac*L - R;
        kt = alphac*L;
        ki = alphac^2*L;
end    

%% Simulate and plot figures
sim('lr_cont');

figure(1); 
subplot(2,1,1); hold on;
plot(iRef,'k--','linewidth',0.5); plot(iAct,'b');
axis([0 .04 0 12.5]); 
legend('$i_\mathrm{ref}$', '$i$', 'Location', 'SouthEast');
ylabel('$i$ (A)');
subplot(2,1,2); hold on;
plot(eAct,'r','linewidth',0.5);
plot(uAct,'b'); 
axis([0 .04 0 400]); 
legend('$e$', '$u$', 'Location', 'NorthEast');
xlabel('$t$ (s)'); ylabel('$u$ (V)');
set(gcf,'Position',[5 5 width_sq height_sq]);
%tightfig; print -dpdf ex.pdf
%tightfig; export_fig ex.pdf -transparent -dpdf;