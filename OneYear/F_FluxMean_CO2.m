function [ F_HOD_DM,F_OBS_DM,C_OBS_DM, RMSE_DM,NRMSE_DM,CC_DM,...
    F_HOD_DC,F_OBS_DC,C_OBS_DC, RMSE_DC, NRMSE_DC, CC_DC,...
    F_HOD_MM,F_OBS_MM,C_OBS_MM,RMSE_MM, NRMSE_MM, CC_MM,...
    F_HOD_MMDC,F_OBS_MMDC,C_OBS_MMDC,RMSE_MMDC, NRMSE_MMDC, CC_MMDC]...
    = F_FluxMean_CO2(F_HOD, F_OBS,C_OBS, RecordsADay,DaysAYear)
%Calculate the daily mean of calculated fluxes. exclude the days with nan
%values.

RecordsAnHour = RecordsADay/24;

F_HOD = F_HOD+F_OBS - F_OBS;
F_OBS = F_OBS + F_HOD - F_HOD;

% Reshape the vector to a matrix
F_HOD_Day = reshape(F_HOD,[RecordsADay, DaysAYear]);
F_OBS_Day = reshape(F_OBS,[RecordsADay, DaysAYear]);
C_OBS_Day = reshape(C_OBS,[RecordsADay, DaysAYear]);

%Daily Mean
F_HOD_DM = nanmean(F_HOD_Day,1);
F_OBS_DM = nanmean(F_OBS_Day,1);
C_OBS_DM = nanmean(C_OBS_Day,1);

[ RMSE_DM, NRMSE_DM, CC_DM ] = F_Statistics( F_HOD_DM, F_OBS_DM );

figure(41);
subplot(3,1,1);
plot(1:1:DaysAYear, C_OBS_DM);grid on;
ylabel('Daily Mean CO2 (\mumol/mol)');
subplot(3,1,2);
plot(1:1:DaysAYear,F_HOD_DM,'-or',1:1:DaysAYear,F_OBS_DM,'-b');grid on;
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

[ RMSE_MM, NRMSE_MM, CC_MM ] = F_Statistics( F_HOD_MM, F_OBS_MM );

figure(43);
subplot(3,1,1);
plot(1:1:Month, C_OBS_MM);grid on;
ylabel('CO2 (\mumol/mol)');
subplot(3,1,2);
plot(1:1:Month,F_HOD_MM,'-or',1:1:Month,F_OBS_MM,'-b');grid on;
legend('HOD','OBS');
ylabel('Fc (umol/(m2s))');
subplot(3,1,3);
scatter(F_OBS_MM, F_HOD_MM);grid on;
xlabel('OBS Fc (umol/(m2s))');
ylabel('HOD Fc (umol/(m2s))');
axis('square');

%Monthly Mean of Diurnal Cycle

F_HOD_MMDC = NaN(RecordsADay, Month);
F_OBS_MMDC = NaN(RecordsADay, Month);
C_OBS_MMDC = NaN(RecordsADay, Month);

for i =1:Month
    FirstDay = sum(DaysEachMonth(1:(i-1)))+1;
    LastDay = sum(DaysEachMonth(1:i));
    F_HOD_MMDC(:,i) = nanmean(F_HOD_Day(:,FirstDay:LastDay),2);
    F_OBS_MMDC(:,i) = nanmean(F_OBS_Day(:,FirstDay:LastDay),2);
    C_OBS_MMDC(:,i) = nanmean(C_OBS_Day(:,FirstDay:LastDay),2);
end

%Calculate monthly accumulative 
%HOD
DT = (RecordsADay/4+1):1:(RecordsADay*3/4); %Daytime
F_HOD_MDT = nanmean(F_HOD_MMDC(DT,:),1);%monthly daytime mean;
SecondsDaytime = 12*60*60; MC = 12;
F_HOD_AMDT = F_HOD_MDT .* DaysEachMonth.*SecondsDaytime; %monthly accumulative daytime Fc in unit of umol...
F_HOD_AMDT_gCm2 = F_HOD_AMDT.*MC.*1E-6; %accumulative monthly daytime ET in unit of mm
SecondsADay = SecondsDaytime .*2;
F_HOD_MM = nanmean(F_HOD_MMDC(:,:),1);
F_HOD_AM = F_HOD_MM .* DaysEachMonth.*SecondsADay;
F_HOD_AM_gCm2 = F_HOD_AM.*MC.*1E-6; %accumulative monthly ET in unit of mm
F_HOD_AMNT_gCm2 = F_HOD_AM_gCm2 - F_HOD_AMDT_gCm2; %monthly accumulative nighttime Fc

