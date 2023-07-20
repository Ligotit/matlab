classdef StringForVectorizedNearestEvenPow2Spacing<FunctionApproximation.internal.prelookupfunction.StringForPrelookupFunction





    methods(Static)
        function prelookupString=getPrelookupString(inputNumber)
            prelookupString=['breakpointValues',num2str(inputNumber),' = reshape(breakpointValues',num2str(inputNumber),',[],1);',newline,...
            'index(:,',num2str(inputNumber),') = preLookUpIndexOnly(inputValues',num2str(inputNumber),...
            ',breakpointValues',num2str(inputNumber),',idxType,bpSpaceExponent',num2str(inputNumber),',bpSpaceReciprocal',num2str(inputNumber),');',newline,...
            'tmpIdx = index(:,',num2str(inputNumber),');',newline,...
            'indexTemp = find(tmpIdx < length(breakpointValues',num2str(inputNumber),'));',newline,...
            'indexNew = indexTemp(accumneg(breakpointValues',num2str(inputNumber),...
            '(tmpIdx(indexTemp) + 1), inputValues',num2str(inputNumber),'(indexTemp)) <= accumneg(inputValues',num2str(inputNumber),'(indexTemp), breakpointValues',num2str(inputNumber),...
            '(tmpIdx(indexTemp))));',newline,...
            'tmpIdx(indexNew) = (tmpIdx(indexNew) + 1);',newline,...
            'index(:,',num2str(inputNumber),') = tmpIdx;',newline];
        end
    end
end

