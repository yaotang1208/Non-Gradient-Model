function [F_HOD_AA_H2O_mm, F_OBS_AA_H2O_mm,F_HOD_AADT_H2O_mm,F_OBS_AADT_H2O_mm,F_HOD_AANT_H2O_mm,F_OBS_AANT_H2O_mm] = F_AnnualAccumulative_H2O( F_HOD_DC_H2O,F_OBS_DC_H2O,DaysAYear )
% Annual Accumulative H2O 
% Calculate the annual accumulative H2O in unit of mm/year
%F_H2O_DC_H2O original unit is mmol/(m^2 s)
MH2O = 18;
N = length(F_HOD_DC_H2O);

F_HOD_DM_H2O = nanmean(F_HOD_DC_H2O);
F_OBS_DM_H2O = nanmean(F_OBS_DC_H2O);

SecondsADay = 60*60*24;

F_HOD_AA_H2O_mmol = F_HOD_DM_H2O.*SecondsADay.*DaysAYear; %unit is mmol/(m^2s)
F_OBS_AA_H2O_mmol = F_OBS_DM_H2O.*SecondsADay.*DaysAYear;

F_HOD_AA_H2O_mm = F_HOD_AA_H2O_mmol.*MH2O.*1E-6; %unit is mm/year
F_OBS_AA_H2O_mm = F_OBS_AA_H2O_mmol.*MH2O.*1E-6; %unit is mm/year

%Daytime 6 AM to 6 PM
Daytime = (N/4+1):(3*N/4);
F_HOD_DTM_H2O = nanmean(F_HOD_DC_H2O(Daytime));
F_OBS_DTM_H2O = nanmean(F_OBS_DC_H2O(Daytime));

F_HOD_AADT_H2O_mmol = F_HOD_DTM_H2O.*SecondsADay.*DaysAYear./2; %unit is mmol/(m^2s)
F_OBS_AADT_H2O_mmol = F_OBS_DTM_H2O.*SecondsADay.*DaysAYear./2;

F_HOD_AADT_H2O_mm = F_HOD_AADT_H2O_mmol.*MH2O.*1E-6; %unit is mm/year
F_OBS_AADT_H2O_mm = F_OBS_AADT_H2O_mmol.*MH2O.*1E-6; %unit is mm/year

%Nighttime 6PM to 6 AM

F_HOD_AANT_H2O_mm = F_HOD_AA_H2O_mm-F_HOD_AADT_H2O_mm; %unit is mm/year
F_OBS_AANT_H2O_mm = F_OBS_AA_H2O_mm-F_OBS_AADT_H2O_mm; %unit is mm/year

end

