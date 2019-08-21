function [ EMEP,HMEP,GMEP ] = F_MEP(Rn,TA,RH)
%MEP function
esT0 = 6.11;
Lv = 2.5E6;
Rv = 461;
T0 = 273;
Rd = 287;
KA = T0 + TA;

% RH = 1; %saturated qs
RH = RH./100; %qa 
P = 100;
e = RH .* esT0 .* exp(Lv ./ Rv .*(1./T0 - 1./KA)); % water vapor pressure
rhov = e .* 100 ./ (Rv .* KA); % water vapor density
rhod = (1000 .* P - e .* 100) ./ (Rd .* KA);
rho = rhov + rhod;
qa = rhov ./ rho;

qs = qa;
%constant
cp = 1000;

% MEP

sigma = Lv .^ 2 ./ cp ./ Rv .* qs ./ KA .^2; 
B = 6 .* (sqrt(1+11./36.* sigma)-1);
EMEP = B .* Rn./(1+B);
HMEP = Rn ./ (1+B);
GMEP = Rn - EMEP - HMEP;
end

