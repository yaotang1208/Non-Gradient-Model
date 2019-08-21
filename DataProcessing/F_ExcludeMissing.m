function [ Rn1,RH1,CO21,LE1,H1,FC1,WS1, TA1,UST1,...
    PREC1,H2O1,SWC1,FG1,Ts1,RecordsADay] = F_ExcludeMissing( Rn,RH,CO2,LE,H,FC,WS, TA,UST,...
    PREC,H2O,SWC,FG,Ts,TimeResolution )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
Rn1 = Rn;
RH1 = RH;
CO21 = CO2;
LE1 = LE;
H1 = H;
FC1 = FC;
WS1 = WS;
TA1 = TA;
UST1 = UST;
PREC1 = PREC;
H2O1 = H2O;
SWC1 = SWC;
FG1 = FG;
Ts1 = Ts;

NAll = length(Rn);
RecordsADay = 24.*60./TimeResolution; %Record every day, 24 or 48
XALL = (1:NAll)./RecordsADay;

Rn1(Rn<-5000) = NaN;
RH1(RH<0) = NaN;
CO21(CO2< 0) = NaN;
LE1(LE<-5000 | LE == 0) = NaN;
H1(H<-5000) = NaN;
FC1(FC<-5000) = NaN;
WS1(WS<0) = NaN;
TA1(TA<-500) = NaN;
UST1(UST<0) = NaN;
PREC1(PREC1<0) = NaN;
H2O1(H2O1<0) = NaN;
SWC1(SWC1 <0) = NaN;
FG1(FG1 <-5000) = NaN;
Ts1(Ts<-500) = NaN;

SWC1 = SWC1./100;

figure(1); plot(XALL, Rn1);
xlabel('Julian Day');
ylabel('Rn (W/m^2)');
figure(2); plot(XALL, RH1);
xlabel('Julian Day');
ylabel('RH (%)');
figure(3); plot(XALL, CO21);
xlabel('Julian Day');
ylabel('CO2 Concentration(ppm)');
figure(4); plot(XALL, LE1);
xlabel('Julian Day');
ylabel('E (W/m^2)');
figure(5); plot(XALL, H1);
xlabel('Julian Day');
ylabel('H (W/m^2)');
figure(6); plot(XALL, FC1);
xlabel('Julian Day');
ylabel('CO2 Flux (umol/(m2s))');
figure(7); plot(XALL, WS1);
xlabel('Julian Day');
ylabel('Wind Speed (m/s)');
figure(8); plot(XALL, TA1);
xlabel('Julian Day');
ylabel('Ta (DegC)');
figure(9); plot(XALL, UST1);
xlabel('Julian Day');
ylabel('Ustar (m/s)');
%important inputs
figure(10); 
h10_1 = subplot(4,1,1);
plot(XALL, PREC1);
xlabel('Julian Day');
ylabel('PREC(mm/30mins)');

h10_2 = subplot(4,1,2);
plot(XALL, Rn1);
xlabel('Julian Day');
ylabel('Rn (W/m^2)');

h10_3=subplot(4,1,3);
plot(XALL, CO21);
xlabel('Julian Day');
ylabel('CO2 Concentration(ppm)');

h10_4=subplot(4,1,4);
plot(XALL, TA1);
xlabel('Julian Day');
ylabel('Ta (DegC)');

linkaxes([h10_1,h10_2,h10_3,h10_4] ,'x');

end