%OBS
F_OBS_MDT = nanmean(F_OBS_MMDC(DT,:),1);%monthly daytime mean;
% SecondsDaytime = 12*60*60; MCO2 = 18;
F_OBS_AMDT = F_OBS_MDT .* DaysEachMonth.*SecondsDaytime; %monthly accumulative daytime Fc in unit of umol...
F_OBS_AMDT_gCm2 = F_OBS_AMDT.*MC.*1E-6; %accumulative monthly daytime Fc in unit of gCm^-2
% SecondsADay = SecondsDaytime .*2;
F_OBS_MM = nanmean(F_OBS_MMDC(:,:),1);
F_OBS_AM = F_OBS_MM .* DaysEachMonth.*SecondsADay;
F_OBS_AM_gCm2 = F_OBS_AM.*MC.*1E-6; %accumulative monthly Fc in unit of gCm^-2
F_OBS_AMNT_gCm2 = F_OBS_AM_gCm2 - F_OBS_AMDT_gCm2; %monthly accumulative nighttime Fc


% monthly mean of diurnal cycle in a vector form
F_HOD_MMDC_V = reshape(F_HOD_MMDC, [RecordsADay*Month,1]); 
F_OBS_MMDC_V = reshape(F_OBS_MMDC, [RecordsADay*Month,1]);
C_OBS_MMDC_V = reshape(C_OBS_MMDC, [RecordsADay*Month,1]);

X_MMDC = 1:RecordsADay*Month;

[ RMSE_MMDC, NRMSE_MMDC, CC_MMDC ] = F_Statistics( F_HOD_MMDC_V, F_OBS_MMDC_V );

figure(44);
subplot(3,1,1);
plot(X_MMDC, C_OBS_MMDC_V);grid on;
ylabel('CO2 (\mumol/mol)');
subplot(3,1,2);
plot(X_MMDC,F_HOD_MMDC_V,'-or',X_MMDC,F_OBS_MMDC_V,'-b');grid on;
legend('HOD','OBS');
ylabel('Fc (umol/(m2s))');
subplot(3,1,3);
scatter(F_OBS_MMDC_V, F_HOD_MMDC_V);grid on;
xlabel('OBS Fc (umol/(m2s))');
ylabel('HOD Fc (umol/(m2s))');
axis('square');

MonthName = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};

figure(45);
subplot('position',[0.05 0.55 0.6 0.3]);
plot(X_MMDC,F_HOD_MMDC_V,'-or',X_MMDC,F_OBS_MMDC_V,'-b','LineWidth',1.5);grid on;
legend('HOD','OBS');
% set(gca,'xtick',1:12,'xticklabel',MonthName)
xticks((RecordsADay/2):RecordsADay:(RecordsADay/2+RecordsADay*(Month-1)));
xlim([0 RecordsADay*Month]);
xticklabels(MonthName);
xlabel('Month');
ylabel('Fc (\mumol m^{-2} s^{-1})');
title('(a)','FontSize',11);

subplot('position',[0.67 0.55 0.3 0.3]);
scatter(F_OBS_MMDC_V, F_HOD_MMDC_V,'LineWidth',1.5);grid on;hold on;
plot(-100:1:100,-100:1:100,'-r','LineWidth',1.5);hold off;
xlabel('OBS Fc (\mumol m^{-2} s^{-1})');
ylabel('HOD Fc (\mumol m^{-2} s^{-1})');
axis('square');
title('(b)','FontSize',11);

