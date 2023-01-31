function [boomAngle, stickAngle, bucketAngle] = Excavator_getDesignPosition(ExcvGlobal)
% Function to calculate angles that describe current position of excavator.

% Copyright 2022-2023 The MathWorks, Inc

% Boom Angle
vecA = ExcvGlobal.Chassis.ToBoom-ExcvGlobal.Chassis.ToBoomCyl;
vecB = ExcvGlobal.Boom.ToBoomCyl-ExcvGlobal.Chassis.ToBoomCyl;
boomAngle = ang3pts(vecA,vecB)*180/pi;

% Stick Angle
vecA = ExcvGlobal.Boom.ToStick-ExcvGlobal.Stick.ToStickCyl;
vecB = ExcvGlobal.Boom.ToStickCyl-ExcvGlobal.Stick.ToStickCyl;
stickAngle = ang3pts(vecA,vecB)*180/pi;

% Bucket Angle
vecA = ExcvGlobal.Stick.ToBucket-ExcvGlobal.Bucket.ToBucketLinkage;
vecB = ExcvGlobal.Stick.ToBucketCyl-ExcvGlobal.Bucket.ToBucketLinkage;
bucketAngle = ang3pts(vecA,vecB)*180/pi;

    function angle = ang3pts(vecA,vecB)

        angle = acos(dot(vecA,vecB)/(norm(vecA)*norm(vecB)));
    end
end