function [ Ia_SIM,KH_SIM ] = F_Ia_SIM_DailyMean( H,Ta, RecordsADay,DaysAYear)
%Ia_Simple Summary of this function goes here
% Use simple method in Wang et al 2010 GRL paper to estimate thermal
% inertial of air. And calculate eddy diffusivity from the calculated
% thermal inertial
%constants
rhoa = 1.18; % air density is 1.18 kg/m^3
cp = 1000; % specific heat of air is 1000 Jkg^-1K^-1

%reshape the vector to a matric
H_Day = reshape(H,[RecordsADay, DaysAYear]);
Ta_Day = reshape(Ta,[RecordsADay, DaysAYear]);

Hmax = nanmax(H_Day,[],1); %maximum H every day
Hmin = nanmin(H_Day,[],1); %minimum H every day
Tamax = nanmax(Ta_Day,[],1);%maximum Ta
Tamin = nanmin(Ta_Day,[],1);%minimum Ta

DeltaH = Hmax - Hmin;
DeltaTa = Tamax - Tamin;
omega0 = 2*pi/(24*60*60); % omega is the radius of 1 day

Ia_SIM = DeltaH./(DeltaTa.* sqrt(omega0));
KH_SIM = (Ia_SIM./(rhoa.*cp)).^2;
end

