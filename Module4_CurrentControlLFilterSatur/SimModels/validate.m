function [e,r2] = validate(y,X,b)
    e = y - X*b;                                    % Residuals
    %J = e'*e;                                       % Sum of squared residuals
    max_e = max(abs(e));                            % Maximum residual
    rms_e = rms(e);                                 % RMS of residuals
    r2 = 1 - sum(e.^2)./sum((y - mean(y)).^2);      % Coefficient of determination
    disp('Residual statistics:');
    %disp(['  Sum of squared residuals: ' num2str(J,'%.3f') ' A^2']);
    disp(['  RMS of residuals: ' num2str(rms_e,'%.3f') ' A']);
    disp(['  Maximum residual: ' num2str(max_e,'%.3f') ' A']);
    disp(['  Coefficient of determination: ' num2str(r2,'%.3f')]);
end