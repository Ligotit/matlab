
function saveInterfacesToNewDD(cbinfo)
    studio=cbinfo.studio;
    [bdOrDDName,interfaceCatalogStorageContext]=...
    systemcomposer.internal.getModelOrDDName(studio);
    systemcomposer.InterfaceEditor.saveInterfacesToNewDD(...
    bdOrDDName,...
    interfaceCatalogStorageContext);
end