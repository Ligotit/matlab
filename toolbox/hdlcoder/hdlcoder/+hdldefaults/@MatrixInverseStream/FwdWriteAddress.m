

function FwdWriteAddress(~,hN,FwdWrtAddrInSigs,FwdWrtAddrOutSigs,...
    hBoolT,hAddrT,hCounterT,slRate,blockInfo)


    hFwdWrtAddrN=pirelab.createNewNetwork(...
    'Name','FwdWriteAddress',...
    'InportNames',{'rowCountOut','colCountOut'},...
    'InportTypes',[hCounterT,hCounterT],...
    'InportRates',slRate*ones(1,2),...
    'OutportNames',{'wrtAddrFwdSub'},...
    'OutportTypes',FwdWrtAddrOutSigs(1).Type);

    hFwdWrtAddrN.setTargetCompReplacementCandidate(true);


    for ii=1:numel(hFwdWrtAddrN.PirOutputSignals)
        hFwdWrtAddrN.PirOutputSignals(ii).SimulinkRate=slRate;
    end

    hFwdWrtAddrNinSigs=hFwdWrtAddrN.PirInputSignals;
    hFwdWrtAddrNoutSigs=hFwdWrtAddrN.PirOutputSignals;

    Constant2_out1_s6=l_addSignal(hFwdWrtAddrN,'Constant2_out1',hCounterT,slRate);

    Subtract1_out1_s12=l_addSignal(hFwdWrtAddrN,'Subtract1_out1',hAddrT,slRate);
    Subtract2_out1_s13=l_addSignal(hFwdWrtAddrN,'Subtract2_out1',hAddrT,slRate);

    pirelab.getConstComp(hFwdWrtAddrN,...
    Constant2_out1_s6,...
    1,...
    'Constant2','on',0,'','','');

    pirelab.getAddComp(hFwdWrtAddrN,...
    [hFwdWrtAddrNinSigs(2),Constant2_out1_s6],...
    Subtract1_out1_s12,...
    'Floor','Wrap','Subtract1',hCounterT,'+-');


    pirelab.getAddComp(hFwdWrtAddrN,...
    [hFwdWrtAddrNinSigs(1),Constant2_out1_s6],...
    Subtract2_out1_s13,...
    'Floor','Wrap','Subtract2',hCounterT,'+-');

    AddrOut=hdlhandles(blockInfo.RowSize,1);

    CompareToConstantS=hdlhandles(blockInfo.RowSize,1);
    SwitchS=hdlhandles(blockInfo.RowSize,1);
    DelayS=hdlhandles(blockInfo.RowSize,1);


    for itr=1:blockInfo.RowSize

        suffix=['_',int2str(itr)];
        CompareToConstantS(itr)=l_addSignal(hFwdWrtAddrN,['CompareToConstant',suffix],hBoolT,slRate);
        SwitchS(itr)=l_addSignal(hFwdWrtAddrN,['Switch',suffix],hAddrT,slRate);
        DelayS(itr)=l_addSignal(hFwdWrtAddrN,['Delay',suffix],hAddrT,slRate);

        pirelab.getCompareToValueComp(hFwdWrtAddrN,...
        hFwdWrtAddrNinSigs(1),...
        CompareToConstantS(itr),...
        '==',itr,...
        sprintf(['Compare\nTo Constant',suffix]),0);

        pirelab.getSwitchComp(hFwdWrtAddrN,...
        [Subtract1_out1_s12,Subtract2_out1_s13],...
        SwitchS(itr),...
        CompareToConstantS(itr),['Switch',suffix],...
        '~=',0,'Floor','Wrap');

        pirelab.getIntDelayComp(hFwdWrtAddrN,...
        SwitchS(itr),...
        DelayS(itr),...
        1,['Delay',suffix],...
        0,...
        0,0,[],0,0);

        AddrOut(itr)=DelayS(itr);

    end

    pirelab.getMuxComp(hFwdWrtAddrN,...
    AddrOut(1:end),...
    hFwdWrtAddrNoutSigs(1),...
    'concatenate');



    pirelab.instantiateNetwork(hN,hFwdWrtAddrN,FwdWrtAddrInSigs,...
    FwdWrtAddrOutSigs,[hFwdWrtAddrN.Name,'_inst']);

end


function hS=l_addSignal(hN,sigName,pirTyp,simulinkRate)
    hS=hN.addSignal;
    hS.Name=sigName;
    hS.Type=pirTyp;
    hS.SimulinkHandle=-1;
    hS.SimulinkRate=simulinkRate;
end