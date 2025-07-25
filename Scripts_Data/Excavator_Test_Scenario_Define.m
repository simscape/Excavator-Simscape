function Scenario = Excavator_Test_Scenario_Define
%% P28 Test Scenario Definitions
% This script contains all model test scenario definitions.

% Copyright 2022-2025 The MathWorks, Inc

%% Defaults
% -- Test Definitions
load('TestCommands.mat','TestCmds','EmptyBucketDigCycle','LoadedBucketDigCycle');
activeTestCmds = TestCmds;

% -- Bucket Loads
defaultsetting.bucketLoadsActive = false;

materialDensity = 2500; % [kg/m^3]
bucketVolume = 2; % [m^3]
materialMass = materialDensity * bucketVolume; % [kg]
defaultsetting.materialWeight = materialMass * 9.81/1000; % [kN]

defaultsetting.yForceMax = 250; % [kN]
defaultsetting.zForceMax = 150; % [kN]
defaultsetting.startDiggingZPos = -3600+1745    ; % [mm]
defaultsetting.velocityToYForceGain = -0.25;
defaultsetting.yForceToZForceGain = -0.75;

% -- BOF & TOF Parameters
defaultsetting.BOFTestActive = false;
defaultsetting.TOFTestActive = false;
%defaultsetting.forceTestMaxActiveCylPr = 350; % [bar]
%defaultsetting.forceTestMaxReactiveCylPr = 400; % [bar]

defSetFields = fieldnames(defaultsetting);


%% 'idle'
% Add defaults
for dfs_i = 1:length(defSetFields)
    Scenario.Idle.(defSetFields{dfs_i}) = defaultsetting.(defSetFields{dfs_i});
end

Scenario.Idle.initSwingAngle = 0; % [deg]
Scenario.Idle.initBoomPistonPos = 500; % [mm]
Scenario.Idle.initStickPistonPos = 500; % [mm]
Scenario.Idle.initBucketPistonPos = 500; % [mm]
Scenario.Idle.initChassisToBoomRevPos = 41.38; % [deg]
Scenario.Idle.initBoomToStickRevPos = -32.539; % [deg]
Scenario.Idle.initStickToBucketRevPos = -50; % [deg]

% Set the model conditions
Scenario.Idle.stopTime = 20; % [s]
Scenario.Idle.activeTestCmds = TestCmds;


%% 'BOF'
% Add defaults
for dfs_i = 1:length(defSetFields)
    Scenario.BOF.(defSetFields{dfs_i}) = defaultsetting.(defSetFields{dfs_i});
end

Scenario.BOF.BOFTestActive = true;

% Set the model conditions
Scenario.BOF.stopTime = 60; % [s]
Scenario.BOF.activeTestCmds = TestCmds;


%% 'TOF'
% Add defaults
for dfs_i = 1:length(defSetFields)
    Scenario.TOF.(defSetFields{dfs_i}) = defaultsetting.(defSetFields{dfs_i});
end

Scenario.TOF.TOFTestActive = true;

% Set the model conditions
Scenario.TOF.stopTime = 60; % [s]
Scenario.TOF.activeTestCmds = TestCmds;

%% 'swingLeft'
% Add defaults
for dfs_i = 1:length(defSetFields)
    Scenario.swingLeft.(defSetFields{dfs_i}) = defaultsetting.(defSetFields{dfs_i});
end
Scenario.swingLeft.initSwingAngle = 0; % [deg]
Scenario.swingLeft.initBoomPistonPos = 900; % [mm]
Scenario.swingLeft.initStickPistonPos = 1000; % [mm]
Scenario.swingLeft.initBucketPistonPos = 750; % [mm]
Scenario.swingLeft.initChassisToBoomRevPos = 66.313; % [deg]
Scenario.swingLeft.initBoomToStickRevPos = -60.542; % [deg]
Scenario.swingLeft.initStickToBucketRevPos = -75.335; % [deg]

% Set the command
fcnCmd = createCmd(-1, 5, 0.2, 10); % (value, startOffset, rampTime, totalCmdTime)
fcnCmd.Name = 'SwingCmd';
cmdDataTmp = fcnCmd;

% Update the scenario with the modified element object
activeTestCmds = TestCmds;
idxTmp = find(strcmp(activeTestCmds.getElementNames,'SwingCmd'));
activeTestCmds{idxTmp} = cmdDataTmp;
Scenario.swingLeft.activeTestCmds = activeTestCmds;

