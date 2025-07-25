function [ExcvGlobalStruct,ExcvGlobalTable] = Excavator_Pin_Locations_global(designName)
% Function to import excavator pin locations from Excel.
% Input argument is the name of the sheet where the pin locations are
% stored.

% Copyright 2022-2025 The MathWorks, Inc

ExcvGlobalTable  = readtable('Excavator_Pin_Locations_global.xlsx','Sheet',designName,'Range','B2:F15','VariableNamingRule','preserve');
ExcvGlobalStruct = Excavator_Pin_Locations_table2struct(ExcvGlobalTable);
