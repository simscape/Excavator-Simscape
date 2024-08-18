function Excavator_global = Excavator_Pin_Locations_simlogToGlobal(simlogData)
% Function to extract pin locations relative to global frame from
% simulation results

% Copyright 2022-2024 The MathWorks, Inc

Boom.ToBoomCyl    = simlogData.Boom.B1.Data;
Boom.ToStickCyl   = simlogData.Boom.B2.Data;
Boom.ToStick      = simlogData.Boom.B3.Data;

Chassis.ToBoom    = simlogData.Chassis.A1.Data;
Chassis.ToBoomCyl = simlogData.Chassis.A2.Data;

Stick.ToStickCyl      = simlogData.Stick.C1.Data;
Stick.ToBucketCyl     = simlogData.Stick.C2.Data;
Stick.ToBucketLinkage = simlogData.Stick.C3.Data;
Stick.ToBucket        = simlogData.Stick.C4.Data;

Bucket.ToBucketLinkage = simlogData.Bucket.D1.Data;
Bucket.ToCuttingEdge   = simlogData.Bucket.D2.Data;
Bucket.ToCG            = simlogData.Bucket.D3.Data;

Linkage.ToBucketCyl	   = simlogData.Linkage.E1.Data;

Excavator_global.Chassis = Chassis;
Excavator_global.Boom = Boom;
Excavator_global.Stick = Stick;
Excavator_global.Bucket = Bucket;
Excavator_global.Linkage = Linkage;

