function out=needsCommService(h,varargin)



    out=codertarget.attributes.supportTargetServicesFeature(h,'ToAsyncQueueAppSvc',varargin{:})||...
    codertarget.attributes.supportTargetServicesFeature(h,'RTIOStreamAppSvc',varargin{:})||...
    codertarget.attributes.supportTargetServicesFeature(h,'ParamTuningAppSvc',varargin{:})||...
    (~isempty(which('coder.internal.connectivity.StreamingProfilerAppSvc'))&&...
    coder.internal.connectivity.StreamingProfilerBaseSvc.isStreamingProfilerAppSvcNeeded(h)...
    );
end