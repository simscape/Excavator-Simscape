% Startup script for Excavator.prj

% Copyright 2022-2025 The MathWorks, Inc

Excavator_Init_Params
Scenario = Excavator_Test_Scenario_Define;
Excavator_Test_Scenario_Select('loadedBucketDigCycle')
loadedBucketDigCycleHold = Scenario.loadedBucketDigCycle;

loadedBucketDigCycleHold.activeTestCmds{1}.Data = activeTestCmds{1}.Data*0;
loadedBucketDigCycleHold.activeTestCmds{2}.Data = activeTestCmds{2}.Data*0;
loadedBucketDigCycleHold.activeTestCmds{3}.Data = activeTestCmds{3}.Data*0;
loadedBucketDigCycleHold.activeTestCmds{4}.Data = activeTestCmds{4}.Data*0;
Scenario.loadedBucketDigCycleHold = loadedBucketDigCycleHold;
clear loadedBucketDigCycleHold


Excavator_System_params
ExcvGlobal = Excavator_Pin_Locations_global('Design A');
ExcvLocal  = Excavator_Pin_Locations_global2local(ExcvGlobal);

load ScenarioMotion
activeTestPos = ScenarioMotion.loadedBucketDigCycle;

% Set environment variable for ZMQ library
% if DLL has already been created
if(exist('addZMQDLLtoSysPath.m','file'))
    addZMQDLLtoSysPath;
    Ts_DEM = 1e-4;
    initializeBoxDimensions; % Visualization in Mechanics Explorer
end

Excavator_Design_app_run

web('Excavator_Design_Overview.html')

