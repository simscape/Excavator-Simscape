% Startup script for Excavator.prj

% Copyright 2022 The MathWorks, Inc

Excavator_Init_Params
Scenario = Excavator_Test_Scenario_Define;
Excavator_Test_Scenario_Select('loadedBucketDigCycle')

Excavator_System_params
ExcvGlobal = Excavator_Pin_Locations_global('Design A');
ExcvLocal  = Excavator_Pin_Locations_global2local(ExcvGlobal);

Excavator_Design_app_run

web('Excavator_Design_Overview.html')