% Set the model conditions
Scenario.swingLeft.stopTime = fcnCmd.Time(end); % [s]

%% 'swingRight'
% Add defaults
for dfs_i = 1:length(defSetFields)
    Scenario.swingRight.(defSetFields{dfs_i}) = defaultsetting.(defSetFields{dfs_i});
end

Scenario.swingRight.initSwingAngle = 0; % [deg]
Scenario.swingRight.initBoomPistonPos = 900; % [mm]
Scenario.swingRight.initStickPistonPos = 1000; % [mm]
Scenario.swingRight.initBucketPistonPos = 750; % [mm]
Scenario.swingRight.initChassisToBoomRevPos = 66.313; % [deg]
Scenario.swingRight.initBoomToStickRevPos = -60.542; % [deg]
Scenario.swingRight.initStickToBucketRevPos = -75.335; % [deg]

% Set the command
fcnCmd = createCmd(1, 5, 0.2, 10); % (value, startOffset, rampTime, totalCmdTime)
fcnCmd.Name = 'SwingCmd';
cmdDataTmp = fcnCmd;

% Update the scenario with the modified element object
activeTestCmds = TestCmds;
idxTmp = find(strcmp(activeTestCmds.getElementNames,'SwingCmd'));
activeTestCmds{idxTmp} = cmdDataTmp;
Scenario.swingRight.activeTestCmds = activeTestCmds;

% Set the model conditions
Scenario.swingRight.stopTime = fcnCmd.Time(end); % [s]

%% 'boomUp'
% Add defaults
for dfs_i = 1:length(defSetFields)
    Scenario.boomUp.(defSetFields{dfs_i}) = defaultsetting.(defSetFields{dfs_i});
end

Scenario.boomUp.initSwingAngle = 0; % [deg]
Scenario.boomUp.initBoomPistonPos = 300; % [mm]
Scenario.boomUp.initStickPistonPos = 0; % [mm]
Scenario.boomUp.initBucketPistonPos = 0; % [mm]
Scenario.boomUp.initChassisToBoomRevPos = 27.945; % [deg]
Scenario.boomUp.initBoomToStickRevPos = -1; % [deg]
Scenario.boomUp.initStickToBucketRevPos = -1.5; % [deg]

% Set the command
fcnCmd = createCmd(-1, 5, 1, 6.5); % (value, startOffset, rampTime, totalCmdTime)
fcnCmd.Name = 'BoomCmd';
cmdDataTmp = fcnCmd;

% Update the scenario with the modified element object
activeTestCmds = TestCmds;
idxTmp = find(strcmp(activeTestCmds.getElementNames,'BoomCmd'));
activeTestCmds{idxTmp} = cmdDataTmp;
Scenario.boomUp.activeTestCmds = activeTestCmds;

% Set the model conditions
Scenario.boomUp.stopTime = fcnCmd.Time(end); % [s]

%% 'boomDown'
% Add defaults
for dfs_i = 1:length(defSetFields)
    Scenario.boomDown.(defSetFields{dfs_i}) = defaultsetting.(defSetFields{dfs_i});
end
Scenario.boomDown.initSwingAngle = 0; % [deg]
Scenario.boomDown.initBoomPistonPos = 1200; % [mm]
Scenario.boomDown.initStickPistonPos = 10; % [mm]
Scenario.boomDown.initBucketPistonPos = 10; % [mm]
Scenario.boomDown.initChassisToBoomRevPos = 85.994; % [deg]
Scenario.boomDown.initBoomToStickRevPos = -1; % [deg]
Scenario.boomDown.initStickToBucketRevPos = -1.5; % [deg]

% Set the command
fcnCmd = createCmd(1, 5, 1, 4); % (value, startOffset, rampTime, totalCmdTime)
fcnCmd.Name = 'BoomCmd';
cmdDataTmp = fcnCmd;

% Update the scenario with the modified element object
activeTestCmds = TestCmds;
idxTmp = find(strcmp(activeTestCmds.getElementNames,'BoomCmd'));
activeTestCmds{idxTmp} = cmdDataTmp;
Scenario.boomDown.activeTestCmds = activeTestCmds;

% Set the model conditions
Scenario.boomDown.stopTime = fcnCmd.Time(end); % [s]

