function SignalProps=initializeSignalData(~)
    SignalProps=struct(...
    'Element',[],...
    'isBus',false,...
    'isComplex',false,...
    'Dims',1,...
    'TimeColID',1,...
    'DimsColIDs',0,...
    'ChannelIdxs',{},...
    'BusHier',{},...
    'LeafName','',...
    'TimeVals',[],...
    'RealColIDs',[],...
    'ImagColIDs',[],...
    'RealDataVals',{},...
    'ImagDataVals',{}...
    );
end