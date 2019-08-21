function [ output_args ] = F_MEP_PlotGEH(Rn,FG,LE,H,GMEP,EMEP,HMEP,T)


figure(21);
h21_1 = subplot(4,1,1);
plot(T,Rn,'-b');
grid on;
ylabel('Rn (W m^-2)');

h21_2 = subplot(4,1,2);
plot(T, EMEP,'r-',T, LE,'b-');
grid on;
% axis([160,170,-100,600])
legend('EMEP','EOBS');
% title('MEP VS OBS, 2006')
% xlabel('Julian Day');
ylabel('E (W m-2)');

h21_3 = subplot(4,1,3);
plot(T, HMEP,'r-',T, H,'b-');
grid on;
% axis([160,170,-100,500])
legend('HMEP','HOBS');
% xlabel('Julian Day');
ylabel('H (W m-2)');

h21_4 = subplot(4,1,4);
plot(T, GMEP,'r-',T, FG,'b-');
grid on;
% axis([160,170,-100,500])
legend('GMEP','GOBS');
xlabel('Julian Day');
ylabel('G (W m-2)');
linkaxes([h21_1,h21_2,h21_3, h21_4] ,'x');

FG(isnan(FG)) = 0;

figure(22);
scatter(Rn,LE+H+FG);hold on;
plot(-1000:1:2000,-1000:1:2000,'-r');hold off
xlabel(' Rn (W/m^2)');
ylabel('E+H+G (W/m^2)');
grid on;
axis('square');

figure(23);
subplot(3,1,1);
scatter(LE,EMEP,'LineWidth',1.5);grid on;hold on;
plot(-200:1:600,-200:1:600,'-r','LineWidth',1.5);
hold off;
xlabel('EOBS(W m-2)');
ylabel('EMEP(W m-2)');
axis('square');

subplot(3,1,2);
scatter(H,HMEP,'LineWidth',1.5);grid on;hold on;
plot(-200:1:600,-200:1:600,'-r','LineWidth',1.5);
hold off;
xlabel('HOBS(W m-2)');
ylabel('HMEP(W m-2)');
axis('square');

subplot(3,1,3);
scatter(FG,GMEP,'LineWidth',1.5);grid on;hold on;
plot(-200:1:600,-200:1:600,'-r','LineWidth',1.5);
hold off;
xlabel('GOBS(W m-2)');
ylabel('GMEP(W m-2)');
axis('square');

end

