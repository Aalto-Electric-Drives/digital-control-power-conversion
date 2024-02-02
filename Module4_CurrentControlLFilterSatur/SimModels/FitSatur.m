clc; clear; close all; fig_settings;   

%% Measured data 
% 2.2-kW SyRM at the Politecnico
% Subset of the d-axis data, measured using the constant-speed method
IMeas   = [0.59; 1.08; 1.67; 2.45; 3.63; 7.25; 13.6];
PsiMeas = [0.20; 0.39; 0.59; 0.81; 1.00; 1.20; 1.39];

%% Fit the model to the measured data
S = 5; X = [PsiMeas, PsiMeas.^(S+1)]; y = IMeas; b = X\y; 
a0 = b(1); aS = b(2); 
validate(y,X,b); 

%% Fitted characteristics 
PsiModel = 0:.05:1.6;   % Flux vector for plotting the algebraic model
IModel = PsiModel.*(a0 + aS*PsiModel.^S);

%% Calculate the chord-slope inductance at psix
psix = 1.3; ix = psix*(a0 + aS*psix^S);
ax = ix/psix; 
% Calculate the incremental inductance at idx
LIncModel = 1/(a0 + (S + 1)*aS*psix^S); 
iinc = [0 25];
psi0 = psix - LIncModel*ix; 
psiinc = psi0 + LIncModel*iinc;

%% Plotting
figure(1); hold on;
plot(IMeas, PsiMeas, 'k*', 'linewidth', 1);             % Measured data
plot(IModel, PsiModel, 'b','linewidth', 2);             % Model
plot(PsiModel*a0, PsiModel, 'b--', 'linewidth', .5);    % Unsaturated inductance 
plot(PsiModel*ax, PsiModel, 'r-.','linewidth', .5);     % Chord slope
plot(iinc, psiinc, 'r:','linewidth', .5);               % Incremental
plot(ix,psix,'ro','linewidth', .5);                     % Mark the point (idx, psidx)

% Axes etc.
axis([0 20 0 1.5]); 
xlabel('$i$ (A)'); ylabel('$\psi$ (Vs)');
legend('Measured', 'Model', 'Unsaturated', 'Chord slope', 'Incremental', 'Location', 'SouthEast');
axis('square');
set(gcf,'Position',[5 5 width_sq height_sq]);
%tightfig; print -dpdf intro1.pdf
tightfig; export_fig ex1a.pdf -transparent -dpdf;

%% Plot the current as a function of the flux linkage
figure(2); hold on;

% Plot the measured data
plot(PsiMeas, IMeas, 'k*', 'linewidth', 1);             % Measured data
plot(PsiModel, IModel, 'b', 'linewidth', 2);            % Model
plot(PsiModel, PsiModel*a0, 'b--', 'linewidth', .5);    % Unsaturated inductance 
plot(PsiModel, PsiModel*ax, 'r-.','linewidth', .5);     % Chord slope
plot(psiinc, iinc, 'r:','linewidth', .5);               % Incremental inductance
plot(psix,ix,'ro','linewidth', .5);                     % Mark the point (idx, psidx)

% Axes etc.
axis([0 1.5 0 20]); 
ylabel('$i$ (A)'); xlabel('$\psi$ (Vs)');
legend('Measured', 'Model', 'Unsaturated', 'Chord slope', 'Incremental', 'Location', 'NorthWest');
axis('square');
set(gcf,'Position',[5 5 width_sq height_sq]);
%tightfig; print -dpdf intro2.pdf
tightfig; export_fig ex1b.pdf -transparent -dpdf;