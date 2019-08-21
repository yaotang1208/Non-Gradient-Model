function [ output_args ] = F_Plot_KH_DailyMean( KH_EXT,KH_SIM,DaysAYear )
%Plot CO2 Concentration with other variables.
t = 1:DaysAYear;

KH_EXT = KH_EXT- KH_SIM + KH_SIM;
KH_SIM = KH_SIM - KH_EXT + KH_EXT;


figure(13);
subplot(2,1,1)
plot(t, KH_EXT,'-or',t, KH_SIM,'-b','LineWidth',1.5,'MarkerSize',6);
set(gca,'FontSize',12)
AX = legend('EXT','SIM');
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',12)
xlabel('Time (Julian Day)','FontSize',12);
ylabel('KH','FontSize',12);
% axis([X_min,X_max,UST_min,UST_max])
title('(a)','FontSize',12);
grid on;

subplot(2,1,2)
scatter(KH_SIM, KH_EXT,'LineWidth',1.5);
% hold on;
% plot(UST_min:1:UST_max,UST_min:1:UST_max,'r','LineWidth',1.5);hold off
xlabel('KH_SIM (m/s)','FontSize',11);
ylabel('KH_EXT (m/s)','FontSize',11);
title('(b)','FontSize',12);
% axis([UST_min,UST_max,UST_min,UST_max])
grid on;
axis('square');

end

