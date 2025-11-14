% Code to plot simulation results from Excavator_Mevea* models
%% Plot Description:
%
% The plots below shows the load applied to the bucket by the soil. The
% x-axis is the distance of the bucket CG from the cab swing motor, the y-axis
% is the vertical distance of the bucket CG from the cab swing motor, all
% reported in the cab swing motor reference frame (swing motor angle is
% ignored).

% Copyright 2022-2025 The MathWorks, Inc.

simlog_bucketCGpos      = simOut.logsout_Excavator_Complete.get('Bucket_CG');
simlog_bucketForces     = simOut.logsout_Excavator_Complete.get('Bucket_Forces');
simlog_bucketTorques    = simOut.logsout_Excavator_Complete.get('Bucket_Forces');
simlog_qChassis         = simOut.simlog_Excavator_Complete.Excavator.Machine.BaseToChassis.BaseToChassis.Rz.q.series.values('rad');

simlog_t = simlog_bucketCGpos.Values.xLong.Time;
BktCGpLon      = simlog_bucketCGpos.Values.xLong.Data(:);
BktCGpVer      = simlog_bucketCGpos.Values.xVert.Data(:);
BktSoilfGlobal = squeeze(simlog_bucketForces.Values.Data);
BktSoiltGlobal = squeeze(simlog_bucketTorques.Values.Data);
%BktSoilVer     = simlog_bucketSoilLoad.Values.fVert.Data;

% Extract vertical and "longitudinal" (arm axis) forces
BktSoilVer     = BktSoilfGlobal(:,3);
% Assumes undercarriage points along global y-axis when digging
BktSoilLon     = BktSoilfGlobal(:,1).*sin(simlog_qChassis)+ BktSoilfGlobal(:,2).*cos(simlog_qChassis);

% Filter Forces
BktSoilLonFilt = movmean(BktSoilLon,500);
BktSoilVerFilt = movmean(BktSoilVer,500);

% Resample data at evenly spaced points along bucket travel
% Calculate distance of bucket CG travel
BktCGDist = [0; cumsum(sqrt(diff(BktCGpLon).^2+diff(BktCGpVer).^2))];

% Unique points required for interpolation
[BktCGDistUN,ia] = unique(BktCGDist);
BktSoilLonUN  = BktSoilLonFilt(ia);
BktSoilVerUN  = BktSoilVerFilt(ia);
BktCGpLonUN = BktCGpLon(ia);
BktCGpVerUN = BktCGpVer(ia);

% Identify points for sampling
npts = 200;
BktCGDistSamp = unique(linspace(0,max(BktCGDistUN),npts));

% Sample force and CG locations
BktSoilLonSA = interp1(BktCGDistUN,BktSoilLonUN,BktCGDistSamp);
BktSoilVerSA = interp1(BktCGDistUN,BktSoilVerUN,BktCGDistSamp);
BktCGpLonSA  = interp1(BktCGDistUN,BktCGpLonUN,BktCGDistSamp);
BktCGpVerSA  = interp1(BktCGDistUN,BktCGpVerUN,BktCGDistSamp);

% Reuse figure if it exists, else create new figure
if ~exist('h4_Excavator_Complete', 'var') || ...
        ~isgraphics(h4_Excavator_Complete, 'figure')
    h4_Excavator_Complete = figure('Name', 'Excavator_Actuator_Soil_Load');
end
figure(h4_Excavator_Complete)
clf(h4_Excavator_Complete)

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

% Reuse figure if it exists, else create new figure
if ~exist('h5_Excavator_Complete', 'var') || ...
        ~isgraphics(h5_Excavator_Complete, 'figure')
    h5_Excavator_Complete = figure('Name', 'Excavator_Actuator_Soil_Load');
end
figure(h5_Excavator_Complete)
clf(h5_Excavator_Complete)

ah(1) = subplot(211);
plot(simlog_t,BktSoilLon, 'LineWidth', 1,'DisplayName','Unfiltered')
hold on
plot(simlog_t,BktSoilLonFilt,'k--', 'LineWidth', 1,'DisplayName','Filtered')
hold off

grid on
title('Longitudinal Force of Soil On Bucket Pivot Point')
legend('Location','Best')

ah(2) = subplot(212);
plot(simlog_t,BktSoilVer, 'LineWidth', 1,'DisplayName','Unfiltered')
hold on
plot(simlog_t,BktSoilVerFilt,'k--', 'LineWidth', 1,'DisplayName','Filtered')
hold off
xlabel('Time (s)');
ylabel('Force (N)');
hold off

grid on
title('Vertical Force of Soil On Bucket Pivot Point')
legend('Location','Best')


