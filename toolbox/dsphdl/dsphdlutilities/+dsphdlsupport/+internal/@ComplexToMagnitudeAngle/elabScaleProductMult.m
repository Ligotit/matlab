function scaleProductMult=elabScaleProductMult(~,topNet,blockInfo,dataRate,...
    din,coef,...
    dinDly,tapout,...
    syncReset,...
    DATA_WORDLENGTH,DATA_FRACTIONLENGTH,...
    COEF_WORDLENGTH,COEF_FRACTIONLENGTH,...
    OUTPUT_WORDLENGTH,OUTPUT_FRACTIONLENGTH)








    InportNames={'xCD',coef.Name,syncReset.Name};
    InportTypes=[din.Type,coef.Type,syncReset.Type];
    InportRates=[dataRate;dataRate;dataRate];

    OutportNames={dinDly.Name,tapout.Name};
    OutportTypes=[dinDly.Type,tapout.Type];

    scaleProductMult=pirelab.createNewNetwork(...
    'Network',topNet,...
    'Name','ScaleProductMult',...
    'InportNames',InportNames,...
    'InportTypes',InportTypes,...
    'InportRates',InportRates,...
    'OutportNames',OutportNames,...
    'OutportTypes',OutportTypes...
    );

    inputPort=scaleProductMult.PirInputSignals;
    outputPort=scaleProductMult.PirOutputSignals;
    din=inputPort(1);
    coef=inputPort(2);
    syncReset='';

    dinDly=outputPort(1);
    tapout=outputPort(2);

    fid=fopen(fullfile(matlabroot,'toolbox','dsphdl','dsphdlutilities','+dsphdlsupport','+internal',...
    '@ComplexToMagnitudeAngle','cgireml','ScaleProductMultCalc.m'),'r');
    fcnBody=fread(fid,Inf,'char=>char')';
    fclose(fid);

    desc='ScaleProductMultCalc';

    blockInfo.synthesisTool='Xilinx Vivado';

    tap=scaleProductMult.addComponent2(...
    'kind','cgireml',...
    'Name','ScaleProdMultCalc',...
    'InputSignals',[din,coef],...
    'OutputSignals',[dinDly,tapout],...
    'EMLFileName','ScaleProductMultCalc',...
    'EMLFileBody',fcnBody,...
    'EMLParams',{DATA_WORDLENGTH,DATA_FRACTIONLENGTH...
    ,COEF_WORDLENGTH,COEF_FRACTIONLENGTH,...
    OUTPUT_WORDLENGTH,OUTPUT_FRACTIONLENGTH,blockInfo.synthesisTool},...
    'ExternalSynchronousResetSignal',syncReset,...
    'EMLFlag_TreatInputIntsAsFixpt',true,...
    'EMLFlag_SaturateOnIntOverflow',false,...
    'EMLFlag_TreatInputBoolsAsUfix1',false,...
    'BlockComment',desc);


    tap.runConcurrencyMaximizer(0);

    tap.resetNone(true);

end
