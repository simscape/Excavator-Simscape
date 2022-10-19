%% Excavator Design Solution in Simscape: Load Chart Calculation
% 
% This app enables you to create a load chart for a given excavator design.
% The load chart calculation is performed using a minimal set of parameters
% to enable design space exploration.
%
% You use the app to specify:
%
% * Pin locations 
% * Maximum hydraulic relief pressures 
% * Cylinder areas
% * Boom, stick, and bucket masses
% * Excavator arm angles for test points
%
% The app will assign these values to a parameterized excavator model
% created using Simscape Multibody. It will then run a set of simulations
% to determine the lift capacity at each of those points, including the
% effects of gravity. The resulting plot will be shown in the app.
%
% Copyright 2022 The MathWorks, Inc.

%% Excavator Design App: Define Pin Locations
%
% On the "Design" tab you specify the pin locations in the design position.
% 
% * Edit the pin locations in the table.
% * Press the "Plot Design Position" button to draw the excavator.
% * Press the "Model Design Position" button to display the model. This
% loads the pin locations into the MATLAB workspace. 
%
% Pre-saved sets of pin locations can be loaded from Excel.
%
% <<Excavator_BOF_TOF_UI_Design_Tab.png>>
%
% <<Excavator_BOF_TOF_UI_Model_Design_Position.png>>

%% Excavator Design App: Create Load Chart
%
% On the "Load Chart" tab you configure the load chart sweep.
% 
% * Define maximum pressures for the actuators
% * Define cylinder cross-sectional areas. 
% * Define the mass for the boom, stick, and bucket
% * Define the excavator arm angles for test points.
% * --- See the BOF, TOF tab for a diagram explaining the angles
% * --- The stick and bucket angles will be held at their initial position while
% the boom angle is swept from start to stop
% * --- Next, the stick angle will be swept as the boom angle is held at
% the stop angle and the bucket angle is held at the start angle.
% * --- Finally, the bucket angle will be swept as the boom angle and stick angle are held at
% their respective stop angles 
% * Set the "Use Fast Restart" checkbox for a faster sweep (excavator visualization will
% not be shown) or leave it blank to see each excavator position.
% * Press "Generate Load Chart" button
%
% <<Excavator_BOF_TOF_UI_LoadChart_Tab.png>>
%
% The final configuration of the excavator will be visualized. The arrows
% in the windo show the load force applied and the forces in each
% cylinder.  This image shows an example of the Load Chart test.  During the test,
% 
% * Gravity is turned on
% * The cylinders are locked in the specified test position 
% * The load is increased until one of the cylinders reaches the limit specified in the app.
%
% <<Excavator_LoadChart_UI_Calc.png>>
%

%% Load Chart Test, Pressure Settings A
%
% Generating the load chart can be automated using MATLAB commands.  The
% MATLAB code below creates a load chart for Design A.
%
mdl_LoadChart_setup = 'Excavator_Param_BOFTOF_Setup';
mdl_LoadChart_calc  = 'Excavator_Param_BOFTOF_Calc';

MPdata = readtable('Excavator_Pin_Locations_global.xlsx','Sheet','Design A','Range','B2:F15','VariableNamingRule','preserve');
ExcvGlobal = Excavator_Pin_Locations_table2struct(MPdata);
ExcvLocal  = Excavator_Pin_Locations_global2local(ExcvGlobal);

forceTestMaxActiveCylPr   = 350; % bar, Max pressure boom cylinder
forceTestMaxReactiveCylPr = 400; % bar, Max pressure stick and bucket cylinders

BOFTOF_BoomCylArea   = 38013; % mm^2, Area boom cylinder, head end
BOFTOF_StickCylArea  = 26389; % mm^2, Area stick cylinder, rod end
BOFTOF_BucketCylArea = 17907; % mm^3, Area bucket cylinder, rod end

LoadChart_BoomMass   = 7226.51; % kg, Mass boom arm
LoadChart_StickMass  = 3327.88; % kg, Mass stick arm
LoadChart_BucketMass = 5119.51; % kg, Mass bucket

qBoomSet   = linspace(60,120,10); % deg
qStickSet  = linspace(120,45,5);  % deg
qBucketSet = linspace(90,60,3);   % deg

Excavator_LoadChart_Create(qBoomSet,qStickSet,qBucketSet,...
    mdl_LoadChart_setup,mdl_LoadChart_calc,true);

%% Load Chart Test, Design B
%
% In this test we generate the load chart using Design B

MPdata = readtable('Excavator_Pin_Locations_global.xlsx','Sheet','Design B','Range','B2:F15','VariableNamingRule','preserve');
ExcvGlobal = Excavator_Pin_Locations_table2struct(MPdata);
ExcvLocal  = Excavator_Pin_Locations_global2local(ExcvGlobal);

Excavator_LoadChart_Create(qBoomSet,qStickSet,qBucketSet,...
    mdl_LoadChart_setup,mdl_LoadChart_calc,true);

%% Load Chart Test, Design B, Higher Pressure Settings
%
% In this test we increase the pressure settings to see the effect on the
% load chart.

forceTestMaxActiveCylPr   = 400; % bar, Max pressure boom cylinder
forceTestMaxReactiveCylPr = 450; % bar, Max pressure stick and bucket cylinders

Excavator_LoadChart_Create(qBoomSet,qStickSet,qBucketSet,...
    mdl_LoadChart_setup,mdl_LoadChart_calc,true);