subplot('position',[0.05 0.15 0.6 0.3]);
plot(X_DC,F_HOD_DC,'-or',X_DC,F_OBS_DC,'-b','LineWidth',1.5);grid on;
xticks(0:6:24);
xlim([0 24]);
legend('HOD','OBS');
ylabel('Fc (\mumol m^{-2} s^{-1})');
xlabel('Hour of Day');
title('(c)','FontSize',11);

subplot('position',[0.67 0.15 0.3 0.3]);
scatter(F_OBS_DC,F_HOD_DC,'LineWidth',1.5);hold on;
plot(-100:1:100,-100:1:100,'-r','LineWidth',1.5);hold off;
xlabel('Fc (\mumol m^{-2} s^{-1})');
ylabel('Fc (\mumol m^{-2} s^{-1})');
grid on;
axis('square');
title('(d)','FontSize',11);

%add accumulative monthly ET
X_month = (0.5):1:(Month-0.5);
figure(60);
subplot('position',[0.05 0.72 0.6 0.25]);
% subplot('position',[0.05 0.07 0.6 0.25]);
plot(X_month,F_HOD_AMDT_gCm2,'-ok',X_month,F_OBS_AMDT_gCm2,'--om',...
    X_month,F_HOD_AMNT_gCm2,'-xc',X_month,F_OBS_AMNT_gCm2,'--xr',...
    X_month,F_HOD_AM_gCm2,'-^g',X_month,F_OBS_AM_gCm2,'--^b','LineWidth',1.5,'MarkerSize',12);grid on;
legend('HOD^{DT}','OBS^{DT}','HOD^{NT}','OBS^{NT}','HOD','OBS');
% set(gca,'xtick',1:12,'xticklabel',MonthName)
xticks(0.5:1:(Month-0.5));
xlim([0 Month]);
xticklabels(MonthName);
% xlabel('Month');
ylabel('Fc (gC m^{-2})');
title('(a)');

subplot('position',[0.05 0.41 0.6 0.25]);
% subplot('position',[0.05 0.72 0.6 0.25]);
plot(X_MMDC,F_HOD_MMDC_V,'-or',X_MMDC,F_OBS_MMDC_V,'--b','LineWidth',1.5);grid on;
legend('HOD','OBS');
% set(gca,'xtick',1:12,'xticklabel',MonthName)
xticks((RecordsADay/2):RecordsADay:(RecordsADay/2+RecordsADay*(Month-1)));
xlim([0 RecordsADay*Month]);
xticklabels(MonthName);
xlabel('Month');
ylabel('Fc (\mumol m^{-2} s^{-1})');
title('(b)');

subplot('position',[0.7 0.41 0.25 0.25]);
% subplot('position',[0.7 0.72 0.25 0.25]);
scatter(F_OBS_MMDC_V, F_HOD_MMDC_V,'LineWidth',1.5);grid on;hold on;
plot(-100:1:100,-100:1:100,'-r','LineWidth',1.5);hold off;
xlabel('OBS Fc (\mumol m^{-2} s^{-1})');
ylabel('HOD Fc (\mumol m^{-2} s^{-1})');
axis('square');
title('(c)');

subplot('position',[0.05 0.07 0.6 0.25]);
% subplot('position',[0.05 0.41 0.6 0.25]);
plot(X_DC,F_HOD_DC,'-or',X_DC,F_OBS_DC,'--b','LineWidth',1.5);grid on;
xticks(0:6:24);
xlim([0 24]);
% legend('HOD','OBS');
ylabel('Fc (\mumol m^{-2} s^{-1})');
xlabel('Hour of Day');
title('(d)');

subplot('position',[0.7 0.07 0.25 0.25]);
% subplot('position',[0.7 0.41 0.25 0.25]);
scatter(F_OBS_DC,F_HOD_DC,'LineWidth',1.5);hold on;
plot(-100:1:100,-100:1:100,'-r','LineWidth',1.5);hold off;
xlabel('OBS Fc (\mumol m^{-2} s^{-1})');
ylabel('HOD Fc (\mumol m^{-2} s^{-1})');
grid on;
axis('square');
title('(e)');
end

