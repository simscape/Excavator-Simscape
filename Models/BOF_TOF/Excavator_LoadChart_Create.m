function Excavator_LoadChart_Create(qBoomSet,qStickSet,qBucketSet,setupMdl,calcMdl,useFastRestart,varargin)
% Code to create load chart based on simulations

% Copyright 2022-2023 The MathWorks, Inc

% If an axis handle has been passed, plot on that axis
% Else, the standard figure will be used
if(nargin>6)
    ax_h = varargin{1};
else
    ax_h = [];
end

% Remove ".slx" if part of model name
if(endsWith(setupMdl,'.slx'))
    setupMdl = setupMdl(1:end-4);
end
if(endsWith(calcMdl,'.slx'))
    calcMdl = calcMdl(1:end-4);
end

% Open model and save under another name for test
mdl_setup = [setupMdl '_pct_temp'];
if(~bdIsLoaded(mdl_setup))
    % Only load/save as if model not already loaded
    orig_mdl_setup = setupMdl;
    load_system(orig_mdl_setup);
    save_system(orig_mdl_setup,mdl_setup);
end

mdl_calc = [calcMdl '_pct_temp'];
if(~bdIsLoaded(mdl_calc))
    % Only load/save as if model not already loaded
    orig_mdl_calc = calcMdl;
    load_system(orig_mdl_calc);
    save_system(orig_mdl_calc,mdl_calc);
end

% Select Load Chart scenario: Gravity on, force straight down
Excavator_Test_Scenario_Select('Lift',mdl_setup,mdl_calc)

%% Generate parameter sets for setup runs to obtain mechanism configuration
BOFTOF_stickAngle_set   = qStickSet;
BOFTOF_boomAngle_set    = qBoomSet;
BOFTOF_bucketAngle_set  = qBucketSet;

numtests = length(BOFTOF_boomAngle_set)+length(BOFTOF_stickAngle_set)+length(BOFTOF_bucketAngle_set)-2;

clear simInputSetup
simInputSetup(1:numtests) = Simulink.SimulationInput(mdl_setup);
numtest = 0;
for i=1:length(BOFTOF_boomAngle_set)
    numtest = numtest+1;
    simInputSetup(numtest) = simInputSetup(numtest).setVariable('BOFTOF_boomAngle',BOFTOF_boomAngle_set(i));
    simInputSetup(numtest) = simInputSetup(numtest).setVariable('BOFTOF_stickAngle',BOFTOF_stickAngle_set(1));
    simInputSetup(numtest) = simInputSetup(numtest).setVariable('BOFTOF_bucketAngle',BOFTOF_bucketAngle_set(1));

end
for i=2:length(BOFTOF_stickAngle_set)
    numtest = numtest+1;
    simInputSetup(numtest) = simInputSetup(numtest).setVariable('BOFTOF_boomAngle',BOFTOF_boomAngle_set(end));
    simInputSetup(numtest) = simInputSetup(numtest).setVariable('BOFTOF_stickAngle',BOFTOF_stickAngle_set(i));
    simInputSetup(numtest) = simInputSetup(numtest).setVariable('BOFTOF_bucketAngle',BOFTOF_bucketAngle_set(1));
end
if(length(BOFTOF_bucketAngle_set)>1)
    for i=2:length(BOFTOF_bucketAngle_set)
        numtest = numtest+1;
        simInputSetup(numtest) = simInputSetup(numtest).setVariable('BOFTOF_boomAngle',BOFTOF_boomAngle_set(end));
        simInputSetup(numtest) = simInputSetup(numtest).setVariable('BOFTOF_stickAngle',BOFTOF_stickAngle_set(end));
        simInputSetup(numtest) = simInputSetup(numtest).setVariable('BOFTOF_bucketAngle',BOFTOF_bucketAngle_set(i));
    end
end
%% Adjust settings and save
set_param(mdl_setup,'SimscapeLogType','none');
set_param(mdl_setup,'SimscapeLogToSDI','off');
save_system(mdl_setup)

%% Run parameter sweep
warning off physmod:common:logging2:mli:mcos:kernel:SdiStreamSaveError
timerVal = tic;

if(~useFastRestart)
    % For parallel simulations use "parsim"
    simOutSetup = sim(simInputSetup,'ShowSimulationManager','on',...
        'ShowProgress','on');
