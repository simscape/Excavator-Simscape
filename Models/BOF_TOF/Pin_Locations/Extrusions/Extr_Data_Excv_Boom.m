function [xy_boomArm, xy_boomSticklink] = Extr_Data_Excv_Boom(Boom)
% Function to create extrusion for boom from pin locations

% Copyright 2022-2025 The MathWorks, Inc

A = [0 0];
B = Boom.ToBoomCyl;
C = Boom.ToStick;
D = Boom.ToStickCyl;

% Create boom arm extrusion
A2B = B-A;
A2C = C-A;
Lab = norm(A2B);
Lac = norm(A2C);

AngBAC = acosd(dot(A2B,A2C)/(norm(A2B)*norm(A2C)));

L  = Lac;
H  = Lab*sind(AngBAC);
ro = 0.05*Lab;
ri = 0.5*ro;
xL = Lab*cosd(AngBAC)/Lac;

[xy_boomArm] = Extr_Data_TriangleRounded_Holes(L, H, xL, ri, ro);
xy_boomArm = [xy_boomArm;Lab*cosd(AngBAC) H*0.7];

theta = -atand(C(2)/C(1));
R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
xy_boomArm = xy_boomArm*R;

% Create boom stick link extrusion
B2D = D-B;
Lbd = norm(B2D);

L = Lbd;
W = 2*ro;
r = ri;

[xy_boomSticklink] = Extr_Data_LinkHoles(L, W, r, 2);
xy_boomSticklink = xy_boomSticklink+[Lbd/2 0];

theta = -atan2d(B2D(2),B2D(1));
R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
xy_boomSticklink = xy_boomSticklink*R;
