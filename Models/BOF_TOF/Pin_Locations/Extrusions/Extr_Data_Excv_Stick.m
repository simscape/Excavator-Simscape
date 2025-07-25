function [xy_stickArm, xy_stickBucketlink] = Extr_Data_Excv_Stick(Stick)
% Function to create extrusion for stick from pin locations

% Copyright 2022-2025 The MathWorks, Inc

A = Stick.ToBucket;
B = [0 0];
C = Stick.ToStickCyl;
D = Stick.ToBucketCyl;

% Create stick arm extrusion
A2B = B-A;
A2C = C-A;
Lab = norm(A2B);
Lac = norm(A2C);

AngBAC = acosd(dot(A2B,A2C)/(norm(A2B)*norm(A2C)));

L  = Lac;
H  = Lab*sind(AngBAC);
ro = 0.05*Lac;
ri = 0.5*ro;
xL = Lab*cosd(AngBAC)/Lac;
Extr_Data_TriangleRounded_Holes(L, H, xL, ri, ro);
[xy_stickArm] = Extr_Data_TriangleRounded_Holes(L, H, xL, ri, ro);

theta = -atan2d(A2C(2),A2C(1));
R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
xy_stickArm = xy_stickArm*R;

% Create stick bucket link extrusion
B2D = D-B;
Lbd = norm(B2D);

L = Lbd;
W = 2*ro;
r = ri;

[xy_stickBucketlink] = Extr_Data_LinkHoles(L, W, r, 2);
xy_stickBucketlink = xy_stickBucketlink+[Lbd/2 0];

theta = -atand(B2D(2)/B2D(1));
R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
xy_stickBucketlink = xy_stickBucketlink*R;
