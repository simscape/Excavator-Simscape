function Excavator_BOFTOFLoad_plot(ExcvGlobal,fLoad,test_type,pBoom,pStick,pBucket,pinForces,varargin)
% Code to plot load chart

% Copyright 2022-2023 The MathWorks, Inc

% Assume no new figure needed
createFigure = false;

if(nargin>7)
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

axis(ax_h,'equal');

%% Label Pressures
clrPress = '#A9461F';
% Label pBoom
xyLabel = (ExcvGlobal.Boom.ToBoomCyl+ExcvGlobal.Chassis.ToBoomCyl)/2;
pr_h = text(xyLabel(1),xyLabel(2),sprintf('%3.1f bar',pBoom),'Color',clrPress,...
    'HorizontalAlignment','left','VerticalAlignment','bottom');

% Label pStick
xyLabel = (ExcvGlobal.Boom.ToStickCyl+ExcvGlobal.Stick.ToStickCyl)/2;
text(xyLabel(1),xyLabel(2),sprintf('%3.1f bar',pStick),'Color',clrPress,...
    'HorizontalAlignment','left','VerticalAlignment','bottom');

% Label pBucket
xyLabel = (ExcvGlobal.Stick.ToBucketCyl+ExcvGlobal.Linkage.ToBucketCyl)/2;
%xyLabel = (ExcvGlobal.Stick.ToBucketCyl+xyLabel)/2;
text(xyLabel(1),xyLabel(2),sprintf('%3.1f bar',pBucket),'Color',clrPress,...
    'HorizontalAlignment','left','VerticalAlignment','bottom');

% Label fLoad
switch test_type
    case('TOF')
        load_angle = atan2d( ...
            ExcvGlobal.Boom.ToStick(2)-ExcvGlobal.Bucket.ToCuttingEdge(2),...
            ExcvGlobal.Boom.ToStick(1)-ExcvGlobal.Bucket.ToCuttingEdge(1));
    case('BOF')
        load_angle = atan2d( ...
            ExcvGlobal.Stick.ToBucket(2)-ExcvGlobal.Bucket.ToCuttingEdge(2),...
            ExcvGlobal.Stick.ToBucket(1)-ExcvGlobal.Bucket.ToCuttingEdge(1));
    case('Load')
        load_angle = 180;
end
xyfLoad = [...
    ExcvGlobal.Bucket.ToCuttingEdge;
    ExcvGlobal.Bucket.ToCuttingEdge+[cosd(load_angle+90) sind(load_angle+90)]*fLoad/200];
dp = [cosd(load_angle+90) sind(load_angle+90)]*1;
plot(xyfLoad(:,1),xyfLoad(:,2),'r')
plot(xyfLoad(2,1),xyfLoad(2,2),'s','MarkerEdgeColor','r','MarkerFaceColor','r');
lo_h = text(xyfLoad(2,1),xyfLoad(2,2),sprintf('%3.1f kN',fLoad),...
    'HorizontalAlignment','right','VerticalAlignment','top',...
    'Color','r','FontSize',10);

% Label Pin Loads
clrPin = 'blue';
fszPin = 10;
xyLabel = ExcvGlobal.Chassis.ToBoomCyl;
pl_h = text(xyLabel(1),xyLabel(2),sprintf('%3.1f kN',pinForces.Boom_Cylinder_To_Chassis),...
    'HorizontalAlignment','left','VerticalAlignment','top','Color',clrPin,'FontSize',fszPin);

xyLabel = ExcvGlobal.Boom.ToBoomCyl;
text(xyLabel(1),xyLabel(2),sprintf('%3.1f kN',pinForces.Boom_Cylinder_To_Boom),...
    'HorizontalAlignment','left','VerticalAlignment','top','Color',clrPin,'FontSize',fszPin);

xyLabel = ExcvGlobal.Chassis.ToBoom;
text(xyLabel(1),xyLabel(2),sprintf('%3.1f kN',pinForces.Boom_To_Chassis),...
    'HorizontalAlignment','center','VerticalAlignment','bottom','Color',clrPin,'FontSize',fszPin);

xyLabel = ExcvGlobal.Boom.ToStickCyl;
text(xyLabel(1),xyLabel(2),sprintf('%3.1f kN',pinForces.Stick_Cylinder_To_Boom),...
    'HorizontalAlignment','right','VerticalAlignment','bottom','Color',clrPin,'FontSize',fszPin);

xyLabel = ExcvGlobal.Stick.ToStickCyl;
text(xyLabel(1),xyLabel(2),sprintf('%3.1f kN',pinForces.Stick_Cylinder_To_Stick),...
    'HorizontalAlignment','left','VerticalAlignment','bottom','Color',clrPin,'FontSize',fszPin);

xyLabel = ExcvGlobal.Boom.ToStick;
text(xyLabel(1),xyLabel(2),sprintf('%3.1f kN ',pinForces.Boom_To_Stick),...
    'HorizontalAlignment','right','VerticalAlignment','top','Color',clrPin,'FontSize',fszPin);

xyLabel = ExcvGlobal.Stick.ToBucketLinkage;
text(xyLabel(1),xyLabel(2),sprintf('%3.1f kN ',pinForces.Stick_To_Linkage),...
    'HorizontalAlignment','right','VerticalAlignment','middle','Color',clrPin,'FontSize',fszPin);

xyLabel = ExcvGlobal.Stick.ToBucket;
text(xyLabel(1),xyLabel(2),sprintf('%3.1f kN ',pinForces.Stick_To_Bucket),...
    'HorizontalAlignment','right','VerticalAlignment','middle','Color',clrPin,'FontSize',fszPin);

xyLabel = ExcvGlobal.Bucket.ToBucketLinkage;
text(xyLabel(1),xyLabel(2),sprintf(' %3.1f kN',pinForces.Bucket_To_Linkage),...
    'HorizontalAlignment','left','VerticalAlignment','middle','Color',clrPin,'FontSize',fszPin);

xyLabel = ExcvGlobal.Linkage.ToBucketCyl;
text(xyLabel(1),xyLabel(2),sprintf(' %3.1f kN',pinForces.Bucket_Cylinder_To_Linkage),...
    'HorizontalAlignment','left','VerticalAlignment','middle','Color',clrPin,'FontSize',fszPin);

xlabel(ax_h,'m')
ylabel(ax_h,'m')
title(ax_h,['Results of ' test_type ' Test'])


% Ensure there is some space around edges of plot
ylimits = get(ax_h,'yLim');
yLimPad = (ylimits(2)-ylimits(1))*0.05;
set(ax_h,'YLim',[ylimits(1)-yLimPad ylimits(2)+yLimPad])

% Legend
text(0.05,0.15,'Cylinder Pressure','Color',clrPress,'Units','Normalized','FontSize',fszPin);
text(0.05,0.1,'Bucket Force','Color','r','Units','Normalized','FontSize',fszPin);
text(0.05,0.05,'Pin Load','Color',clrPin,'Units','Normalized','FontSize',fszPin);
hold off
