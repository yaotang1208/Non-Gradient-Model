function [ UST_EXT, KH_EXT ] = F_UST_EXT( H, zb,ratio)
%Calculate Ustar from H
rho = 1.18;
kappa = 0.4;
cp = 1000;
T0 = 300; % temperature
g = 9.8;
beta = 4.7;
gamma2 = 9;
gamma1 = 15;
alpha = 1;
D1 = (2*beta*kappa*g/rho/cp/T0)^(1/3);
D2 = (gamma2*kappa*g/2/rho/cp/T0)^(1/3);

N = length(H);
UST_EXT = zeros(N,1);
Ck = zeros(N,1);
zb_Stable = zb/ratio;
zb_Unstable = zb;
KH_EXT = zeros(N,1);

for i=1:N
    if H(i)<0 %Stable
        UST_EXT(i) = D1.*(-H(i).*zb_Stable).^(1./3);
        Ck(i) = 2/(1+2*alpha);
        KH_EXT(i) = Ck(i).*kappa.*zb_Stable.*UST_EXT(i);
    else %Unstable
        UST_EXT(i) = D2.*(H(i).*zb_Unstable).^(1./3);
        Ck(i) = sqrt(3)/alpha;
        KH_EXT(i) = Ck(i).*kappa.*zb_Unstable.*UST_EXT(i);
    end
end
end