%% 'stickIn'
% Add defaults
for dfs_i = 1:length(defSetFields)
    Scenario.stickIn.(defSetFields{dfs_i}) = defaultsetting.(defSetFields{dfs_i});
end
Scenario.stickIn.initSwingAngle = 0; % [deg]
Scenario.stickIn.initBoomPistonPos = 500; % [mm]
Scenario.stickIn.initStickPistonPos = 10; % [mm]
Scenario.stickIn.initBucketPistonPos = 500; % [mm]
Scenario.stickIn.initChassisToBoomRevPos = 41; % [deg]
Scenario.stickIn.initBoomToStickRevPos = -1; % [deg]
Scenario.stickIn.initStickToBucketRevPos = -50; % [deg]

% Set the command
fcnCmd = createCmd(-1, 5, 1, 6.5); % (value, startOffset, rampTime, totalCmdTime)
fcnCmd.Name = 'StickCmd';
cmdDataTmp = fcnCmd;

% Update the scenario with the modified element object
activeTestCmds = TestCmds;
idxTmp = find(strcmp(activeTestCmds.getElementNames,'StickCmd'));
activeTestCmds{idxTmp} = cmdDataTmp;
Scenario.stickIn.activeTestCmds = activeTestCmds;

% Set the model conditions
Scenario.stickIn.stopTime = fcnCmd.Time(end); % [s]

%% 'stickOut'
% Add defaults
for dfs_i = 1:length(defSetFields)
    Scenario.stickOut.(defSetFields{dfs_i}) = defaultsetting.(defSetFields{dfs_i});
end
Scenario.stickOut.initSwingAngle = 0; % [deg]
Scenario.stickOut.initBoomPistonPos = 500; % [mm]
Scenario.stickOut.initStickPistonPos = 1400; % [mm]
Scenario.stickOut.initBucketPistonPos = 500; % [mm]
Scenario.stickOut.initChassisToBoomRevPos = 41; % [deg]
Scenario.stickOut.initBoomToStickRevPos = -85.662; % [deg]
Scenario.stickOut.initStickToBucketRevPos = -50; % [deg]

% Set the command
fcnCmd = createCmd(1, 5, 1, 4.5); % (value, startOffset, rampTime, totalCmdTime)
fcnCmd.Name = 'StickCmd';
cmdDataTmp = fcnCmd;

% Update the scenario with the modified element object
activeTestCmds = TestCmds;
idxTmp = find(strcmp(activeTestCmds.getElementNames,'StickCmd'));
activeTestCmds{idxTmp} = cmdDataTmp;
Scenario.stickOut.activeTestCmds = activeTestCmds;

% Set the model conditions
Scenario.stickOut.stopTime = fcnCmd.Time(end); % [s]

%% 'bucketOpen'
% Add defaults
for dfs_i = 1:length(defSetFields)
    Scenario.bucketOpen.(defSetFields{dfs_i}) = defaultsetting.(defSetFields{dfs_i});
end
Scenario.bucketOpen.initSwingAngle = 0; % [deg]
Scenario.bucketOpen.initBoomPistonPos = 500; % [mm]
Scenario.bucketOpen.initStickPistonPos = 500; % [mm]
Scenario.bucketOpen.initBucketPistonPos = 900; % [mm]
Scenario.bucketOpen.initChassisToBoomRevPos = 41; % [deg]
Scenario.bucketOpen.initBoomToStickRevPos = -32.539; % [deg]
Scenario.bucketOpen.initStickToBucketRevPos = -94.050; % [deg]

% Set the command
fcnCmd = createCmd(1, 5, 1, 3); % (value, startOffset, rampTime, totalCmdTime)
fcnCmd.Name = 'BucketCmd';
cmdDataTmp = fcnCmd;

% Update the scenario with the modified element object
activeTestCmds = TestCmds;
idxTmp = find(strcmp(activeTestCmds.getElementNames,'BucketCmd'));
activeTestCmds{idxTmp} = cmdDataTmp;
Scenario.bucketOpen.activeTestCmds = activeTestCmds;

% Set the model conditions
Scenario.bucketOpen.stopTime = fcnCmd.Time(end); % [s]

%% 'bucketClose'
% Add defaults
for dfs_i = 1:length(defSetFields)
    Scenario.bucketClose.(defSetFields{dfs_i}) = defaultsetting.(defSetFields{dfs_i});
