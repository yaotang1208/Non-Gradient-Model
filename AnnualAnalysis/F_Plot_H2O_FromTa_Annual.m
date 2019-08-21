function [ FC_OBS ] = F_Plot_H2O_FromTa_Annual( DaysAYear,CwS_SI,CwN_SI,FC_HOD,LE )
%Plot CO2 Concentration with other variables.
t = 1:1:DaysAYear;
Mw = 18; %mole mass of water, g/mol
rho = 1.8;
MAir = 29;
Lv = 2.5E6;
FC_OBS = LE./Lv.* 1E6 ./ Mw;
X_min = round(t(1))-0.25;
X_max = round(t(end))+0.25;

CwS = CwS_SI./Mw./rho./1E-3.*MAir;
CwN = CwN_SI./Mw./rho./1E-3.*MAir; % water vapor concentration in SI unit: kg/m^3
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
h12_1= subplot('position',[0.15 0.75 0.7 0.2]);
plot(t,CwS,'-r',t,CwN,'-b','LineWidth',1); 
AX = legend('Saturated','Unsaturated');
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',12)
axis([X_min,X_max,Cw_min,Cw_max])
set(gca,'FontSize',12)
% xlabel('Time (Julian Day)','FontSize',12);
ylabel('Cw (mmol mol^{-1})','FontSize',12);
title('(a)','FontSize',12);
grid on;

% subplot(2,1,2)
h12_2= subplot('position',[0.15 0.5 0.7 0.2]);
plot(t, FC_HOD,'-or',t, FC_OBS,'b','LineWidth',1.5,'MarkerSize',6);
set(gca,'FontSize',12)
AX = legend('Eq(3)','Obs');
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',12)
xlabel('Time (Julian Day)','FontSize',12);
ylabel('Fw (mmol m^{-2} s^{-1})','FontSize',12);
axis([X_min,X_max,FC_min,FC_max])
title('(b)','FontSize',12);
grid on;
linkaxes([h12_1,h12_2] ,'x');
subplot('position',[0.325 0.07 0.35 0.35]);
scatter(FC_OBS_P, FC_HOD_P,'LineWidth',1.5);hold on;
plot(FC_min:1:FC_max,FC_min:1:FC_max,'r','LineWidth',1.5);hold off
xlabel('Observed Fw (mmol m^{-2} s^{-1})','FontSize',11);
ylabel('Modeled Fw (mmol m^{-2} s^{-1})','FontSize',11);
title('(c)','FontSize',12);
axis([FC_min,FC_max,FC_min,FC_max])
grid on;
axis('square');
end

