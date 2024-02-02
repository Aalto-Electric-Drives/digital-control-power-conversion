clear; close all; fig_settings;  

%% Actual system parameters
ug0Act = 300;                                   % Initial value
LfcAct = 3e-3; CfAct = 10e-6; LfgAct = 2e-3;    % LCL filter

% H-bridge converter
Udc = 350; uMax = Udc; 
Ts = 200e-6; 
Tsw = Ts;                                       % Single-update PWM
%Tsw = 2*Ts;                                    % Double-update PWM
% Current measurement noise
sigmaNoise = 0*.1;                              % Standard deviation
TNoise = Ts;                                    % Correlation time

%% Parameter estimates and tuning parameters for the controller
Lfc = LfcAct; Lfg = LfgAct; Cf = CfAct; ug0 = ug0Act;
%Lfc = .9*LfcAct; Lfg = .8*LfgAct; Cf = 1.2*CfAct; ug0 = ug0Act;

% Tuning parameters
alphac = 2*pi*600;  % Controller: bandwidth
zetar = .2;         % Controller: resonance damping 
alphao = 4*alphac;  % Observer: dominant pole
zetaor = .7;        % Observer: resonance damping 

%% Discrete-time model
Lt = Lfc + Lfg;
wp = sqrt(Lt/(Lfc*Lfg*Cf));     % Resonance frequency 
%wz = sqrt(1/(Lfg*Cf));          % Antiresonance frequency

a11 = (Lfc + Lfg*cos(wp*Ts))/Lt; a12 = -sin(wp*Ts)/(wp*Lfc); a13 = Lfg*(1 - cos(wp*Ts))/Lt;
a21 = sin(wp*Ts)/(wp*Cf); a22 = cos(wp*Ts); a23 = -sin(wp*Ts)/(wp*Cf);
a31 = Lfc*(1 - cos(wp*Ts))/Lt; a32 = sin(wp*Ts)/(wp*Lfg); a33 = (Lfg + Lfc*cos(wp*Ts))/Lt;
bc1 = (Ts + Lfg*sin(wp*Ts)/(wp*Lfc))/Lt;
bc2 = Lfg*(1 - cos(wp*Ts))/Lt;
bc3 = (Ts - sin(wp*Ts)/wp)/Lt;
%bg1 = -(Ts - sin(Ts*wp)/wp)/Lt; 
%bg2 = Lfc*(1 - cos(Ts*wp))/Lt; 
%bg3 = -(Ts + Lfc*sin(Ts*wp)/(Lfg*wp))/Lt;

A = [a11, a12, a13;
     a21, a22, a23;
     a31, a32, a33];
Bc = [bc1; bc2; bc3]; 
%Bg = [bg1; bg2; bg3];
Cc = [1, 0, 0];

%% Place the observer poles
% Desired continuous-time observer poles 
betao = exp(-alphao*Ts);                                % Dominant poles
betaor = exp((-zetaor + 1j*sqrt(1 - zetaor^2))*wp*Ts);  % Resonant poles
                       
% Discrete-time observer poles
po = [betao, betaor, conj(betaor)];
Ko = acker(A',Cc',po).';
xEst0 = (eye(3) - A + Ko*Cc)\Bc*ug0;                    % Initial value

%% Place the controller poles
% Augmented matrices 
Aa = [A, Bc, [0; 0; 0];
      0, 0, 0, 0, 0;
     -Cc, 0, 1];
Ba = [0; 0; 0; 1; 0];

betar = exp((-zetar + 1j*sqrt(1 - zetar^2))*wp*Ts);
beta = exp(-alphac*Ts);
p = [0, beta, beta, betar, conj(betar)];
Ka = acker(Aa,Ba,p);
K = Ka(1:4); ki = -Ka(5); kt = ki/(1 - beta);
ui0 = ug0 + K*[xEst0; ug0];                             

%% Simulate and plot figures
sim('lcl_fo');

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
axis([0 .03 0 400]);
legend('$u_\mathrm{c,ref}$', '$u_\mathrm{g}$', 'Location', 'SouthWest');
set(gcf,'Position',[5 5 width_sq height_sq]);
%tightfig; print -dpdf ex1.pdf
%tightfig; export_fig ex2.pdf -transparent -dpdf;
