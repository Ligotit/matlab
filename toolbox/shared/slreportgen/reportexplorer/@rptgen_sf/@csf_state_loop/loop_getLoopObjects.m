function hList=loop_getLoopObjects(c)






    hList=[];


    if strcmp(c.Depth,'local')
        depthTerms={'-depth',1};
    else
        depthTerms={};
    end

    adSF=rptgen_sf.appdata_sf;
    currContext=getContextType(adSF,c,false);
    switch lower(currContext)
    case 'machine'
        parentID=get(adSF,'CurrentMachine');
    case 'chart'
        parentID=get(adSF,'CurrentChart');
    case 'state'
        parentID=get(rptgen_sf.appdata_sf,'CurrentState');

    case 'object'
        parentID=adSF.CurrentObject;
        if~isempty(parentID)
            parentID=parentID.up;
            if(isa(parentID,'Stateflow.State')||...
                isa(parentID,'Stateflow.EMFunction')||...
                isa(parentID,'Stateflow.Function')||...
                isa(parentID,'Stateflow.Box')||...
                isa(parentID,'Stateflow.Truthtable')||...
                isa(parentID,'Stateflow.SLFunction'))
                depthTerms={'-depth',0};
            else
                parentID=[];
            end
        end
    otherwise

        chartLoop=rptgen_sf.csf_chart_loop;
        parentComp=c.up;
        if~isempty(parentComp)
            connect(parentComp,chartLoop,'down');
        end

        parentID=chartLoop.loop_getLoopObjects;
        disconnect(chartLoop);
    end

    if isempty(parentID)
        return;
    end

    typeFilter=addTypeFilter(c.isAndOrStates,'State',{});
    typeFilter=addTypeFilter(c.isFcnStates,'Function',typeFilter);
    typeFilter=addTypeFilter(c.isEMFunctions,'EMFunction',typeFilter);
    typeFilter=addTypeFilter(c.isSLFunctions,'SLFunction',typeFilter);
    typeFilter=addTypeFilter(c.isBoxStates,'Box',typeFilter);
    typeFilter=addTypeFilter(c.isTruthTables,'TruthTable',typeFilter);

    if c.isSFFilterList
        filterTerms=rptgen_sf.findTerms(c.SFFilterTerms);
    else
        filterTerms={};
    end


    if c.SkipAutogenerated
        agTerms={'-function',@isNotAutogenerated};
    else
        agTerms={};
    end

    hList=find(parentID,depthTerms{:},...
    typeFilter,...
    filterTerms{:},...
    agTerms{:});
    if~isempty(hList)
        if hList(1)==parentID


            hList=hList(2:end);
        end
        hList=hList(:);
    end

    switch lower(c.SortBy)
    case 'depthfirst'
        hList=locSortByDepth(hList);
    end


    function hList=locSortByDepth(hList)

        fullName=cell(1,length(hList));
        for i=1:length(hList)
            fullName{i}=hList(i).getFullName();
        end

        [~,sortIndex]=sort(fullName);
        hList=hList(sortIndex);


        function tft=addTypeFilter(isTrue,sfType,tft)

            if isTrue
                thisTerm={'-isa',['Stateflow.',sfType]};
                if isempty(tft)
                    tft=thisTerm;
                else
                    tft=[tft,{'-or'},thisTerm];
                end
            end


            function tf=isNotAutogenerated(sfID)




                tf=rptgen_sf.isNotAutogenerated(sfID);