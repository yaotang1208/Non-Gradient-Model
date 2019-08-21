clear
clc
close all

currentFolder = pwd;
FolderString = strsplit(currentFolder,'\');
Index_string = find(ismember(FolderString,'NGM'));
CodeFolder = join(FolderString(1:Index_string),'\');
Lib_path = join([CodeFolder,'LibraryOfFunctions'],'\');

addpath(string(Lib_path)); %Test if I can add path. works well
addpath(string(join([Lib_path,'DataProcessing'],'\')));
addpath(string(join([Lib_path,'HOD'],'\')));
addpath(string(join([Lib_path,'MEP'],'\')));
addpath(string(join([Lib_path,'UST'],'\')));
addpath(string(join([Lib_path,'Ia'],'\')));
addpath(string(join([Lib_path,'OneYear'],'\')));



% addpath('C:\Users\ytang90\Box Sync\Research\HalfOrderDerivtive\Carbon\Code\Function\LibraryOfFunctions'); %Test if I can add path. works well
% addpath('C:\Users\ytang90\Box Sync\Research\HalfOrderDerivtive\Carbon\Code\Function\LibraryOfFunctions\DataProcessing');
% addpath('C:\Users\ytang90\Box Sync\Research\HalfOrderDerivtive\Carbon\Code\Function\LibraryOfFunctions\HOD');
% addpath('C:\Users\ytang90\Box Sync\Research\HalfOrderDerivtive\Carbon\Code\Function\LibraryOfFunctions\MEP');
% addpath('C:\Users\ytang90\Box Sync\Research\HalfOrderDerivtive\Carbon\Code\Function\LibraryOfFunctions\UST');
% addpath('C:\Users\ytang90\Box Sync\Research\HalfOrderDerivtive\Carbon\Code\Function\LibraryOfFunctions\Ia');
% addpath('C:\Users\ytang90\Box Sync\Research\HalfOrderDerivtive\Carbon\Code\Function\LibraryOfFunctions\OneYear');
%====Introduction====%
%Main Program of HOD model
%Calculates CO2 and H2O fluxes, and Ustar
%Use readdata to read data from excel file and save them in .mat file
%(Matlab processes .mat file faster

%====Important=======%
%first choose a time period to run the program. Break at Line 96, choose a
%period from the figures of all input.
%Variables to set before running the program. 

Z_Measurement = 27;
Z_Canopy = 10;
% zb = Z_Measurement - Z_Canopy;
z_MEP = 5;
ratio = 1;
z_H2O = 30;
z_CO2 = 20;
z_UST = 30;
TimeResolution =60; 
RecordsADay = 24.*60./TimeResolution;

load 'AMF_BRSa1_2003.mat';

[ Rn1,RH1,CO21,LE1,H1,FC1,WS1, TA1,UST1,PREC1,H2O1,SWC1,...
    FG1,Ts1,RecordsADay] = F_ExcludeMissing(Rn,RH,CO2,LE,H,FC,WS,...
    TA,UST,PREC,H2O,SWC,FG,Ts,TimeResolution);
%%====STOP  HERE TO SEE Day1 and Day2==============%% 

Day1 = 210; %Beginning Day
Day2 = 220; %Last Day
Days = Day2 - Day1;

close all;
% Data processing%
[Rn_DP,RH_DP,CO2_DP,LE_DP,H_DP ,FC_DP,WS_DP,TA_DP,UST_DP,...
    PREC_DP,H2O_DP,SWC_DP,FG_DP,Ts_DP,T] =...
    F_DataProcessing(Rn1,RH1,CO21,LE1,H1,FC1,WS1, TA1,UST1,...
    PREC1,H2O1,SWC1,FG1,Ts1, Day1, Day2, RecordsADay);

%================Plot all inputs================%%
F_PlotAllInputs(Rn_DP,RH_DP,CO2_DP,LE_DP,H_DP,...
    FC_DP,WS_DP,TA_DP,UST_DP,PREC_DP,H2O_DP,SWC_DP,FG_DP,Ts_DP,T)

%================MEP Model======================%%
% CO2_DP(FC_DP>0) = NaN;

Is = 600;
type = 1; %1 dense canopy, 0 grass
[ qs, qa ] = F_qs_qa(TA_DP,RH_DP);
qa(isnan(qa)) = qs(isnan(qa));
[ EMEP, HMEP, GMEP, I0 ] = F_MEP_EHG(Rn_DP,TA_DP,qa,Is,z_MEP,ratio,type);
F_MEP_PlotGEH(Rn_DP,FG_DP,LE_DP,H_DP,GMEP,EMEP,HMEP,T)

%%=======HOD Model of CO2=======================%%
Dc_CO2 = F_HOD_Dc(HMEP, z_CO2);
Dc_CO2_c = ones(length(Dc_CO2),1).*nanmean(Dc_CO2);
% CO2_DP(CO2_DP>450) = NaN;
FCO2_HOD = F_HOD_CO2(CO2_DP, Dc_CO2_c,TimeResolution);
% FCO2_HOD(FCO2_HOD<-60 | FCO2_HOD > 40) = NaN;
%Statistics
[ RMSE_CO2, NRMSE_CO2, CC_CO2 ] = F_Statistics( FCO2_HOD, FC_DP )
%Plots
F_Plot_CO2(T,CO2_DP,FCO2_HOD,FC_DP);

%%=======HOD Model of H2O=======================%%
[ CwS_SI, CwN_SI,CwS,CwN ] = F_CalculateCw(TA_DP,RH_DP);
Dc_H2O = F_HOD_Dc(HMEP, z_H2O);
Dc_H2O_c = ones(length(Dc_H2O),1).*nanmean(Dc_H2O);
[FH2O_HOD_S] = F_HOD_H2O(CwS_SI,Dc_H2O_c,TimeResolution);
[FH2O_HOD_N] = F_HOD_H2O(CwN_SI,Dc_H2O_c,TimeResolution);
FH2O_HOD = F_H2O(FH2O_HOD_S,FH2O_HOD_N);

%Plots
FH2O_OBS = F_Plot_H2O_FromTa(T,CwS,CwN,H2O_DP,FH2O_HOD,LE_DP );
%Statistics
[ RMSE_H2O, NRMSE_H2O, CC_H2O ] = F_Statistics( FH2O_HOD,FH2O_OBS );
%%=======Extreme Solution to Calculate Ustar=======================%%
[UST_EXT,KH_EXT] = F_UST_EXT( HMEP,z_UST,ratio);
%Statistics
[ RMSE_UST, NRMSE_UST, CC_UST ] = F_Statistics( UST_EXT, UST_DP );
%Plots
F_Plot_UST( T,HMEP,WS_DP,UST_EXT,UST_DP )

%===========Calculate daily mean for a year=====%%
%===========CO2 ===============%%
[ F_HOD_DM_CO2,F_OBS_DM_CO2,C_OBS_DM_CO2, RMSE_DM_CO2,NRMSE_DM_CO2,CC_DM_CO2,...
    F_HOD_DC_CO2,F_OBS_DC_CO2,C_OBS_DC_CO2, RMSE_DC_CO2, NRMSE_DC_CO2, CC_DC_CO2,]...
    = F_DiurnalMean_CO2(FCO2_HOD, FC_DP,CO2_DP, RecordsADay,Days);

[ F_HOD_DM_H2O,F_OBS_DM_H2O,C_OBS_DM_H2O, RMSE_DM_H2O,NRMSE_DM_H2O,CC_DM_H2O,...
    F_HOD_DC_H2O,F_OBS_DC_H2O,C_OBS_DC_H2O, RMSE_DC_H2O, NRMSE_DC_H2O, CC_DC_H2O]...
    = F_DiurnalMean_H2O(FH2O_HOD, FH2O_OBS,H2O_DP,CwS,CwN,RecordsADay,Days);

[ F_HOD_DM_UST,F_OBS_DM_UST,C_OBS_DM_UST, RMSE_DM_UST,NRMSE_DM_UST,CC_DM_UST,...
    F_HOD_DC_UST,F_OBS_DC_UST,C_OBS_DC_UST, RMSE_DC_UST, NRMSE_DC_UST, CC_DC_UST]...
    = F_DiurnalMean_UST(UST_EXT, UST_DP,WS_DP,RecordsADay,Days);

%% Plot in Publications HOD of Water and CO2%%%
F_Plot_H2O_WithTheta_Paper( T,CwS,CwN,SWC_DP,FH2O_HOD,FH2O_OBS,F_HOD_DC_H2O,F_OBS_DC_H2O,RecordsADay)
F_Plot_CO2_Short_Paper( T,CO2_DP,FCO2_HOD,FC_DP,F_HOD_DC_CO2,F_OBS_DC_CO2,RecordsADay)

%% Output Statistics
Fv_Statistics = [RMSE_H2O, NRMSE_H2O, CC_H2O,RMSE_DC_H2O, NRMSE_DC_H2O, CC_DC_H2O];
Fc_Statistics = [RMSE_CO2, NRMSE_CO2, CC_CO2,RMSE_DC_CO2, NRMSE_DC_CO2, CC_DC_CO2];

%% Output data for plots
Fw_HOD_BRSa1_c = FH2O_HOD;
Fc_HOD_BRSa1_c = FCO2_HOD;
Dc_BRSa1 = Dc_H2O;
Dc_BRSa1_c = Dc_H2O_c;

save('BRSa1_TenDay_c.mat','Fw_HOD_BRSa1_c','Fc_HOD_BRSa1_c','Dc_BRSa1','Dc_BRSa1_c')

