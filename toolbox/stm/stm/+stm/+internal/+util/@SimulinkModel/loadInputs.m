function[currenState1,currenState2,sigB,ind,...
    varsLoaded,currStopTime,paramValues,warnMessage,...
    logOrError,externalInputRunData,sigBuilderInfo]...
    =loadInputs(obj,simInputs,inputDataSetsRunFile,inputSignalGroupRunFile)

    [currenState1,currenState2,sigB,ind,...
    varsLoaded,currStopTime,paramValues,warnMessage,...
    logOrError,externalInputRunData,sigBuilderInfo,...
    ~]=stm.internal.util.loadInputData(obj,simInputs,inputDataSetsRunFile,inputSignalGroupRunFile);
end