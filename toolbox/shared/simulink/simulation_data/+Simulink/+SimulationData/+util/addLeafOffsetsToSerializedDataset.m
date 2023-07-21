function serializedDataset=addLeafOffsetsToSerializedDataset(...
    serializedDataset,...
    aobHierarchy,...
leafSignalOffset...
    )
    nElements=length(serializedDataset);
    for elementIdx=1:nElements
        if elementIdx<=numel(aobHierarchy)
            serializedElement=serializedDataset{elementIdx};
            aobHierarchyElement=aobHierarchy{elementIdx};
            leafSignalOffsetElement=leafSignalOffset{elementIdx};
            nodeIdx=1;
            flatIdx=0;
            serializedElement=...
            loc_set_dataset_element_leaf_signal_offsets(...
            serializedElement,...
            aobHierarchyElement,...
            leafSignalOffsetElement,...
            nodeIdx,...
flatIdx...
            );
            serializedDataset{elementIdx}=serializedElement;
        else
            return
        end
    end
end



function serializedElement=...
    loc_set_dataset_element_leaf_signal_offsets(...
    serializedElement,...
    aobHierarchy,...
    leafSignalOffset,...
    nodeIdx,...
flatIdx...
    )

    if isempty(serializedElement)
        return
    end

    if isfield(serializedElement,'ElementType')


        if isequal(serializedElement.ElementType,'live_data')
            serializedElement.Offset=0;
            return
        end
    end
    if isempty(aobHierarchy(nodeIdx).Children)
        assert(loc_is_serialized_leaf_signal(serializedElement));
        serializedElement.Offset=leafSignalOffset(flatIdx+1);
        return
    end
    assert(isstruct(serializedElement));
    fields=fieldnames(serializedElement);
    for idx=1:numel(serializedElement)
        for fieldIdx=1:length(fields)
            flatIdxChild=...
            flatIdx+(idx-1)*aobHierarchy(nodeIdx).NLeavesPerElement;
            field=fields{fieldIdx};
            fieldFound=false;
            for childNodeIdx=aobHierarchy(nodeIdx).Children
                if strcmp(aobHierarchy(childNodeIdx).Name,field)
                    fieldFound=true;
                    serializedElement(idx).(field)=...
                    loc_set_dataset_element_leaf_signal_offsets(...
                    serializedElement(idx).(field),...
                    aobHierarchy,...
                    leafSignalOffset,...
                    childNodeIdx,...
flatIdxChild...
                    );
                    break;
                end
                flatIdxChild=...
                flatIdxChild+aobHierarchy(childNodeIdx).NLeaves;
            end
            assert(fieldFound);
        end
    end
end


function bRet=loc_is_serialized_leaf_signal(el)


    bRet=...
    isstruct(el)&&...
    isfield(el,'LeafMarker')&&...
    isscalar(el.LeafMarker)&&...
    ischar(el.LeafMarker)&&...
    el.LeafMarker==...
    Simulink.SimulationData.Storage.DatasetStorage.LeafMarkerValue;
end