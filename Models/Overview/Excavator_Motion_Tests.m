%% Excavator with Prescribed Actuator Motion, Test Scenarios
% 
% This example models an excavator arm with boom, stick, and bucket
% cylinders plus a swing motor. The motion of the actuators is prescribed
% and the simulation calculates the amount of force or torque required to
% execute the motion.  The load on the bucket due to the soil can be
% enabled or disabled.
%
% The results below are from tests that exercise each actuator is exercised
% individually, and then a full dig cycle is completed. Positions and
% forces/torques for each actuator are reported in plots for each scenario.
%
% Copyright 2022-2023 The MathWorks, Inc.

%% Model
clear
mdl = 'Excavator_Motion';

Excavator_Init_Params
Excavator_System_params
load ScenarioMotion
bucketLoadsActive = 0;

Scenario = Excavator_Test_Scenario_Define;
open_system(mdl)

%% Swing Left
activeScenario = 'swingLeft';
activeTestPos = ScenarioMotion.(activeScenario);
Excavator_Test_Scenario_Select(activeScenario)
simOut = sim(mdl);

Excavator_Motion_plot2position
Excavator_Motion_plot3forces

%% Swing Right
activeScenario = 'swingRight';
activeTestPos = ScenarioMotion.(activeScenario);
Excavator_Test_Scenario_Select(activeScenario)

simOut = sim(mdl);

Excavator_Motion_plot2position
Excavator_Motion_plot3forces

%% Boom Up
activeScenario = 'boomUp';
activeTestPos = ScenarioMotion.(activeScenario);
Excavator_Test_Scenario_Select(activeScenario)
simOut = sim(mdl);

Excavator_Motion_plot2position
Excavator_Motion_plot3forces

%% Boom Down
activeScenario = 'boomDown';
activeTestPos = ScenarioMotion.(activeScenario);
Excavator_Test_Scenario_Select(activeScenario)
simOut = sim(mdl);

Excavator_Motion_plot2position
Excavator_Motion_plot3forces

%% Stick In
activeScenario = 'stickIn';
activeTestPos = ScenarioMotion.(activeScenario);
Excavator_Test_Scenario_Select(activeScenario)
simOut = sim(mdl);

Excavator_Motion_plot2position
Excavator_Motion_plot3forces

%% Stick Out
activeScenario = 'stickOut';
activeTestPos = ScenarioMotion.(activeScenario);
Excavator_Test_Scenario_Select(activeScenario)
simOut = sim(mdl);

Excavator_Motion_plot2position
Excavator_Motion_plot3forces

%% Bucket Close
activeScenario = 'bucketClose';
activeTestPos = ScenarioMotion.(activeScenario);
Excavator_Test_Scenario_Select(activeScenario)
simOut = sim(mdl);

Excavator_Motion_plot2position
Excavator_Motion_plot3forces

%% Bucket Open
activeScenario = 'bucketOpen';
activeTestPos = ScenarioMotion.(activeScenario);
Excavator_Test_Scenario_Select(activeScenario)
simOut = sim(mdl);

Excavator_Motion_plot2position
Excavator_Motion_plot3forces

%% Empty Bucket Dig Cycle
activeScenario = 'emptyBucketDigCycle';
activeTestPos = ScenarioMotion.(activeScenario);
Excavator_Test_Scenario_Select(activeScenario)
simOut = sim(mdl);

Excavator_Motion_plot2position
Excavator_Motion_plot3forces


%% Loaded Bucket Dig Cycle
activeScenario = 'loadedBucketDigCycle';
activeTestPos = ScenarioMotion.(activeScenario);
Excavator_Test_Scenario_Select(activeScenario)
bucketLoadsActive = 1;
simOut = sim(mdl);

Excavator_Motion_plot2position
Excavator_Motion_plot3forces
Excavator_Motion_plot4loadsoil
bucketLoadsActive = 0;

