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

%mean of diurnal cycle
F_HOD_DC = nanmean(F_HOD_Day,2);
F_OBS_DC = nanmean(F_OBS_Day,2);
C_OBS_DC = nanmean(C_OBS_Day,2);

[ RMSE_DC, NRMSE_DC, CC_DC ] = F_Statistics( F_HOD_DC, F_OBS_DC );
X_DC = (1:1:RecordsADay)./RecordsAnHour;

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

MonthName = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};

%add accumulative monthly ET
X_month = (0.5):1:(Month-0.5);
figure(60);
% subplot('position',[0.05 0.72 0.6 0.25]);
subplot(3,3,[1,2]);
plot(X_month,F_HOD_AMDT_gCm2,'-ok',X_month,F_OBS_AMDT_gCm2,'--om',...
    X_month,F_HOD_AMNT_gCm2,'-xc',X_month,F_OBS_AMNT_gCm2,'--xr',...
    X_month,F_HOD_AM_gCm2,'-^g',X_month,F_OBS_AM_gCm2,'--^b','LineWidth',1.5,'MarkerSize',12);
grid on;box on;
legend('HOD^{DT}','OBS^{DT}','HOD^{NT}','OBS^{NT}','HOD','OBS');
% set(gca,'xtick',1:12,'xticklabel',MonthName)
xticks(0.5:1:(Month-0.5));
xlim([0 Month]);
ylim([-150 150]);
xticklabels(MonthName);
% xlabel('Month');
ylabel('Fc (gC m^{-2})');
title('(a)');
set(gca,'FontSize',14)

% subplot('position',[0.05 0.41 0.6 0.25]);
subplot(3,3,[4,5]);
plot(X_MMDC,F_HOD_MMDC_V,'-or',X_MMDC,F_OBS_MMDC_V,'--b','LineWidth',1.5);
grid on;box on;
legend('HOD','OBS');
% set(gca,'xtick',1:12,'xticklabel',MonthName)
xticks((RecordsADay/2):RecordsADay:(RecordsADay/2+RecordsADay*(Month-1)));
xlim([0 RecordsADay*Month]);
ylim([-30 20]);
xticklabels(MonthName);
xlabel('Month');
ylabel('Fc (\mumol m^{-2} s^{-1})');
title('(b)');
set(gca,'FontSize',14)

% subplot('position',[0.7 0.41 0.25 0.25]);
subplot(3,3,6);
scatter(F_OBS_MMDC_V, F_HOD_MMDC_V,'LineWidth',1.5);hold on;
plot(-100:1:100,-100:1:100,'-r','LineWidth',1.5);hold off;
grid on;box on;
xlabel('OBS Fc (\mumol m^{-2} s^{-1})');
ylabel('HOD Fc (\mumol m^{-2} s^{-1})');
xlim([-30 20]);
ylim([-30 20]);
axis('square');
title('(c)');
set(gca,'FontSize',14)

% subplot('position',[0.05 0.07 0.6 0.25]);
subplot(3,3,[7,8]);
plot(X_DC,F_HOD_DC,'-or',X_DC,F_OBS_DC,'--b','LineWidth',1.5);
grid on;box on;
xticks(0:6:24);
xlim([0 24]);
ylim([-20 10]);
% legend('HOD','OBS');
ylabel('Fc (\mumol m^{-2} s^{-1})');
xlabel('Hour of Day');
title('(d)');
set(gca,'FontSize',14)

% subplot('position',[0.7 0.07 0.25 0.25]);
subplot(3,3,9);
scatter(F_OBS_DC,F_HOD_DC,'LineWidth',1.5);hold on;
plot(-100:1:100,-100:1:100,'-r','LineWidth',1.5);hold off;
xlabel('OBS Fc (\mumol m^{-2} s^{-1})');
ylabel('HOD Fc (\mumol m^{-2} s^{-1})');
xlim([-20 10]);
ylim([-20 10]);
grid on;box on;
axis('square');
title('(e)');
set(gca,'FontSize',14)
end

