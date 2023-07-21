classdef ScriptGenerator<handle&matlab.mixin.SetGet




    properties(Access=private)

        CodeBuffer;


        DefaultScopeObject;
    end



    methods

        function varargout=generateScript(this)




            this.CodeBuffer=StringWriter();
            if nargout<1


                addHeader(this);
            end

            addConstructor(this);

            addMeasurementsSetup(this);
            str=this.CodeBuffer;
            if nargout>0
                varargout{1}=str;
            else
                sendToEditor(this,string(str),true);
            end
        end
    end



    methods(Access=protected)

        function addHeader(this)

            str=this.CodeBuffer;
            timeInfo=datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z');
            mlInfo=ver('matlab');
            tbxInfo=ver(this.Product);
            str.addcr('%% Generated by MATLAB(R) %s %s and %s %s %s.',...
            mlInfo.Version,...
            mlInfo.Release,...
            tbxInfo.Name,...
            tbxInfo.Version,...
            tbxInfo.Release);
            str.addcr('%% Generated on %s.\n',string(timeInfo));
            str.addcr('%% Construct a %s object',this.getClassName());
        end

        function addConstructor(this)

            str=this.CodeBuffer;
            if isempty(this.DefaultScopeObject)


                defaultobj=eval(this.getClassName());
                this.DefaultScopeObject=defaultobj;
            else

                defaultobj=this.DefaultScopeObject;
            end

            pvPairs=this.getScopeChangedPVPairs(defaultobj);

            if(~isempty(this.getDisplaySpecificProperties()))
                displayPVPairs=this.getDisplayChangedPVPairs(defaultobj);
                if(~isempty(displayPVPairs))
                    if~isempty(pvPairs)
                        delim=[', ...',newline];
                        pvPairs=[pvPairs,delim,displayPVPairs];
                    else
                        pvPairs=displayPVPairs;
                    end
                end
            end
            ctorExp=class(defaultobj);
            if~isempty(pvPairs)
                ctorExp=[ctorExp,'(',pvPairs,')'];
            end

            varName=getScopeVariableName(this);
            str.addcr('%s = %s;',varName,ctorExp);
        end

        function addMeasurementsSetup(this)
            measurersMap=getSupportedMeasurements(this);
            if~isempty(measurersMap)
                measurers=keys(measurersMap);
                for m=1:numel(measurers)
                    addMeasurement(this,measurersMap(measurers{m}));
                end
            end
        end

        function addMeasurement(this,measurer)
            measurerObj=this.(measurer);
            str=this.CodeBuffer;

            varName=getScopeVariableName(this);

            defaultMeasurerObj=this.DefaultScopeObject.(measurer);

            [flag,props,vals]=getMeasurementChangedPVPairs(this,measurerObj,defaultMeasurerObj);
            if flag



                measureName=getMeasurementName(measurerObj);

                measurerPropertytName=getMeasurementPropertyName(measurerObj);
                str.addcr('%% %s Configuration',measureName);
                for idx=1:numel(props)
                    str.addcr('%s.%s.%s = %s;',varName,measurerPropertytName,props{idx},vals{idx});
                end
            end
        end

        function pvPairs=getScopeChangedPVPairs(this,defaultobj)
            defaultStruct=get(defaultobj);

            propNames=setdiff(fields(defaultStruct),this.getIrrelevantConstructorProperties(),'stable');

            propNames=setdiff(propNames,this.getDisplaySpecificProperties(),'stable');

            propNames=getValidDisplayProperties(this,propNames);
            numProps=numel(propNames);
            delim=[', ...',newline];
            pvPairs='';

            for idx=1:numProps
                objPropName=propNames{idx};
                specObjPropName=propNames{idx};


                if~isprop(this,objPropName)
                    continue;
                end

                if strcmpi(objPropName,'YLimits')
                    if isprop(this,'PlotAsMagnitudePhase')




                        defaultobj.PlotAsMagnitudePhase=this.PlotAsMagnitudePhase;
                    end
                end
                defaultPropValue=defaultobj.(objPropName);
                newPropValue=this.(specObjPropName);
                if ischar(newPropValue)

                    if~strcmpi(defaultPropValue,newPropValue)
                        if~isempty(pvPairs)
                            pvPairs=[pvPairs,delim];%#ok<AGROW>
                        end
                        pvPairs=[pvPairs,objPropName,'=','"',newPropValue,'"'];%#ok<AGROW>
                    end
                elseif iscell(newPropValue)

                    if(any(~strcmpi(defaultPropValue,newPropValue)))
                        if~isempty(pvPairs)
                            pvPairs=[pvPairs,delim];%#ok<AGROW>
                        end
                        [nRows,nCols]=size(newPropValue);
                        cells='';
                        for row=1:nRows
                            for col=1:nCols
                                cells=[cells,matlab.system.internal.toExpression(newPropValue{row,col},...
                                'Split',true,'IncludeHidden',false)];%#ok<AGROW>
                                if col<nCols
                                    cells=[cells,','];%#ok<AGROW>
                                end
                            end
                            if row<nRows
                                cells=[cells,'; '];%#ok<AGROW>
                            end
                        end
                        if numel(newPropValue)>1
                            expression=['[',regexprep(cells,'''','"'),']'];
                        else
                            expression=regexprep(cells,'''','"');
                        end
                        pvPairs=[pvPairs,objPropName,'=',expression];%#ok<AGROW>
                    end
                else
                    if~isequal(defaultPropValue,newPropValue)
                        if~isempty(pvPairs)
                            pvPairs=[pvPairs,delim];%#ok<AGROW>
                        end
                        propExpr=matlab.system.internal.toExpression(newPropValue,...
                        'Split',true,'IncludeHidden',false);
                        pvPairs=[pvPairs,objPropName,'=',propExpr];%#ok<AGROW>
                    end
                end
            end
        end

        function pvPairs=getDisplayChangedPVPairs(this,defaultobj)
            propNames=this.getDisplaySpecificProperties();
            numProps=numel(propNames);
            delim=[', ...',newline];
            pvPairs='';
            dispPVPairs='';
            addActiveDisplayProp=false;
            numDisplays=prod(this.LayoutDimensions);

            for dIdx=1:numDisplays


                defaultobj.LayoutDimensions=this.LayoutDimensions;
                defaultobj.ActiveDisplay=dIdx;
                for pIdx=1:numProps
                    objPropName=propNames{pIdx};

                    if strcmpi(objPropName,'YLimits')
                        if isprop(this,'PlotAsMagnitudePhase')




                            defaultobj.PlotAsMagnitudePhase=this.PlotAsMagnitudePhase(1,dIdx);
                        end
                    end
                    defaultPropValue=defaultobj.(objPropName);
                    if(isnumeric(defaultPropValue))
                        newPropValue=this.(objPropName)(dIdx,:);
                    else
                        newPropValue=this.(objPropName)(dIdx);
                    end
                    if(isstring(newPropValue))

                        newPropValue=convertStringsToChars(newPropValue);
                        if~strcmpi(defaultPropValue,newPropValue)
                            addActiveDisplayProp=true;
                            if~isempty(dispPVPairs)
                                dispPVPairs=[dispPVPairs,delim];%#ok<AGROW>
                            end
                            dispPVPairs=[dispPVPairs,objPropName,'=','"',newPropValue,'"'];%#ok<AGROW>
                        end
                    else

                        if~isequal(defaultPropValue,newPropValue)
                            addActiveDisplayProp=true;
                            if~isempty(dispPVPairs)
                                dispPVPairs=[dispPVPairs,delim];%#ok<AGROW>
                            end
                            propExpr=matlab.system.internal.toExpression(newPropValue,...
                            'Split',true,'IncludeHidden',false);
                            dispPVPairs=[dispPVPairs,'',objPropName,'=',propExpr];%#ok<AGROW>
                        end
                    end
                end
                if(addActiveDisplayProp&&numDisplays>1)

                    activeDisplayExpr=matlab.system.internal.toExpression(dIdx,...
                    'Split',true,'IncludeHidden',false);
                    dispPVPairs=['ActiveDisplay=',activeDisplayExpr,delim,dispPVPairs];%#ok<AGROW>
                    addActiveDisplayProp=false;
                end
                if(~isempty(pvPairs)&&~isempty(dispPVPairs))
                    pvPairs=[pvPairs,delim,dispPVPairs];%#ok<AGROW>
                else
                    pvPairs=[pvPairs,dispPVPairs];%#ok<AGROW>    
                end
                dispPVPairs='';
            end
        end

        function[flag,props,vals]=getMeasurementChangedPVPairs(~,measurerObj,defaultMeasurerObj)
            flag=false;
            props={};
            vals={};
            ctr=1;
            validProps=getValidDisplayProperties(measurerObj,properties(measurerObj));
            for idx=1:numel(validProps)

                if isnumeric(defaultMeasurerObj.(validProps{idx}))

                    if defaultMeasurerObj.(validProps{idx})~=measurerObj.(validProps{idx})
                        flag=true;
                        props{ctr}=validProps{idx};%#ok<AGROW>
                        vals{ctr}=mat2str(measurerObj.(validProps{idx}));%#ok<AGROW>
                        ctr=ctr+1;
                    end
                elseif islogical(defaultMeasurerObj.(validProps{idx}))

                    if xor(defaultMeasurerObj.(validProps{idx}),measurerObj.(validProps{idx}))
                        flag=true;
                        props{ctr}=validProps{idx};%#ok<AGROW>
                        propVal=measurerObj.(validProps{idx});
                        if propVal
                            vals{ctr}='true';%#ok<AGROW>
                        else
                            vals{ctr}='false';%#ok<AGROW>
                        end
                        ctr=ctr+1;
                    end

                else

                    if~strcmpi(defaultMeasurerObj.(validProps{idx}),measurerObj.(validProps{idx}))
                        flag=true;
                        props{ctr}=validProps{idx};%#ok<AGROW>
                        vals{ctr}=strcat('"',measurerObj.(validProps{idx}),'"');%#ok<AGROW>
                        ctr=ctr+1;
                    end
                end
            end
        end

        function varName=getScopeVariableName(this)
            name=getScopeName(this);

            varName=regexprep(name,' ','');

            varName(1)=lower(varName(1));
            if strcmpi(varName,'spectrumAnalyzer')
                varName='specScope';
            end
            if strcmpi(varName,'DynamicFilterVisualizer')
                varName='filtVisualizer';
            end
        end

        function sendToEditor(~,str,smartIndent)
            if nargin<2
                smartIndent=true;
            end
            editorDoc=matlab.desktop.editor.newDocument(str);
            if smartIndent
                editorDoc.smartIndentContents();
            end
        end
    end
end