function [fLoad,test_type,pBoom,pStick,pBucket,pinForces]= Excavator_simlogToBOFTOF(logsoutData)
% Function to extract load and pressures from simulation results.

% Copyright 2022-2023 The MathWorks, Inc

fLoad   = logsoutData.get('Load_kN').Values.Data;
pBoom   = logsoutData.get('CylPr_bar').Values.Data(1);
pStick  = logsoutData.get('CylPr_bar').Values.Data(2);
pBucket = logsoutData.get('CylPr_bar').Values.Data(3);

testTypeValue = logsoutData.get('Test_Type').Values.Data;

pinForces = Excavator_simlogToPinForces(logsoutData);

switch(testTypeValue)
    case 1; test_type = 'BOF';
    case 2; test_type = 'TOF';
    case 3; test_type = 'Load';
end
end