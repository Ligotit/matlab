function satComp=getSaturateComp(hN,hInSignals,hOutSignals,lowerLimit,upperLimit,rndMeth,name)



    if(nargin<7)
        name='saturate';
    end

    if length(hOutSignals)<2

        satComp=hN.addComponent2(...
        'kind','cgireml',...
        'Name',name,...
        'InputSignals',hInSignals,...
        'OutputSignals',hOutSignals,...
        'EMLFileName','hdleml_saturate',...
        'EMLParams',{upperLimit,lowerLimit});

    else


        satComp=hN.addComponent2(...
        'kind','cgireml',...
        'Name',name,...
        'InputSignals',hInSignals,...
        'OutputSignals',hOutSignals,...
        'EMLFileName','hdleml_saturate_in_dti',...
        'EMLParams',{upperLimit,lowerLimit});
    end

end

