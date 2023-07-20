function hcComp=getHitCrossComp(hN,hInSignals,hOutSignals,hcOffset,hcDirectionMode,name)



    if(nargin<6)
        name='hitcross';
    end
    hcComp=hN.addComponent2(...
    'kind','cgireml',...
    'Name',name,...
    'InputSignals',hInSignals,...
    'OutputSignals',hOutSignals,...
    'EMLFileName','hdleml_hitcross',...
    'EMLParams',{hcOffset,hcDirectionMode});
end

