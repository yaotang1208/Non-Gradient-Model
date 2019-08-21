function [V_DTM,V_NTM,V_DM ]= F_DayNightMean_V(V,RecordsADay,DaysAYear)
%Calculate the daily mean of calculated fluxes. exclude the days with nan
%values.
% Reshape the vector to a matrix
V_Day = reshape(V,[RecordsADay, DaysAYear]);
%Daily Mean
% V_DM = nanmean(V_Day,1);
V_DC = nanmean(V_Day,2);
DT = (RecordsADay/4+1):1:(RecordsADay*3/4);
V_DTM = nanmean(V_DC(DT,:),1);
V_DM = nanmean(V_DC(:,:),1);
V_NTM = 2*V_DM - V_DTM;
end

