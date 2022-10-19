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
% Copyright 2022 The MathWorks, Inc.

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
Excavator_Test_Scenario_Select('swingLeft')
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure

%% Swing Right
Excavator_Test_Scenario_Select('swingRight')
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure

%% Boom Up
Excavator_Test_Scenario_Select('boomUp')
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure

%% Boom Down
Excavator_Test_Scenario_Select('boomDown')
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure

%% Stick In
Excavator_Test_Scenario_Select('stickIn')
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure

%% Stick Out
Excavator_Test_Scenario_Select('stickOut')
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure

%% Bucket Close
Excavator_Test_Scenario_Select('bucketClose')
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure

%% Bucket Open
Excavator_Test_Scenario_Select('bucketOpen')
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure

%% Empty Bucket Dig Cycle
Excavator_Test_Scenario_Select('emptyBucketDigCycle')
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure
Excavator_Energy_Calc

%% Loaded Bucket Dig Cycle
Excavator_Test_Scenario_Select('loadedBucketDigCycle')
simOut = sim(mdl);
Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure
Excavator_Complete_plot4loadsoil
Excavator_Energy_Calc

