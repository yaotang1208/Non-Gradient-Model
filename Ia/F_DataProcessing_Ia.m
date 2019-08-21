function [Rn_DP,RH_DP,CO2_DP,LE_DP,H_DP ,FC_DP,WS_DP,TA_DP,UST_DP,PREC_DP,T,number,DT] =...
    F_DataProcessing_Ia(Rn1,RH1,CO21,LE1,H1,FC1,WS1, TA1,UST1, PREC1, Day1, Day2, RecordsADay,TimeResolution)
%Function with rainfall data

T1 = Day1.*RecordsADay+1;
T2 = Day2.*RecordsADay;
X_C = T1:1:T2; 
T = X_C./RecordsADay;

Rn2 = Rn1(X_C);
RH2 = RH1(X_C);
CO22 = CO21(X_C);
LE2 = LE1(X_C);
H2 = H1(X_C);
FC2 = FC1(X_C);
WS2 = WS1(X_C);
TA2 = TA1(X_C);
UST2 = UST1(X_C);
PREC2 = PREC1(X_C);

PREC3 = PREC2;
PREC3(PREC2~=0) = NaN;

MISSData = PREC3.*TA2.*Rn2;
MISSData(~isnan(MISSData))=1;
MM = MISSData;

number = find(~isnan(MM));
DT = (number(2:end)-number(1:end-1)).*TimeResolution.*60;

Rn_DP = Rn2.*MM;
RH_DP = RH2.*MM;
CO2_DP = CO22.*MM;
LE_DP = LE2.*MM;
H_DP = H2.*MM;
FC_DP = FC2.*MM;
WS_DP = WS2.*MM;
TA_DP = TA2.*MM;
UST_DP = UST2.*MM;
PREC_DP = PREC2;

end

