function result=openImpl(reporter,impl,varargin)
    if isempty(varargin)
        key=['E2CxosCQAQVPieCaqx23IiIeSp4yrJ3umG66Jn2QdFRBCuOGRttWQHaYcxCE'...
        ,'ZoCiQURhLCgo+TnH/tDm7oam4W/KwZ/+gDPoefddW2OPkNTi6iMhaRxieR5B'...
        ,'zvpW+WS9P9ADD0lwJTy6BxPF6YhUT9pG19KniNR7kPYpO88Iq8maWxWBDA9W'...
        ,'i4J/Y5wio42wo0Wm5kUbxN1Zpuxo4H4FRgrqsorMMwvqCPivV6Pes3sfJkaG'...
        ,'8R2xY45KRNxrywvO/I6SrXMdUxTGiOUYBKymHB8g6VvuhCr/qnD8gdqqoe4='];
    else
        key=varargin{1};
    end
    result=open(impl,key,reporter);
end