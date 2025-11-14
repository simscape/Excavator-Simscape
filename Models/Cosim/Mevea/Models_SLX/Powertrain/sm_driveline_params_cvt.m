function HMPST = sm_driveline_params_cvt
% Function to load parameters for CVT

%% 1. Define parameters necessary for CVT design
% HMPST.Tire.Rad = 393.7/1000; % m
% 
% % Output Transfer Gear Pair (External gear pair between CVT to differential)
% HMPST.OutputTransferGearPair.N_Pinion = 34;
% HMPST.OutputTransferGearPair.N_Gear   = 60;
% HMPST.OutputTransferGearPair.Ratio    = ...
%     HMPST.OutputTransferGearPair.N_Gear/...
%     HMPST.OutputTransferGearPair.N_Pinion;
% 
% % Driveshafts
% HMPST.DriveshaftF.K = 1e5; % N*m/rad
% HMPST.DriveshaftF.D = 1e3; % N*m/rad
% 
% HMPST.DriveshaftR.J = 1; % kg*m^2
% HMPST.DriveshaftFL.J = 1; % kg*m^2
% HMPST.DriveshaftFR.J = 1; % kg*m^2
% HMPST.DriveshaftRL.J = 1; % kg*m^2
% HMPST.DriveshaftRR.J = 1; % kg*m^2
% 
% % Differential
% HMPST.Differential.N_Pinion     = 10;
% HMPST.Differential.N_Ring       = 28;
% HMPST.Differential.N_SpiderGear = 10;
% HMPST.Differential.N_SideGear   = 16;
% HMPST.Differential.Ratio = ...
%     HMPST.Differential.N_Ring/...
%     HMPST.Differential.N_Pinion;
% 
% % Final Drive
% HMPST.FinalDrive.N_Sun    = 24;
% HMPST.FinalDrive.N_Ring   = 87;
% HMPST.FinalDrive.N_Planet = 30;
% HMPST.FinalDrive.Ratio = ...
%     (HMPST.FinalDrive.N_Sun + HMPST.FinalDrive.N_Ring)/...
%      HMPST.FinalDrive.N_Sun;

%% 2. Calculate final drive ratio (kmph/rpm)
% vWhl2CVTOut = 1/(3.6*...
%     HMPST.Tire.Rad...
%     *pi/30)*...
%     HMPST.OutputTransferGearPair.Ratio* ...
%     HMPST.Differential.Ratio* ...
%     HMPST.FinalDrive.Ratio;

%% 3. Set engine speed
wEng = 2200;
HMPST.Eng.wTarget = wEng;

%% Select Hydrostatic Component Sizes
% HMPST.HydroUnit.Pump.Disp       = 110;  % cc/rev
% HMPST.HydroUnit.Pump.SpeedLimit = 3350; % RPM
% HMPST.HydroUnit.Motor.Disp      = 85;   % cc/rev
% 
% % -- additional hydrostat parameters
% HMPST.HydroUnit.Motor.wNominal       = 2200; % RPM 
% HMPST.HydroUnit.Pump.volEffNominal   = 0.97; % (0-1)
% HMPST.HydroUnit.Motor.volEffNominal  = 0.97; % (0-1)
% HMPST.HydroUnit.Pump.mechEffNominal  = 0.88; % (0-1)
% HMPST.HydroUnit.Motor.mechEffNominal = 0.88; % (0-1)
% HMPST.HydroUnit.Pump.prGainNominal   = 50;   % MPa
% HMPST.HydroUnit.Motor.prDropNominal  = 50;   % MPa
% 
% HMPST.HydroUnit.ChkV.pDiffCrack      = 0.03;   % MPa
% HMPST.HydroUnit.ChkV.pDiffMax        = 2;      % MPa
% HMPST.HydroUnit.ChkV.aMax            = 5e-5;   % m^2
% HMPST.HydroUnit.ChkV.aLeak           = 1e-10;  % m^2
% 
% HMPST.HydroUnit.PrV.pDiffSet         = 55;     % MPa
% HMPST.HydroUnit.PrV.pRange           = 3.5;    % MPa
% HMPST.HydroUnit.PrV.aMax             = 5e-5;   % m^2
% HMPST.HydroUnit.PrV.aLeak            = 1e-10;  % m^2
% 
% HMPST.HydroUnit.Pipes.len            = 6;      % m
% HMPST.HydroUnit.Pipes.aGeom          = pi*0.02^2/4;    % m
% HMPST.HydroUnit.Pipes.aHydr          = 0.02;   % m^2
% 
% HMPST.HydroUnit.ChargePump.Disp           = 15;   % cm^3/rev
% HMPST.HydroUnit.ChargePump.wNominal       = 3350; % RPM 
% HMPST.HydroUnit.ChargePump.volEffNominal  = 0.92; % (0-1)
% HMPST.HydroUnit.ChargePump.mechEffNominal = 0.86; % (0-1)
% HMPST.HydroUnit.ChargePump.prGainNominal  = 2;    % MPa
% 
% HMPST.HydroUnit.ChargePumpPrV.pDiffSet    = 5;     % MPa
% HMPST.HydroUnit.ChargePumpPrV.pRange      = 0.15;    % MPa
% HMPST.HydroUnit.ChargePumpPrV.aMax        = 5e-5;   % m^2
% HMPST.HydroUnit.ChargePumpPrV.aLeak       = 1e-10;  % m^2

