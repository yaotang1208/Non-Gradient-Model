function [ RMSE, NRMSE, CC ] = F_Statistics( FC_HOD, FC_OBS )
% output statistics of calculated fluxes. 
%RMSE rooted mean square error
%NRMSE normalized rooted mean square error
%CC Corelation Coefficient
FC_HOD = FC_HOD-FC_OBS+FC_OBS;
FC_OBS = FC_OBS-FC_HOD+FC_HOD;
Errors = FC_HOD - FC_OBS;
SquareEs = Errors.^2;
RMSE = sqrt(nanmean(SquareEs));
NRMSE = RMSE /(nanmax(FC_OBS)-nanmin(FC_OBS));
Number = find(~isnan(FC_OBS));
Corrcoef4 = corrcoef(FC_HOD(Number),FC_OBS(Number));
CC = Corrcoef4(2);

end

