function dzComp=getDeadZoneDynamicComp(hN,hInSignals,hOutSignals,compName)



    if(nargin<4)
        compName='deadzoneDynamic';
    end

    dzComp=hN.addComponent2(...
    'kind','cgireml',...
    'Name',compName,...
    'InputSignals',hInSignals,...
    'OutputSignals',hOutSignals,...
    'EMLFileName','hdleml_deadzone_dynamic',...
    'EMLParams',{},...
    'EMLFlag_RunLoopUnrolling',true);

end

