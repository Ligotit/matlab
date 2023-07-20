function delayComp=getIntDelayComp(hN,hInSignals,hOutSignals,delayNumber,compName,ic,resettype,rambased,desc,slHandle)



    [isReset,initValScalarExpandable,ic,preserveInitValDimensions]=...
    pircore.processDelayIC(ic);

    delayComp=hN.addComponent2(...
    'kind','IntegerDelay',...
    'SimulinkHandle',slHandle,...
    'name',compName,...
    'InputSignals',hInSignals,...
    'OutputSignals',hOutSignals,...
    'InitialValue',ic,...
    'ResetNone',resettype,...
    'RAMBased',rambased,...
    'NumDelays',delayNumber,...
    'ResetInitVal',isReset,...
    'InitValScalarExpandable',initValScalarExpandable,...
    'PreserveInitValDimensions',preserveInitValDimensions,...
    'BlockComment',desc);

end