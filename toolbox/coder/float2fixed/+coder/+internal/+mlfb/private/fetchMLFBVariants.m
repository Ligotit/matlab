function[origMLFB,fixptMLFB]=fetchMLFBVariants(varSubSys,reuseVarSubsys)

    if nargin==1
        reuseVarSubsys=1;
    end

    origMLFB=[];
    fixptMLFB=[];
    try
        variantChoices=get_param(varSubSys,'Variants');
    catch ex

        return;
    end
    if length(variantChoices)==2
        variantOne=variantChoices(1).BlockName;
        variantTwo=variantChoices(2).BlockName;
        if isMLFB(variantOne)&&isMLFB(variantTwo)
            if isOriginalVariant(variantOne)&&isAutogeneratedFixptVariant(variantTwo)
                origMLFB=variantOne;
                fixptMLFB=variantTwo;
            elseif isAutogeneratedFixptVariant(variantOne)&&isOriginalVariant(variantTwo)
                origMLFB=variantTwo;
                fixptMLFB=variantOne;
            elseif isAutogeneratedFixptVariant(variantOne)&&isAutogeneratedFixptVariant(variantTwo)
                origMLFB=variantOne;
                fixptMLFB=variantTwo;
            end
        else
            origMLFB=[];
            fixptMLFB=[];
        end
    elseif reuseVarSubsys&&length(variantChoices)==1
        variantOne=variantChoices(1).BlockName;
        if isOriginalVariant(variantOne)
            origMLFB=variantOne;
            fixptMLFB=[];
        end
    else

    end
end

function r=isOriginalVariant(mlfb)
    r=false;
    try
        originalVariantControl='false()';
        r=~isAutogeneratedFixptVariant(mlfb)&&strcmp(get_param(mlfb,'VariantControl'),originalVariantControl);
    catch
    end
end

function r=isAutogeneratedFixptVariant(mlfb)
    try
        sfId=sfprivate('block2chart',mlfb);
        chart=idToHandle(slroot,sfId);
        r=~isempty(strfind(chart.Script,coder.internal.MLFcnBlock.F2FDriver.AUTO_GENERATED_MARKER));
        fixptVariantControl='(default)';
        r=r&&strcmp(get_param(mlfb,'VariantControl'),fixptVariantControl);
    catch ex
        r=false;
    end
end