else
    % For parallel simulations use "parsim"
    simOutSetup = sim(simInputSetup,'ShowSimulationManager','on',...
        'ShowProgress','on','UseFastRestart','on');
end
Elapsed_Time_Time_parallel  = toc(timerVal);
warning on physmod:common:logging2:mli:mcos:kernel:SdiStreamSaveError

%% Extract assembly information
for i=1:length(simOutSetup)
    BOFTOFPos(i) = Excavator_simlogToBOFTOFPos(simOutSetup(i).BOFTOFSetupOut);
end

ExcvGlobal_LoadChartPos1 = Excavator_Pin_Locations_simlogToGlobal(simOutSetup(1).excavator_frames);

%% Generate parameter sets, Load Calc
clear simInputLoad
simInputLoad(1:length(simOutSetup)) = Simulink.SimulationInput(mdl_calc);
numtest = 0;
for i=1:length(simOutSetup)
    numtest = numtest+1;
    simInputLoad(i) = simInputLoad(i).setVariable('initBoomPistonPos' ,BOFTOFPos(i).initBoomPistonPos);
    simInputLoad(i) = simInputLoad(i).setVariable('initStickPistonPos',BOFTOFPos(i).initStickPistonPos);
    simInputLoad(i) = simInputLoad(i).setVariable('initBucketPistonPos',BOFTOFPos(i).initBucketPistonPos);
    simInputLoad(i) = simInputLoad(i).setVariable('initChassisToBoomRevPos',BOFTOFPos(i).initChassisToBoomRevPos);
    simInputLoad(i) = simInputLoad(i).setVariable('initBoomToStickRevPos',BOFTOFPos(i).initBoomToStickRevPos);
    simInputLoad(i) = simInputLoad(i).setVariable('initStickToBucketRevPos',BOFTOFPos(i).initStickToBucketRevPos);
    simInputLoad(i) = simInputLoad(i).setVariable('bucketForceAngleBOF',BOFTOFPos(i).bucketForceAngleBOF);
    simInputLoad(i) = simInputLoad(i).setVariable('bucketForceAngleTOF',BOFTOFPos(i).bucketForceAngleTOF);
    simInputLoad(i) = simInputLoad(i).setVariable('bucketForceAngleGravity',BOFTOFPos(i).bucketForceAngleGravity);
end
assignin('base','simInputLoad',simInputLoad)
%% Adjust settings and save
set_param(mdl_calc,'SimscapeLogType','none');
set_param(mdl_calc,'SimscapeLogToSDI','off');
save_system(mdl_calc)

%% Run parameter sweep
warning off physmod:common:logging2:mli:mcos:kernel:SdiStreamSaveError
timerVal = tic;

if(~useFastRestart)
    % For parallel simulations use "parsim"
    simOutLoad = sim(simInputLoad,'ShowSimulationManager','on',...
        'ShowProgress','on');
else
    % For parallel simulations use "parsim"
    simOutLoad = sim(simInputLoad,'ShowSimulationManager','on',...
        'ShowProgress','on','UseFastRestart','on');
end

Elapsed_Time_Time_parallel  = toc(timerVal);
warning on physmod:common:logging2:mli:mcos:kernel:SdiStreamSaveError

%% Extract assembly information
for i=1:length(simOutLoad)
    load_set(i)           = simOutLoad(i).logsout.get('Load_kN').Values.Data;
    bucketEdgeXY_set(i,1) = simOutLoad(i).logsout.get('BucketEdge').Values.x.Data(1);
    bucketEdgeXY_set(i,2) = simOutLoad(i).logsout.get('BucketEdge').Values.y.Data(1);
    pBoom_set(i)          = simOutLoad(i).logsout.get('CylPr_bar').Values.Data(1);
    pStick_set(i)         = simOutLoad(i).logsout.get('CylPr_bar').Values.Data(2);
    pBucket_set(i)        = simOutLoad(i).logsout.get('CylPr_bar').Values.Data(3);
    tout_set              = simOutLoad(i).tout(end);
end

% For debugging/testing 
assignin('base','simOutLoad',simOutLoad);
assignin('base',"bucketEdgeXY_set",bucketEdgeXY_set);
assignin('base',"load_set",load_set);
assignin('base',"ExcvGlobal_LoadChartPos1",ExcvGlobal_LoadChartPos1)

% Create load chart
Excavator_LoadChart_Plot(ExcvGlobal_LoadChartPos1,bucketEdgeXY_set,load_set,ax_h)
