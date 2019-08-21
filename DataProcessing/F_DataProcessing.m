function [Rn_DP,RH_DP,CO2_DP,LE_DP,H_DP ,FC_DP,WS_DP,TA_DP,UST_DP,...
    PREC_DP,H2O2_DP,SWC_DP,FG_DP,Ts_DP,T] =...
    F_DataProcessing(Rn1,RH1,CO21,LE1,H1,FC1,WS1, TA1,UST1,...
    PREC1,H2O1,SWC1,FG1,Ts1,Day1, Day2, RecordsADay)
%Find data in a certain period

T1 = Day1.*RecordsADay+1;
T2 = Day2.*RecordsADay;
X_C = T1:1:T2; 
T = (X_C./RecordsADay)';

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
H2O2 = H2O1(X_C);
SWC2 = SWC1(X_C);
FG2 = FG1(X_C);
Ts2 = Ts1(X_C);
% eta2 = eta(X_C);

Rn_DP = Rn2;
RH_DP = RH2;
CO2_DP = CO22;
LE_DP = LE2;
H_DP = H2;
FC_DP = FC2;
WS_DP = WS2;
TA_DP = TA2;
UST_DP = UST2;
PREC_DP = PREC2;
H2O2_DP = H2O2;
SWC_DP = SWC2;
FG_DP = FG2;
Ts_DP = Ts2;
% eta_DP = eta2;

end

