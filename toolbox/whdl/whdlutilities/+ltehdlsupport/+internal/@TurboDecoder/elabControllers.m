function tbcNet=elabControllers(~,topNet,blockInfo,dataRate)




    boolType=pir_boolean_t();
    addrType=blockInfo.dataRAMaddrType;
    alphaRAMaddrType=blockInfo.alphaRAMaddrType;



    inportNames={'startIn','endIn','validIn','bLen','bLen_ext'};
    inTypes=[boolType,boolType,boolType,addrType,addrType];
    indataRates=[dataRate,dataRate,dataRate,dataRate,dataRate];
    outportNames={'r_addr','intlver_start','BB_Dr','BB_Sc','BB_En','Buffer_id',...
    'betaA_En','betaB_En','alpha_En','extrinsic_En',...
    'decoder_id','aprior_Src','alpha_raddr','alpha_waddr','addr_Src','output_start',...
    'dataSource','w_en','w_addr','ramout_Sel'};
    outTypes=[addrType,boolType,boolType,boolType,boolType,boolType,boolType,...
    boolType,boolType,boolType,boolType,boolType,alphaRAMaddrType,...
    alphaRAMaddrType,boolType,boolType,boolType,boolType,addrType,boolType];

    tbcNet=pirelab.createNewNetwork(...
    'Network',topNet,...
    'Name','Controllers',...
    'InportNames',inportNames,...
    'InportTypes',inTypes,...
    'InportRates',indataRates,...
    'OutportNames',outportNames,...
    'OutportTypes',outTypes...
    );


    startIn=tbcNet.PirInputSignals(1);
    endIn=tbcNet.PirInputSignals(2);
    validIn=tbcNet.PirInputSignals(3);
    bLen=tbcNet.PirInputSignals(4);
    bLen_ext=tbcNet.PirInputSignals(5);


    r_addr=tbcNet.PirOutputSignals(1);
    intlver_start=tbcNet.PirOutputSignals(2);
    BB_Dr=tbcNet.PirOutputSignals(3);
    BB_Sc=tbcNet.PirOutputSignals(4);
    BB_En=tbcNet.PirOutputSignals(5);
    Buffer_id=tbcNet.PirOutputSignals(6);
    betaA_En=tbcNet.PirOutputSignals(7);
    betaB_En=tbcNet.PirOutputSignals(8);
    alpha_En=tbcNet.PirOutputSignals(9);
    extrinsic_En=tbcNet.PirOutputSignals(10);
    decoder_id=tbcNet.PirOutputSignals(11);
    aprior_Src=tbcNet.PirOutputSignals(12);
    alpha_raddr=tbcNet.PirOutputSignals(13);
    alpha_waddr=tbcNet.PirOutputSignals(14);
    addr_Src=tbcNet.PirOutputSignals(15);
    output_start=tbcNet.PirOutputSignals(16);
    datasource=tbcNet.PirOutputSignals(17);
    w_en=tbcNet.PirOutputSignals(18);
    w_addr=tbcNet.PirOutputSignals(19);

    ramout_Sel=tbcNet.PirOutputSignals(20);




    decoding_start=tbcNet.addSignal(boolType,'decoding_start');
    centralcontroller_reset=tbcNet.addSignal(boolType,'centralcontroller_reset');
    checkRW=tbcNet.addSignal(boolType,'checkRW');


    desc='dataRAM Controller - generate control signals to store inputs';

    fid=fopen(fullfile(matlabroot,'toolbox','whdl','whdlutilities',...
    '+ltehdlsupport','+internal','@TurboDecoder','cgireml','DataRAMController.m'),'r');
    fcnBody=fread(fid,Inf,'char=>char');

    fclose(fid);


    inports=[startIn,endIn,validIn,bLen,bLen_ext];

    outports=[datasource,w_addr,w_en,decoding_start,centralcontroller_reset,checkRW];


    dramctrl=tbcNet.addComponent2(...
    'kind','cgireml',...
    'Name','dataRAMController',...
    'InputSignals',inports,...
    'OutputSignals',outports,...
    'EMLFileName','DataRAMController',...
    'EMLFileBody',fcnBody,...
    'EMLParams',{blockInfo.winSize},...
    'EMLFlag_TreatInputIntsAsFixpt',true,...
    'EMLFlag_SaturateOnIntOverflow',false,...
    'EMLFlag_TreatInputBoolsAsUfix1',false,...
    'BlockComment',desc);
    dramctrl.runConcurrencyMaximizer(0);


    desc='Central Controller - generate control signals for DecoderCore';

    fid=fopen(fullfile(matlabroot,'toolbox','whdl','whdlutilities',...
    '+ltehdlsupport','+internal','@TurboDecoder','cgireml','centralController.m'),'r');
    fcnBody=fread(fid,Inf,'char=>char');

    fclose(fid);

    ccInports=[decoding_start,w_addr,centralcontroller_reset,checkRW,bLen,bLen_ext];
    ccOutports=[r_addr,intlver_start,BB_Dr,BB_Sc,BB_En,Buffer_id,...
    betaA_En,betaB_En,alpha_En,extrinsic_En,...
    decoder_id,aprior_Src,alpha_raddr,alpha_waddr,addr_Src,output_start,ramout_Sel];



    inter_decoder_delay=16;

    centralctrl=tbcNet.addComponent2(...
    'kind','cgireml',...
    'Name','CentralController',...
    'InputSignals',ccInports,...
    'OutputSignals',ccOutports,...
    'EMLFileName','centralController',...
    'EMLFileBody',fcnBody,...
    'EMLParams',{blockInfo.winSize,blockInfo.numIterations,inter_decoder_delay},...
    'EMLFlag_TreatInputIntsAsFixpt',true,...
    'EMLFlag_SaturateOnIntOverflow',false,...
    'EMLFlag_TreatInputBoolsAsUfix1',false,...
    'BlockComment',desc);
    centralctrl.runConcurrencyMaximizer(0);