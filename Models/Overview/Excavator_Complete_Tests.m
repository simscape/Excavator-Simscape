%% Excavator with Hydraulic System, Test Scenarios
% 
% This example models an excavator with complete hydraulic system to power
% cylinders for the boom, stick, and bucket, as well as the swing motor to
% orient the excavator. It can be used to measure the duration and
% efficiency of a dig cycle.
%
% The results below are from tests that exercise each actuator is exercised
% individually, and then a full dig cycle is completed. Positions,
% pressures, and the energy expended are reported in plots for each
% scenario.
%
% Copyright 2022-2023 The MathWorks, Inc.

%% Model
clear
mdl = 'Excavator_Complete';
mdl_BOFTOF_setup = 'Excavator_Param_BOFTOF_Setup';
mdl_BOFTOF_calc  = 'Excavator_Param_BOFTOF_Calc';

Excavator_Init_Params
Excavator_System_params

Scenario = Excavator_Test_Scenario_Define;
open_system(mdl)

%% Swing Left
activeScenario = 'swingLeft';
Excavator_Test_Scenario_Select(activeScenario)
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure

Excavator_Motion_Test_Assemble
ScenarioMotion.(activeScenario) = activeTestPos;

%% Swing Right
activeScenario = 'swingRight';
Excavator_Test_Scenario_Select(activeScenario)
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure

Excavator_Motion_Test_Assemble
ScenarioMotion.(activeScenario) = activeTestPos;

%% Boom Up
activeScenario = 'boomUp';
Excavator_Test_Scenario_Select(activeScenario)
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure

Excavator_Motion_Test_Assemble
ScenarioMotion.(activeScenario) = activeTestPos;

%% Boom Down
activeScenario = 'boomDown';
Excavator_Test_Scenario_Select(activeScenario)
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure

Excavator_Motion_Test_Assemble
ScenarioMotion.(activeScenario) = activeTestPos;

%% Stick In
activeScenario = 'stickIn';
Excavator_Test_Scenario_Select(activeScenario)
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure

Excavator_Motion_Test_Assemble
ScenarioMotion.(activeScenario) = activeTestPos;

%% Stick Out
activeScenario = 'stickOut';
Excavator_Test_Scenario_Select(activeScenario)
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure

Excavator_Motion_Test_Assemble
ScenarioMotion.(activeScenario) = activeTestPos;

%% Bucket Close
activeScenario = 'bucketClose';
Excavator_Test_Scenario_Select(activeScenario)
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure

Excavator_Motion_Test_Assemble
ScenarioMotion.(activeScenario) = activeTestPos;

%% Bucket Open
activeScenario = 'bucketOpen';
Excavator_Test_Scenario_Select(activeScenario)
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure

Excavator_Motion_Test_Assemble
ScenarioMotion.(activeScenario) = activeTestPos;

%% Empty Bucket Dig Cycle
activeScenario = 'emptyBucketDigCycle';
Excavator_Test_Scenario_Select(activeScenario);
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure
Excavator_Energy_Calc

Excavator_Motion_Test_Assemble
ScenarioMotion.(activeScenario) = activeTestPos;

%% Loaded Bucket Dig Cycle
activeScenario = 'loadedBucketDigCycle';
Excavator_Test_Scenario_Select(activeScenario);
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure
Excavator_Complete_plot4loadsoil
Excavator_Energy_Calc

Excavator_Motion_Test_Assemble
ScenarioMotion.(activeScenario) = activeTestPos;
