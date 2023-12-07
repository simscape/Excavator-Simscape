%% Excavator Design with Simscape(TM): Model Soil Loads 
% 
% <<Excavator_Motion_B3D_Overview.png>>
%
% (<matlab:web('Excavator_Design_Overview.html') return to Excavator Design Overview>)
%
% This example models an excavator acting against soil loads modeled using
% discrete element modeling in ThreeParticle/CAE(TM) software. The motion of the
% actuators is prescribed, and the simulation calculates the amount of force
% or torque required to execute the motion.  Cosimulation is used to
% connect the Simscape Multibody model to ThreeParticle/CAE(TM).
%
% *If you have downloaded the correct release from GitHub*, you can follow
% the steps below to set up cosimulation on your machine.  All of the files
% you need to set up the cosimulation are provided in a specific release
% you must obtain from the <https://github.com/simscape/Excavator-Simscape
% GitHub repository>.  You will also need <https://www.becker3d.com/
% ThreeParticle/CAE(TM) software> R6.1 and API version 3.1.1 which you can
% obtain in a trial license from BECKER 3D.
% 
% Note that the compiled files provided will only work with MATLAB R2023a
% on a Windows 64-bit operating system. To set up this example for other
% versions or operating systems, please contact the authors of this
% submission on the MATLAB Central File Exchange.  We worked with
% <https://simutopia.com/ Simutopia(R)> to create this example.
%
% <matlab:try,open_system('Excavator_Motion_B3D'),catch,warning('Model%20Excavator_Motion_B3D.slx%20not%20found.%20Please%20obtain%20the%20correct%20release%20from%20GitHub.'),end Open Excavator with
% ThreeParticle DEM Soil Loads Model>
%
% Copyright 2022-2023 The MathWorks, Inc.

%% Cosimulation Setup
%
% (Note: the compiled files will only work with MATLAB R2023a on a Windows
% 64 bit operating system.)
%
% *1. Copy |\Models\Cosim\util_zmq\zmqdll\libzmq-v143-mt-4_3_5.dll| to the
% "Bin" subfolder within your ThreeParticle installation directory.*
%
% <<Excavator_Motion_B3D_CopyZMQDLL.png>>
%
% *2. Copy |\Models\Cosim\B3D_Bucket\CosimDLL\API_CoSimulation.dll| to the
% |"Bin\API"| subfolder within your ThreeParticle installation directory.*
%
% <<Excavator_Motion_B3D_CopyAPICosimDLL.png>>
%
% *3. Open ThreeParticle/CAE(TM) Software*
%
% *4. Import keyword file
% |\Models\Cosim\B3D_Bucket\Models_B3D\Bucket_Dig_Cycle.inp|*
%
% <<Excavator_Motion_B3D_LoadBucketDigCycle.png>>
%
% *5. In MATLAB, open Simulink model Excavator_Motion_B3D.slx*
%
% *6. Start the simulation in ThreeParticle/CAE(TM) software*
%
% <<Excavator_Motion_B3D_StartThreeParticleSim.png>>
%
% *7. Start the simulation in Simulink*
%
% <<Excavator_Motion_B3D_StartSimulinkSim.png>>
%
% *8. Monitor the progress in animation*
%
% <<Excavator_Motion_B3D_ProgressAnimation.png>>


%% Model
open_system('Excavator_Motion_B3D')
ann_h = find_system('Excavator_Motion_B3D','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures');
for i=1:length(ann_h)
    set_param(ann_h(i),'Interpreter','off');
end

%% Excavator Machine Subsystem
%
% <matlab:open_system('Excavator_Motion_B3D');open_system('Excavator_Motion_B3D/Excavator/Machine','force'); Open Subsystem>

set_param('Excavator_Motion_B3D/Excavator/Machine','LinkStatus','none')
open_system('Excavator_Motion_B3D/Excavator/Machine','force')

%% DEM Loads Subsystem
%
% <matlab:open_system('Excavator_Motion_B3D');open_system('Excavator_Motion_B3D/DEM%20Loads','force'); Open Subsystem>

set_param('Excavator_Motion_B3D/DEM Loads','LinkStatus','none')
open_system('Excavator_Motion_B3D/DEM Loads','force')


%% Dig Test
%
% The simulation actuates the excavator arm to dig the bucket into the bed
% of particles which models the soil.  The soil loads are plotted below.
%   
% <<Excavator_Motion_B3D_results_soil_loads.png>>



%%

%clear all
close all
bdclose all

