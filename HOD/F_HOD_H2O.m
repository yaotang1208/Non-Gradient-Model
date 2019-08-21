function [ FC_HOD ] = F_HOD_H2O(Cw,Dc,dt)

%====Introduction=====%
%Half-Order Derivative model of H2O
%====Inputs====%
%TA, RH, H, DT, number,zb
%Cw
%dt is interval
%======Outputs====%
%FC_HOD, FC_OBS,Cw
%======Function====%
Mw = 18; %Molar mass of water
N = length(Cw);
%================calculate interval
number = find(~isnan(Cw));
DT = (number(2:end)-number(1:end-1)).*dt.*60;
%==============Calculate F========================%%
%Diffusivity is a step function of t and a function of z.
FC_HOD_SI = NaN(N,1); % modeled flux in SI units, Unit: kg/(m^2 s)
NV = length(number); %available data
if N < 480 %NV<250 means only two weeks' data    
    for n = 2:NV
        a = 0; %a = summation of total
         for i = 1:n-1        
            b1 = sum(Dc(number(i:(n-1))).*DT(i:(n-1))); % b1 = sumation of Dc(i) to Dc(N)
            b2 = sum(Dc(number((i+1):(n-1))).*DT((i+1):(n-1))); % b2 = sumation of Dc(i+1) to Dc(N)
            bb1 = sqrt(b1);
            bb2 = sqrt(b2);
            bb = bb1 - bb2;
            a = a + (Cw(number(i+1))-Cw(number(i)))/Dc(number(i))*bb/DT(i);
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
        a = a + (Cw(number(i+1))-Cw(number(i)))/Dc(number(i))*bb/DT(i);
     end
    else 
        for i=n-24:n-1
        b1 = sum(Dc(number(i:(n-1))).*DT(i:(n-1))); % b1 = sumation of Dc(i) to Dc(N)
        b2 = sum(Dc(number((i+1):(n-1))).*DT((i+1):(n-1))); % b2 = sumation of Dc(i+1) to Dc(N)
        bb1 = sqrt(b1);
        bb2 = sqrt(b2);
        bb = bb1 - bb2;
        a = a + (Cw(number(i+1))-Cw(number(i)))/Dc(number(i))*bb/DT(i);
        end
    end
        FC_HOD_SI(number(n)) = 2*Dc(number(n-1))/sqrt(pi)*a;
    end    
end
    FC_HOD = FC_HOD_SI .* 1E6 ./ Mw; % Change Unit to Observed Flux: Unit: mmol/(m^2 s)
%     FC_HOD(FC_HOD==0) = NaN;
end

