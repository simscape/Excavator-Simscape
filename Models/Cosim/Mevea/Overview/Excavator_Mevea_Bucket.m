%% Excavator Design with Simscape(TM): Model Soil Loads on Bucket with Mevea
% 
% <<Excavator_Mevea_Overview_Image.png>>
%
% (<matlab:web('Excavator_Design_Overview.html') return to Excavator Design Overview>)
%
% This example models an excavator acting against soil loads modeled using
% discrete element modeling in Mevea software. The motion of the
% actuators is prescribed and the simulation calculates the amount of force
% or torque required to execute the motion.  Cosimulation is used to
% connect the Simscape Multibody model to Mevea.
%
% Running this model requires Mevea software.  Open the Simulink model,
% start the simulation in Simulink, and when Mevea software opens press the
% Start button.  Both tools will be open simultaneously and the results can
% be seen in both animation windows.
%
% Copyright 2022-2024 The MathWorks, Inc.

%% Model
%
% <matlab:open_system('Excavator_Mevea_Bucket'); Open Model>

open_system('Excavator_Mevea_Bucket')
ann_h = find_system('Excavator_Mevea_Bucket','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures');
for i=1:length(ann_h)
    set_param(ann_h(i),'Interpreter','off');
end

%% Excavator Subsystem
%
% <matlab:open_system('Excavator_Mevea_Bucket');open_system('Excavator_Mevea_Bucket/Excavator','force'); Open Subsystem>

set_param('Excavator_Mevea_Bucket/Excavator','LinkStatus','none')
open_system('Excavator_Mevea_Bucket/Excavator','force')

%% Excavator Machine Subsystem
%
% <matlab:open_system('Excavator_Mevea_Bucket');open_system('Excavator_Mevea_Bucket/Excavator/Machine','force'); Open Subsystem>

set_param('Excavator_Mevea_Bucket/Excavator/Machine','LinkStatus','none')
open_system('Excavator_Mevea_Bucket/Excavator/Machine','force')

%% Excavator Mevea Loads
%
% <matlab:open_system('Excavator_Mevea_Bucket');open_system('Excavator_Mevea_Bucket/Excavator/Machine/Mevea','force'); Open Subsystem>

set_param('Excavator_Mevea_Bucket/Excavator/Machine/Mevea','LinkStatus','none')
open_system('Excavator_Mevea_Bucket/Excavator/Machine/Mevea','force')

%% Excavator Hydraulics Subsystem
%
% <matlab:open_system('Excavator_Mevea_Bucket');open_system('Excavator_Mevea_Bucket/Excavator/Hydraulics','force'); Open Subsystem>

set_param('Excavator_Mevea_Bucket/Excavator/Hydraulics','LinkStatus','none')
open_system('Excavator_Mevea_Bucket/Excavator/Hydraulics','force')

%% Excavator Hydraulic Valve Block (Left) Subsystem
%
% <matlab:open_system('Excavator_Mevea_Bucket');open_system('Excavator_Mevea_Bucket/Excavator/Hydraulics/ValveBlocks/LeftValveBlock','force'); Open Subsystem>

set_param('Excavator_Mevea_Bucket/Excavator/Hydraulics/ValveBlocks/LeftValveBlock','LinkStatus','none')
open_system('Excavator_Mevea_Bucket/Excavator/Hydraulics/ValveBlocks/LeftValveBlock','force')

%% Excavator Hydraulic Boom Cylinder Subsystem
%
% <matlab:open_system('Excavator_Mevea_Bucket');open_system('Excavator_Mevea_Bucket/Excavator/Hydraulics/Functions/Boom','force'); Open Subsystem>

set_param('Excavator_Mevea_Bucket/Excavator/Hydraulics/Functions/Boom','LinkStatus','none')
open_system('Excavator_Mevea_Bucket/Excavator/Hydraulics/Functions/Boom','force')

%% Excavator Controller
%
% <matlab:open_system('Excavator_Mevea_Bucket');open_system('Excavator_Mevea_Bucket/Controller/Function%20Commander','force'); Open Subsystem>

set_param('Excavator_Mevea_Bucket/Controller/Function Commander','LinkStatus','none')
open_system('Excavator_Mevea_Bucket/Controller/Function Commander','force')

%% Dig Cycle Test
%
% Simulate a complete dig cycle and plot operator commands, actuator
% positions, cylinder pressures, and the load on the bucket due to the
% soil.

mdl = 'Excavator_Mevea_BucketDriveline';

simOut = sim(mdl);

Excavator_Complete_plot1operatorcmds
Excavator_Complete_plot2position
Excavator_Complete_plot3pressure
Excavator_Mevea_plot4loadsoil
Excavator_Energy_Calc


%%

%clear all
close all
bdclose all