%% 1. Choose speed ranges, including max speed
% tgtVSpdRanges = [0 3 6.4 14.2 30]; % km/h

%% 4. Calculate speed range of hydrostatic output (motor shaft)
% %eta_v          =  0.97;    % Assume nominal value, but varies with pressure
% tgtMaxSwash     =  0.7317;  % Assume less than max swash plate angle

%% 5. Initial guess for planetary gears
% nGearHSOut = 1.425; % Gear HS Output
% nTRing     = 99;   % All Ring Teeth
% nTSuns     = [39,49,25,25]; % Each Sun Teeth
% 
% % Vector of gear parameters to tune
% xInit = [nGearHSOut nTSuns];

%% 6. Obtain planetary gear parameters using optimization
% Uncomment this section if you have Optimization Toolbox and 
% Global Optimization Toolbox.  See CVT_Calculate_Swash_Control_app.mlapp
% for more details on this workflow.

%{
lb = [0.1,4,4,4,4]; % lower bound
ub = [5,28,28,28,28]; % upper bound 

objFcnHdl = @(x)cvtObjFunGearRatios4SpdsSwash(x, tgtVSpdRanges, ...
    HMPST.HydroUnit.Pump.Disp/HMPST.HydroUnit.Motor.Disp,...
    wEng,HMPST.HydroUnit.Pump.SpeedLimit, vWhl2CVTOut, nTRing, tgtMaxSwash);
%xOpt = fmincon(objFcnHdl,xInit,[],[],[],[],lb,ub);
%xOpt = patternsearch(objFcnHdl,xInit,[],[],[],[],lb,ub);

intcon = [2,3,4,5];

if(exist('gaOptStreamState.mat','file'))
    % Reset seed to get consistent results
    load('gaOptStreamState.mat','streamState');
    stream = RandStream.getGlobalStream;
    stream.State = streamState;
end

[xOpt,~,~,~] = ga(objFcnHdl,size(lb,2),[],[],[],[],lb,ub,[],intcon);

clear streamState

%options = optimoptions('surrogateopt','PlotFcn','surrogateoptplot',...
%    'MaxFunctionEvaluations',500);
%[xOpt,fval,exitflag,output] = surrogateopt(objFcnHdl,lb,ub,intcon,options);

% Take optimized value and ensure integer number of teeth 
% that mate with 3 planetary gears
%xFinal = [xOpt(1) 3*xOpt(2:5)];
%assignin('base',"xFinal",xFinal)

%}

