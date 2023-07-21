





function createStructsAndParameters(tree)
    if~isempty(tree.SimulinkVariables)&&serdes.utilities.canWriteWorkSpace(tree.SimulinkWorkSpace)
        for varIdx=1:numel(tree.SimulinkVariables)
            variable=tree.SimulinkVariables{varIdx};
            tree.SimulinkWorkSpace.clear(variable)
        end
        tree.SimulinkVariables={};
    end
    if~isempty(tree.BaseWorkspaceVariables)&&...
        serdes.utilities.canWriteWorkSpace('base')&&...
        serdes.utilities.canWriteWorkSpace(tree.SimulinkWorkSpace)


        for varIdx=1:numel(tree.BaseWorkspaceVariables)
            variable=tree.BaseWorkspaceVariables;
            evalin('base',char("clear "+variable))
        end
        tree.BaseWorkspaceVariables={};
    end

    createStructsAndParametersforReserved(tree);

    blockNodes=tree.getChildren(tree.ModelSpecificNode);
    for nodeIdx=1:numel(blockNodes)
        blockNode=blockNodes{nodeIdx};
        createStructsAndParametersforNode(tree,blockNode)
        maskPath=[bdroot,'/',char(tree.Direction),'/',char(blockNode.NodeName)];
        try
            serdes.internal.callbacks.datapathOpen(maskPath,true);
        catch mex %#ok<NASGU>

        end
    end

    try
        serdes.internal.ibisami.ami.updateUtilitiesBlock('Configuration','IgnoreBitsDisplay')
        serdes.internal.ibisami.ami.updateUtilitiesBlock('Stimulus','Jitter')
    catch mex %#ok<NASGU>

    end
    serdes.internal.ibisami.ami.setPaths2Nodes(tree)

    mwsParams={'Aggressors','ChannelImpulse','Modulation','RowSize','SampleInterval','SymbolTime'};
    if serdes.utilities.canWriteWorkSpace(tree.SimulinkWorkSpace)
        for varIdx=1:numel(mwsParams)
            if tree.SimulinkWorkSpace.hasVariable(mwsParams{varIdx})
                tempParam=tree.SimulinkWorkSpace.getVariable(mwsParams{varIdx});
                if~strcmpi(tempParam.StorageClass,"Model default")
                    tempParam.StorageClass='Model default';
                end
            end
        end
    end
end
function createStructsAndParametersforNode(tree,blockNode)
    if serdes.utilities.canWriteWorkSpace(tree.SimulinkWorkSpace)
        [parameterStruct,signalStruct]=tree.simulinkStructs(blockNode);


        blockName=blockNode.NodeName;
        dictSystem=get_param(tree.SimulinkWorkSpace.ownerName,'DictionarySystem');
        if~isempty(parameterStruct)&&~isempty(fields(parameterStruct))



            simulinkParameterVariable=blockName+"Parameter";

            simulinkParameter=Simulink.Parameter;
            simulinkParameter.Value=parameterStruct;
            simulinkParameter.CoderInfo.StorageClass='Model default';
            tree.SimulinkVariables{end+1}=simulinkParameterVariable;
            assignin(tree.SimulinkWorkSpace,simulinkParameterVariable,simulinkParameter)
            simulinkParameter=dictSystem.Parameter{simulinkParameterVariable};
            simulinkParameter.Argument=true;
            simulinkParameter.StorageClass='Model default';
        end
        if~isempty(signalStruct)&&~isempty(fields(signalStruct))



            simulinkSignalParameterVariable=blockName+"SignalInitialValue";

            simulinkSignalParameter=Simulink.Parameter;
            simulinkSignalParameter.Value=signalStruct;
            tree.SimulinkVariables{end+1}=simulinkSignalParameterVariable;
            assignin(tree.SimulinkWorkSpace,simulinkSignalParameterVariable,simulinkSignalParameter)

            simulinkSignal=Simulink.Signal;

            simulinkSignal.InitialValue=simulinkSignalParameterVariable;

            busStruct=Simulink.Bus.createObject(signalStruct);

            autoGeneratedBusName=busStruct.busName;
            simulinkBusVariable=blockName+"Bus";
            simulinkSignalVariable=blockName+"Signal";
            tree.BaseWorkspaceVariables{end+1}=simulinkBusVariable;
            evalin('base',simulinkBusVariable+"="+autoGeneratedBusName+";");

            evalin('base',"clear "+autoGeneratedBusName);

            simulinkSignal.DataType=['Bus: ',char(simulinkBusVariable)];
            simulinkSignal.DimensionsMode='Fixed';
            simulinkSignal.Dimensions=1;
            simulinkSignal.Complexity='real';

            tree.SimulinkVariables{end+1}=simulinkSignalVariable;
            assignin(tree.SimulinkWorkSpace,simulinkSignalVariable,simulinkSignal);
        end
    end
end
function createStructsAndParametersforReserved(tree)
    if serdes.utilities.canWriteWorkSpace(tree.SimulinkWorkSpace)
        reservedParameters=tree.getReservedParameters;
        for paraIdx=1:length(reservedParameters)
            reservedParameter=reservedParameters{paraIdx};
            if reservedParameter.CreateMWSVariables
                if~reservedParameter.Hidden
                    setReservedMWSParameter(reservedParameter);
                else
                    clearReservedMWS(reservedParameter)
                end
            end
        end
    end
end
function setReservedMWSParameter(reservedParameter)
    if isa(reservedParameter.Usage,"serdes.internal.ibisami.ami.usage.In")
        tree=reservedParameter.Tree;
        dictSystem=get_param(tree.SimulinkWorkSpace.ownerName,'DictionarySystem');

        simulinkParameter=Simulink.Parameter;
        simulinkParameter.Value=reservedParameter.Default;
        simulinkParameter.CoderInfo.StorageClass='Model default';
        tree.SimulinkVariables{end+1}=reservedParameter.NodeName;
        assignin(tree.SimulinkWorkSpace,reservedParameter.NodeName,simulinkParameter)
        simulinkParameter=dictSystem.Parameter{reservedParameter.NodeName};
        simulinkParameter.Argument=true;
        simulinkParameter.StorageClass='Model default';
    elseif isa(reservedParameter.Usage,"serdes.internal.ibisami.ami.usage.Out")
        tree=reservedParameter.Tree;

        simulinkSignal=Simulink.Signal;

        simulinkSignal.InitialValue=string(reservedParameter.Default);

        simulinkSignal.DataType='double';
        simulinkSignal.DimensionsMode='Fixed';
        simulinkSignal.Dimensions=[1,1];
        simulinkSignal.Complexity='real';
        tree.SimulinkVariables{end+1}=reservedParameter.NodeName;

        assignin(tree.SimulinkWorkSpace,reservedParameter.NodeName,simulinkSignal);
    end
end
function clearReservedMWS(reservedParameter)
    tree=reservedParameter.Tree;
    clear(tree.SimulinkWorkSpace,reservedParameter.NodeName);
end
