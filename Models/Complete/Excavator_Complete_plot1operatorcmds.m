function Excavator_Complete_plot1operatorcmds(varargin) 
% Code to plot operator commands for Excavator_Complete.slx

% Copyright 2022-2024 The MathWorks, Inc.

if (nargin==0)

    figString = ['h1_' mfilename];
    % Only create a figure if no figure exists
    figExist = 0;
    fig_hExist = evalin('base',['exist(''' figString ''')']);
    if (fig_hExist)
        figExist = evalin('base',['ishandle(' figString ') && strcmp(get(' figString ', ''type''), ''figure'')']);
    end
    if ~figExist
        fig_h = figure('Name',figString);
        assignin('base',figString,fig_h);
    else
        fig_h = evalin('base',figString);
    end
    figure(fig_h)
    clf(fig_h)
    ax_h = gca;
else
    %assignin('base','UIAX',varargin{1})
    ax_h = varargin{1};
    box(ax_h,'on')
end

activeTestCmds = evalin('base','activeTestCmds');
activeScenario = evalin('base','activeScenario');
temp_colororder = get(ax_h,'defaultAxesColorOrder');

% Plot commands
cla(ax_h)
plot(ax_h,activeTestCmds.get('BoomCmd').Time, activeTestCmds.get('BoomCmd').Data,...
    ':', 'Color',temp_colororder(3,:),'LineWidth',2,'DisplayName','Boom')
hold(ax_h,'on')
plot(ax_h,activeTestCmds.get('StickCmd').Time, activeTestCmds.get('StickCmd').Data,...
    '-.','Color',temp_colororder(2,:),'LineWidth',2,'DisplayName','Stick')
plot(ax_h,activeTestCmds.get('BucketCmd').Time, activeTestCmds.get('BucketCmd').Data,...
    '-.','Color',temp_colororder(1,:),'LineWidth',1,'DisplayName','Bucket')
plot(ax_h,activeTestCmds.get('SwingCmd').Time, activeTestCmds.get('SwingCmd').Data,...
    '--','Color',temp_colororder(4,:),'LineWidth',1,'DisplayName','Swing')
hold(ax_h,'off')
xlabel(ax_h,'Time(s)')
ylabel(ax_h,'Command (-1 to 1)')
text(ax_h,0.025,0.115,sprintf('%s\n%s\n%s\n%s','Left','Up','In','Close'),'Units','Normalized','Color',[1 1 1]*0.3)
text(ax_h,0.025,0.9,sprintf('%s\n%s\n%s\n%s','Right','Down','Out','Open'),'Units','Normalized','Color',[1 1 1]*0.3)
legend(ax_h,'Location','Best');
title(ax_h,['Operator Commands, ' activeScenario])
set(ax_h,'YLim',[-1.1 1.1])

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder