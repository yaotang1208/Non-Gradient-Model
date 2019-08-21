function [ Dc ] = F_HOD_Dc(H, zb)

%====Introduction=====%
%Calculate Diffusivity using Extreme Solution
%Date: Jan 19,2018
%====Inputs====%
%zb, H
%zb is the z in the expression of diffusivity.
%H is sensible heat flux, Unit: W/m^2

%======Outputs====%
%FC_Dc
%======Function====%

rho = 1.18; % air density, Unit: kg/m^3
kappa = 0.4; % Von Karman constant
cp = 1000; % Specific heat of air, Unit: J/(kg K)
T0 = 300; % reference temperature, Unit: K
g = 9.8; % gravititional accerlaration, Unit: m/s^2
alpha = 1; beta = 5; gamma2 = 9; % Constants of Monin-Obkhov Similarity Theory

N = length(H);

Ck_Unstable = sqrt(3)./alpha.*ones(N,1);
Ck_Stable = 2./(1+2*alpha).*ones(N,1);

zb_Unstable = zb;
zb_Neutral = zb;
zb_Stable = zb;%z in stable case is smaller
H_Neutral = 50.*ones(N,1);

Value_Under_Sqrt_Unstable = abs(gamma2 .* kappa .* g .* H .*zb_Unstable ./ (2 .* rho .* cp .* T0)); % the expression in the square root is positive. 
Value_Under_Sqrt_Stable = abs(-2 .* beta .* kappa .* g .* H .* zb_Stable ./ (rho .* cp .* T0));
Value_Under_Sqrt_Neutral = abs(-2 .* beta .* kappa .* g .* H_Neutral .* zb_Neutral ./ (rho .* cp .* T0));

Ustar_Unstable = (Value_Under_Sqrt_Unstable).^(1./3);
Ustar_Stable = (Value_Under_Sqrt_Stable).^(1./3);
Ustar_Neutral = (Value_Under_Sqrt_Neutral).^(1./3);

Dc_Unstable = Ck_Unstable.* kappa.* zb_Unstable.* Ustar_Unstable; % diffusivity 
Dc_Stable = Ck_Stable.* kappa.* zb_Stable.* Ustar_Stable;
Dc_Neutral = Ck_Stable.* kappa.* zb_Neutral.* Ustar_Neutral;

Ustar = zeros(N,1);
Dc_Direct = zeros(N,1); %Diffusivity at each time step

for i = 1:N
    if H(i)>0  %Unstable
        Ustar(i) = Ustar_Unstable(i);
        Dc_Direct(i) = Dc_Unstable (i);        
%     elseif 0<H(i)<100 %nuetral
%         Ustar(i) = Ustar_Neutral(i);
%         Dc_Direct(i) = Dc_Neutral(i);
    else   %Stable 
        Ustar(i) = Ustar_Stable(i);
        Dc_Direct(i) = Dc_Stable (i);
    end
end
% Dc_Direct(H<30) = 1; %when stable, eddy diffusivity is much smaller
Dc2 = Dc_Direct(2:end); % to calculate mean diffusivity in a time interval
Dc = nanmean([Dc_Direct(1:(end-1)),Dc2],2);
Dc(end+1) = Dc_Direct(end); % mean diffusivity in a time interval
Dc(isnan(Dc))=nanmean(Dc);