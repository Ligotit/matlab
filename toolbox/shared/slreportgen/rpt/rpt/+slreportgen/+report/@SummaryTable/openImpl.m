function result=openImpl(reporter,impl,varargin)
    if isempty(varargin)
        key=['E2CxpMaUARVPDOGaq6+KIuiLFFqRlJ3uBhMI9bd3tqfw4yEXegjSR7McrTHF'...
        ,'RmhlrS6zETcQTwqGIYni+i1qoXPuaDj8jxZ8QAio7UcIZH/NgsucRCCBq4bD'...
        ,'yJaYAOdqtMcLECjSnX0ju+jaJ9mod1j4Y+h2QUA+u+DnYqiV6gUqpDE3mfwe'...
        ,'pTu8Mj2xQhIZSIyoQOUTHyOaRVp1Ue4TflT1jyu2ezXgBMxrKhxuH0Jf63nt'...
        ,'RzIEqLoOZXTw6kuGlXAFsajtfcMbh5/w56JmF7YQoy2auiu4XOx1lcy85Yyx'...
        ,'xi32'];
    else
        key=varargin{1};
    end
    result=open(impl,key,reporter);
end