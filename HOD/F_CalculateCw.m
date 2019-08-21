function [ CwS_SI, CwN_SI,CwS,CwN ] = F_CalculateCw(TA,RH)
%====Introduction=====%
%Calculate water vapor concentration from air temperature and humidity
%====Inputs====%
%TA, RH
%TA is air temperature, Unit: DegC
%RH is relative humidity, Unit: %
%======Outputs====%
%CwS,CwN
%======Function====%
%change units%
Mw = 18; %mole mass of water, g/mol
rho = 1.8;
MAir = 29;
Lv = 2.5E6;
es0 = 6.11; %mb
T1 = 273; %T0 for CC equation
TA = TA + T1;
Rv = 461;
es = es0 .* exp(Lv./Rv.*(1./T1 - 1./ TA));
CwS_SI = es .* 100 ./ Rv ./ TA; % rho_v in SI unit kg/m^3
CwN_SI = RH./100.*CwS_SI; 
CwS = CwS_SI./rho.*MAir./Mw.*10^3;% CwS_SI in Unit kg/m^3
CwN = CwN_SI./rho.*MAir./Mw.*10^3; % CwS in Unit mmol/mol