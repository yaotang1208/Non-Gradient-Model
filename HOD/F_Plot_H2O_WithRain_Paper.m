function [ output_args ] = F_Plot_H2O_WithRain_Paper( t,CwS,CwN,Theta,FC_HOD,FC_OBS,F_HOD_DC, F_OBS_DC,PREC,RecordsADay)
%Plot CO2 Concentration with other variables.
%Unit of H2O is mmol/mol.
RecordsAnHour = RecordsADay/24;
X_DC = (1:1:RecordsADay)./RecordsAnHour;

X_min = round(t(1))-0.25;
X_max = round(t(end))+0.25;


Cw = [CwS;CwN];
Cw_min = (round(nanmin(Cw)/3)-1).*3;
Cw_max = (round(nanmax(Cw)/3)+1).*3;

FC_Mix = [FC_HOD;FC_OBS];

FC_min = (round(nanmin(FC_Mix)/3)-1).*3;
FC_max = (round(nanmax(FC_Mix)/3)+1).*3;

 %make NaN at the same time
FC_HOD_P = FC_HOD + FC_OBS - FC_OBS;
FC_OBS_P = FC_OBS + FC_HOD - FC_HOD;

figure(12);
% subplot(2,1,1)
h12_1= subplot('position',[0.05 0.72 0.6 0.25]);
plot(t,CwS,'-r',t,CwN,'--b','LineWidth',1.5); 
% AX = legend('Saturated','Observed');
% LEG = findobj(AX,'type','text');
% set(LEG,'FontSize',11)
axis([X_min,X_max,Cw_min,Cw_max])
set(gca,'FontSize',11)
% xlabel('Time (Julian Day)','FontSize',12);
ylabel('Cv (mmol mol^{-1})','FontSize',11);
title('(a)','FontSize',11);
grid on;
yyaxis right
plot(t, Theta,':k','LineWidth',1.5);
% set(gca,'Ydir','reverse')
ylabel('\Theta(m^3 m^{-3})','Color','k')
AX = legend('Saturated','Observed','\Theta');

% subplot(2,1,2)
h12_2= subplot('position',[0.05 0.41 0.6 0.25]);
plot(t, FC_HOD,'-or',t, FC_OBS,'--b','LineWidth',1.5,'MarkerSize',6);
set(gca,'FontSize',11)

% LEG = findobj(AX,'type','text');
% set(LEG,'FontSize',11)
xlabel('DOY','FontSize',11);
ylabel('Fv (mmol m^{-2} s^{-1})','FontSize',11);
axis([X_min,X_max,FC_min,FC_max])
title('(b)','FontSize',11);
grid on;
yyaxis right
plot(t, PREC,':k','LineWidth',1.5);
set(gca,'Ydir','reverse')
ylabel('Precipitation(mm)','Color','k')
linkaxes([h12_1,h12_2] ,'x');
AX = legend('HOD','OBS','Rain');

subplot('position',[0.7 0.41 0.25 0.25]);
scatter(FC_OBS_P, FC_HOD_P,'LineWidth',1.5);hold on;
plot(FC_min:1:FC_max,FC_min:1:FC_max,'r','LineWidth',1.5);hold off
xlabel('OBS Fv (mmol m^{-2} s^{-1})','FontSize',11);
ylabel('HOD Fv (mmol m^{-2} s^{-1})','FontSize',11);
title('(c)','FontSize',11);
axis([FC_min,FC_max,FC_min,FC_max])
grid on;
axis('square');

subplot('position',[0.05 0.07 0.6 0.25]);
plot(X_DC,F_HOD_DC,'-or',X_DC,F_OBS_DC,'--b','LineWidth',1.5);grid on;
xticks(0:6:24);
xlim([0 24]);
legend('HOD','OBS');
ylabel('Fv (mmol m^{-2} s^{-1})','FontSize',11);
xlabel('Hour of Day','FontSize',11);
title('(d)','FontSize',11);

subplot('position',[0.7 0.07 0.25 0.25]);
scatter(F_OBS_DC,F_HOD_DC,'LineWidth',1.5);hold on;
plot(-100:1:100,-100:1:100,'-r','LineWidth',1.5);hold off;
xlabel('OBS Fv (mmol m^{-2} s^{-1})','FontSize',11);
ylabel('HOD Fv (mmol m^{-2} s^{-1})','FontSize',11);
axis('square');
title('(e)','FontSize',11);
grid on;
end

