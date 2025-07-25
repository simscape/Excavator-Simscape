function Excavator_Test_Scenario_Select(scenario_name,varargin)
% Function to select test scenario for excavator model 

% Copyright 2022-2025 The MathWorks, Inc


Scenario_set = evalin('base','Scenario');

if(nargin>1)
    setup_mdl = varargin{1};
    calc_mdl  = varargin{2};
else
    setup_mdl = 'Excavator_Param_BOFTOF_Setup';
    calc_mdl  = 'Excavator_Param_BOFTOF_Calc';
end

fldnames = fieldnames(Scenario_set.(scenario_name));

for fld_i = 1:length(fldnames)
    %disp(fldnames{fld_i})
    assignin('base',fldnames{fld_i},Scenario_set.(scenario_name).(fldnames{fld_i}))
end

assignin('base','activeScenario',scenario_name)

switch scenario_name
    case {'BOF', 'TOF', 'Lift'}
        % Use setup model to obtain assembly conditions for test
        out = sim(setup_mdl);
        BOFTOFPos = Excavator_simlogToBOFTOFPos(out.BOFTOFSetupOut);

        % Assign values to workspace for calculation model
        assignin('base','initBoomPistonPos',       BOFTOFPos.initBoomPistonPos); % [mm]
        assignin('base','initStickPistonPos',      BOFTOFPos.initStickPistonPos); % [mm]
        assignin('base','initBucketPistonPos',     BOFTOFPos.initBucketPistonPos); % [mm]
        assignin('base','initChassisToBoomRevPos', BOFTOFPos.initChassisToBoomRevPos); % [deg]
        assignin('base','initBoomToStickRevPos',   BOFTOFPos.initBoomToStickRevPos); % [deg]
        assignin('base','initStickToBucketRevPos', BOFTOFPos.initStickToBucketRevPos); % [deg]
        assignin('base','bucketForceAngleBOF',     BOFTOFPos.bucketForceAngleBOF); % [deg]
        assignin('base','bucketForceAngleTOF',     BOFTOFPos.bucketForceAngleTOF); % [deg]
        assignin('base','bucketForceAngleGravity', BOFTOFPos.bucketForceAngleGravity); % [deg]

        ExcvGlobal_BOFTOFPos = Excavator_Pin_Locations_simlogToGlobal(out.excavator_frames);
        assignin('base','ExcvGlobal_BOFTOFPos', ExcvGlobal_BOFTOFPos);

        % Load and configure calculation model
        load_system(calc_mdl)
        set_param([calc_mdl '/Excavator'],'test_type', strrep(scenario_name,'_',' '))

end

