function [fLoad,test_type,pBoom,pStick,pBucket,PinForces] = Excavator_RunBOFTOF(setup_mdl,calc_mdl,testType)
% Code to run BOF, TOF, or Load Capacity test

% Copyright 2022-2023 The MathWorks, Inc

if(endsWith(setup_mdl,'.slx'))
    setup_mdl = setup_mdl(1:end-4);
end
if(endsWith(calc_mdl,'.slx'))
    calc_mdl = calc_mdl(1:end-4);
end

Excavator_Test_Scenario_Select(testType,setup_mdl,calc_mdl);

%disp([calc_mdl '.slx']);
load_system(calc_mdl);
out = sim(calc_mdl);
[fLoad,test_type,pBoom,pStick,pBucket] = Excavator_simlogToBOFTOF(out.logsout);
PinForces = Excavator_simlogToPinForces(out.logsout);