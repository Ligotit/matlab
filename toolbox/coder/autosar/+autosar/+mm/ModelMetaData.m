classdef ModelMetaData<handle




    properties(Constant)
        InterfaceToElementsPropName=containers.Map(...
        {'Simulink.metamodel.arplatform.interface.SenderReceiverInterface',...
        'Simulink.metamodel.arplatform.interface.NvDataInterface',...
        'Simulink.metamodel.arplatform.interface.ParameterInterface',...
        'Simulink.metamodel.arplatform.interface.ModeSwitchInterface',...
        'Simulink.metamodel.arplatform.interface.ClientServerInterface',...
        'Simulink.metamodel.arplatform.interface.TriggerInterface'},...
        {'DataElements',...
        'DataElements',...
        'DataElements',...
        'ModeGroup',...
        'Operations',...
        'Triggers'});

        InterfaceToElementsMetaClass=containers.Map(...
        {'Simulink.metamodel.arplatform.interface.SenderReceiverInterface',...
        'Simulink.metamodel.arplatform.interface.NvDataInterface',...
        'Simulink.metamodel.arplatform.interface.ParameterInterface',...
        'Simulink.metamodel.arplatform.interface.ModeSwitchInterface',...
        'Simulink.metamodel.arplatform.interface.ClientServerInterface',...
        'Simulink.metamodel.arplatform.interface.TriggerInterface'},...
        {'Simulink.metamodel.arplatform.interface.FlowData',...
        'Simulink.metamodel.arplatform.interface.FlowData',...
        'Simulink.metamodel.arplatform.interface.ParameterData',...
        'Simulink.metamodel.arplatform.interface.ModeDeclarationGroupElement',...
        'Simulink.metamodel.arplatform.interface.Operation',...
        'Simulink.metamodel.arplatform.interface.Trigger'});
    end
end

