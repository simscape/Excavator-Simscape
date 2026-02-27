%% Excavator Complete Parameter Initialization
% This script defines parameters for the Excavator_Complete.slx model


%% Setup

% Sample time
Ts = 0.1;
p0 = 1.01325; % 56.6532; % [bar]  

%% Test Definition

% No active functions
% idle

% Single Function Tests
% swingLeft | swingRight | boomUp | boomDown 
% stickIn | stickOut | bucketClose | bucketOpen

% Combined Tests
% emptyBucketDigCycle | loadedBucketDigCycle


% Gravity
gravity = -9.81; % [m/s^2]

%% Maximum Function Flow Rates
swingMaxQ = 300; % [lpm]
boomUpMaxQ = 700; % [lpm]
stickInMaxQ = 600; % [lpm]
stickOutMaxQ = 600; % [lpm]
bucketOpenMaxQ = 400; % [lpm]
bucketCloseMaxQ = 400; % [lpm]

%% Function Parameters
% Valve Command Rate Limit
valveCmdPosRateLimit = 10; % [mm/s]
valveCmdNegRateLimit = -10; % [mm/s]

% Pump Displacement Command Rate Limit
pumpCmdPosRateLimit = 1500; % [cc/rev/s]
pumpCmdNegRateLimit = -1500; % [cc/rev/s]

% Valve Spool Vector
spoolPos = (0:0.25:5)'; % [mm] 

% Valve bypass area
BiPArea = [1.75.^flip(spoolPos(2:end)); 1e-3]; % [mm^2] 

% Boom
boomStroke = 1300; % [mm] 
boomBoreDiameter = 220; % [mm]
boomRodDiameter = 150; % [mm]
boomHEArea = pi * (boomBoreDiameter/2)^2; % [mm^2]
boomREArea = pi * (boomBoreDiameter/2)^2 - pi*(boomRodDiameter/2)^2; % [mm^2]
boomValve.spoolPosVector = spoolPos; % [mm]
boomValve.BiPOrificeAreaVector = BiPArea; % [mm^2]
boomValve.PtoAOrificeAreaVector = [1e-3; 3.5.^spoolPos(2:end)]; % [mm^2]
boomValve.AtoTOrificeAreaVector = [1e-3; 2.2.^spoolPos(2:end)]; % [mm^2]
boomValve.AtoBRegOrificeAreaVector = [1e-3; 2.2.^spoolPos(2:end)]; % [mm^2]
boomValve.BtoTOrificeAreaVector = [1e-3; 2.6.^spoolPos(2:end)]; % [mm^2]
boomValve.PtoBOrificeAreaVector = [1e-3; 2.6.^spoolPos(2:end)]; % [mm^2]
boomValve.checkValveCrackingPrDiff    = 0.001*10; % [bar] % REAL-TIME ADJ
boomValve.checkValveMaxOpeningPrDiff  = 0.01*100; % [bar] % REAL-TIME ADJ
boomValve.checkValveMaxOpeningArea = 1100; % [mm^2]
boomValve.checkValveLeakageArea = 0.001; % [mm^2]
boomCylFriction.brkawyToCoulRatio = 1.2;
boomCylFriction.brkawyVel = 1e-2; % [m/s]
boomCylFriction.preloadForce = 20; % [N]
boomCylFriction.coulForceCoef = 1e-4; % [N/Pa]
boomCylFriction.viscCoeff = 5e3; % [N/(m/s)] 

% Stick
stickStroke  = 1500; % [mm] 
stickBoreDiameter = 250; % [mm]
stickRodDiameter = 170; % [mm]
stickHEArea = pi * (stickBoreDiameter/2)^2; % [mm^2]
stickREArea = pi * (stickBoreDiameter/2)^2 - pi*(stickRodDiameter/2)^2; % [mm^2]
stickValve.spoolPosVector = spoolPos; % [mm]
stickValve.BiPOrificeAreaVector = BiPArea; % [mm^2]
stickValve.PtoAOrificeAreaVector = [1e-3; 3.3.^spoolPos(2:end)]; % [mm^2]
stickValve.AtoTOrificeAreaVector = [1e-3; 3.0.^spoolPos(1:end-1)]; % [mm^2]
stickValve.BtoARegOrificeAreaVector = [1e-3; 2.2.^spoolPos(2:end)]; % [mm^2] 
stickValve.BtoTOrificeAreaVector = [1e-3; 2.6.^spoolPos(2:end)]; % [mm^2]
stickValve.PtoBOrificeAreaVector = [1e-3; 3.6.^spoolPos(2:end)]; % [mm^2]
stickValve.checkValveCrackingPrDiff   = 0.001*10; % [bar]  % REAL-TIME ADJ
stickValve.checkValveMaxOpeningPrDiff = 0.01*100; % [bar]  % REAL-TIME ADJ
stickValve.checkValveMaxOpeningArea = 1100; % [mm^2]
stickValve.checkValveLeakageArea = 0.01; % [mm^2]
stickCylFriction.brkawyToCoulRatio = 1.2;
stickCylFriction.brkawyVel = 1e-2; % [m/s]
stickCylFriction.preloadForce = 20; % [N]
stickCylFriction.coulForceCoef = 1e-4; % [N/Pa]
stickCylFriction.viscCoeff = 5e3; % [N/(m/s)] 

