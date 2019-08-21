function [ output_args ] = F_MEP_PlotEH(Rn,LE,H,EMEP,HMEP,T)


figure(21);
h21_1 = subplot(3,1,1);
plot(T,Rn,'-b');
grid on;
ylabel('Rn (W m^-2)');

h21_2 = subplot(3,1,2);
plot(T, EMEP,'r-',T, LE,'b-');
grid on;
% axis([160,170,-100,600])
legend('EMEP','EOBS');
% title('MEP VS OBS, 2006')
% xlabel('Julian Day');
ylabel('E (W m-2)');

h21_3 = subplot(3,1,3);
plot(T, HMEP,'r-',T, H,'b-');
grid on;
% axis([160,170,-100,500])
legend('HMEP','HOBS');
% xlabel('Julian Day');
ylabel('H (W m-2)');

linkaxes([h21_1,h21_2,h21_3] ,'x');

figure(22);
scatter(Rn,LE+H);hold on;
plot(-1000:1:2000,-1000:1:2000,'-r');hold off
xlabel(' Rn (W/m^2)');
ylabel('E+H (W/m^2)');
grid on;
axis('square');

end

