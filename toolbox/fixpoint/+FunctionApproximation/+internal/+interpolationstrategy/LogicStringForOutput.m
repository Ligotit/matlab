classdef LogicStringForOutput<handle



    methods(Static)
        function string=getInterpolationLogicString(numInputs)
            string=['if index >= numel(tableValues)',newline,...
            'intermediateValue(:) = tableValues(end);',newline,...
            'elseif frac == 0',newline,...
            'intermediateValue(:) = tableValues(index);',newline,...
            'else',newline,...
            'tmp = cast(tableValues(index),''like'',tableValuesDelta);',newline,...
            'tableValuesDelta(:) = tableValues(index+1);',newline,...
            'intermediateValue(:) = (frac * (tableValuesDelta - tmp)) + tmp;',newline,...
            'end',newline,...
            'output(i) = intermediateValue;'];
            if numInputs>1
                string=FunctionApproximation.internal.interpolationstrategy.NDLogicStringForOutput.getInterpolationLogicString();
            end
        end
    end
end