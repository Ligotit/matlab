classdef WidgetClassHandler<handle



    properties(Constant)
        handlers=struct('uigridlayout','DataGridBuilder',...
        'uibutton','ButtonBuilder',...
        'uislider','SliderBuilder',...
        'uidropdown','ComboboxBuilder',...
        'uicheckbox','CheckboxBuilder',...
        'uieditfield','EditFieldBuilder',...
        'uinumericeditfield','EditFieldBuilder',...
        'uilabel','LabelBuilder',...
        'uispinner','SpinnerBuilder');
    end

    methods(Static)
        function className=getClassName(type)
            import matlab.internal.editor.widgetbuilder.WidgetClassHandler;
            className=WidgetClassHandler.handlers.(type);
        end
    end
end