end
Scenario.bucketClose.initSwingAngle = 0; % [deg]
Scenario.bucketClose.initBoomPistonPos = 500; % [mm]
Scenario.bucketClose.initStickPistonPos = 500; % [mm]
Scenario.bucketClose.initBucketPistonPos = 100; % [mm]
Scenario.bucketClose.initChassisToBoomRevPos = 41; % [deg]
Scenario.bucketClose.initBoomToStickRevPos = -32.539; % [deg]
Scenario.bucketClose.initStickToBucketRevPos = -12.591; % [deg]

% Set the command
fcnCmd = createCmd(-1, 5, 1, 4); % (value, startOffset, rampTime, totalCmdTime)
fcnCmd.Name = 'BucketCmd';
cmdDataTmp = fcnCmd;

% Update the scenario with the modified element object
activeTestCmds = TestCmds;
idxTmp = find(strcmp(activeTestCmds.getElementNames,'BucketCmd'));
activeTestCmds{idxTmp} = cmdDataTmp;
Scenario.bucketClose.activeTestCmds = activeTestCmds;

% Set the model conditions
Scenario.bucketClose.stopTime = fcnCmd.Time(end); % [s]

%% 'emptyBucketDigCycle'
% Add defaults
for dfs_i = 1:length(defSetFields)
    Scenario.emptyBucketDigCycle.(defSetFields{dfs_i}) = defaultsetting.(defSetFields{dfs_i});
end
Scenario.emptyBucketDigCycle.initSwingAngle = -120; % [deg]
Scenario.emptyBucketDigCycle.initBoomPistonPos = 1100; % [mm]
Scenario.emptyBucketDigCycle.initStickPistonPos = 1000; % [mm]
Scenario.emptyBucketDigCycle.initBucketPistonPos = 50; % [mm]
Scenario.emptyBucketDigCycle.initChassisToBoomRevPos = 79.2; % [deg]
Scenario.emptyBucketDigCycle.initBoomToStickRevPos = -60.5; % [deg]
Scenario.emptyBucketDigCycle.initStickToBucketRevPos = -6.9; % [deg]

Scenario.emptyBucketDigCycle.activeTestCmds = EmptyBucketDigCycle;

% Set the model conditions
Scenario.emptyBucketDigCycle.stopTime = 31; % [s]

%% 'loadedBucketDigCycle'
% Add defaults
for dfs_i = 1:length(defSetFields)
    Scenario.loadedBucketDigCycle.(defSetFields{dfs_i}) = defaultsetting.(defSetFields{dfs_i});
end
Scenario.loadedBucketDigCycle.initSwingAngle = -120; % [deg]
Scenario.loadedBucketDigCycle.initBoomPistonPos = 1100; % [mm]
Scenario.loadedBucketDigCycle.initStickPistonPos = 1000; % [mm]
Scenario.loadedBucketDigCycle.initBucketPistonPos = 50; % [mm]
Scenario.loadedBucketDigCycle.initChassisToBoomRevPos = 79.2; % [deg]
Scenario.loadedBucketDigCycle.initBoomToStickRevPos = -60.5; % [deg]
Scenario.loadedBucketDigCycle.initStickToBucketRevPos = -6.9; % [deg]

Scenario.loadedBucketDigCycle.activeTestCmds = LoadedBucketDigCycle;

% Set the model conditions
Scenario.loadedBucketDigCycle.stopTime = 31; % [s]
Scenario.loadedBucketDigCycle.bucketLoadsActive = true;

fldnames = fieldnames(Scenario);

for fld_i = 1:length(fldnames)
    numEl = Scenario.(fldnames{fld_i}).activeTestCmds.numElements;
    for cmd_i = 1:numEl
        Scenario.(fldnames{fld_i}).activeTestCmds{cmd_i}.Time(end) = Scenario.(fldnames{fld_i}).stopTime;
    end
end
%% 'Load Chart'
Scenario.Lift = Scenario.BOF;

% Create command data
    function cmd = createCmd(value,startOffset,rampTime,totalCmdTime)
        cmd = timeseries([ ...
            0;
            0;
            value;
            value;
            0;
            0], [ ...
            0;
            startOffset;
            startOffset + rampTime;
            startOffset + totalCmdTime - rampTime;
            startOffset + totalCmdTime;
            startOffset + startOffset + totalCmdTime]);
    end
end