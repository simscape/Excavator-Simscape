% This script initializes dimensions for the pick-up and dump boxes that
% contain the DEM elements used for the cosimulation example model -
% Excavator_Motion_DEMCosim.slx

% Box outer wall dimensions
boxOuterSurfaceLength = 6; % [m]
boxOuterSurfaceWidth = 9; % [m]
boxThickness = 0.1; % [m]
boxHeight = 3; % [m]

% box inner wall length, width
boxInnerSurfaceLength = boxOuterSurfaceLength-2*boxThickness;
boxInnerSurfaceWidth = boxOuterSurfaceWidth-2*boxThickness;

% create cross-section for the box that is used within the extrude block
% Each row represents a coordinate frame.
% The order of the coordinate frames is such that we start with the outer
% surface and close the loop and then for the inner surface, follow the
% order (start with the closest point with the nearest outer surface point)
% and go in CW direction (that way the left side always represents the
% solid)
boxCrossSectionCoords = [-boxOuterSurfaceLength/2 boxOuterSurfaceWidth/2;
    -boxOuterSurfaceLength/2 -boxOuterSurfaceWidth/2;
    boxOuterSurfaceLength/2 -boxOuterSurfaceWidth/2;
    boxOuterSurfaceLength/2 boxOuterSurfaceWidth/2;
    -boxOuterSurfaceLength/2 boxOuterSurfaceWidth/2;
    -boxOuterSurfaceLength/2 -boxOuterSurfaceWidth/2+boxThickness;
    -boxOuterSurfaceLength/2+boxThickness -boxOuterSurfaceWidth/2+boxThickness;
    -boxOuterSurfaceLength/2+boxThickness boxOuterSurfaceWidth/2-boxThickness;
    boxOuterSurfaceLength/2-boxThickness boxOuterSurfaceWidth/2-boxThickness;
    boxOuterSurfaceLength/2-boxThickness -boxOuterSurfaceWidth/2+boxThickness;
    -boxOuterSurfaceLength/2 -boxOuterSurfaceWidth/2+boxThickness];





