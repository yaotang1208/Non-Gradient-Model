function [ F_HOD_DM,F_OBS_DM,C_OBS_DM, RMSE_DM,NRMSE_DM,CC_DM,...
    F_HOD_DC,F_OBS_DC,C_OBS_DC, RMSE_DC, NRMSE_DC, CC_DC]...
    = F_DiurnalMean_UST(F_HOD, F_OBS,C_OBS, RecordsADay,Days)
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

figure(31);
subplot(3,1,1);
plot(1:1:Days, C_OBS_DM);grid on;
ylabel('Daily Mean Wind Speed (m/s)');
subplot(3,1,2);
plot(1:1:Days,F_HOD_DM,'-or',1:1:Days,F_OBS_DM,'-b');grid on;
legend('EXT','OBS');
xlabel('DOY');
ylabel('Daily Mean UST (m/s)');
subplot(3,1,3);
scatter(F_OBS_DM, F_HOD_DM);grid on;
xlabel('OBS Daily Mean UST (m/s)');
ylabel('EXT Daily Mean UST (m/s)');
axis('square');

%mean of diurnal cycle
F_HOD_DC = nanmean(F_HOD_Day,2);
F_OBS_DC = nanmean(F_OBS_Day,2);
C_OBS_DC = nanmean(C_OBS_Day,2);

[ RMSE_DC, NRMSE_DC, CC_DC ] = F_Statistics( F_HOD_DC, F_OBS_DC );
X_DC = (1:1:RecordsADay)./RecordsAnHour;

figure(32)
subplot(3,1,1);
plot(X_DC, C_OBS_DC);grid on;
ylabel('Wind Speed (m/s)');
subplot(3,1,2);
plot(X_DC,F_HOD_DC,'-or',X_DC,F_OBS_DC,'-b');grid on;
legend('EXT','OBS');
ylabel('UST (m/s)');
subplot(3,1,3);
scatter(F_OBS_DC,F_HOD_DC);grid on;
xlabel('OBS UST (m/s)');
ylabel('EXT UST (m/s)');
axis('square');
end

