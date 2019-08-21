function [F_HOD_AA_CO2_gCm2, F_OBS_AA_CO2_gCm2,F_HOD_AADT_CO2_gCm2,F_OBS_AADT_CO2_gCm2,F_HOD_AANT_CO2_gCm2,F_OBS_AANT_CO2_gCm2] = F_AnnualAccumulative_CO2( F_HOD_DC_CO2,F_OBS_DC_CO2,DaysAYear )
% Annual Accumulative CO2 
% Calculate the annual accumulative CO2 in unit of mm/year
%F_CO2_DC_CO2 original unit is mmol/(m^2 s)
MC = 12;
F_HOD_DM_CO2 = nanmean(F_HOD_DC_CO2);
F_OBS_DM_CO2 = nanmean(F_OBS_DC_CO2);

SecondsADay = 60*60*24;

F_HOD_AA_CO2_umol = F_HOD_DM_CO2.*SecondsADay.*DaysAYear; %unit is umol/(m^2s)
F_OBS_AA_CO2_umol = F_OBS_DM_CO2.*SecondsADay.*DaysAYear;

F_HOD_AA_CO2_gCm2 = F_HOD_AA_CO2_umol.*MC.*1E-6; %unit is gC/m2
F_OBS_AA_CO2_gCm2 = F_OBS_AA_CO2_umol.*MC.*1E-6; %unit is gC/m2

%Daytime 6 AM to 6 PM
N = length(F_HOD_DC_CO2);
Daytime = (N/4+1):(3*N/4);
F_HOD_DTM_CO2 = nanmean(F_HOD_DC_CO2(Daytime));
F_OBS_DTM_CO2 = nanmean(F_OBS_DC_CO2(Daytime));

F_HOD_AADT_CO2_umol = F_HOD_DTM_CO2.*SecondsADay.*DaysAYear./2; %unit is mmol/(m^2s)
F_OBS_AADT_CO2_umol = F_OBS_DTM_CO2.*SecondsADay.*DaysAYear./2;

F_HOD_AADT_CO2_gCm2 = F_HOD_AADT_CO2_umol.*MC.*1E-6; %unit is gC/m2
F_OBS_AADT_CO2_gCm2 = F_OBS_AADT_CO2_umol.*MC.*1E-6; %unit is gC/m2

%Nighttime 6PM to 6 AM

F_HOD_AANT_CO2_gCm2 = F_HOD_AA_CO2_gCm2-F_HOD_AADT_CO2_gCm2; %unit is gC/m2
F_OBS_AANT_CO2_gCm2 = F_OBS_AA_CO2_gCm2-F_OBS_AADT_CO2_gCm2; %unit is gC/m2

end