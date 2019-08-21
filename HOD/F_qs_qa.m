function [ qs, qa ] = F_qs_qa(TA_DP,RH_DP)
%MEP function
P = 100; % KP
esT0 = 6.11;
Lv = 2.5E6;
Rv = 461;
T0 = 273;
Rd = 287;
KA = T0 + TA_DP;

RH = 1; %saturated qs
% RH = RH_DP./100; %qa 
P = 100;
e = RH .* esT0 .* exp(Lv ./ Rv .*(1./T0 - 1./KA)); % water vapor pressure
rhov = e .* 100 ./ (Rv .* KA); % water vapor density
rhod = (1000 .* P - e .* 100) ./ (Rd .* KA);
rho = rhov + rhod;
qa = rhov ./ rho;
qs = qa;

%qa
RH = RH_DP./100; %qa 
P = 100;
e = RH .* esT0 .* exp(Lv ./ Rv .*(1./T0 - 1./KA)); % water vapor pressure
rhov = e .* 100 ./ (Rv .* KA); % water vapor density
rhod = (1000 .* P - e .* 100) ./ (Rd .* KA);
rho = rhov + rhod;
qa = rhov ./ rho;

end

