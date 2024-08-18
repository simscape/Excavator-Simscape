function ExcvGlobal = Excavator_Pin_Locations_table2struct(ExcvTable)
% Function to convert table of pin locations to MATLAB structure.
% MATLAB structure is used by model as a mask parameter to apply
% pin locations to Simscape model.

% Copyright 2022-2024 The MathWorks, Inc

Chassis.ToBoom      = ExcvTable{1,4:5};
Chassis.ToBoomCyl   = ExcvTable{2,4:5};

Boom.ToBoomCyl	    = ExcvTable{3,4:5};
Boom.ToStickCyl     = ExcvTable{4,4:5};
Boom.ToStick	    = ExcvTable{5,4:5};

Stick.ToStickCyl	= ExcvTable{6,4:5};
Stick.ToBucketCyl	= ExcvTable{7,4:5};
Stick.ToBucketLinkage	=ExcvTable{8,4:5};
Stick.ToBucket	    = ExcvTable{9,4:5};	

Linkage.ToBucketCyl	= ExcvTable{10,4:5};	

Bucket.ToBucketLinkage	= ExcvTable{11,4:5};	
Bucket.ToCuttingEdge	= ExcvTable{12,4:5};	
Bucket.ToCG	            = ExcvTable{13,4:5};	

ExcvGlobal.Chassis = Chassis;
ExcvGlobal.Boom = Boom;
ExcvGlobal.Stick = Stick;
ExcvGlobal.Bucket = Bucket;
ExcvGlobal.Linkage = Linkage;
