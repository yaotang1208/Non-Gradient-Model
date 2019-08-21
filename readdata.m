clc
clear

filename = 'AMF_BRSa1_2003.xlsx';

UST = xlsread(filename,'F4:F17523');
TA = xlsread(filename,'G4:G17523');
WS = xlsread(filename,'I4:I17523');
FC = xlsread(filename,'K4:K17523');
H = xlsread(filename,'M4:M17523');
LE = xlsread(filename,'O4:O17523');
PREC = xlsread(filename,'V4:V17523');
RH = xlsread(filename,'W4:W17523');
CO2 = xlsread(filename,'Y4:Y17523');
Rn = xlsread(filename,'AC4:AC17523');
SWC = xlsread(filename,'AA4:AA17523');
FG = xlsread(filename,'Q4:Q17523');
H2O = xlsread(filename,'AK4:AK17523');


save('AMF_BRSa1_2003.mat','UST','TA','WS','FC','H','LE','PREC','RH','CO2','Rn','SWC','FG','H2O');