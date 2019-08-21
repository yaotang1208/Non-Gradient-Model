function [ A_DM ] = F_DailyMean( A,RecordsADay,DaysAYear )
%UNTITLED3 Summary of this function goes here
%   Calculate the DailyMean with NAN
A_Day = reshape(A,[RecordsADay, DaysAYear]);
A_DM = nanmean(A_Day,1);
end

