function Excavator_LoadChart_Plot(ExcvGlobal,bucketEdgeXY_set,load_set,varargin)
% Code to plot load chart

% Copyright 2022-2023 The MathWorks, Inc

% Assume no new figure needed
createFigure = false;

if(nargin>3)
    % If optional argument is an axis handle, use it
    if(strcmp(get(varargin{1}, 'type'), 'axes') && isa(varargin{1}, 'matlab.ui.control.UIAxes'))
        ax_h = varargin{1};
    else
        createFigure = true;
    end
else
    % If no optional argument passed, use standard figure
    createFigure = true;
end

if(createFigure)
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
end

% Clear axis - 'reset' needed for UIAxes
cla(ax_h,'reset')

% Add excavator stick figure to plot
Excavator_Pin_Locations_plotGlobal(ExcvGlobal,ax_h)
hold(ax_h,'on');

% Plot loads with color representing magnitude
surface(ax_h,...
    [bucketEdgeXY_set(:,1)';bucketEdgeXY_set(:,1)'], ...
    [bucketEdgeXY_set(:,2)';bucketEdgeXY_set(:,2)'], ...
    zeros(2,size(bucketEdgeXY_set,1)),...
    [load_set;load_set],...
    'facecol','no',...
    'edgecol','interp',...
    'linew',2)

axis(ax_h,'equal');

% Add labels to points
for i=1:length(load_set)
    text(ax_h,bucketEdgeXY_set(i,1),bucketEdgeXY_set(i,2),sprintf('%3.2f ',load_set(i)),'HorizontalAlignment','right')
end

% Add dots to points
plot(ax_h,bucketEdgeXY_set(:,1),bucketEdgeXY_set(:,2),'o',...
    'MarkerFaceColor',[1 1 1]*0.6,'MarkerEdgeColor',[1 1 1]*0.6,...
    'MarkerSize',4);
hold(ax_h,'off');
xlabel(ax_h,'m')
ylabel(ax_h,'m')
title(ax_h,'Load Chart')
c=colorbar(ax_h);
c.Label.String = 'Load (kN)';

% Ensure there is some space around edges of plot
ylimits = get(ax_h,'yLim');
yLimPad = (ylimits(2)-ylimits(1))*0.05;
set(ax_h,'YLim',[ylimits(1)-yLimPad ylimits(2)+yLimPad])
