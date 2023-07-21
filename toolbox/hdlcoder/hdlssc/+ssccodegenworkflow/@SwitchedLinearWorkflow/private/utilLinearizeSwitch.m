function utilLinearizeSwitch(hswitchSystem,switchValues,hswitch,hSPS,switchNum,inputFlip)






    switchSystem=getfullname(hswitchSystem);

    portConnectivity=get_param(hswitch,'PortConnectivity');
    hLconn=portConnectivity(1).DstBlock;
    hRconn=portConnectivity(3).DstBlock;
    hIn1=get_param(get_param(get_param(portConnectivity(2).DstBlock,"portHandles").Inport,"Line"),"srcBlockHandle");

    if~inputFlip
        set_param(hLconn,'Orientation','right')
        set_param(hRconn,'Orientation','left')
        set_param(hLconn,'Name','+')
        set_param(hRconn,'Name','-')
        set_param(hLconn,'Position',[195,178,225,192])
        set_param(hRconn,'Position',[630,198,660,212])
        anodeName=strcat(get_param(hLconn,'name'),'/Rconn1');
        cathodeName=strcat(get_param(hRconn,'name'),'/Rconn1');
    else
        set_param(hRconn,'Orientation','right')
        set_param(hLconn,'Orientation','left')
        set_param(hLconn,'Name','-')
        set_param(hRconn,'Name','+')
        set_param(hRconn,'Position',[195,178,225,192])
        set_param(hLconn,'Position',[630,198,660,212])
        cathodeName=strcat(get_param(hLconn,'name'),'/Rconn1');
        anodeName=strcat(get_param(hRconn,'name'),'/Rconn1');
    end
    set_param(hIn1,'Position',[-110,-192,-80,-178])


    spsPorts=get_param(hSPS,'PortHandles');
    delete_line(get_param(spsPorts.Inport,'Line'));

    delete_block(hSPS);

    switchPorts=get_param(hswitch,'porthandles');
    delete_line(get_param(switchPorts.LConn,'Line'));
    delete_line(get_param(switchPorts.RConn(1),'Line'));
    delete_line(get_param(switchPorts.RConn(2),'Line'));
    delete_block(hswitch);






    hResistor=add_block('fl_lib/Electrical/Electrical Elements/Resistor',strcat(switchSystem,'/Rs'),...
    'MakeNameUnique','on',...
    'R',num2str(switchValues.Rs),...
    'Position',[325,211,365,239]);
    hCurrentSource=add_block('fl_lib/Electrical/Electrical Sources/Controlled Current Source',strcat(switchSystem,'/Controlled Current Source'),...
    'MakeNameUnique','on',...
    'Orientation','right',...
    'Position',[325,165,365,205]);
    hCurrentSensor=add_block('fl_lib/Electrical/Electrical Sensors/Current Sensor',strcat(switchSystem,'/Current Sensor'),...
    'MakeNameUnique','on',...
    'Orientation','right',...
    'Position',[420,175,460,215]);
    hVoltageSensor=add_block('fl_lib/Electrical/Electrical Sensors/Voltage Sensor',strcat(switchSystem,'/Voltage Sensor'),...
    'MakeNameUnique','on',...
    'Orientation','right',...
    'Position',[325,100,365,140]);


    hCurrentSensorPSS=add_block('nesl_utility/PS-Simulink Converter',strcat(switchSystem,'/HDLLinSwitchCurrent',num2str(switchNum)),...
    'MakeNameUnique','on',...
    'Orientation','up',...
    'Position',[462,140,478,155]);
    hVoltageSensorPSS=add_block('nesl_utility/PS-Simulink Converter',strcat(switchSystem,'/HDLLinSwitchVoltage',num2str(switchNum)),...
    'MakeNameUnique','on',...
    'Orientation','up',...
    'Position',[-113,110,-97,125]);
    hCurrentSourceSPS=add_block('nesl_utility/Simulink-PS Converter',strcat(switchSystem,'/HDLLinSwitchJ',num2str(switchNum)),...
    'MakeNameUnique','on',...
    'Orientation','down',...
    'Position',[557,115,573,130]);

    hCurrentDelay=add_block('simulink/Discrete/Unit Delay',strcat(switchSystem,'/Unit Delay'),...
    'MakeNameUnique','on',...
    'Orientation','up',...
    'Position',[453,85,487,120]);
    hVoltageDelay=add_block('simulink/Discrete/Unit Delay',strcat(switchSystem,'/Unit Delay1'),...
    'MakeNameUnique','on',...
    'Position',[-90,58,-55,92]);


    utilSwitchLogic(strcat(get_param(hVoltageDelay,'name'),'/1'),...
    strcat(get_param(hCurrentDelay,'name'),'/1'),...
    strcat(get_param(hIn1,'name'),'/1'),...
    strcat(get_param(hCurrentSourceSPS,'name'),'/1'),...
    switchSystem,switchValues,'double')


    outPorts={strcat(get_param(hCurrentSensorPSS,'name'),'/Lconn1'),...
    strcat(get_param(hVoltageSensorPSS,'name'),'/Lconn1'),...
    strcat(get_param(hCurrentSourceSPS,'name'),'/Rconn1'),...
    strcat(get_param(hCurrentSensorPSS,'name'),'/1'),...
    strcat(get_param(hVoltageSensorPSS,'name'),'/1')};


    inPorts={strcat(get_param(hCurrentSensor,'name'),'/Rconn1'),...
    strcat(get_param(hVoltageSensor,'name'),'/Rconn1'),...
    strcat(get_param(hCurrentSource,'name'),'/Rconn1'),...
    strcat(get_param(hCurrentDelay,'name'),'/1'),...
    strcat(get_param(hVoltageDelay,'name'),'/1')};

    add_line(switchSystem,outPorts,inPorts,'AutoRouting','smart')

    add_line(switchSystem,anodeName,strcat(get_param(hResistor,'name'),'/Lconn1'),...
    'AutoRouting','on');
    add_line(switchSystem,strcat(get_param(hResistor,'name'),'/Rconn1'),strcat(get_param(hCurrentSensor,'name'),'/Lconn1'),...
    'AutoRouting','on');

    add_line(switchSystem,anodeName,strcat(get_param(hCurrentSource,'name'),'/Lconn1'),...
    'AutoRouting','on');
    add_line(switchSystem,strcat(get_param(hCurrentSource,'name'),'/Rconn2'),strcat(get_param(hCurrentSensor,'name'),'/Lconn1'),...
    'AutoRouting','on');

    add_line(switchSystem,anodeName,strcat(get_param(hVoltageSensor,'name'),'/Lconn1'),...
    'AutoRouting','on');
    add_line(switchSystem,strcat(get_param(hVoltageSensor,'name'),'/Rconn2'),strcat(get_param(hCurrentSensor,'name'),'/Lconn1'),...
    'AutoRouting','on');

    add_line(switchSystem,strcat(get_param(hCurrentSensor,'name'),'/Rconn2'),cathodeName,...
    'AutoRouting','on');


end

