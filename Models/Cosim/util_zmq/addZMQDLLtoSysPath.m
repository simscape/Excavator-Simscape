function success = addZMQDLLtoSysPath(varargin)

% Defaults
showResult = 0;
success    = 0;

% Check for caller inputs
if(nargin>0)
    showResult = varargin{1};
end

%% Add the ZMQ DLL to the system path:
p = simulinkproject;
if strcmp(mexext,'mexw64')
    zmqdll_list = dir([p.RootFolder '/**/util_zmq/zmqdll/libzmq*.dll']);
    if(length(zmqdll_list)==1)
        %if exist(fullfile(p.RootFolder,'Models','Cosim','zmq','libzmq','bin','x64','bin','Release','libzmq-v143-mt-4_3_5.dll'),'file')
        pathEnvVar = getenv('PATH');
        pathcheck = strfind(pathEnvVar,zmqdll_list.folder);
        if(isempty(pathcheck))
            setenv('PATH',[pathEnvVar ';' zmqdll_list.folder]);
            success = 1;
            msg = sprintf('%s\n%s','libzmq DLL added to system PATH:',[zmqdll_list.folder filesep zmqdll_list.name]);
        else
            success = 1;
            msg = sprintf('%s\n%s','libzmq DLL already on system PATH:',[zmqdll_list.folder]);
        end
    elseif(length(zmqdll_list)>1)
        success = 0;
        msg = ['ZMQ library not added to path. There were ' length(zmqdll_list') ' libzmq DLLs found in subfolders.'];
    elseif(isempty(zmqdll_list))
        msg = 'ZMQ library not found.';
    end
else
    success = 0;
    msg = 'Non-Windows OS, please add the ZMQ library to your PATH environment variable manually';
end

if(showResult)
    disp(msg)
end

