function hC=getIBUFGComp(hN,hInSignals,hOutSignals)




    hC=pirelab.getInstantiationComp(...
    'Network',hN,...
    'Name','IBUFG',...
    'EntityName','IBUFG',...
    'InportNames',{'I'},...
    'OutportNames',{'O'},...
    'InportSignals',hInSignals,...
    'OutportSignals',hOutSignals,...
    'AddClockPort','off',...
    'AddClockEnablePort','off',...
    'AddResetPort','off',...
    'InlineConfigurations','off'...
    );