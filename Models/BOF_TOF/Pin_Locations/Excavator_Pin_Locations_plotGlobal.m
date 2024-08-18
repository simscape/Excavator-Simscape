function Excavator_Pin_Locations_plotGlobal(ExcvGlobal,varargin)
% Excavator_Pin_Locations_plotGlobal  Plot excavator pin locations and
% outlines of the excavator parts.
%    Excavator_Pin_Locations_plotGlobal(ExcvGlobal,<axis handle>)
%

% Copyright 2022-2024 The MathWorks, Inc

partfill_clr = [1 1 0.2];
partedge_clr = [0.6 0.6 0.6];
pst_clr      = [1 1 1]*0.8;
cyl_clr      = [1 1 1]*0.4;
pst_wid      = 4;
cyl_wid      = 6;
lnk_clr      = [1 1 1]*0.6;
lnk_wid      = [1 1 1]*0.6;

ExcvLocal  = Excavator_Pin_Locations_global2local(ExcvGlobal);

warning('off','MATLAB:polyshape:repairedBySimplify')

if (nargin==1)
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
end
cla(ax_h)
box(ax_h,'on')

ptclrset = {...
    'Chassis','#C00000';...
    'Boom','#00B050';...
    'Stick','#00B0F0';...
    'Linkage','#FFC000';...
    'Bucket','#7030A0'};
    
%{
light  {...
        'Boom', 'C9FFE1';
        'Chassis', 'FFDDDD';
        'Stick', 'D1F3FF';
        'Linkage', 'FFEEB7';
        'Bucket','E6D5F3';];
%}          


axis(ax_h,'equal')
hold(ax_h,'on');

[xy_boomArm, xy_boomSticklink] = Extr_Data_Excv_Boom(ExcvLocal.Boom);
BoomLink_g = xy_boomSticklink+ExcvGlobal.Boom.ToBoomCyl;
BoomArm_g = xy_boomArm+ExcvGlobal.Chassis.ToBoom;
%fill(ax_h,BoomLink_g(:,1),BoomLink_g(:,2),partfill_clr,'EdgeColor',partedge_clr)
%fill(ax_h,BoomArm_g(:,1),BoomArm_g(:,2),partfill_clr,'EdgeColor',partedge_clr)
p1 = polyshape(BoomLink_g);
p2 = polyshape(BoomArm_g);
BoomPart = union(p1,p2);
plot(ax_h,BoomPart,'FaceColor',partfill_clr,'EdgeColor',partedge_clr)
%fill(BoomPart.Vertices(:,1),BoomPart.Vertices(:,2),partfill_clr,'EdgeColor',partedge_clr);

[xy_stickArm, xy_stickBucketlink] = Extr_Data_Excv_Stick(ExcvLocal.Stick);
StickLink_g = xy_stickBucketlink+ExcvGlobal.Boom.ToStick;
StickArm_g  = xy_stickArm+ExcvGlobal.Stick.ToBucket;
%fill(StickLink_g(:,1),StickLink_g(:,2),partfill_clr,'EdgeColor',partedge_clr)
%fill(StickArm_g(:,1),StickArm_g(:,2),partfill_clr,'EdgeColor',partedge_clr)
p1 = polyshape(StickLink_g);
p2 = polyshape(StickArm_g);
StickPart = union(p1,p2);
plot(ax_h,StickPart,'FaceColor',partfill_clr,'EdgeColor',partedge_clr)
%fill(StickPart(:,1),StickPart(:,2),partfill_clr,'EdgeColor',partedge_clr);


[xy_bucketBracket, xy_bucketScoop] = Extr_Data_Excv_Bucket(ExcvLocal.Bucket);
Bracket_g = xy_bucketBracket+ExcvGlobal.Bucket.ToBucketLinkage;
Scoop_g  = xy_bucketScoop+ExcvGlobal.Stick.ToBucket;
%fill(StickLink_g(:,1),StickLink_g(:,2),partfill_clr,'EdgeColor',partedge_clr)
%fill(StickArm_g(:,1),StickArm_g(:,2),partfill_clr,'EdgeColor',partedge_clr)
p1 = polyshape(Bracket_g);
p2 = polyshape(Scoop_g);
BucketPart = union(p1,p2);
plot(ax_h,BucketPart,'FaceColor',partfill_clr,'EdgeColor',partedge_clr)
%fill(StickPart(:,1),StickPart(:,2),partfill_clr,'EdgeColor',partedge_clr);

