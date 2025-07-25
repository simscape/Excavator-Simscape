%% Excavator Design with Simscape(TM): Hydromechanical Model with Controls
% 
% <<Excavator_Complete_Overview_Image.png>>
%
% (<matlab:web('Excavator_Design_Overview.html') return to Excavator Design Overview>)
%
% This example models an excavator with complete hydraulic system to power
% cylinders for the boom, stick, and bucket, as well as the swing motor to
% orient the excavator. It can be used to measure the duration and
% efficiency of a dig cycle.
%
% <matlab:open_system('Excavator_Complete') Open Hydromechanical Model with Controls>
%
% Copyright 2022-2025 The MathWorks, Inc.

%% Model
open_system('Excavator_Complete')
ann_h = find_system('Excavator_Complete','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures');
for i=1:length(ann_h)
    set_param(ann_h(i),'Interpreter','off');
end

%% Excavator Subsystem
%
% <matlab:open_system('Excavator_Complete');open_system('Excavator_Complete/Excavator','force'); Open Subsystem>

set_param('Excavator_Complete/Excavator','LinkStatus','none')
open_system('Excavator_Complete/Excavator','force')

%% Excavator Machine Subsystem
%
% <matlab:open_system('Excavator_Complete');open_system('Excavator_Complete/Excavator/Machine','force'); Open Subsystem>

set_param('Excavator_Complete/Excavator/Machine','LinkStatus','none')
open_system('Excavator_Complete/Excavator/Machine','force')

%% Excavator Hydraulics Subsystem
%
% <matlab:open_system('Excavator_Complete');open_system('Excavator_Complete/Excavator/Hydraulics','force'); Open Subsystem>

set_param('Excavator_Complete/Excavator/Hydraulics','LinkStatus','none')
open_system('Excavator_Complete/Excavator/Hydraulics','force')

%% Excavator Hydraulic Pump Subsystem
%
% <matlab:open_system('Excavator_Complete');open_system('Excavator_Complete/Excavator/Hydraulics/LeftPump','force'); Open Subsystem>

set_param('Excavator_Complete/Excavator/Hydraulics/LeftPump','LinkStatus','none')
open_system('Excavator_Complete/Excavator/Hydraulics/LeftPump','force')

%% Excavator Hydraulic Valve Block (Left) Subsystem
%
% <matlab:open_system('Excavator_Complete');open_system('Excavator_Complete/Excavator/Hydraulics/ValveBlocks/LeftValveBlock','force'); Open Subsystem>

set_param('Excavator_Complete/Excavator/Hydraulics/ValveBlocks/LeftValveBlock','LinkStatus','none')
open_system('Excavator_Complete/Excavator/Hydraulics/ValveBlocks/LeftValveBlock','force')

%% Excavator Hydraulic Boom Cylinder Subsystem
%
% <matlab:open_system('Excavator_Complete');open_system('Excavator_Complete/Excavator/Hydraulics/Functions/Boom','force'); Open Subsystem>

set_param('Excavator_Complete/Excavator/Hydraulics/Functions/Boom','LinkStatus','none')
open_system('Excavator_Complete/Excavator/Hydraulics/Functions/Boom','force')

%% Excavator Controller
%
% <matlab:open_system('Excavator_Complete');open_system('Excavator_Complete/Controller/Function%20Commander','force'); Open Subsystem>

set_param('Excavator_Complete/Controller/Function Commander','LinkStatus','none')
open_system('Excavator_Complete/Controller/Function Commander','force')

%% Dig Cycle Test
%
% The following code runs the model and produces plots of the operator
% commands, actuator positions, cylinder pressures, and the load on the
% bucket due to the soil.
%   
%   mdl = 'Excavator_Complete';
%   
%   Excavator_Init_Params
%   Excavator_System_params
%   Scenario = Excavator_Test_Scenario_Define;
%   
%   Excavator_Test_Scenario_Select('loadedBucketDigCycle')
%   
%   simOut = sim(mdl);
%   
%   Excavator_Complete_plot1operatorcmds
%   Excavator_Complete_plot2position
%   Excavator_Complete_plot3pressure
%   Excavator_Complete_plot4loadsoil
%   Excavator_Energy_Calc

mdl = 'Excavator_Complete';

Excavator_Init_Params
Excavator_System_params
Scenario = Excavator_Test_Scenario_Define;

Excavator_Test_Scenario_Select('loadedBucketDigCycle')

simOut = sim(mdl);

Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure
Excavator_Complete_plot4loadsoil
Excavator_Energy_Calc

%%

%clear all
close all
bdclose all

