function [ output_args ] = F_Plot_CO2_Short_Paper( t,CO2,FC_HOD,FC_OBS,F_HOD_DC, F_OBS_DC,RecordsADay )
%Plot CO2 Concentration with other variables.

RecordsAnHour = RecordsADay/24;
X_DC = (1:1:RecordsADay)./RecordsAnHour;

X_min = round(t(1))-1;
X_max = round(t(end))+1;

CO2_min = round(nanmin(CO2)/10).*10-5;
CO2_max = round(nanmax(CO2)/10+1).*10;

FC_Mix = [FC_HOD;FC_OBS];
FC_HOD(FC_HOD==0) = NaN;

FC_min = round(nanmin(FC_Mix)/5-1).*5;
FC_max = round(nanmax(FC_Mix)/5+1).*5;

% CO2_P = CO2+(FC_HOD+FC_OBS) - (FC_HOD+FC_OBS);
FC_HOD_P = FC_HOD+(CO2+FC_OBS) - (CO2+FC_OBS);
FC_OBS_P = FC_OBS + (CO2+FC_HOD) - (CO2+FC_HOD);

figure(11);
% subplot(2,1,1)
h11_1 = subplot('position',[0.05 0.72 0.6 0.25]);
plot(t,CO2,'-r','LineWidth',1.5); 
axis([X_min,X_max,CO2_min,CO2_max])
set(gca,'FontSize',11)
% xlabel('Time (Julian Day)','FontSize',12);
ylabel('C (\mumol mol^{-1})','FontSize',11);
title('(a)','FontSize',11);
grid on;

% subplot(2,1,2)
h11_2= subplot('position',[0.05 0.41 0.6 0.25]);
plot(t, FC_HOD,'-or',t, FC_OBS,'--b','LineWidth',1.5,'MarkerSize',6);
set(gca,'FontSize',11)
AX = legend('HOD','OBS');
% LEG = findobj(AX,'type','text');
% set(LEG,'FontSize',12)
xlabel('DOY','FontSize',11);
ylabel('Fc (\mumol m^{-2} s^{-1})','FontSize',11);
axis([X_min,X_max,FC_min,FC_max])
title('(b)','FontSize',11);
grid on;
linkaxes([h11_1,h11_2] ,'x');

subplot('position',[0.7 0.41 0.25 0.25]);
scatter(FC_OBS_P, FC_HOD_P,'LineWidth',1.5);hold on;
plot(FC_min:1:FC_max,FC_min:1:FC_max,'r','LineWidth',1.5);hold off
xlabel('OBS Fc (\mumol m^{-2} s^{-1})','FontSize',11);
ylabel('HOD Fc (\mumol m^{-2} s^{-1})','FontSize',11);
title('(c)','FontSize',11);
axis([FC_min,FC_max,FC_min,FC_max])
grid on;
axis('square');

subplot('position',[0.05 0.07 0.6 0.25]);
plot(X_DC,F_HOD_DC,'-or',X_DC,F_OBS_DC,'--b','LineWidth',1.5);grid on;
xticks(0:6:24);
xlim([0 24]);
legend('HOD','OBS');
ylabel('Fc (\mumol m^{-2} s^{-1})','FontSize',11);
xlabel('Hour of Day','FontSize',11);
title('(d)','FontSize',11);

subplot('position',[0.7 0.07 0.25 0.25]);
scatter(F_OBS_DC,F_HOD_DC,'LineWidth',1.5);hold on;
plot(-100:1:100,-100:1:100,'-r','LineWidth',1.5);hold off;
xlabel('OBS Fc (\mumol m^{-2} s^{-1})','FontSize',11);
ylabel('HOD Fc (\mumol m^{-2} s^{-1})','FontSize',11);
axis('square');
title('(e)','FontSize',11);
grid on;

end