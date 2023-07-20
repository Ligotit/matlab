function[varargout]=autoblksclutchwet(varargin)



    block=varargin{1};
    maskMode=varargin{2};

    couplingType=get_param(block,'couplingType');



    port_config=get_param(block,'port_config');
    switch couplingType
    case 'Include input and output shaft inertias'
        switch port_config
        case 'Simulink'
            blkID=1;
        case 'Simscape'
            blkID=3;
        end
    case 'No shaft dynamics'
        switch port_config
        case 'Simulink'
            blkID=2;
        case 'Simscape'
            blkID=4;
        end
    end


    if maskMode==0
        BlockOptions=...
        {'autolibdrivetraincommon/Wet Clutch','Wet Clutch';...
        'autolibdrivetraincommon/Wet Clutch Coupling','Wet Clutch Coupling';...
        'autolibdrivetraincommon/Wet Clutch SSC','Wet Clutch SSC';...
        'autolibdrivetraincommon/Wet Clutch Coupling SSC','Wet Clutch Coupling SSC'};


        switch blkID
        case 1
            autoblksreplaceblock(block,BlockOptions,blkID);


        case 2
            autoblksreplaceblock(block,BlockOptions,blkID);



        case 3
            autoblksreplaceblock(block,BlockOptions,blkID);



        case 4
            autoblksreplaceblock(block,BlockOptions,blkID);




        end

        ParamList={'Ndisks',[1,1],{'gt',0;'int',0};...
        'Jin',[1,1],{'gt',0};...
        'Jout',[1,1],{'gt',0};...
        'ri',[1,1],{'gt',0};...
        'ro',[1,1],{'gt',0};...
        'omegain_o',[1,1],{'lte',5e3};...
        'omegaout_o',[1,1],{'lte',5e3};...
        'maxAbsSpd',[1,1],{'gt',0};...
        'beta',[1,1],{'gt',0};...
        'rho_a',[1,1],{'gt',0};...
        'sigmaf',[1,1],{'gt',0};...
        'sigmas',[1,1],{'gt',0};...
        'Kperm',[1,1],{'gt',0};...
        'ho',[1,1],{'gt',0};...
        'E',[1,1],{'gt',0};...
        'd',[1,1],{'gt',0};...
        'Ared',[1,1],{'gt',0};...
        'tauC',[1,1],{'gt',0};...
        'ms',[1,1],{'gt',0};...
        'Cps',[1,1],{'gt',0};...
        'Cpoil',[1,1],{'gt',0};...
        'Cpoil',[1,1],{'gt',0};...
        'Vc',[1,1],{'gt',0};...
        'To',[1,1],{'gt',0};...
        'hf',[1,1],{'gt',0};...
        'Tenv',[1,1],{'gt',0};...
        'Aenv',[1,1],{'gt',0};...
        'henv',[1,1],{'gt',0};...
        };
        TableList={{'vrel',[],{}},'muf',{'gte',0};...
        {'Tmu',[],{}},'muc',{'gte',0};...
        {'H',[],{'gte',0}},'phi',{'gte',0};...
        {'H',[],{'gte',0}},'phif',{'gte',0};...
        {'H',[],{'gte',0}},'phifs',{'gte',0};...
        {'Trho_oil',[],{'gte',0}},'rho_oil',{'gt',0};...
        };
        autoblkscheckparams(block,'Wet Clutch',ParamList,TableList);



    end

    if maskMode==2
        if blkID==1||blkID==3
            autoblksenableparameters(block,[],[],'clutchRot');









        else
            autoblksenableparameters(block,[],[],[],'clutchRot');
        end
    end
    varargout{1}=[];

end