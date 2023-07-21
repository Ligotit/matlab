function retFig=getAsHGFigure(this,mdlName)








    showCGVCE=this.checkBoxValueForModel(mdlName);
    retFig=-1;





    warnstate=warning;
    warning('off','Simulink:Engine:ModelHasNoVariantConditions');
    legendData=get_param(mdlName,'VariantAnnotations');

    warning(warnstate);

    if isempty(legendData)
        return
    end

    numVC=length(legendData);





    numRows=3+numVC;


    modelNameStr=DAStudio.message('Simulink:utility:VariantConditionsFor',mdlName);
    annotationHeadingStr=DAStudio.message('Simulink:utility:AnnotationWithoutColon');
    descHeadingStr=DAStudio.message('Simulink:utility:VariantConditions');
    conditionSrcHeadingStr=DAStudio.message('Simulink:utility:VariantConditionSRC');
    descHeadingStrCG=DAStudio.message('Simulink:utility:VariantConditionCG');


    fontUnits='points';
    fontSize=10;
    fontName='FixedWidth';
    positionUnits='Points';
    headingRowNum=numVC;




    retFig=figure('MenuBar','none',...
    'Name',...
    DAStudio.message(...
    'Simulink:utility:VariantConditionLegendTitleWithModel',...
    mdlName),...
    'Toolbar','none',...
    'NumberTitle','off',...
    'Color',[1,1,1],...
    'IntegerHandle','off',...
    'Tag','TMWVarCondLegendForPrinting',...
    'Units','points',...
    'PaperPositionMode','auto');





    ph=uipanel('Parent',retFig,...
    'Title','',...
    'FontWeight','Bold',...
    'BackgroundColor',[1,1,1],...
    'BorderType','none',...
    'BorderWidth',5,...
    'ForegroundColor',[0,0,0],...
    'Units','Normalized',...
    'Position',[0,0,1,1]);


    ModelNameHeading=uicontrol(...
    ph,'Style','text',...
    'String',modelNameStr,...
    'Units',positionUnits,...
    'BackgroundColor',[1,1,1],...
    'FontWeight','bold',...
    'FontUnits',fontUnits,...
    'FontSize',fontSize,'FontName',fontName);


    modelNameExtent=get(ModelNameHeading,'extent');
    modelNameWidth=modelNameExtent(3);







    AnnotationHeading=uicontrol(...
    ph,'Style','text',...
    'String',annotationHeadingStr,...
    'Units',positionUnits,...
    'BackgroundColor',[1,1,1],...
    'FontWeight','bold',...
    'FontUnits',fontUnits,...
    'FontSize',fontSize,'FontName',fontName);
    annotationExtent=get(AnnotationHeading,'extent');
    maxAnnotationLen=annotationExtent(3);

    DescriptionHeading=uicontrol(...
    ph,'Style','text',...
    'String',descHeadingStr,...
    'Units',positionUnits,...
    'BackgroundColor',[1,1,1],...
    'FontWeight','bold',...
    'FontUnits',fontUnits,...
    'FontSize',fontSize,'FontName',fontName,...
    'HorizontalAlignment','left');
    descExtent=get(DescriptionHeading,'extent');
    maxDescLen=descExtent(3);

    ConditionSrcHeading=uicontrol(...
    ph,'Style','text',...
    'String',conditionSrcHeadingStr,...
    'Units',positionUnits,...
    'BackgroundColor',[1,1,1],...
    'FontWeight','bold',...
    'FontUnits',fontUnits,...
    'FontSize',fontSize,'FontName',fontName,...
    'HorizontalAlignment','left');
    condSrcExtent=get(ConditionSrcHeading,'extent');
    maxcondSrcLen=condSrcExtent(3);

    if showCGVCE
        DescriptionHeadingCG=uicontrol(...
        ph,'Style','text',...
        'String',descHeadingStrCG,...
        'Units',positionUnits,...
        'BackgroundColor',[1,1,1],...
        'FontWeight','bold',...
        'FontUnits',fontUnits,...
        'FontSize',fontSize,'FontName',fontName,...
        'HorizontalAlignment','left');
        descExtent=get(DescriptionHeadingCG,'extent');
        maxDescLenCG=descExtent(3);
    end






    annotationH=zeros(numVC,1);
    descriptionH=zeros(numVC,1);
    conditionSrcH=zeros(numVC,1);
    if showCGVCE
        descriptionHCG=zeros(numVC,1);
    end




    idxCell=1;
    for idx=1:numVC

        if(strcmp(legendData(idx).Workspace,'Global'))
            workspace=DAStudio.message('Simulink:utility:VariantCondWksGlobal');
        elseif(strcmp(legendData(idx).Workspace,'Model'))
            workspace=DAStudio.message('Simulink:utility:VariantCondWksModel');
        else
            workspace=DAStudio.message('Simulink:utility:VariantCondWksMask');
        end
        annotationH(idxCell)=uicontrol(...
        ph,'Style','text',...
        'String',legendData(idx).Annotation,...
        'Units',positionUnits,...
        'BackgroundColor',[1,1,1],...
        'FontUnits',fontUnits,...
        'FontSize',fontSize,'FontName',fontName);
        annotationExtent=get(annotationH(idxCell),'extent');
        if(annotationExtent(3)>maxAnnotationLen)
            maxAnnotationLen=annotationExtent(3);
        end

        descriptionH(idxCell)=uicontrol(...
        ph,'Style','text',...
        'String',legendData(idx).VVCE,...
        'Units',positionUnits,...
        'BackgroundColor',[1,1,1],...
        'FontUnits',fontUnits,...
        'FontSize',fontSize,'FontName',fontName,...
        'HorizontalAlignment','left');
        descExtent=get(descriptionH(idxCell),'extent');
        if(descExtent(3)>maxDescLen)
            maxDescLen=descExtent(3);
        end
        conditionSrcH(idxCell)=uicontrol(...
        ph,'Style','text',...
        'String',workspace,...
        'Units',positionUnits,...
        'BackgroundColor',[1,1,1],...
        'FontUnits',fontUnits,...
        'FontSize',fontSize,'FontName',fontName,...
        'HorizontalAlignment','left');
        condSrcExtent=get(conditionSrcH(idxCell),'extent');
        if(condSrcExtent(3)>maxcondSrcLen)
            maxcondSrcLen=condSrcExtent(3);
        end

        if showCGVCE
            descriptionHCG(idxCell)=uicontrol(...
            ph,'Style','text',...
            'String',legendData(idx).CGVCE,...
            'Units',positionUnits,...
            'BackgroundColor',[1,1,1],...
            'FontUnits',fontUnits,...
            'FontSize',fontSize,'FontName',fontName,...
            'HorizontalAlignment','left');
            descExtent=get(descriptionHCG(idxCell),'extent');
            if(descExtent(3)>maxDescLenCG)
                maxDescLenCG=descExtent(3);
            end
        end

        idxCell=idxCell+1;
    end





    scaleFactor=1.1;
    rowHeight=fontSize*1.3;

    annotationWidth=maxAnnotationLen*scaleFactor;
    descriptionWidth=maxDescLen*scaleFactor;
    conditionSrcWidth=maxcondSrcLen*scaleFactor;

    annotationLeftPos=0;
    descriptionLeftPos=annotationLeftPos+annotationWidth;
    conditionSrcLeftPost=descriptionLeftPos+descriptionWidth;



    if showCGVCE
        descriptionWidthCG=maxDescLenCG*scaleFactor;
        descriptionLeftPosCG=conditionSrcLeftPost+conditionSrcWidth;
        figureWidth=annotationWidth+descriptionWidth+conditionSrcWidth+descriptionWidthCG;
    else
        figureWidth=annotationWidth+descriptionWidth+conditionSrcWidth;
    end


    if(modelNameWidth>figureWidth)
        figureWidth=modelNameWidth;
    end
    figureHeight=numRows*rowHeight;



    set(retFig,'Position',[10,10,figureWidth,figureHeight]);
    set(ModelNameHeading,'Position',...
    [0,(numRows-1)*rowHeight,figureWidth,rowHeight]);
    set(AnnotationHeading,'Position',...
    [annotationLeftPos,headingRowNum*rowHeight,...
    annotationWidth,rowHeight]);
    set(DescriptionHeading,'Position',...
    [descriptionLeftPos,headingRowNum*rowHeight,...
    descriptionWidth,rowHeight]);
    set(ConditionSrcHeading,'Position',...
    [conditionSrcLeftPost,headingRowNum*rowHeight,...
    conditionSrcWidth,rowHeight]);
    if showCGVCE
        set(DescriptionHeadingCG,'Position',...
        [descriptionLeftPosCG,headingRowNum*rowHeight,...
        descriptionWidthCG,rowHeight]);
    end

    for idx=1:numVC
        rowNum=headingRowNum-idx;
        set(annotationH(idx),'Position',...
        [annotationLeftPos,rowNum*rowHeight,...
        annotationWidth,rowHeight]);
        set(descriptionH(idx),'Position',...
        [descriptionLeftPos,rowNum*rowHeight,...
        descriptionWidth,rowHeight]);
        set(conditionSrcH(idx),'Position',...
        [conditionSrcLeftPost,rowNum*rowHeight,...
        conditionSrcWidth,rowHeight]);

        if showCGVCE
            set(descriptionHCG(idx),'Position',...
            [descriptionLeftPosCG,rowNum*rowHeight,...
            descriptionWidthCG,rowHeight]);
        end
    end
