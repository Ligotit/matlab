function linkStr=getFilterLinkForAdd(this,ssid,objectiveIdx,outcomeIdx,metricName,descr,addFilterStr,options)




    if isempty(outcomeIdx)
        outcomeIdxStr='[]';
    else
        outcomeIdxStr=num2str(outcomeIdx);
    end

    if isempty(addFilterStr)
        descr=strrep(descr,'"','&quot;');
        descr=strrep(descr,'&apos;','&quot;');



        cvd=this.allTests{1};
        filterFileName='';
        if~isempty(this.appliedFilters)
            fileNames=join({this.appliedFilters.fileName},',');
            filterFileName=fileNames{1};
        end
        [ctxId,reportViewCmd]=options.getFilterCtxId();
        linkStr=sprintf('<a href="matlab: cvi.FilterExplorer.FilterExplorer.reportRuleCallback(''%s'', [], %d,  ''%s'', ''%s'', ''%s'', ''add'', ''%s'', [], %d, %s, ''%s'', ''%s'');"><div title="%s"><img src="%s/%s" border="0"></img></div></a>',...
        ctxId,...
        cvd.id,...
        reportViewCmd,...
        options.topModelName,...
        filterFileName,...
        ssid,...
        objectiveIdx,...
        outcomeIdxStr,...
        metricName,...
        descr,...
        getString(message('Slvnv:simcoverage:cvhtml:AddJustification')),...
        options.imageSubDirectory,...
        'filter_add.png');
    else


        filterFileName='';
        if~isempty(this.appliedFilters)
            fileNames=join({this.appliedFilters.fileName},',');
            filterFileName=fileNames{1};
        end
        cvd=this.allTests{1};
        [ctxId,reportViewCmd]=options.getFilterCtxId();
        linkStr=sprintf('<a href="matlab: cvi.FilterExplorer.FilterExplorer.reportRuleCallback(''%s'', [], %d,  ''%s'', ''%s'', ''%s'', ''add'', ''%s'');">%s</a>',...
        ctxId,...
        cvd.id,...
        reportViewCmd,...
        options.topModelName,...
        filterFileName,...
        ssid,...
        addFilterStr);
    end
end

