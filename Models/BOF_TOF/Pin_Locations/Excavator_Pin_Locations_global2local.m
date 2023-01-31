function ExcvLocal = Excavator_Pin_Locations_global2local(ExcvGlobal)
%Excavator_Pin_Locations_global2local Convert global position of excavator
%pin locations to locations relative to reference pin on each part
%   ExcvLocal = Excavator_Pin_Locations_global2local(ExcvGlobal)
%   This function takes a set of excavator pin locations expressed
%   relative to a single reference frame and re-expresses them 
%   relative to a pin location within the part to which they belong.
%   This enables the locations to be used to define the parts, either 
%   via extrusion profiles or link lengths.
%
%   The conversions must be synchronized with the part definition
%   in Simscape Multibody.  The Rigid Transform blocks must have the same
%   reference frame as defined below.
%
% Copyright 2022-2023 The MathWorks, Inc.

% Offset to local reference within part
boom_offset = ExcvGlobal.Chassis.ToBoom;
stick_offset = ExcvGlobal.Boom.ToStick;
bucket_offset = ExcvGlobal.Stick.ToBucket;

ExcvLocal.Chassis = ExcvGlobal.Chassis;

% Define boom pin locations relative to boom reference frame
ExcvLocal.Boom.ToBoomCyl  = ExcvGlobal.Boom.ToBoomCyl  -boom_offset;
ExcvLocal.Boom.ToStickCyl = ExcvGlobal.Boom.ToStickCyl -boom_offset;
ExcvLocal.Boom.ToStick	  = ExcvGlobal.Boom.ToStick    -boom_offset;

% Define stick pin locations relative to stick reference frame
ExcvLocal.Stick.ToStickCyl	    = ExcvGlobal.Stick.ToStickCyl -stick_offset;
ExcvLocal.Stick.ToBucketCyl	    = ExcvGlobal.Stick.ToBucketCyl -stick_offset;
ExcvLocal.Stick.ToBucketLinkage	= ExcvGlobal.Stick.ToBucketLinkage -stick_offset;
ExcvLocal.Stick.ToBucket	    = ExcvGlobal.Stick.ToBucket -stick_offset;

% Define bucket pin locations relative to bucket reference frame
ExcvLocal.Bucket.ToBucketLinkage = ExcvGlobal.Bucket.ToBucketLinkage-bucket_offset;
ExcvLocal.Bucket.ToCuttingEdge	 = ExcvGlobal.Bucket.ToCuttingEdge-bucket_offset;
ExcvLocal.Bucket.ToCG	         = ExcvGlobal.Bucket.ToCG-bucket_offset;

% Use lengths to define bucket linkage
ExcvLocal.Linkage.LengthToStick  = norm(ExcvGlobal.Linkage.ToBucketCyl-ExcvGlobal.Stick.ToBucketLinkage);
ExcvLocal.Linkage.LengthToBucket = norm(ExcvGlobal.Linkage.ToBucketCyl-ExcvGlobal.Bucket.ToBucketLinkage);
