% Code to extract bucket part trajectory from motion test and apply it in
% test harness model that only contains bucket part.

% Copyright 2022-2025 The MathWorks, Inc

%% Open model to generate part trajectory
open_system('Excavator_Motion')

%% Configure motion test scenario for loaded dig cycle
activeTestPos = ScenarioMotion.loadedBucketDigCycle;
Excavator_Test_Scenario_Select('loadedBucketDigCycle');
bucketLoadsActive = 1;

%% Simulate model
simOut = sim('Excavator_Motion');

%% Extract bucket trajectory
Excavator_Motion_Part_Trajectory

%% Open bucket trajectory test model
open_system('bucket_position_trajectory')

%% Simulate model
sim('bucket_position_trajectory')

%% Open bucket trajectory test model in Unreal
open_system('bucket_position_trajectory_ur1')

%% Simulate model
sim('bucket_position_trajectory_ur1')
