function linkStr=getFilterLinkForRemove(this,ssid,objectiveIdx,outcomeIdx,metricName,filterStr,removeStr,options)




    if isempty(outcomeIdx)
        outcomeIdxStr='[]';
    else
        outcomeIdxStr=num2str(outcomeIdx);
    end

    if isempty(filterStr)
        linkStr=sprintf('<a href="matlab: cvi.TopModelCov.handleFilterCallback(''%s'', ''%s'', ''%s'', ''remove'', [], %d, %d, %s, ''%s'', []);"><img src="%s/%s" border="0"/></a>',...
        options.topModelName,...
        this.filterFileName,...
        ssid,...
        options.explorerGeneratedReport,...
        objectiveIdx,...
        outcomeIdxStr,...
        metricName,...
        options.imageSubDirectory,...
        'filter_remove.png');
    else
        linkStr=sprintf('<b>%s</b> <a href="matlab: cvi.TopModelCov.handleFilterCallback(''%s'', ''%s'', ''%s'', ''remove'', [], %d, %d, %s, ''%s'', []);">%s</a>',...
        filterStr,...
        options.topModelName,...
        this.filterFileName,...
        ssid,...
        options.explorerGeneratedReport,...
        objectiveIdx,...
        outcomeIdxStr,...
        metricName,...
        [' (',removeStr,')']);
    end

end
