% Script to sweep pin locations
% Copyright 2022-2023 The MathWorks, Inc

[~, PinLocTable] = Excavator_Pin_Locations_global('Design A');
PinLocTableFINISH = PinLocTable;

% Index of pin location to shift
ptInds = [2 3 4 5 6 7 8 9 11];

% Size of shift range per pin in meters
ptDev  = [1 1 1 1 1 1 1 1 0.5]*0.1;

% Number of random tests
numTests = 20;

% Loop over sets of pin locations
for n = 1:numTests

    % Perturb pin locations
    for i = 1:length(ptInds)
        PinLocTable.("X(m)")(ptInds(i)) = PinLocTable.("X(m)")(ptInds(i))-ptDev(i)+(2*ptDev(i))*rand(1);
        PinLocTable.("Y(m)")(ptInds(i)) = PinLocTable.("Y(m)")(ptInds(i))-ptDev(i)+(2*ptDev(i))*rand(1);
    end

    % Convert table of pin locations to structure
    ExcvGlobalUI = Excavator_Pin_Locations_table2struct(PinLocTable);
  
    % Convert global locations to local
    ExcvLocal  = Excavator_Pin_Locations_global2local(ExcvGlobalUI);

    % Get angles for position with perturbed point locations
    [BOFTOF_boomAngle, BOFTOF_stickAngle, BOFTOF_bucketAngle] = Excavator_getDesignPosition(ExcvGlobalUI); %#ok<*ASGLU>
    set_param('Excavator_Param_BOFTOF_Setup', 'SimulationCommand', 'update');
    disp(['BOF Test ' num2str(n)])

    % Run test
    [fLoad,test_type,pBoom,pStick,pBucket,pinForces]= Excavator_RunBOFTOF('Excavator_Param_BOFTOF_Setup.slx','Excavator_Param_BOFTOF_Calc.slx','Lift');
    pause(3);

    % Product plot
    Excavator_BOFTOFLoad_plot(ExcvGlobalUI,fLoad,test_type,pBoom,pStick,pBucket,pinForces);
    set(gca,'XLIM',[-1.255 9.99])
    pause(1);

    % Save plot as image file
    saveas(gcf,['PinLoads_' num2str(n) '.png'])
end

% Use design position as last test
ExcvGlobalUI = Excavator_Pin_Locations_table2struct(PinLocTableFINISH);
ExcvLocal  = Excavator_Pin_Locations_global2local(ExcvGlobalUI);
[BOFTOF_boomAngle, BOFTOF_stickAngle, BOFTOF_bucketAngle] = Excavator_getDesignPosition(ExcvGlobalUI);
set_param('Excavator_Param_BOFTOF_Setup', 'SimulationCommand', 'update');
disp('BOF Test FINISH');
[fLoad,test_type,pBoom,pStick,pBucket,pinForces]= Excavator_RunBOFTOF('Excavator_Param_BOFTOF_Setup.slx','Excavator_Param_BOFTOF_Calc.slx','Lift');
Excavator_BOFTOFLoad_plot(ExcvGlobalUI,fLoad,test_type,pBoom,pStick,pBucket,pinForces);
set(gca,'XLIM',[-1.255 9.99])
saveas(gcf,['PinLoads_' num2str(n) '.png'])

