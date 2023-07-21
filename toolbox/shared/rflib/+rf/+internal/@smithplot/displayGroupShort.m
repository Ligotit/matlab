function group=displayGroupShort(obj,varname)

    plist={'Data','Frequency'};

    group=matlab.mixin.util.PropertyGroup(plist);

    str=sprintf([...
'Show <a href="matlab:if exist(''%s'',''var''),'...
    ,'internal.polariCommon.getForDisplay(''%s'',%s,''rf.internal.smithplot''),'...
    ,'else,internal.polariCommon.getForDisplay(''%s''), end'...
    ,'">'...
    ,'all properties</a>, '...
    ,'<a href="matlab:if exist(''%s'',''var''),'...
    ,'internal.polariCommon.methodsForDisplay(''%s'',%s,''rf.internal.smithplot''),'...
    ,'else,internal.polariCommon.methodsForDisplay(''%s''), end'...
    ,'">'...
    ,'methods</a>'],...
    varname,varname,varname,varname,...
    varname,varname,varname,varname);
    group(end+1)=matlab.mixin.util.PropertyGroup('',str);