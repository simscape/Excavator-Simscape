% Code to plot simulation results from Excavator_Motion
%% Plot Description:
%
% The plot below shows the force required of the actuators to complete the test.

% Copyright 2016-2024 The MathWorks, Inc.

% Generate new simulation results if they don't exist or if they need to be updated
%if ~exist('simlog', 'var')) 
%    sim('Excavator_Motion')
%    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
%end


% Get simulation results
simlog_DEMLoads_f = simOut.logsout_Excavator_Motion_B3D.get('DEMLoads_f');
simlog_DEMLoads_m = simOut.logsout_Excavator_Motion_B3D.get('DEMLoads_m');

% Reuse figure if it exists, else create new figure
if ~exist('h1_Excavator_B3D_DEM', 'var') || ...
        ~isgraphics(h1_Excavator_B3D_DEM, 'figure')
    h1_Excavator_B3D_DEM = figure('Name', 'Excavator_B3D_DEM');
end
figure(h1_Excavator_B3D_DEM)
clf(h1_Excavator_B3D_DEM)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_DEMLoads_f.Values.Time, squeeze(simlog_DEMLoads_f.Values.Data(:,1)),...
    'LineWidth', 1,'DisplayName','Lateral');
hold on
plot(simlog_DEMLoads_f.Values.Time, squeeze(simlog_DEMLoads_f.Values.Data(:,2)),...
    'LineWidth', 1,'DisplayName','Longitudinal');
plot(simlog_DEMLoads_f.Values.Time, squeeze(simlog_DEMLoads_f.Values.Data(:,3)),...
    'LineWidth', 1,'DisplayName','Vertical');
hold off
grid on
title('DEM Loads on Bucket CG')
ylabel('Force (N)')
legend('Location','Best')

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_DEMLoads_m.Values.Time, squeeze(simlog_DEMLoads_m.Values.Data(:,1)),...
    'LineWidth', 1,'DisplayName','Global X');
hold on
plot(simlog_DEMLoads_m.Values.Time, squeeze(simlog_DEMLoads_m.Values.Data(:,2)),...
    'LineWidth', 1,'DisplayName','Global Y');
plot(simlog_DEMLoads_m.Values.Time, squeeze(simlog_DEMLoads_m.Values.Data(:,3)),...
    'LineWidth', 1,'DisplayName','Global Z');
hold off
grid on
ylabel('Moment (N*m)')
xlabel('Time (s)')
linkaxes(simlog_handles,'x')
legend('Location','Best')

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
