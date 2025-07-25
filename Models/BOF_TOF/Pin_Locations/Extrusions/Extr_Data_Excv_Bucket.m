function [xy_bucketBracket, xy_bucketScoop] = Extr_Data_Excv_Bucket(Bucket)
% Function to create extrusion for bucket from pin locations

% Copyright 2022-2025 The MathWorks, Inc

A = [0 0];
B = Bucket.ToBucketLinkage;
C = Bucket.ToCuttingEdge;

% Create boom arm extrusion
A2B = B-A;
Lab = norm(A2B);

L  = Lab;
H  = Lab*0.9;
ro = 0.2*Lab;
ri = 0.5*ro;
xL = 0.05*Lab;

[xy_bucketBracket] = Extr_Data_TriangleRounded_Holes(L, H, xL, ri, ro);

bucketAngle = -atan2d(B(2),B(1));
Rbracket = [cosd(bucketAngle+180) -sind(bucketAngle+180); sind(bucketAngle+180) cosd(bucketAngle+180)];
xy_bucketBracket = xy_bucketBracket*Rbracket;

Rscoop  = [cosd(bucketAngle) -sind(bucketAngle); sind(bucketAngle) cosd(bucketAngle)];
nRscoop = [cosd(-bucketAngle) -sind(-bucketAngle); sind(-bucketAngle) cosd(-bucketAngle)];

Arot = A*nRscoop;
Brot = B*nRscoop;
Crot = C*nRscoop;
mABrot = (Arot+Brot)/2;
scoopDiameter = abs(Crot(2)-Arot(2))-Lab/2;
scoopCenter   = [mABrot(1) Crot(2)-scoopDiameter/2*sign(Crot(2)-Arot(2))];
scoopAng      = [-90:5:90]';
scoopArc      = ...
    scoopDiameter/2*[cosd(scoopAng) sind(scoopAng)] + scoopCenter;

xy_bucketScoop = [Crot; scoopArc]*Rscoop;


%{

theta = -atand(C(2)/C(1));
R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
xy_bucketBracket = xy_bucketBracket*R;

% Create boom stick link extrusion
B2D = D-B;
Lbd = norm(B2D);

L = Lbd;
W = 2*ro;
r = ri;

[xy_boomSticklink] = Extr_Data_LinkHoles(L, W, r, 2);
xy_boomSticklink = xy_boomSticklink-[Lbd/2 0];

theta = -atand(B2D(2)/B2D(1));
R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
xy_boomSticklink = xy_boomSticklink*R;
%}
