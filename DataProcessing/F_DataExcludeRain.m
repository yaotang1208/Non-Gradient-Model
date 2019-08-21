function [ CO2_DP ] = F_DataExcludeRain( CO2,PREC )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
PREC3 = PREC;
PREC3(PREC~=0) = NaN;

MISSData = PREC3;
MISSData(~isnan(MISSData))=1;
MM = MISSData;

CO2_DP = CO2.*MM;

end