[xy_linkage_stickLink, xy_linkage_bucketLink] = Extr_Data_Excv_Linkage(ExcvLocal.Linkage);

stickLinkLine = ExcvGlobal.Linkage.ToBucketCyl-ExcvGlobal.Stick.ToBucketLinkage;
theta_SL = -atan2d(stickLinkLine(2),stickLinkLine(1));
R = [cosd(theta_SL) -sind(theta_SL); sind(theta_SL) cosd(theta_SL)];
xy_linkage_stickLink = xy_linkage_stickLink*R;

bucketLinkLine = ExcvGlobal.Linkage.ToBucketCyl-ExcvGlobal.Bucket.ToBucketLinkage;
theta_BL = -atan2d(bucketLinkLine(2),bucketLinkLine(1))+90;
R = [cosd(theta_BL) -sind(theta_BL); sind(theta_BL) cosd(theta_BL)];
xy_linkage_bucketLink = xy_linkage_bucketLink*R;

StickL_g = xy_linkage_stickLink+ExcvGlobal.Stick.ToBucketLinkage;
BucketL_g  = xy_linkage_bucketLink+ExcvGlobal.Bucket.ToBucketLinkage;
fill(ax_h,StickL_g(:,1),StickL_g(:,2),lnk_clr,'EdgeColor',[0.4 0.4 0.4])
fill(ax_h,BucketL_g(:,1),BucketL_g(:,2),lnk_clr,'EdgeColor',[0.4 0.4 0.4])
%plot(BucketPart,'FaceColor',partfill_clr,'EdgeColor',partedge_clr)
%fill(StickPart(:,1),StickPart(:,2),partfill_clr,'EdgeColor',partedge_clr);

BoomPstPts = [ExcvGlobal.Chassis.ToBoomCyl;ExcvGlobal.Boom.ToBoomCyl];
BoomCylPts = [BoomPstPts(1,:);BoomPstPts(1,:)+diff(BoomPstPts)*0.5];
plot(ax_h,BoomPstPts(:,1),BoomPstPts(:,2),'Color',pst_clr,'LineWidth',pst_wid)
plot(ax_h,BoomCylPts(:,1),BoomCylPts(:,2),'Color',cyl_clr,'LineWidth',cyl_wid)

StickPstPts = [ExcvGlobal.Boom.ToStickCyl;ExcvGlobal.Stick.ToStickCyl];
StickCylPts = [StickPstPts(1,:);StickPstPts(1,:)+diff(StickPstPts)*0.5];
plot(ax_h,StickPstPts(:,1),StickPstPts(:,2),'Color',pst_clr,'LineWidth',pst_wid)
plot(ax_h,StickCylPts(:,1),StickCylPts(:,2),'Color',cyl_clr,'LineWidth',cyl_wid)

BucketPstPts = [ExcvGlobal.Stick.ToBucketCyl;ExcvGlobal.Linkage.ToBucketCyl];
BucketCylPts = [BucketPstPts(1,:);BucketPstPts(1,:)+diff(BucketPstPts)*0.5];
plot(ax_h,BucketPstPts(:,1),BucketPstPts(:,2),'Color',pst_clr,'LineWidth',pst_wid)
plot(ax_h,BucketCylPts(:,1),BucketCylPts(:,2),'Color',cyl_clr,'LineWidth',cyl_wid)

fldn_EG = fieldnames(ExcvGlobal);
for i = 1:length(fldn_EG)
    fldn_Part = fieldnames(ExcvGlobal.(fldn_EG{i}));
    clr_ind = strcmp(ptclrset(:,1),fldn_EG{i});
    ptclr = ptclrset{clr_ind,2};
    for j=1:length(fldn_Part)
        point = ExcvGlobal.(fldn_EG{i}).(fldn_Part{j});
        plot(ax_h,point(1),point(2),'o',...
            'MarkerEdgeColor',ptclr,...
            'MarkerFaceColor',ptclr);
    end
end

hold(ax_h,'off');
warning('on','MATLAB:polyshape:repairedBySimplify')

xlabel(ax_h,'X')
ylabel(ax_h,'Y')
title(ax_h,'Excavator Pin Locations')