% Answer from optimization code above using ga()
% xFinal = [1.461405405205455 39 51 27 27];
% 
% % Plot with current results and calculate swash control table
% [swashCtrlIdeal, swashCtrlTable] = cvtCalcSwashControl(...
%     tgtVSpdRanges,...                      % tgtVSpdRanges...
%     HMPST.Tire.Rad,...                     % rWhl
%     HMPST.OutputTransferGearPair.Ratio,... % nGearCVTOut
%     HMPST.Differential.Ratio,...           % nDiff
%     HMPST.FinalDrive.Ratio,...             % nFinalDrive
%     wEng,...                               % wEng
%     HMPST.HydroUnit.Pump.SpeedLimit,...    % wPumpNom
%     HMPST.HydroUnit.Pump.Disp /...
%     HMPST.HydroUnit.Motor.Disp,...         % nHSPumpMotor 
%     tgtMaxSwash,...                        % tgtMaxSwash
%     nTRing,...                             % nTRing
%     xFinal(2:5),...                        % nTSuns
%     xFinal(1),...                          % nGearHSOut
%     HMPST.HydroUnit.Pump.volEffNominal,...
%     'noplot');   %pumpVolEff
%
swashCtrlIdeal = [-0.7145 0; 0.7416 0.2143; -0.7145 0.4451; 0.7416 1; 0.7449 2.0996];
swashCtrlTable = [-0.7145 0; 0 0.1051; 0.7645 0.2142; 0.7194 0.2143];
HMPST.Ctrl.Swash.XY_I = swashCtrlIdeal; % Ideal Intersection Points
HMPST.Ctrl.Swash.XY_A = swashCtrlTable; % All points


%% Remaining parameters
HMPST.Simu.TimeStep = -1;

%% Design Requirement
% HMPST.DesignReq.MaxPwr = 484*1000;  % Maximum ground power
% HMPST.DesignReq.CutSpd = 8;         % kph
% HMPST.DesignReq.MaxForce = HMPST.DesignReq.MaxPwr/(HMPST.DesignReq.CutSpd/3.6); % N
% 
% % Maximum desired output speed at CVT (planetary 4 carrier shaft speed)
% % This is calculated based on desired max vehicle speed and the
% % optimization value achieved. Look in the optimization script for max
% % speed factor (engine speed x max factor).
% % In the present case, it is engspeed x 2.1 (2200*2.1)
HMPST.DesignReq.MaxCVTOutputSpeed = 4620; % RPM
% 
% HMPST.Veh.TopSpeed = 3.6*HMPST.Tire.Rad*(HMPST.DesignReq.MaxCVTOutputSpeed/...
%     HMPST.OutputTransferGearPair.Ratio/HMPST.Differential.Ratio/HMPST.FinalDrive.Ratio)...
%     *(pi/30);
% 
% HMPST.Veh.Mass      = 3.638e3; % kg
% HMPST.Veh.Track     = 1.0414; % m
% HMPST.Veh.Wheelbase = 1.7408; % m
% HMPST.Veh.CG.FA2CGx    = 1.0380; % m
% HMPST.Veh.CG.RA2CGx    = 1.7408-HMPST.Veh.CG.FA2CGx; % m
% HMPST.Veh.CG.FA2CGz    = 1.0380; % m

%% Engine Parameters
% HMPST.Eng.MaxTorq.SpdVec = [0 800 1000 1200 1400 1600 1800 2000 2200 2350 2500]; %RPM
% HMPST.Eng.MaxTorq.TrqVec = [100 560 700 780 800 750 700 640 550 0 0]*4.6; % Nm
% HMPST.Eng.MaxTorq.PwrVec = HMPST.Eng.MaxTorq.SpdVec.*HMPST.Eng.MaxTorq.TrqVec/30*pi/1000;
% HMPST.Eng.MinTorq.SpdVec = [0 800 1000 1200 1400 1600 1800 2000 2200 2350 2500]; %RPM
% HMPST.Eng.MinTorq.TrqVec = -[0 0 40 50 60 70 80 90 100 110 120]*4.6; % Nm
% HMPST.Eng.MinTorq.PwrVec = HMPST.Eng.MaxTorq.SpdVec.*HMPST.Eng.MaxTorq.TrqVec/30*pi/1000;

