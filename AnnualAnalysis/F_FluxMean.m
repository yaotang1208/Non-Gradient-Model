function [ F_HOD_DM,F_OBS_DM,C_OBS_DM, RMSE_DM,NRMSE_DM,CC_DM,...
    F_HOD_DC,F_OBS_DC,C_OBS_DC, RMSE_DC, NRMSE_DC, CC_DC,...
    F_HOD_MM,F_OBS_MM,C_OBS_MM,RMSE_MM, NRMSE_MM, CC_MM,...
    F_HOD_MMDC,F_OBS_MMDC,C_OBS_MMDC,RMSE_MMDC, NRMSE_MMDC, CC_MMDC]...
    = F_FluxMean(F_HOD, F_OBS,C_OBS, RecordsADay,DaysAYear)
%Calculate the daily mean of calculated fluxes. exclude the days with nan
%values.

RecordsAnHour = RecordsADay/24;

% Reshape the vector to a matrix
F_HOD_Day = reshape(F_HOD,[RecordsADay, DaysAYear]);
F_OBS_Day = reshape(F_OBS,[RecordsADay, DaysAYear]);
C_OBS_Day = reshape(C_OBS,[RecordsADay, DaysAYear]);

%Daily Mean
F_HOD_DM = nanmean(F_HOD_Day,1);
F_OBS_DM = nanmean(F_OBS_Day,1);
C_OBS_DM = nanmean(C_OBS_Day,1);

[ RMSE_DM, NRMSE_DM, CC_DM ] = F_Statistics( F_HOD_DM, F_OBS_DM )

figure(41);
subplot(3,1,1);
plot(1:1:DaysAYear, C_OBS_DM);
subplot(3,1,2);
plot(1:1:DaysAYear,F_HOD_DM,'-or',1:1:DaysAYear,F_OBS_DM,'-b');
legend('HOD','OBS');
subplot(3,1,3);
scatter(F_OBS_DM, F_HOD_DM);
xlabel('OBS');
ylabel('HOD');

%mean of diurnal cycle
F_HOD_DC = nanmean(F_HOD_Day,2);
F_OBS_DC = nanmean(F_OBS_Day,2);
C_OBS_DC = nanmean(C_OBS_Day,2);

[ RMSE_DC, NRMSE_DC, CC_DC ] = F_Statistics( F_HOD_DC, F_OBS_DC )
X_DC = (1:1:RecordsADay)./RecordsAnHour;
figure(42)
subplot(3,1,1);
plot(X_DC, C_OBS_DC);
subplot(3,1,2);
plot(X_DC,F_HOD_DC,'-or',X_DC,F_OBS_DC,'-b');
legend('HOD','OBS');
subplot(3,1,3);
scatter(F_OBS_DC,F_HOD_DC);
xlabel('OBS');
ylabel('HOD');

%Monthly Mean
if DaysAYear > 365 % leap years
    DaysEachMonth = [31 29 31 30 31 30 31 31 30 31 30 31];
else
    DaysEachMonth = [31 28 31 30 31 30 31 31 30 31 30 31];
end

Month = 12;

F_HOD_MM = NaN(Month, 1);
F_OBS_MM = NaN(Month, 1);
C_OBS_MM = NaN(Month, 1);

for i =1:Month
    FirstDay = sum(DaysEachMonth(1:(i-1)))+1;
    LastDay = sum(DaysEachMonth(1:i));
    F_HOD_MM(i) = nanmean(F_HOD_DM(FirstDay:LastDay));
    F_OBS_MM(i) = nanmean(F_OBS_DM(FirstDay:LastDay));
    C_OBS_MM(i) = nanmean(C_OBS_DM(FirstDay:LastDay));
end

[ RMSE_MM, NRMSE_MM, CC_MM ] = F_Statistics( F_HOD_MM, F_OBS_MM )

figure(43);
subplot(3,1,1);
plot(1:1:Month, C_OBS_MM);
subplot(3,1,2);
plot(1:1:Month,F_HOD_MM,'-or',1:1:Month,F_OBS_MM,'-b');
legend('HOD','OBS');
subplot(3,1,3);
scatter(F_OBS_MM, F_HOD_MM);
xlabel('OBS');
ylabel('HOD');

%Monthly Mean of Diurnal Cycle

F_HOD_MMDC = NaN(RecordsADay, Month);
F_OBS_MMDC = NaN(RecordsADay, Month);
C_OBS_MMDC = NaN(RecordsADay, Month);

for i =1:Month
    FirstDay = sum(DaysEachMonth(1:(i-1)))+1;
    LastDay = sum(DaysEachMonth(1:i));
    F_HOD_MMDC(:,i) = nanmean(F_HOD_Day(:,FirstDay:LastDay),2);
    F_OBS_MMDC(:,i) = nanmean(F_OBS_Day(:,FirstDay:LastDay),2);
    C_OBS_MMDC(:,i) = nanmean(F_OBS_Day(:,FirstDay:LastDay),2);
end

% monthly mean of diurnal cycle in a vector form
F_HOD_MMDC_V = reshape(F_HOD_MMDC, [RecordsADay*Month,1]); 
F_OBS_MMDC_V = reshape(F_OBS_MMDC, [RecordsADay*Month,1]);
C_OBS_MMDC_V = reshape(C_OBS_MMDC, [RecordsADay*Month,1]);

X_MMDC = 1:RecordsADay*Month;

[ RMSE_MMDC, NRMSE_MMDC, CC_MMDC ] = F_Statistics( F_HOD_MMDC_V, F_OBS_MMDC_V )


figure(44);
subplot(3,1,1);
plot(X_MMDC, C_OBS_MMDC_V);
subplot(3,1,2);
plot(X_MMDC,F_HOD_MMDC_V,'-or',X_MMDC,F_OBS_MMDC_V,'-b');
legend('HOD','OBS');
subplot(3,1,3);
scatter(F_OBS_MMDC_V, F_HOD_MMDC_V);
xlabel('OBS');
ylabel('HOD');

end

