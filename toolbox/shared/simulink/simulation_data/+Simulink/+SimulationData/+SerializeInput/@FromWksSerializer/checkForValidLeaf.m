function checkForValidLeaf(this,element,dataPath,~,~)




    if~isa(element,'timeseries')&&...
        ~isa(element,'timetable')&&...
        (~isa(element,'matlab.io.datastore.SimulationDatastore')&&...
        isequal(this.slFeatures.fromWksUnification,2))
        this.throwError(...
        true,...
        'Simulink:SimInput:FrmWksAobBusLeafFormat',...
dataPath...
        );
    end
end

