function lnk=link(source,varargin)%#codegen







































































































































































    coder.allowpcode('plain');

    if nargin>1
        lnk=satcom.satellitescenario.internal.AddAssetsAndAnalyses.link(source,varargin{:});
    else
        lnk=satcom.satellitescenario.internal.AddAssetsAndAnalyses.link(source);
    end
end
