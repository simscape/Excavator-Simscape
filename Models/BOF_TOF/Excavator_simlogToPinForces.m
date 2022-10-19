function PinForces = Excavator_simlogToPinForces(logsoutData)
% Function to extract pin forces from simulation results.

% Copyright 2022 The MathWorks, Inc

pinForcesLog = logsoutData.get('Pin_Forces');
pinNames = sort(fieldnames(pinForcesLog.Values));

for i = 1:length(pinNames)
    PinForces.(pinNames{i}) = pinForcesLog.Values.(pinNames{i}).Data(end)/1000; % [kN]
end