%% Geartrain Parameters
% HMPST.GearTrain.Mod             = 0.004;
% 
% % Calculate possible number of gear teeth for Gear 1 and 3 so that
% % hydrostatic pump is driven at nominal speed 
% gcdPumpEngine = gcd(HMPST.HydroUnit.Pump.SpeedLimit,wEng);
% 
% HMPST.GearTrain.Gear1.TeethNum  = HMPST.HydroUnit.Pump.SpeedLimit/gcdPumpEngine;
% HMPST.GearTrain.Gear1.PitchDiam = HMPST.GearTrain.Gear1.TeethNum* HMPST.GearTrain.Mod;
% HMPST.GearTrain.Gear1.InnerDiam = HMPST.GearTrain.Gear1.PitchDiam*0.4;
% HMPST.GearTrain.Gear2.TeethNum  = round(gcdPumpEngine/2); % Not important for ratio
% HMPST.GearTrain.Gear2.PitchDiam = HMPST.GearTrain.Gear2.TeethNum* HMPST.GearTrain.Mod;
% HMPST.GearTrain.Gear2.InnerDiam = HMPST.GearTrain.Gear2.PitchDiam*0.4;
% HMPST.GearTrain.Gear3.TeethNum  = wEng/gcdPumpEngine;
% HMPST.GearTrain.Gear3.PitchDiam = HMPST.GearTrain.Gear3.TeethNum* HMPST.GearTrain.Mod;
% HMPST.GearTrain.Gear3.InnerDiam = HMPST.GearTrain.Gear3.PitchDiam*0.4;
% 
% % Ensure gear at hydrostatic output has ratio from optimization above
% HMPST.GearTrain.Gear4.TeethNum  = 10*4;
% HMPST.GearTrain.Gear4.PitchDiam = HMPST.GearTrain.Gear4.TeethNum* HMPST.GearTrain.Mod;
% HMPST.GearTrain.Gear4.InnerDiam = HMPST.GearTrain.Gear4.PitchDiam*0.4;
% HMPST.GearTrain.Gear5.TeethNum  = xFinal(1)*HMPST.GearTrain.Gear4.TeethNum;
% HMPST.GearTrain.Gear5.PitchDiam = HMPST.GearTrain.Gear5.TeethNum* HMPST.GearTrain.Mod;
% HMPST.GearTrain.Gear5.InnerDiam = HMPST.GearTrain.Gear5.PitchDiam*0.4;
% %HMPST.GearTrain.Gear6.TeethNum  = 67;
% %HMPST.GearTrain.Gear6.PitchDiam = HMPST.GearTrain.Gear6.TeethNum* HMPST.GearTrain.Mod;
% %HMPST.GearTrain.Gear6.InnerDiam = HMPST.GearTrain.Gear6.PitchDiam*0.4;
% 
% %% Planetary Gear 1
% HMPST.GearTrain.PG1.Sun.TeethNum     = xFinal(2);
% HMPST.GearTrain.PG1.Sun.PitchDiam    = HMPST.GearTrain.PG1.Sun.TeethNum*HMPST.GearTrain.Mod;
% HMPST.GearTrain.PG1.Sun.InnerDiam    = HMPST.GearTrain.PG1.Sun.PitchDiam*0.4;
% HMPST.GearTrain.PG1.Planet.TeethNum  = (nTRing-xFinal(2))/2;
% HMPST.GearTrain.PG1.Planet.PitchDiam = HMPST.GearTrain.PG1.Planet.TeethNum*HMPST.GearTrain.Mod;
% HMPST.GearTrain.PG1.Planet.InnerDiam = HMPST.GearTrain.PG1.Planet.PitchDiam*0.4;
% HMPST.GearTrain.PG1.Ring.TeethNum    = HMPST.GearTrain.PG1.Sun.TeethNum+2*HMPST.GearTrain.PG1.Planet.TeethNum;
% HMPST.GearTrain.PG1.Ring.PitchDiam   = HMPST.GearTrain.PG1.Ring.TeethNum*HMPST.GearTrain.Mod;
% HMPST.GearTrain.PG1.Ring.OutDiam     = HMPST.GearTrain.PG1.Ring.PitchDiam*1.25;
% 
% %% Planetary Gear 2
% HMPST.GearTrain.PG2.Sun.TeethNum     = xFinal(3);
% HMPST.GearTrain.PG2.Sun.PitchDiam    = HMPST.GearTrain.PG2.Sun.TeethNum*HMPST.GearTrain.Mod;
% HMPST.GearTrain.PG2.Sun.InnerDiam    = HMPST.GearTrain.PG2.Sun.PitchDiam*0.4;
% HMPST.GearTrain.PG2.Planet.TeethNum  = (nTRing-xFinal(3))/2;
% HMPST.GearTrain.PG2.Planet.PitchDiam = HMPST.GearTrain.PG2.Planet.TeethNum*HMPST.GearTrain.Mod;
% HMPST.GearTrain.PG2.Planet.InnerDiam = HMPST.GearTrain.PG2.Planet.PitchDiam*0.4;
% HMPST.GearTrain.PG2.Ring.TeethNum    = HMPST.GearTrain.PG2.Sun.TeethNum+2*HMPST.GearTrain.PG2.Planet.TeethNum;
% HMPST.GearTrain.PG2.Ring.PitchDiam   = HMPST.GearTrain.PG2.Ring.TeethNum*HMPST.GearTrain.Mod;
% HMPST.GearTrain.PG2.Ring.OutDiam     = HMPST.GearTrain.PG2.Ring.PitchDiam*1.25;
% 
% %% Planetary Gear 3
% HMPST.GearTrain.PG3.Sun.TeethNum     = xFinal(4);
% HMPST.GearTrain.PG3.Sun.PitchDiam    = HMPST.GearTrain.PG3.Sun.TeethNum*HMPST.GearTrain.Mod;
% HMPST.GearTrain.PG3.Sun.InnerDiam    = HMPST.GearTrain.PG3.Sun.PitchDiam*0.4;
% HMPST.GearTrain.PG3.Planet.TeethNum  = (nTRing-xFinal(4))/2;
% HMPST.GearTrain.PG3.Planet.PitchDiam = HMPST.GearTrain.PG3.Planet.TeethNum*HMPST.GearTrain.Mod;
% HMPST.GearTrain.PG3.Planet.InnerDiam = HMPST.GearTrain.PG3.Planet.PitchDiam*0.4;
% HMPST.GearTrain.PG3.Ring.TeethNum    = HMPST.GearTrain.PG3.Sun.TeethNum+2*HMPST.GearTrain.PG3.Planet.TeethNum;
% HMPST.GearTrain.PG3.Ring.PitchDiam   = HMPST.GearTrain.PG3.Ring.TeethNum*HMPST.GearTrain.Mod;
% HMPST.GearTrain.PG3.Ring.OutDiam     = HMPST.GearTrain.PG3.Ring.PitchDiam*1.25;
% 
% %% Planetary Gear 4
% HMPST.GearTrain.PG4.Sun.TeethNum     = xFinal(5);
% HMPST.GearTrain.PG4.Sun.PitchDiam    = HMPST.GearTrain.PG4.Sun.TeethNum*HMPST.GearTrain.Mod;
% HMPST.GearTrain.PG4.Sun.InnerDiam    = HMPST.GearTrain.PG4.Sun.PitchDiam*0.4;
% HMPST.GearTrain.PG4.Planet.TeethNum  = (nTRing-xFinal(5))/2;
% HMPST.GearTrain.PG4.Planet.PitchDiam = HMPST.GearTrain.PG4.Planet.TeethNum*HMPST.GearTrain.Mod;
% HMPST.GearTrain.PG4.Planet.InnerDiam = HMPST.GearTrain.PG4.Planet.PitchDiam*0.4;
% HMPST.GearTrain.PG4.Ring.TeethNum    = HMPST.GearTrain.PG4.Sun.TeethNum+2*HMPST.GearTrain.PG4.Planet.TeethNum;
% HMPST.GearTrain.PG4.Ring.PitchDiam   = HMPST.GearTrain.PG4.Ring.TeethNum*HMPST.GearTrain.Mod;
% HMPST.GearTrain.PG4.Ring.OutDiam     = HMPST.GearTrain.PG4.Ring.PitchDiam*1.25;
% 
% %% Abstract CVT
HMPST.AbstractCVT.dInput       = 0.3/(3+0.6); % N*m/(rad/s)
HMPST.AbstractCVT.dOutput      = 0.4/(4.2+0.5); % N*m/(rad/s)
% HMPST.AbstractCVT.kCompliance  = 10000; % N*m/rad
% HMPST.AbstractCVT.dCompliance  = 100*10;   % N*m/(rad/s)

