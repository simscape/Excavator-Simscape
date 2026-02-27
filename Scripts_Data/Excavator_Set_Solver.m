function Excavator_Set_Solver(mdlname,solvOpt)

slvCfg = [mdlname '/Excavator/Hydraulics/Solver Configuration'];

switch solvOpt
    case 'Variable'
        set_param(mdlname,'Solver','ode23t');
        set_param(slvCfg,'UseLocalSolver','off');
        set_param(slvCfg,'DoFixedCost','off');
    case 'Fixed'
        set_param(mdlname,'Solver','ode3');
        set_param(slvCfg,'UseLocalSolver','on');
        set_param(slvCfg,'DoFixedCost','off');
    case 'FixedCost'
        set_param(mdlname,'Solver','ode3');
        set_param(slvCfg,'UseLocalSolver','on');
        set_param(slvCfg,'DoFixedCost','on');
end
