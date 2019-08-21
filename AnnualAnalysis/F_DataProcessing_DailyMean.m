function [Rn_DM, RH_DM,CO2_DM,LE_DM, H_DM,FC_DM,WS_DM,TA_DM ,UST_DM ,H2O_DM,SWC_DM,FG_DM,Ts_DM] =F_DataProcessing_DailyMean(Rn,RH,CO2,LE,H,FC,WS,TA,UST,H2O,SWC,FG,Ts,RecordsADay,DaysAYear)
% Calculate the daily mean of all inputs with NaNmean function
%   Calculate the DailyMean with NAN
Rn_DM = (F_DailyMean( Rn,RecordsADay,DaysAYear ))';
RH_DM = (F_DailyMean( RH,RecordsADay,DaysAYear ))';
CO2_DM = (F_DailyMean(CO2,RecordsADay,DaysAYear ))';
LE_DM = (F_DailyMean( LE,RecordsADay,DaysAYear ))';
H_DM = (F_DailyMean( H,RecordsADay,DaysAYear ))';
FC_DM = (F_DailyMean( FC,RecordsADay,DaysAYear ))';
WS_DM = (F_DailyMean( WS,RecordsADay,DaysAYear ))';
TA_DM = (F_DailyMean( TA,RecordsADay,DaysAYear ))';
UST_DM = (F_DailyMean( UST,RecordsADay,DaysAYear ))';
H2O_DM = (F_DailyMean( H2O,RecordsADay,DaysAYear ))';
SWC_DM = (F_DailyMean( SWC,RecordsADay,DaysAYear ))';
FG_DM = (F_DailyMean( FG,RecordsADay,DaysAYear ))';
Ts_DM = (F_DailyMean( Ts,RecordsADay,DaysAYear ))';
end