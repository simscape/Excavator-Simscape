% Code to plot simulation results from Excavator_Complete model
%% Plot Description:
%
% The plot below shows the extension of the actuator as the control system
% attempts to track a reference input.  The Piezo Stack can react much
% faster than the DC motor but has a limited range.  The control system
% uses them together to track the reference signal.

% Copyright 2016-2019 The MathWorks, Inc.

% Generate new simulation results if they don't exist or if they need to be updated
%if ~exist('simlog', 'var')) 
%    sim('Excavator_Complete')
%    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
%end

simlog_StickPos  = simOut.logsout_Excavator_Complete.get('PosSensors').Values.StickPos;
simlog_BoomPos   = simOut.logsout_Excavator_Complete.get('PosSensors').Values.BoomPos;
simlog_BucketPos = simOut.logsout_Excavator_Complete.get('PosSensors').Values.BucketPos;
simlog_SwingAng  = simOut.logsout_Excavator_Complete.get('PosSensors').Values.SwingAng;

% Reuse figure if it exists, else create new figure
if ~exist('h2_Excavator_Complete', 'var') || ...
        ~isgraphics(h2_Excavator_Complete, 'figure')
    h2_Excavator_Complete = figure('Name', 'Excavator_Actuator_Position');
end
figure(h2_Excavator_Complete)
clf(h2_Excavator_Complete)

yyaxis left
plot(simlog_StickPos.Time, simlog_StickPos.Data, 'LineWidth', 1,'DisplayName','Stick')
hold on
plot(simlog_BoomPos.Time, simlog_BoomPos.Data, 'LineWidth', 1,'DisplayName','Boom')
plot(simlog_BucketPos.Time, simlog_BucketPos.Data,'-.', 'LineWidth', 1,'DisplayName','Bucket')
ylabel('Extension (mm)')
hold off
yyaxis right
plot(simlog_SwingAng.Time, simlog_SwingAng.Data, 'LineWidth', 1,'DisplayName','Swing')
ylim_vals = get(gca,'YLim');
set(gca,'YLim',[-1 1]*max(1,max(abs(ylim_vals))))
grid on
title('Actuator Positions')
ylabel('Angle (deg)')
legend('Location','Best');
xlabel('Time (s)')


% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
clear simlog_xLeadscrew simlog_xMeas simlog_xRef simlog_xStack