function [ A_DMNAN ] = F_DailyMeanNAN( A,RecordsADay,DaysAYear )
%UNTITLED3 Summary of this function goes here
%   Calculate the DailyMean with NAN
A_Day = reshape(A,[RecordsADay, DaysAYear]);
A_DMNAN = mean(A_Day,1);
end