%% Electrical CVT
HMPST.eCVT.Battery.Vnom           = 400;  % V
HMPST.eCVT.Battery.Rint           = 2e-5; % Ohm
HMPST.eCVT.Battery.AH             = 100;   % A*hr
HMPST.eCVT.Battery.V1             = 391;  % V
HMPST.eCVT.Battery.AH1            = 50;   % A*hr

HMPST.eCVT.Generator.trqSpd.t     = [2.5, 2.3, 2.4, 0]*1000;  % N*m
HMPST.eCVT.Generator.trqSpd.w     = [0, 1500, 2500, 3000];    % rpm
HMPST.eCVT.Generator.Tc           = 0.05;   % sec
HMPST.eCVT.Generator.J            = 4.17;   % kg*m^2, W22 IE2 300 kW
HMPST.eCVT.Generator.lam          = HMPST.AbstractCVT.dInput; % kg*m^2
HMPST.eCVT.Generator.w0           = HMPST.Eng.wTarget;        % rpm

HMPST.eCVT.Motor.trqSpd.t         = [3.2, 3.0, 3.1, 0]*1000;  % N*m
HMPST.eCVT.Motor.trqSpd.w         = [0, 500, 1000, 1500];    % rpm
HMPST.eCVT.Motor.Tc               = 0.01;   % sec
HMPST.eCVT.Motor.J                = 4.17;   % kg*m^2, W22 IE2 300 kW
HMPST.eCVT.Motor.lam              = HMPST.AbstractCVT.dOutput; % kg*m^2
HMPST.eCVT.Motor.w0               = 0;        % rpm

