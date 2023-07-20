

function[errTxt,rtype]=validateCppIdentifierName(rtypeName,repTypes,varargin)

    errTxt='';
    rtype=strtrim(rtypeName);
    if isempty(rtype)
        return
    end

    cppKeywords={'alignas','alignof','and','and_eq','bitand','bitor',...
    'bool','catch','char','char16_t','char32_t','class',...
    'compl','const','constexpr','const_cast','continue','decltype',...
    'default','delete','dynamic_cast',...
    'explicit','export','false','friend',...
    'goto','inline','mutable','namespace','new',...
    'noexcept','not','not_eq','nullptr','operator','or','or_eq','private',...
    'protected','public','register','reinterpret_cast',...
    'static_assert','static_cast',...
    'template','this','thread_local','throw','true',...
    'try','typeid','typename','using',...
    'virtual','wchar_t','xor','xor_eq'};

    cppKeywords{end+1}='std';

    if ismember(rtype,cppKeywords)
        errTxt=getString(message('Coder:configSet:ecufRepTypeIsCppKeyword',rtype));
    else

        errTxt=coder.internal.validateCTypeName(rtype,repTypes,varargin);
    end