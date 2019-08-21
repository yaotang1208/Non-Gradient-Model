function [ output_args ] = F_Plot_UST( t,HMEP,WS,UST_EST,UST_OBS )
%Plot CO2 Concentration with other variables.

X_min = round(t(1))-0.25;
X_max = round(t(end))+0.25;
H_min = (round(nanmin(HMEP)/3)-1).*3;
H_max = (round(nanmax(HMEP)/3)+1).*3;

UST_Mix = [UST_EST;UST_OBS];

UST_min = round(nanmin(UST_Mix))-0.5;
UST_max = round(nanmax(UST_Mix))+0.5;


WS_min = round(nanmin(WS))-0.5;
WS_max = round(nanmax(WS))+0.5;

H_P = HMEP;
WS_P = WS;
UST_EST_P = UST_EST;
UST_OBS_P = UST_OBS;

figure(13);
% subplot(2,1,1)
h13_1 = subplot('position',[0.15 0.75 0.7 0.2]);
plot(t,H_P,'-b','LineWidth',1.5); 
xlim([X_min X_max])
set(gca,'FontSize',12)
% xlabel('Time (Julian Day)','FontSize',12);
ylabel('H (Wm^-2)','FontSize',12);
title('(a)','FontSize',12);
grid on;

% subplot(2,1,2)
h13_2 = subplot('position',[0.15 0.5 0.7 0.2]);
plot(t, UST_EST_P,'-or',t, UST_OBS_P,'b','LineWidth',1.5,'MarkerSize',6);
set(gca,'FontSize',12)
AX = legend('Eq(3)','Obs');
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',12)
xlabel('Time (Julian Day)','FontSize',12);
ylabel('UST (m/s)','FontSize',12);
xlim([X_min X_max])
title('(b)','FontSize',12);
grid on;
linkaxes([h13_1,h13_2] ,'x');

subplot('position',[0.325 0.07 0.35 0.35]);
scatter(UST_OBS_P, UST_EST_P,'LineWidth',1.5);hold on;
plot(UST_min:1:UST_max,UST_min:1:UST_max,'r','LineWidth',1.5);hold off
xlabel('Observed UST (m/s)','FontSize',11);
ylabel('Modeled UST (m/s)','FontSize',11);
title('(c)','FontSize',12);
axis([UST_min,UST_max,UST_min,UST_max])
grid on;
axis('square');

figure(14);
% subplot(2,1,1)
h14_1 = subplot('position',[0.15 0.75 0.7 0.2]);
plot(t,WS_P,'-b','LineWidth',1.5); 
xlim([X_min X_max])
set(gca,'FontSize',12)
% xlabel('Time (Julian Day)','FontSize',12);
ylabel('Wind Speed (m/s)','FontSize',12);
title('(a)','FontSize',12);
grid on;

% subplot(2,1,2)
h14_2= subplot('position',[0.15 0.5 0.7 0.2]);
plot(t, UST_EST_P,'-or',t, UST_OBS_P,'b','LineWidth',1.5,'MarkerSize',6);
set(gca,'FontSize',12)
AX = legend('Eq(3)','Obs');
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',12)
xlabel('Time (Julian Day)','FontSize',12);
ylabel('UST (m/s)','FontSize',12);
xlim([X_min X_max])
title('(b)','FontSize',12);
grid on;
linkaxes([h14_1,h14_2] ,'x');

subplot('position',[0.325 0.07 0.35 0.35]);
scatter(UST_OBS_P, UST_EST_P,'LineWidth',1.5);hold on;
plot(UST_min:1:UST_max,UST_min:1:UST_max,'r','LineWidth',1.5);hold off
xlabel('Observed UST (m/s)','FontSize',11);
ylabel('Modeled UST (m/s)','FontSize',11);
title('(c)','FontSize',12);
axis([UST_min,UST_max,UST_min,UST_max])
grid on;
axis('square');

end