HMPST.Control.Kp                  = 15;        % -
HMPST.Control.Ki                  = 0.3;        % -
HMPST.Control.tFilt               = 0.05;     % sec

%% Clutch Parameters
% HMPST.Clutch.SpdRange.trqRad      = 200;  % mm
% HMPST.Clutch.SpdRange.nSurf       = 8;    % count
% HMPST.Clutch.SpdRange.aPiston     = 0.0083;    % m^2
% HMPST.Clutch.SpdRange.muSta       = 0.6;  % (0-1)
% HMPST.Clutch.SpdRange.muKin       = 0.4;  % (0-1)
% HMPST.Clutch.SpdRange.vTol        = 1e-3; % rad/s
% HMPST.Clutch.SpdRange.pr2Engage   = 100;  % Pa
% HMPST.Clutch.SpdRange.logic2Press = 10^6; % Pa
% HMPST.Clutch.SpdRange.tsFilt      = 0.05; % sec
% 
% HMPST.Clutch.SpdRangeBrk.trqRad      = 200;  % mm
% HMPST.Clutch.SpdRangeBrk.nSurf       = 22;    % count
% HMPST.Clutch.SpdRangeBrk.aPiston     = 0.0083;    % m^2
% HMPST.Clutch.SpdRangeBrk.muSta       = 0.6;  % (0-1)
% HMPST.Clutch.SpdRangeBrk.muKin       = 0.4;  % (0-1)
% HMPST.Clutch.SpdRangeBrk.vTol        = 1e-4; % rad/s
% HMPST.Clutch.SpdRangeBrk.pr2Engage   = 100;  % Pa
% HMPST.Clutch.SpdRangeBrk.logic2Press = 10^6; % Pa
% HMPST.Clutch.SpdRangeBrk.tsFilt      = 0.05; % sec
% 
% HMPST.Clutch.FwdRev.trqRad           = 500;  % mm
% HMPST.Clutch.FwdRev.nSurf            = 12;   % count
% HMPST.Clutch.FwdRev.aPiston          = 0.012;% m^2
% HMPST.Clutch.FwdRev.muSta            = 0.35; % (0-1)
% HMPST.Clutch.FwdRev.muKin            = 0.3;  % (0-1)
% HMPST.Clutch.FwdRev.vTol             = 1e-3; % rad/s
% HMPST.Clutch.FwdRev.pr2Engage        = 100;  % Pa
% HMPST.Clutch.FwdRev.logic2Press      = 10^6; % Pa
% HMPST.Clutch.FwdRev.tsFilt           = 0.05; % sec
% 
% HMPST.Brake.rPad         = 50;   % mm
% HMPST.Brake.cylBore      = 4;    % mm
% HMPST.Brake.numPads      = 2;    % mm
% HMPST.Brake.muSta        = 0.6;  % (0-1)
% HMPST.Brake.muKin        = 0.4;  % (0-1)
% HMPST.Brake.vBrk         = 0.01; % rad/s
% HMPST.Brake.dVisc        = 0.0;  % N*m/(rad/s)
% 
%%
% HMPST.Brake.logic2Press  = 5e5;  % Pa
% HMPST.Brake.tsFilt       = 0.05; % sec