% Bucket
bucketStroke  = 1000; % [mm] 
bucketBoreDiameter = 220; % [mm]
bucketRodDiameter = 160; % [mm]
bucketHEArea = pi * (bucketBoreDiameter/2)^2; % [mm^2]
bucketREArea = pi * (bucketBoreDiameter/2)^2 - pi*(bucketRodDiameter/2)^2; % [mm^2]
bucketValve.spoolPosVector = spoolPos; % [mm]
bucketValve.BiPOrificeAreaVector = BiPArea; % [mm^2]
bucketValve.PtoAOrificeAreaVector = [1e-3; 3.6.^spoolPos(2:end)]; % [mm^2] 
bucketValve.AtoTOrificeAreaVector = [1e-3; 3.5.^spoolPos(2:end)]; % [mm^2] 
bucketValve.BtoTOrificeAreaVector = [1e-3; 2.4.^spoolPos(2:end)]; % [mm^2] 
bucketValve.PtoBOrificeAreaVector = [1e-3; 3.5.^spoolPos(2:end)]; % [mm^2] 
bucketCylFriction.brkawyToCoulRatio = 1.2;
bucketCylFriction.brkawyVel = 1e-2; % [m/s]
bucketCylFriction.preloadForce = 20; % [N]
bucketCylFriction.coulForceCoef = 1e-4; % [N/Pa]
bucketCylFriction.viscCoeff = 5e3; % [N/(m/s)]

% Swing
swingSpeedQGain = 60; % Flow rate optimization logic gain
swingHighSpeedThreshold = 6; % [rpm]
swingGearRatio = 270; % Motor gearbox and pinion to ring combined
swingDisplacement = 180; % [cc/rev]
swingASideArea = [1e-3; 3.5.^spoolPos(2:end)]; % [mm^2]
swingBSideArea = swingASideArea; % [mm^2]
swingValve.spoolPosVector = spoolPos; % [mm]
swingValve.BiPOrificeAreaVector = BiPArea; % [mm^2]
swingValve.PtoAOrificeAreaVector = swingASideArea; % [mm^2]
swingValve.AtoTOrificeAreaVector = swingASideArea; % [mm^2]
swingValve.BtoTOrificeAreaVector = swingBSideArea; % [mm^2]
swingValve.PtoBOrificeAreaVector = swingBSideArea; % [mm^2]
swingPRV.reliefPr = 260; % [bar] 
swingPRV.regRange = 5; % [bar]
swingPRV.maxOpeningArea = 100; % [mm^2]
swingPRV.leakageArea = 0.01; % [mm^2]

%% Check Valves
checkValves.crackingPrDiff = 0.001*10;   % [bar]  % REAL-TIME ADJ
checkValves.maxOpeningPrDiff = 0.01*100; % [bar] % REAL-TIME ADJ
checkValves.maxOpeningArea = 1200; % [mm^2]
checkValves.leakageArea = 0.01; % [mm^2]

%% Function Pressure Relief Valves
fcnPRV.reliefPr = 400; % [bar]
fcnPRV.regRange = 5; % [bar]
fcnPRV.maxOpeningArea = 1200; % [mm^2]
fcnPRV.leakageArea = 0.01; % [mm^2]

%% Pump Pressure Relief Valves
pumpPRV.reliefPr = 350; % [bar]
pumpPRV.regRange = 5; % [bar]
pumpPRV.maxOpeningArea = 1200; % [mm^2]
pumpPRV.leakageArea = 0.01; % [mm^2]

%% Pumps 
minPumpDisp = 30; % [cc/rev]
maxPumpDisp = 525; % [cc/rev]
pumpChamberVol = 1e5; % [mm^3]

%% Pipes
pipeLength = 5e3; % [mm]
pipeHydraulicDiam = 50; % [mm]
pipeCrossSectArea = pi * (pipeHydraulicDiam/2)^2; % [mm^2] 

%% Engine
nominalEngineSpeed = 2000; % [rpm]


%% Initial Conditions
Tb = 0.001; % model base sample rate [s]
cFilt = tf([1],[0.01 1]); % REAL-TIME ADJ
dFilt = c2d(cFilt,Tb,'tustin'); % REAL-TIME ADJ

%%
initBoomHEPr   = p0*50; % [bar]  % REAL-TIME ADJ
initBoomREPr   = initBoomHEPr*boomHEArea/boomREArea; % [bar]  % REAL-TIME ADJ
initStickHEPr  = p0*50; % [bar]  % REAL-TIME ADJ
initStickREPr  = initStickHEPr*stickHEArea/stickREArea; % [bar]  % REAL-TIME ADJ
initBucketHEPr = p0*50; % [bar]  % REAL-TIME ADJ
initBucketREPr = initBucketHEPr*bucketHEArea/bucketREArea; % [bar]  % REAL-TIME ADJ
initSwingAPr   = p0*10; % [bar]  % REAL-TIME ADJ
initSwingBPr   = p0*10; % [bar]  % REAL-TIME ADJ

% Extra
pistonCylClearance = 0.15; %0.125; % [mm] % REAL-TIME ADJ
pistonHeadLen = 50; %25; % [mm] % REAL-TIME ADJ
vcVol = 2e-3;

