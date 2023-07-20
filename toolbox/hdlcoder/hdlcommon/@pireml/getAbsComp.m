function absComp=getAbsComp(hN,hInSignals,hOutSignals,oType_ex,compName)



    if(nargin<5)
        compName='abs';
    end

    if(nargin<4)
        oType_ex=pirelab.getTypeInfoAsFi(hOutSignals.Type);
    end


    absComp=hN.addComponent2(...
    'kind','cgireml',...
    'Name',compName,...
    'InputSignals',hInSignals,...
    'OutputSignals',hOutSignals,...
    'EMLFileName','hdleml_abs',...
    'EMLParams',{oType_ex},...
    'EMLFlag_ParamsFollowInputs',true,...
    'EMLFlag_TreatInputBoolsAsUfix1','true');
end