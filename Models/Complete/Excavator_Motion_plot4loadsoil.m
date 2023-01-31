% Code to plot simulation results from Excavator_Motion model
%% Plot Description:
%
% The plot below shows the load applied to the bucket by the soil. The
% x-axis is the distance of the bucket CG from the cab swing motor, the y-axis
% is the vertical distance of the bucket CG from the cab swing motor, all
% reported in the cab swing motor reference frame (swing motor angle is
% ignored).

% Copyright 2022-2023 The MathWorks, Inc.

% Generate new simulation results if they don't exist or if they need to be updated
%if ~exist('simlog', 'var'))
%    sim('Excavator_Motion')
%    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
%end

simlog_bucketCGpos      = simOut.logsout_Excavator_Motion.get('Bucket_CG');
simlog_bucketSoilLoad   = simOut.logsout_Excavator_Motion.get('BucketSoilLoad');

BktCGpLon  = simlog_bucketCGpos.Values.xLong.Data(:);
BktCGpVer  = simlog_bucketCGpos.Values.xVert.Data(:);
BktSoilLon = simlog_bucketSoilLoad.Values.fLong.Data;
BktSoilVer = simlog_bucketSoilLoad.Values.fVert.Data;

if((sum(BktSoilLon) + sum(BktSoilVer))==0)
    disp('No soil forces')
else

    % Resample data at evenly spaced points along bucket travel
    % Calculate distance of bucket CG travel
    BktCGDist = [0; cumsum(sqrt(diff(BktCGpLon).^2+diff(BktCGpVer).^2))];

    % Unique points required for interpolation
    [BktCGDistUN,ia] = unique(BktCGDist);
    BktSoilLonUN  = BktSoilLon(ia);
    BktSoilVerUN  = BktSoilVer(ia);
    BktCGpLonUN = BktCGpLon(ia);
    BktCGpVerUN = BktCGpVer(ia);

    % Identify points for sampling
    npts = 100;
    BktCGDistSamp = unique(linspace(0,max(BktCGDistUN),npts));

    % Sample force and CG locations
    BktSoilLonSA = interp1(BktCGDistUN,BktSoilLonUN,BktCGDistSamp);
    BktSoilVerSA = interp1(BktCGDistUN,BktSoilVerUN,BktCGDistSamp);
    BktCGpLonSA  = interp1(BktCGDistUN,BktCGpLonUN,BktCGDistSamp);
    BktCGpVerSA  = interp1(BktCGDistUN,BktCGpVerUN,BktCGDistSamp);

    % Reuse figure if it exists, else create new figure
    if ~exist('h4_Excavator_Motion', 'var') || ...
            ~isgraphics(h4_Excavator_Motion, 'figure')
        h4_Excavator_Motion = figure('Name', 'Excavator_Actuator_Soil_Load');
    end
    figure(h4_Excavator_Motion)
    clf(h4_Excavator_Motion)

    plot(BktCGpLon, BktCGpVer, 'LineWidth', 1,'DisplayName','Bucket CG Position')
    hold on
    quiver(BktCGpLonSA,BktCGpVerSA,...
        BktSoilLonSA,BktSoilVerSA,6,'DisplayName', 'Soil Force')
    plot(BktCGpLon(1), BktCGpVer(1),'bo','MarkerFaceColor','b','DisplayName','Start')
    plot(BktCGpLon(end), BktCGpVer(end),'o','MarkerFaceColor','#FFC000','DisplayName','Finish')


    hold off
    axis equal
    xlabel('Horizontal Distance to Bucket CG (m)');
    ylabel('Vertical Distance to Bucket CG (m)');
    hold off

    grid on
    title('Force of Soil On Bucket CG')
    legend('Location','East');

    % Remove temporary variables
    clear simlog_t simlog_handles temp_colororder
end