clc
clear

filename = 'AMF_BRSa1_2003_L2_GF_GF_V003.nc';

ncdisp(filename);

UST = ncread(filename,'UST');
TA = ncread(filename,'TA');
WS = ncread(filename,'WS');
FC = ncread(filename,'FC');
H = ncread(filename,'H');
LE = ncread(filename,'LE');
PREC = ncread(filename,'PREC');
RH = ncread(filename,'RH');
CO2 = ncread(filename,'CO2');
Rn = ncread(filename,'Rn');
H2O = ncread(filename,'H2O');
SWC = ncread(filename,'SWC1');
FG = ncread(filename,'FG');
Ts = ncread(filename,'TS1');

%without G and theta
% save('AMF_USBr1_2011.mat','UST','TA','WS','FC','H','LE','PREC','RH','CO2','Rn','H2O');
%with G and theta
save('AMF_BRSa1_2003.mat','UST','TA','WS','FC','H','LE','PREC','RH','CO2','Rn','H2O','SWC','FG','Ts');