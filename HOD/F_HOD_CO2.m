function [ FC_HOD ] = F_HOD_CO2(CO2,Dc,dt)

%====Introduction=====%
%Half-Order Derivative model of CO2
%Date: Jan 19,2018
%====Inputs====%
%CO2,dt
%CO2 is the CO2 concentration in the input data, Unit: ppm (umol/mol)
%dt is the time resolution

%======Outputs====%
%FC_HOD
%======Function====%
% CO2(CO2>410 | CO2 <300) = NaN;
number = find(~isnan(CO2));
DT = (number(2:end)-number(1:end-1)).*dt.*60;

%=======Calculate Dc=======%
rho = 1.18; % air density, Unit: kg/m^3
CO2MolMass = 44.01; % mole mass of CO2, Unit: g/mol 
AirMolMass = 28.97; % mole mass of air, Unit: g/mol
CO2_SI = 1E-6 .* CO2MolMass .* rho ./ AirMolMass .* CO2; % change unit from umol/mol to kg/m3 (SI unit)
%==============Calculate F========================%%
%Diffusivity is a step function of t and a function of z. 
N = length(CO2);
FC_HOD_SI = NaN(N,1); % modeled flux in SI units, Unit: kg/(m^2 s)
NV = length(number); %available data
if N < 480 %10 days' data
    
    for n = 2:NV
        a = 0; %a = summation of total
         for i = 1:n-1        
            b1 = sum(Dc(number(i:(n-1))).*DT(i:(n-1))); % b1 = sumation of Dc(i) to Dc(N)
            b2 = sum(Dc(number((i+1):(n-1))).*DT((i+1):(n-1))); % b2 = sumation of Dc(i+1) to Dc(N)
            bb1 = sqrt(b1);
            bb2 = sqrt(b2);
            bb = bb1 - bb2;
            a = a + (CO2_SI(number(i+1))-CO2_SI(number(i)))/Dc(number(i))*bb/DT(i);
        end
       FC_HOD_SI(number(n)) = 2*Dc(number(n-1))/sqrt(pi)*a;
    end
else    
    for n = 2:NV
    a = 0; %a = summation of total
    if n < 25
     for i = 1:n-1        
        b1 = sum(Dc(number(i:(n-1))).*DT(i:(n-1))); % b1 = sumation of Dc(i) to Dc(N)
        b2 = sum(Dc(number((i+1):(n-1))).*DT((i+1):(n-1))); % b2 = sumation of Dc(i+1) to Dc(N)
        bb1 = sqrt(b1);
        bb2 = sqrt(b2);
        bb = bb1 - bb2;
        a = a + (CO2_SI(number(i+1))-CO2_SI(number(i)))/Dc(number(i))*bb/DT(i);
     end
    else 
        for i=n-24:n-1
        b1 = sum(Dc(number(i:(n-1))).*DT(i:(n-1))); % b1 = sumation of Dc(i) to Dc(N)
        b2 = sum(Dc(number((i+1):(n-1))).*DT((i+1):(n-1))); % b2 = sumation of Dc(i+1) to Dc(N)
        bb1 = sqrt(b1);
        bb2 = sqrt(b2);
        bb = bb1 - bb2;
        a = a + (CO2_SI(number(i+1))-CO2_SI(number(i)))/Dc(number(i))*bb/DT(i);
        end
    end
        FC_HOD_SI(number(n)) = 2*Dc(number(n-1))/sqrt(pi)*a;
    end    
end    
FC_HOD = FC_HOD_SI .* 1E9 ./ CO2MolMass; % Change Unit to Observed Flux: Unit: umol/(m^2 s)
% FC_HOD(FC_HOD==0) = NaN;
end

