function BOFTOFPos = Excavator_simlogToBOFTOFPos(simlogData)
% Function to extract initial configuration from simulation results of
% setup model.

% Copyright 2022-2025 The MathWorks, Inc

BOFTOFPos.initBoomPistonPos       = simlogData.LeftBoomPistonPos.Data(end); % [mm]
BOFTOFPos.initStickPistonPos      = simlogData.StickPistonPos.Data(end); % [mm]
BOFTOFPos.initBucketPistonPos     = simlogData.BucketPistonPos.Data(end); % [mm]
BOFTOFPos.initChassisToBoomRevPos = simlogData.ChassisToBoomRevPos.Data(end); % [deg]
BOFTOFPos.initBoomToStickRevPos   = simlogData.BoomToStickRevPos.Data(end); % [deg]
BOFTOFPos.initStickToBucketRevPos = simlogData.StickToBucketRevPos.Data(end); % [deg]
BOFTOFPos.bucketForceAngleBOF     = simlogData.BucketForceAngleBOF.Data(end); % [deg]
BOFTOFPos.bucketForceAngleTOF     = simlogData.BucketForceAngleTOF.Data(end); % [deg]
BOFTOFPos.bucketForceAngleGravity = simlogData.BucketForceAngleGravity.Data(end); % [deg]

end