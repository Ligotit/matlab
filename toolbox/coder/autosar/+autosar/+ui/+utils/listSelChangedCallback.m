




function listSelChangedCallback(h,e)
    if~isempty(e.EventData)&&isa(e.EventData(1),'DAStudio.DAObjectProxy')
        if~isempty(findprop(h,'EventData'))&&isempty(h.EventData)


            h.EventData=[];
        end
        obj=e.EventData(1).getMCOSObjectReference();
        if isa(h.getRoot,'autosar.ui.metamodel.M3ITerminalNode')...
            &&~isempty(obj.getM3iObject())...
            &&(isa(obj.getM3iObject,autosar.ui.configuration.PackageString.Runnables)||...
            isa(obj.getM3iObject,autosar.ui.metamodel.PackageString.CompuMethodClass)||...
            isa(obj.getM3iObject,autosar.ui.metamodel.PackageString.SwAddrMethodClass))||...
            isa(obj.getM3iObject,autosar.ui.metamodel.PackageString.ValueTypeClass)||...
            isa(obj.getM3iObject,'Simulink.metamodel.arplatform.port.DataReceiverPort')||...
            isa(obj.getM3iObject,'Simulink.metamodel.arplatform.port.DataSenderPort')||...
            isa(obj.getM3iObject,'Simulink.metamodel.arplatform.port.DataSenderReceiverPort')||...
            isa(obj.getM3iObject,'Simulink.metamodel.arplatform.port.NvDataReceiverPort')||...
            isa(obj.getM3iObject,'Simulink.metamodel.arplatform.port.NvDataSenderPort')||...
            isa(obj.getM3iObject,'Simulink.metamodel.arplatform.port.NvDataSenderReceiverPort')||...
            isa(obj.getM3iObject,'Simulink.metamodel.arplatform.port.ServiceProvidedPort')||...
            isa(obj.getM3iObject,'Simulink.metamodel.arplatform.port.ServiceRequiredPort')
            h.showDialogView(true);
        elseif isprop(obj,'MObject')&&isa(obj.MObject.MappedTo,'Simulink.AutosarTarget.PortElement')
            h.showDialogView(true);
        else
            h.showDialogView(false);
        end
    end
end

