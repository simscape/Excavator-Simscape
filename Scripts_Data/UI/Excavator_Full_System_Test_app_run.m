% Script to run (instead of edit) Excavator Design app
% and ensure only one copy of the UI is opened.

% Copyright 2022-2025 The MathWorks, Inc.

if(exist('Excavator_Full_System_Test_app_uifigure','var'))
    if(~isempty(Excavator_Full_System_Test_app_uifigure))
        if(length(Excavator_Full_System_Test_app_uifigure.findprop('Excavator_Full_System_Test'))==1)
            % Figure is already open, bring it to the front
            figure(Excavator_Full_System_Test_app_uifigure.Excavator_Full_System_Test);
        else
            % Open UI again and store figure handle
            Excavator_Full_System_Test_app_uifigure = Excavator_Full_System_Test_app;
        end
    else
        % Open UI again and store figure handle
        Excavator_Full_System_Test_app_uifigure = Excavator_Full_System_Test_app;
    end
else
    % Open UI again and store figure handle
    Excavator_Full_System_Test_app_uifigure = Excavator_Full_System_Test_app;
end
