function result=openImpl(reporter,impl,varargin)
    if isempty(varargin)
        key=['E2CxocS0BgVLiNCaF6zwy0bsO7fAGoiaW9g2SxDhVToCagMeO6/BLimJHmEX'...
        ,'AJPDMb4s6zUuxwfVOgrEASoq/TQdJKr1GfWnJUIxDErsZe3TYMmcgPwQYAYe'...
        ,'lQ7Ac19tVeRWr8umS+wRrlWXCeDhBsgcl7Ud0TBhWqfAa7eZrmqkolBw5AAw'...
        ,'AEapMDtAHVVNbyFhDXeeQyWy2/Y4+anL55VECMnG/vVeofaMb5Ob38UGtJVl'...
        ,'KokwphmlHTZjh/OTIuw80YqB24ob4HsnU6DEGopNa9aiprgTNqWwb1HsuwjP'...
        ,'bfvH7rd4zLvYuCcD4gtCHHPuQw=='];
    else
        key=varargin{1};
    end
    result=open(impl,key,reporter);
end