function hNewC=lowerBitwiseOp(hN,hC)



    hNewC=pireml.getBitwiseOpComp(hN,...
    hC.PirInputSignals,...
    hC.PirOutputSignals,...
    hC.getOpName,...
    hC.Name,...
    hC.getUseBitMask,...
    hC.getBitMask);
end