
function importFromBaseWS(cbinfo)
    studio=cbinfo.studio;
    [bdOrDDName,interfaceCatalogStorageContext]=...
    systemcomposer.internal.getModelOrDDName(studio);
    systemcomposer.InterfaceEditor.importFromBaseWS(...
    bdOrDDName,...
    interfaceCatalogStorageContext);
end