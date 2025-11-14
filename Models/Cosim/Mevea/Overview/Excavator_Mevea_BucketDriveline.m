%% Excavator Design with Simscape(TM): Model Soil Loads on Bucket and Ground Interaction with Mevea
% 
% <<Excavator_Mevea_Overview_Image.png>>
%
% (<matlab:web('Excavator_Design_Overview.html') return to Excavator Design Overview>)
%
% This example models an excavator acting against soil loads modeled using
% Mevea software. The motion of the actuators is prescribed and the
% simulation calculates the amount of force or torque required to execute
% the motion.  Cosimulation is used to connect the Simscape Multibody model
% to Mevea.  
% 
% Additionally, terrain interaction with the tracks is modeled in Mevea.
% An electric CVT is modeled in Simscape, and the shaft from that
% powertrain model is connected via cosimulation to a shaft in the Mevea
% model that controls the movement of the tracks.  The tracks interact with
% deformable terrain modeled in Mevea.
%
% Running this model requires Mevea software.  Open the Simulink model,
% start the simulation in Simulink, and when Mevea software opens press the
% Start button.  Both tools will be open simultaneously and the results can
% be seen in both animation windows.
%
% Copyright 2022-2025 The MathWorks, Inc.

%% Model
%
% <matlab:open_system('Excavator_Mevea_BucketDriveline'); Open Model>

open_system('Excavator_Mevea_BucketDriveline')
ann_h = find_system('Excavator_Mevea_BucketDriveline','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures');
for i=1:length(ann_h)
    set_param(ann_h(i),'Interpreter','off');
end

%% Excavator Subsystem
%
% <matlab:open_system('Excavator_Mevea_BucketDriveline');open_system('Excavator_Mevea_BucketDriveline/Excavator','force'); Open Subsystem>

set_param('Excavator_Mevea_BucketDriveline/Excavator','LinkStatus','none')
open_system('Excavator_Mevea_BucketDriveline/Excavator','force')

%% Excavator Machine Subsystem
%
% <matlab:open_system('Excavator_Mevea_BucketDriveline');open_system('Excavator_Mevea_BucketDriveline/Excavator/Machine','force'); Open Subsystem>

set_param('Excavator_Mevea_BucketDriveline/Excavator/Machine','LinkStatus','none')
open_system('Excavator_Mevea_BucketDriveline/Excavator/Machine','force')

%% Excavator Mevea Loads
%
% <matlab:open_system('Excavator_Mevea_BucketDriveline');open_system('Excavator_Mevea_BucketDriveline/Excavator/Machine/Mevea','force'); Open Subsystem>

set_param('Excavator_Mevea_BucketDriveline/Excavator/Machine/Mevea','LinkStatus','none')
open_system('Excavator_Mevea_BucketDriveline/Excavator/Machine/Mevea','force')

%% Excavator Hydraulics Subsystem
%
% <matlab:open_system('Excavator_Mevea_BucketDriveline');open_system('Excavator_Mevea_BucketDriveline/Excavator/Hydraulics','force'); Open Subsystem>

set_param('Excavator_Mevea_BucketDriveline/Excavator/Hydraulics','LinkStatus','none')
open_system('Excavator_Mevea_BucketDriveline/Excavator/Hydraulics','force')

%% Excavator Hydraulic Valve Block (Left) Subsystem
%
% <matlab:open_system('Excavator_Mevea_BucketDriveline');open_system('Excavator_Mevea_BucketDriveline/Excavator/Hydraulics/ValveBlocks/LeftValveBlock','force'); Open Subsystem>

set_param('Excavator_Mevea_BucketDriveline/Excavator/Hydraulics/ValveBlocks/LeftValveBlock','LinkStatus','none')
open_system('Excavator_Mevea_BucketDriveline/Excavator/Hydraulics/ValveBlocks/LeftValveBlock','force')

%% Excavator Hydraulic Boom Cylinder Subsystem
%
% <matlab:open_system('Excavator_Mevea_BucketDriveline');open_system('Excavator_Mevea_BucketDriveline/Excavator/Hydraulics/Functions/Boom','force'); Open Subsystem>

set_param('Excavator_Mevea_BucketDriveline/Excavator/Hydraulics/Functions/Boom','LinkStatus','none')
open_system('Excavator_Mevea_BucketDriveline/Excavator/Hydraulics/Functions/Boom','force')

%% Excavator Controller
%
% <matlab:open_system('Excavator_Mevea_BucketDriveline');open_system('Excavator_Mevea_BucketDriveline/Controller/Function%20Commander','force'); Open Subsystem>

set_param('Excavator_Mevea_BucketDriveline/Controller/Function Commander','LinkStatus','none')
open_system('Excavator_Mevea_BucketDriveline/Controller/Function Commander','force')

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

