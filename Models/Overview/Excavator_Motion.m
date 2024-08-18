%% Excavator Design with Simscape(TM): Determine Actuator Forces
% 
% <<Excavator_Motion_Overview_Image.png>>
%
% (<matlab:web('Excavator_Design_Overview.html') return to Excavator Design Overview>)
%
% This example models an excavator arm with boom, stick, and bucket
% cylinders plus a swing motor. The motion of the actuators is prescribed
% and the simulation calculates the amount of force or torque required to
% execute the motion.  The load on the bucket due to the soil can be
% enabled or disabled.
%
% <matlab:open_system('Excavator_Motion') Open Actuator Force Calculation Model>
%
% Copyright 2022-2024 The MathWorks, Inc.

%% Model
open_system('Excavator_Motion')
ann_h = find_system('Excavator_Motion','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures');
for i=1:length(ann_h)
    set_param(ann_h(i),'Interpreter','off');
end

%% Excavator Machine Subsystem
%
% <matlab:open_system('Excavator_Motion');open_system('Excavator_Motion/Excavator/Machine','force'); Open Subsystem>

set_param('Excavator_Motion/Excavator/Machine','LinkStatus','none')
open_system('Excavator_Motion/Excavator/Machine','force')

%% Dig Cycle Test
%
% The following code runs the model and produces plots of the actuator
% positions, actuator forces and torques, and the load on the bucket due to
% the soil.
%   
%   mdl = 'Excavator_Motion';
%   
%   Excavator_Init_Params
%   Excavator_System_params
%   load ScenarioMotion
%   activeTestPos = ScenarioMotion.loadedBucketDigCycle;
%   
%   simOut = sim(mdl);
%   
%   Excavator_Motion_plot2position
%   Excavator_Motion_plot3forces
%   Excavator_Motion_plot4loadsoil

mdl = 'Excavator_Motion';

Excavator_Init_Params
Excavator_System_params
load ScenarioMotion
activeScenario = 'loadedBucketDigCycle';
Excavator_Test_Scenario_Select(activeScenario)
activeTestPos = ScenarioMotion.(activeScenario);

simOut = sim(mdl);

Excavator_Motion_plot2position
Excavator_Motion_plot3forces
Excavator_Motion_plot4loadsoil

%%

%clear all
close all
bdclose all

