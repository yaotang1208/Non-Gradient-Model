function [ output_args ] = F_Plot_CO2_Annual( DaysAYear,CO2,FC_HOD,FC_OBS )
%Plot CO2 Concentration with other variables.
t = 1:1:DaysAYear;
X_min = round(t(1))-1;
X_max = round(t(end))+1;
% FC_OBS = FC_OBS';

CO2_min = round(nanmin(CO2)/10).*10-5;
CO2_max = round(nanmax(CO2)/10+1).*10;

FC_Mix = [FC_HOD;FC_OBS];

FC_min = round(nanmin(FC_Mix)/5-1).*5;
FC_max = round(nanmax(FC_Mix)/5+1).*5;

CO2_P = CO2;
FC_HOD_P = FC_HOD+(FC_OBS) - (FC_OBS);
FC_OBS_P = FC_OBS + (FC_HOD) - (FC_HOD);

figure(11);
% subplot(2,1,1)
h11_1 = subplot('position',[0.15 0.75 0.7 0.2]);
plot(t,CO2_P,'-b','LineWidth',1.5); 
axis([X_min,X_max,CO2_min,CO2_max])
set(gca,'FontSize',12)
% xlabel('Time (Julian Day)','FontSize',12);
ylabel('C (\mumol mol^{-1})','FontSize',12);
title('(a)','FontSize',12);
grid on;

% subplot(2,1,2)
h11_2= subplot('position',[0.15 0.5 0.7 0.2]);
plot(t, FC_HOD_P,'-or',t, FC_OBS_P,'b','LineWidth',1.5,'MarkerSize',6);
set(gca,'FontSize',12)
AX = legend('Eq(3)','Obs');
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',12)
xlabel('Time (Julian Day)','FontSize',12);
ylabel('Fc (\mumol m^{-2} s^{-1})','FontSize',12);
axis([X_min,X_max,FC_min,FC_max])
title('(b)','FontSize',12);
grid on;
linkaxes([h11_1,h11_2] ,'x');
subplot('position',[0.325 0.07 0.35 0.35]);
scatter(FC_OBS_P, FC_HOD_P,'LineWidth',1.5);hold on;
plot(FC_min:1:FC_max,FC_min:1:FC_max,'r','LineWidth',1.5);hold off
xlabel('Observed Fc (\mumol m^{-2} s^{-1})','FontSize',11);
ylabel('Modeled Fc (\mumol m^{-2} s^{-1})','FontSize',11);
title('(c)','FontSize',12);
axis([FC_min,FC_max,FC_min,FC_max])
grid on;
axis('square');

end