%% Bearing Friction Lumped
% %HMPST.Bearing.dVisc      = 0.001;  % N*m/(rad/s)
% HMPST.Bearing.dVisc      = 0.001;  % N*m/(rad/s)

%% Actuator
% HMPST.Linkage.Actuator.damping = 10; % N*m/(rad/s)

%% Hydraulic Regenerative Brake

% % Pump/Motor
% HMPST.HRB.Pump.stroke2disp =  (280*(0.01)^3/2/pi)/(0.01); % m^2/rad
% HMPST.HRB.Pump.dispMax     =   280*(0.01)^3/2/pi;         % m^3/rad
% HMPST.HRB.Pump.dispMin     = -(280*(0.01)^3/2/pi);         % m^3/rad
% HMPST.HRB.Pump.effMech     =  0.9;  % 0-1
% HMPST.HRB.Pump.effVol      =  0.97; % 0-1
% 
% % Pressure relief valve
% HMPST.HRB.PRV.pDiffOpen = 445;  % bar
% HMPST.HRB.PRV.pRange    = 2;    % bar
% HMPST.HRB.PRV.aMax      = 1e-4; % m^2
% HMPST.HRB.PRV.aLeak     = 1e-12; % m^2
% HMPST.HRB.PRV.tsOpen    = 0.01; % sec
% 
% % Accumulator
% HMPST.HRB.Accumulator.volTotal      = 0.06;               % m^3
% HMPST.HRB.Accumulator.volGasMin     = 0.001;              % m^3
% HMPST.HRB.Accumulator.pPrecharge    = 11 + 0.101325;      % MPa
% HMPST.HRB.Accumulator.volLiquidInit = 5e-3;               % m^3
% HMPST.HRB.Accumulator.pLiquidInit   = 1.01325e5 + 101325; % Pa



%% Clutch Control

% HMPST.Ctrl.HRB.Num = [0 1];
% HMPST.Ctrl.HRB.Den = [0.005*2*5 1];

%% Tires, 1D and 3D

% % Tires, 3D
% HMPST.Tire.Contact = simscape.multibody.tirread('KT_MF_Tool_375_50_R16.tir');
% 
% % Tires, 1D
% HMPST.TireMF1D.FA.fZrated    = 3000; % N
% HMPST.TireMF1D.FA.fXrated    = 3500; % N
% HMPST.TireMF1D.FA.slipRated  = 10;   % Percent 0-100
% HMPST.TireMF1D.FA.rollingR.coeff = 0.015;   % Percent 0-100
% HMPST.TireMF1D.FA.rollingR.vth   = 0.001;   % m/s
% 
% HMPST.TireMF1D.RA.fZrated    = 3000; % N
% HMPST.TireMF1D.RA.fXrated     = 3500; % N
% HMPST.TireMF1D.RA.slipRated  = 10;   % Percent 0-100
% HMPST.TireMF1D.RA.rollingR.coeff = 0.015;   % Percent 0-100
% HMPST.TireMF1D.RA.rollingR.vth   = 0.001;   % m/s


% %% Visuals
% HMPST.Vis.RAxleHou.opc   = 1;%0.1;
% HMPST.Vis.FAxleHou.opc   = 1;%0.1;
% HMPST.Vis.RDiffHou.opc   = 1;%0.1;
% HMPST.Vis.FDiffHou.opc   = 1;%0.1;
% HMPST.Vis.TfrGearHou.opc = 1;%0.1;
% HMPST.Vis.FDriveHou.opc  = 1;%0.1;
% HMPST.Vis.WhlPlaHou.opc  = 1;%0.5;
% HMPST.Vis.SteerWheel.opc = 1; 
% HMPST.Vis.SeatTrim.opc   = 1;
% HMPST.Vis.Bucket.opc     = 1;
% HMPST.Vis.Cap.opc        = 1;
% HMPST.Vis.Light.opc      = 1;
% HMPST.Vis.Lens.opc       = 0.7;





