function [ F_HOD_DM,F_OBS_DM,C_OBS_DM, RMSE_DM,NRMSE_DM,CC_DM,...
    F_HOD_DC,F_OBS_DC,C_OBS_DC, RMSE_DC, NRMSE_DC, CC_DC]...
    = F_DiurnalMean_CO2(F_HOD, F_OBS,C_OBS, RecordsADay,Days)
%Calculate the daily mean of calculated fluxes. exclude the days with nan
%values.

RecordsAnHour = RecordsADay/24;

% Reshape the vector to a matrix
F_HOD_Day = reshape(F_HOD,[RecordsADay, Days]);
F_OBS_Day = reshape(F_OBS,[RecordsADay, Days]);
C_OBS_Day = reshape(C_OBS,[RecordsADay, Days]);

%Daily Mean
F_HOD_DM = nanmean(F_HOD_Day,1);
F_OBS_DM = nanmean(F_OBS_Day,1);
C_OBS_DM = nanmean(C_OBS_Day,1);

[ RMSE_DM, NRMSE_DM, CC_DM ] = F_Statistics( F_HOD_DM, F_OBS_DM );

figure(41);
subplot(3,1,1);
plot(1:1:Days, C_OBS_DM);grid on;
ylabel('Daily Mean CO2 (\mumol/mol)');
subplot(3,1,2);
plot(1:1:Days,F_HOD_DM,'-or',1:1:Days,F_OBS_DM,'-b');grid on;
legend('HOD','OBS');
xlabel('DOY');
ylabel('Daily Mean Fc (umol/(m2s))');
subplot(3,1,3);
scatter(F_OBS_DM, F_HOD_DM);
xlabel('OBS Daily Mean Fc (umol/(m2s))');
ylabel('HOD Daily Mean Fc (umol/(m2s))');
grid on;
axis('square');

%mean of diurnal cycle
F_HOD_DC = nanmean(F_HOD_Day,2);
F_OBS_DC = nanmean(F_OBS_Day,2);
C_OBS_DC = nanmean(C_OBS_Day,2);

[ RMSE_DC, NRMSE_DC, CC_DC ] = F_Statistics( F_HOD_DC, F_OBS_DC );
X_DC = (1:1:RecordsADay)./RecordsAnHour;

figure(42)
subplot(3,1,1);
plot(X_DC, C_OBS_DC);grid on;
ylabel('CO2 (\mumol/mol)');
subplot(3,1,2);
plot(X_DC,F_HOD_DC,'-or',X_DC,F_OBS_DC,'-b');grid on;
legend('HOD','OBS');
ylabel('Fc (umol/(m2s))');
subplot(3,1,3);
scatter(F_OBS_DC,F_HOD_DC);
xlabel('OBS Fc (umol/(m2s))');
ylabel('HOD Fc (umol/(m2s))');
grid on;
axis('square');

end

