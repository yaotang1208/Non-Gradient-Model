function [ output_args ] = F_PlotAllInputs(Rn,RH,CO2,LE,H,FC,WS,TA,UST,PREC,H2O,SWC,FG,Ts,T)
%Plot All Inputs
%  

X_min = round(T(1))-1;
X_max = round(T(end))+1;

figure(1)
h1_1 = subplot(4,1,1);
plot(T,Rn);
xlim([X_min X_max])
ylabel('Rn');
h1_2 = subplot(4,1,2);
plot(T,LE);xlim([X_min X_max])
ylabel('E');
h1_3 = subplot(4,1,3);
plot(T,H);xlim([X_min X_max])
ylabel('H');
h1_4 = subplot(4,1,4);
plot(T,FG);xlim([X_min X_max])
ylabel('G');
linkaxes([h1_1,h1_2,h1_3,h1_4],'x');

figure(2)
h1_1 = subplot(4,1,1);
plot(T,TA,'-r',T,Ts,'-b');
legend('Ta','Ts');
xlim([X_min X_max])
ylabel('Ta');
h1_2 = subplot(4,1,2);
plot(T,RH);xlim([X_min X_max])
ylabel('RH');
h1_3 = subplot(4,1,3);
plot(T,PREC);xlim([X_min X_max])
ylabel('PREC');
h1_4 = subplot(4,1,4);
plot(T,SWC);xlim([X_min X_max])
ylabel('\Theta');
linkaxes([h1_1,h1_2,h1_3,h1_4],'x');

figure(3)
h1_1 = subplot(3,1,1);
plot(T,CO2);xlim([X_min X_max])
ylabel('CO2');
h1_2 = subplot(3,1,2);
plot(T,FC);xlim([X_min X_max])
ylabel('CO2 Flux');
h1_3 = subplot(3,1,3);
plot(T,H2O);xlim([X_min X_max])
ylabel('H2O concentration');
linkaxes([h1_1,h1_2,h1_3],'x');

figure(4)
h1_1 = subplot(2,1,1);
plot(T,WS);xlim([X_min X_max])
ylabel('Wind Speed');
h1_2 = subplot(2,1,2);
plot(T,UST);xlim([X_min X_max])
ylabel('UST');
linkaxes([h1_1,h1_2],'x');
end

