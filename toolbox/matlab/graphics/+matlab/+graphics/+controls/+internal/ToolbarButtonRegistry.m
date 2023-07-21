classdef ToolbarButtonRegistry<handle




    properties(Access=private,Constant)

        DefaultCartesianMapping={...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.restoreview),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createRegistration('push',...
        'MATLAB:uistring:figuretoolbar','TooltipString_Exploration_RestoreView',false,...
        @(e,d)matlab.graphics.controls.internal.resetHelper(d.Axes,false),...
        @(e,d)matlab.graphics.controls.internal.resetHelper(d.Axes,true))...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.zoomout),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createRegistration('state',...
        'MATLAB:uistring:figuretoolbar','TooltipString_Exploration_ZoomOut',false,...
        @(e,d)matlab.graphics.controls.internal.interactionsModeCallback('zoomout',e,d),...
        @(e,d)matlab.graphics.controls.internal.interactionsModeCallback('zoomout',e,d))...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.zoomin),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createRegistration('state',...
        'MATLAB:uistring:figuretoolbar','TooltipString_Exploration_ZoomIn',false,...
        @(e,d)matlab.graphics.controls.internal.interactionsModeCallback('zoom',e,d),...
        @(e,d)matlab.graphics.controls.internal.interactionsModeCallback('zoom',e,d))...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.pan),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createRegistration('state',...
        'MATLAB:uistring:figuretoolbar','TooltipString_Exploration_Pan',false,...
        @(e,d)matlab.graphics.controls.internal.interactionsModeCallback('pan',e,d),...
        @(e,d)matlab.graphics.controls.internal.interactionsModeCallback('pan',e,d))...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.rotate),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createRegistration('state',...
        'MATLAB:uistring:figuretoolbar','TooltipString_Exploration_Rotate',true,...
        @(e,d)matlab.graphics.controls.internal.interactionsModeCallback('rotate',e,d),...
        @(e,d)matlab.graphics.controls.internal.interactionsModeCallback('rotate',e,d))...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.datacursor),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createRegistration('state',...
        'MATLAB:uistring:figuretoolbar','TooltipString_Exploration_DataCursor',true,...
        @(e,d)datacursormode(ancestor(d.Source,'figure'),d.Value),...
        [])...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.brush),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createRegistration('state',...
        'MATLAB:uistring:figuretoolbar','TooltipString_Exploration_Brushing',true,...
        @(e,d)brush(ancestor(d.Source,'figure'),char(d.Value)),...
        @(e,d)matlab.graphics.interaction.webmodes.toggleMode(d.Axes,'brush',d.Value))...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.export),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createContainerRegistration('dropdown',...
        'MATLAB:uistring:figuretoolbar',["copyvector","copyimage","saveas"])
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.saveas),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createRegistration('push',...
        'MATLAB:uistring:figuretoolbar','TooltipString_Standard_ExportAxes',true,...
        @(e,d)matlab.graphics.internal.export.exportCallback(...
        matlab.graphics.controls.internal.exportHelper(d.Axes)),...
        @(e,d)matlab.graphics.internal.export.exportCallback(...
        matlab.graphics.controls.internal.exportHelper(d.Axes)))...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.copyimage),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createRegistration('push',...
        'MATLAB:uistring:figuretoolbar','TooltipString_Standard_CopyAxesImage',true,...
        @(e,d)matlab.graphics.internal.export.exportTo(...
        matlab.graphics.controls.internal.exportHelper(d.Axes),'target','clipboard','format','image'),...
        @(e,d)matlab.graphics.internal.export.exportTo(...
        matlab.graphics.controls.internal.exportHelper(d.Axes),'target','clipboard','format','image'))...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.copyvector),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createRegistration('push',...
        'MATLAB:uistring:figuretoolbar','TooltipString_Standard_CopyAxesVector',true,...
        @(e,d)matlab.graphics.internal.export.exportTo(...
        matlab.graphics.controls.internal.exportHelper(d.Axes),'target','clipboard','format','vector','vector',true),...
        @(e,d)matlab.graphics.internal.export.exportTo(...
        matlab.graphics.controls.internal.exportHelper(d.Axes),'target','clipboard','format','vector','vector',true))...
        }...
        };

        IconCacheMapping={...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.restoreview),...
        [64,64,64,64,64,64,60,13,13,60,64,64,64,64,64,64
        64,64,64,64,64,60,13,5,5,13,60,13,1,1,64,64
        64,64,64,64,60,13,5,52,52,9,13,60,11,1,64,64
        64,64,64,60,13,13,56,64,64,60,13,13,60,11,64,64
        64,64,60,13,13,60,64,64,64,64,60,13,13,60,64,64
        64,60,13,13,60,64,64,64,64,64,64,60,13,13,52,64
        60,13,13,60,64,64,64,64,64,64,64,64,60,13,5,52
        13,13,60,64,64,64,64,64,64,64,64,64,64,60,24,5
        13,60,1,64,64,64,64,64,64,64,64,64,64,1,64,24
        64,64,1,64,64,64,64,64,64,64,64,64,64,1,64,64
        64,64,1,64,64,64,1,1,1,1,64,64,64,1,64,64
        64,64,1,64,64,64,1,64,64,1,64,64,64,1,64,64
        64,64,1,64,64,64,1,64,64,1,64,64,64,1,64,64
        64,64,1,64,64,64,1,64,64,1,64,64,64,1,64,64
        64,64,1,64,64,64,1,64,64,1,64,64,64,1,64,64
        64,64,1,1,1,1,1,64,64,1,1,1,1,1,64,64]...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.zoomout),...
        [64,64,64,32,9,1,1,1,9,32,64,64,64,64,64,64
        64,60,13,5,32,52,64,52,32,5,13,60,64,64,64,64
        64,13,13,60,64,64,64,64,64,60,13,13,64,64,64,64
        32,5,60,64,64,64,64,64,64,64,60,5,32,64,64,64
        9,32,64,64,64,64,64,64,64,64,64,32,9,64,64,64
        1,52,64,64,64,64,64,64,64,64,64,52,1,64,64,64
        1,64,64,1,1,1,1,1,1,1,64,64,1,64,64,64
        1,52,64,64,64,64,64,64,64,64,64,52,1,64,64,64
        9,32,64,64,64,64,64,64,64,64,64,32,9,64,64,64
        36,5,56,64,64,64,64,64,64,64,56,5,40,64,64,64
        64,13,13,56,64,64,64,64,64,56,5,5,64,64,64,64
        64,60,13,5,32,48,64,48,32,5,10,4,24,64,64,64
        64,64,64,40,13,1,1,1,13,40,64,44,1,24,64,64
        64,64,64,64,64,64,64,64,64,64,64,64,40,1,24,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,40,1,36
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,40,1]...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.zoomin),...
        [64,64,64,32,9,1,1,1,9,32,64,64,64,64,64,64
        64,60,13,5,32,52,64,52,32,5,13,60,64,64,64,64
        64,13,13,60,64,64,64,64,64,60,13,13,64,64,64,64
        32,5,60,64,64,64,1,64,64,64,60,5,32,64,64,64
        9,32,64,64,64,64,1,64,64,64,64,32,9,64,64,64
        1,52,64,64,64,64,1,64,64,64,64,52,1,64,64,64
        1,64,64,1,1,1,1,1,1,1,64,64,1,64,64,64
        1,52,64,64,64,64,1,64,64,64,64,52,1,64,64,64
        9,32,64,64,64,64,1,64,64,64,64,32,9,64,64,64
        36,5,56,64,64,64,1,64,64,64,56,5,40,64,64,64
        64,13,13,56,64,64,64,64,64,56,5,5,64,64,64,64
        64,60,13,5,32,48,64,48,32,5,10,4,24,64,64,64
        64,64,64,40,13,1,1,1,13,40,64,44,1,24,64,64
        64,64,64,64,64,64,64,64,64,64,64,64,40,1,24,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,40,1,36
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,40,1]...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.pan),...
        [64,64,64,64,60,56,56,5,1,9,56,64,64,64,64,64
        64,64,64,40,1,1,9,1,32,1,13,1,17,60,64,64
        64,64,64,17,9,32,1,17,64,17,1,24,1,48,56,64
        64,64,64,17,24,64,1,17,64,17,17,64,1,5,1,17
        64,64,64,32,13,64,17,17,64,17,24,60,1,5,28,1
        64,52,60,44,1,64,32,17,64,17,32,48,1,40,44,1
        28,1,5,21,1,48,44,17,64,21,40,48,1,56,32,17
        9,40,48,5,1,36,64,56,64,64,64,60,44,64,21,24
        40,9,60,52,5,36,64,64,64,64,64,64,64,64,9,32
        64,13,13,64,40,52,64,64,64,64,64,64,64,64,1,48
        64,52,1,36,64,64,64,64,64,64,64,64,64,48,1,60
        64,64,32,5,60,64,64,64,64,64,64,64,64,40,5,64
        64,64,60,9,24,64,64,64,64,64,64,64,64,28,17,64
        64,64,64,44,1,52,64,64,64,64,64,64,64,9,36,64
        64,64,64,64,17,17,64,64,64,64,64,64,48,1,56,64
        64,64,64,64,52,1,1,1,1,1,1,1,1,21,64,64]...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.rotate),...
        [64,64,64,64,40,17,1,1,64,64,64,1,1,1,24,64
        64,64,56,13,1,24,44,48,64,64,64,1,1,17,64,64
        64,56,5,13,52,64,64,64,64,64,64,1,17,1,40,64
        64,13,13,60,64,64,64,48,48,64,64,24,64,32,5,56
        40,1,52,64,64,52,17,1,1,17,52,64,64,64,9,28
        17,24,64,64,24,1,13,48,48,13,1,24,64,64,28,13
        1,44,64,64,1,1,17,52,52,17,1,1,64,64,48,1
        1,48,64,64,1,28,9,1,1,9,28,1,64,64,48,1
        1,52,64,64,1,48,60,13,21,60,48,1,64,64,48,1
        1,44,64,64,1,28,64,17,32,64,28,1,64,64,44,1
        17,24,64,64,32,1,9,9,21,9,5,36,64,64,24,17
        40,1,52,64,64,56,17,1,1,21,60,64,64,52,1,40
        64,13,13,60,64,64,64,44,48,64,64,64,60,13,13,64
        64,56,5,13,52,64,64,64,64,64,64,52,13,5,56,64
        64,64,56,13,1,24,44,48,52,44,24,1,13,56,64,64
        64,64,64,64,40,17,1,1,1,1,17,40,64,64,64,64]...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.datacursor),...
        [64,64,1,1,1,1,1,1,1,1,1,1,1,1,1,1
        64,64,1,64,64,64,64,64,64,64,64,64,64,64,64,1
        64,64,1,64,64,64,64,64,64,64,64,64,64,64,64,1
        64,64,1,64,64,64,64,64,64,64,64,64,64,64,64,1
        64,64,1,64,64,64,64,64,64,64,64,64,64,64,64,1
        64,60,1,64,64,64,64,64,64,64,64,64,64,64,64,1
        60,13,13,64,64,1,1,1,1,1,1,1,1,64,64,1
        13,5,56,64,64,64,64,64,64,64,64,64,64,64,64,1
        13,5,56,64,64,64,64,64,64,64,64,64,64,64,64,1
        60,13,13,64,64,1,1,1,1,1,1,1,1,64,64,1
        64,56,1,64,64,64,64,64,64,64,64,64,64,64,64,1
        64,64,1,64,64,64,64,64,64,64,64,64,64,64,64,1
        64,64,1,64,64,64,64,64,64,64,64,64,64,64,64,1
        64,64,1,64,64,64,64,64,64,64,64,64,64,64,64,1
        64,64,1,64,64,64,64,64,64,64,64,64,64,64,64,1
        64,64,1,1,1,1,1,1,1,1,1,1,1,1,1,1]...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.brush),...
        [64,64,64,64,64,64,64,64,1,1,1,1,1,64,64,64
        64,64,64,64,64,64,64,64,1,64,64,64,1,64,64,64
        64,64,64,64,64,64,64,64,1,64,64,64,1,64,64,64
        64,64,64,64,64,64,64,64,1,64,64,64,1,64,64,64
        64,64,64,64,64,64,64,64,1,64,64,64,1,64,64,64
        64,64,64,64,64,64,64,52,1,64,64,64,1,52,64,64
        64,64,64,64,64,64,60,9,13,64,64,64,13,9,60,64
        64,64,64,64,64,64,13,13,60,64,64,64,60,13,13,60
        64,64,64,64,64,64,1,1,1,1,1,1,1,1,1,64
        64,64,64,64,64,64,1,64,64,64,64,64,64,64,1,64
        64,64,64,64,64,44,1,1,1,1,1,1,1,1,1,64
        64,64,64,64,64,17,21,64,64,64,64,64,64,48,1,64
        64,64,64,64,44,1,48,64,64,64,64,64,64,40,1,64
        64,64,64,52,5,28,64,64,56,44,32,21,9,1,17,64
        64,64,52,5,1,28,17,1,1,1,1,1,1,1,28,64
        60,32,1,1,1,1,1,1,1,1,1,1,1,1,44,64]...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.export),...
        [64,64,64,64,64,64,64,64,64,64,13,60,64,64,64,64
        64,64,64,64,64,64,64,64,64,64,1,9,52,64,64,64
        64,64,64,64,64,64,64,64,64,64,1,13,5,44,64,64
        64,64,64,64,64,64,64,40,13,1,1,64,24,1,36,64
        64,64,64,64,64,60,17,1,24,44,60,64,64,36,1,24
        64,64,64,64,64,13,5,48,64,60,44,64,64,36,1,24
        64,64,64,64,32,1,52,60,24,1,1,64,24,1,32,64
        64,64,64,60,5,32,60,13,5,40,1,13,5,40,64,64
        64,64,64,40,1,60,17,5,52,64,1,5,52,64,64,64
        64,64,64,24,21,48,1,48,64,64,13,60,64,64,64,64
        64,64,64,13,32,24,17,64,64,64,64,64,64,64,64,64
        1,1,1,1,48,5,1,1,1,1,1,1,1,1,1,1
        1,64,64,1,48,1,48,64,64,64,64,64,64,64,64,1
        1,64,64,1,1,1,48,64,64,64,64,64,64,64,64,1
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,64,1
        1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.saveas),...
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
        1,64,64,1,64,64,64,64,64,64,1,64,1,64,64,1
        1,64,64,1,64,64,64,64,64,64,1,64,1,64,64,1
        1,64,64,1,64,64,64,64,64,64,64,64,1,64,64,1
        1,64,64,1,1,1,1,1,1,1,1,1,1,64,64,1
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,64,1
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,64,1
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,64,1
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,64,1
        1,64,64,1,1,1,1,1,1,1,1,1,1,64,64,1
        1,64,64,1,64,64,64,64,64,64,64,64,1,64,64,1
        1,64,64,1,64,1,1,1,1,1,1,64,1,64,64,1
        1,52,64,1,64,64,64,64,64,64,64,64,1,64,64,1
        24,5,52,1,64,1,1,1,1,64,64,64,1,64,64,1
        64,24,5,1,64,64,64,64,64,64,64,64,1,64,64,1
        64,64,24,1,1,1,1,1,1,1,1,1,1,1,1,1]...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.copyimage),...
        [
        1,1,1,1,1,1,1,1,1,1,1,64,64,64,64,64
        1,64,64,64,64,64,64,64,64,64,1,64,64,64,64,64
        1,64,64,64,64,64,52,9,52,64,1,64,64,64,64,64
        1,64,64,64,64,64,9,1,9,64,1,64,64,64,64,64
        1,64,64,24,24,64,52,9,52,64,1,64,64,64,64,64
        1,64,36,1,5,1,1,1,1,1,1,1,1,1,1,1
        1,48,1,32,52,1,64,64,64,64,64,64,64,64,64,1
        1,5,21,64,64,1,64,64,64,64,64,52,9,52,64,1
        1,13,60,64,64,1,64,64,64,64,64,9,1,9,64,1
        1,52,64,64,64,1,64,64,24,24,64,52,9,52,64,1
        1,1,1,1,1,1,64,36,1,5,24,64,64,64,64,1
        64,64,64,64,64,1,48,1,32,52,5,24,64,64,64,1
        64,64,64,64,64,1,5,21,64,64,52,5,24,64,64,1
        64,64,64,64,64,1,13,60,64,64,64,52,5,24,64,1
        64,64,64,64,64,1,52,64,64,64,64,64,52,5,24,1
        64,64,64,64,64,1,1,1,1,1,1,1,1,1,1,1]...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.copyvector),...
        [1,1,1,1,1,1,1,1,1,1,1,64,64,64,64,64
        1,64,64,64,64,64,64,64,64,64,1,64,64,64,64,64
        1,64,1,1,1,60,64,64,64,64,1,64,64,64,64,64
        1,64,1,64,1,5,24,56,64,64,1,64,64,64,64,64
        1,64,1,1,1,40,13,13,64,64,1,64,64,64,64,64
        1,64,64,64,64,1,1,1,1,1,1,1,1,1,1,1
        1,64,64,64,64,1,64,64,64,64,64,64,64,64,64,1
        1,64,64,64,64,1,64,1,1,1,56,64,64,64,64,1
        1,64,64,64,64,1,64,1,64,1,1,9,52,64,64,1
        1,64,64,64,64,1,64,1,1,1,52,13,9,64,64,1
        1,1,1,1,1,1,64,64,64,64,64,56,1,48,64,1
        64,64,64,64,64,1,64,64,64,64,64,1,1,1,64,1
        64,64,64,64,64,1,64,64,64,64,64,1,64,1,64,1
        64,64,64,64,64,1,64,64,64,64,64,1,1,1,64,1
        64,64,64,64,64,1,64,64,64,64,64,64,64,64,64,1
        64,64,64,64,64,1,1,1,1,1,1,1,1,1,1,1]...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.stepzoomout),...
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,64,64,64,1,1,1,1,1,1,1,64,64,64,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64]...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.stepzoomin),...
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,1,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,1,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,1,64,64,64,64,64,64,1,64
        1,64,64,64,1,1,1,1,1,1,1,64,64,64,1,64
        1,64,64,64,64,64,64,1,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,1,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,1,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,64,64,64,64,64,64,64,64,64,64,64,64,64,1,64
        1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64]...
        },...
        {...
        'expanded',...
        [64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
        64,64,43,1,51,64,64,64,64,64,64,51,1,43,64,64
        64,64,60,9,1,51,64,64,64,64,51,1,9,60,64,64
        64,64,64,60,9,1,51,64,64,51,1,9,60,64,64,64
        64,64,64,64,60,9,1,51,51,1,9,60,64,64,64,64
        64,64,64,64,64,60,9,1,1,9,60,64,64,64,64,64
        64,64,64,64,64,64,60,9,9,60,64,64,64,64,64,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64]
        },...
        {...
        'collapsed',...
        [64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
        64,64,64,64,64,52,17,60,64,64,64,64,64,64,64,64
        64,64,64,64,64,60,13,13,60,64,64,64,64,64,64,64
        64,64,64,64,64,64,60,13,13,60,64,64,64,64,64,64
        64,64,64,64,64,64,64,60,13,13,60,64,64,64,64,64
        64,64,64,64,64,64,64,64,60,13,13,60,64,64,64,64
        64,64,64,64,64,64,64,64,64,56,1,24,64,64,64,64
        64,64,64,64,64,64,64,64,60,13,13,60,64,64,64,64
        64,64,64,64,64,64,64,60,13,13,60,64,64,64,64,64
        64,64,64,64,64,64,60,13,13,60,64,64,64,64,64,64
        64,64,64,64,64,60,13,13,60,64,64,64,64,64,64,64
        64,64,64,64,64,52,17,60,64,64,64,64,64,64,64,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64
        64,64,64,64,64,64,64,64,64,64,64,64,64,64,64,64]
        }...
        };

        DefaultGeographicMapping={...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.restoreview),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createRegistration('push',...
        'MATLAB:uistring:figuretoolbar','TooltipString_Exploration_RestoreView',false,...
        @(e,d)matlab.graphics.controls.internal.resetHelper(d.Axes,false),...
        @(e,d)matlab.graphics.controls.internal.resetHelper(d.Axes,true))...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.stepzoomout),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createRegistration('push',...
        'MATLAB:graphics:maps','MapActionZoomOut',false,...
        @(e,d)matlab.graphics.controls.internal.stepZoomHelper(d.Axes,'zoomout'),...
        @(e,d)matlab.graphics.controls.internal.stepZoomHelper(d.Axes,'zoomout'))...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.stepzoomin),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createRegistration('push',...
        'MATLAB:graphics:maps','MapActionZoomIn',false,...
        @(e,d)matlab.graphics.controls.internal.stepZoomHelper(d.Axes,'zoomin'),...
        @(e,d)matlab.graphics.controls.internal.stepZoomHelper(d.Axes,'zoomin'))...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.datacursor),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createRegistration('state',...
        'MATLAB:uistring:figuretoolbar','TooltipString_Exploration_DataCursor',true,...
        @(e,d)datacursormode(ancestor(d.Source,'figure'),d.Value),...
        [])...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.export),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createContainerRegistration('dropdown',...
        'MATLAB:uistring:figuretoolbar',["copyimage","saveas"])
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.saveas),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createRegistration('push',...
        'MATLAB:uistring:figuretoolbar','TooltipString_Standard_ExportAxes',true,...
        @(e,d)matlab.graphics.internal.export.exportCallback(...
        matlab.graphics.controls.internal.exportHelper(d.Axes)),...
        @(e,d)matlab.graphics.internal.export.exportCallback(...
        matlab.graphics.controls.internal.exportHelper(d.Axes)))...
        },...
        {...
        char(matlab.graphics.controls.internal.ToolbarValidator.copyimage),...
        matlab.graphics.controls.internal.ToolbarButtonRegistry.createRegistration('push',...
        'MATLAB:uistring:figuretoolbar','TooltipString_Standard_CopyAxesImage',true,...
        @(e,d)matlab.graphics.internal.export.exportTo(...
        matlab.graphics.controls.internal.exportHelper(d.Axes),'target','clipboard','format','image'),...
        @(e,d)matlab.graphics.internal.export.exportTo(...
        matlab.graphics.controls.internal.exportHelper(d.Axes),'target','clipboard','format','image'))...
        }...
        };
    end

    properties(SetObservable=true,SetAccess='protected',GetAccess='public',Dependent=false,Hidden=false)
        CartesianMap;
        GeographicMap;
        IconCacheMap;
    end


    methods(Static,Access='public')

        function obj=getInstance()
            persistent registryInstance;
            mlock;
            if isempty(registryInstance)
                registryInstance=matlab.graphics.controls.internal.ToolbarButtonRegistry;
                registryInstance.createRegistryMaps();
            end
            obj=registryInstance;

        end

        function s=createRegistration(type,catalogKey,tooltipKey,stayEnabled,callback,webCallback)
            s=struct('Type',type,'CatalogKey',catalogKey,'Tooltip',tooltipKey,'StayEnabled',stayEnabled,'Callback',callback,'WebCallback',webCallback);
        end

        function s=createContainerRegistration(type,catalogKey,childKeys)
            s=struct('Type',type,'CatalogKey',catalogKey,'ChildKeys',childKeys);
        end

    end

    methods(Access=private)
        function obj=ToolbarButtonRegistry()
        end

        function createRegistryMaps(this)
            this.CartesianMap=this.createMapping(this.DefaultCartesianMapping);
            this.GeographicMap=this.createMapping(this.DefaultGeographicMapping);
            this.IconCacheMap=this.createMapping(this.IconCacheMapping);
        end

        function map=createMapping(~,mapping)
            keyset=cell(1,length(mapping));
            valueset=cell(1,length(mapping));

            for i=1:length(mapping)
                keyset{i}=mapping{1,i}{1,1};
                valueset{i}=mapping{1,i}{1,2};
            end

            map=containers.Map(keyset',...
            valueset');
        end
    end

    methods(Access=public)
        function btn=getButton(obj,key,varargin)
            btn=[];

            isWebButton=true;


            currentMap=obj.CartesianMap;


            if nargin>2

                ax=varargin{1};


                if isa(ax,'matlab.graphics.axis.GeographicAxes')||...
                    isa(ax,'map.graphics.axis.MapAxes')
                    currentMap=obj.GeographicMap;
                end

                fig=ancestor(ax,'figure');
                if~isempty(fig)&&isprop(fig,'UseLegacyExplorationModes')&&fig.UseLegacyExplorationModes
                    isWebButton=false;
                else
                    cca=ancestor(ax,'matlab.ui.internal.mixin.CanvasHostMixin');
                    if isempty(cca)
                        cca=fig;
                    end

                    if~isempty(cca)
                        isWebButton=isa(cca.getCanvas,'matlab.graphics.primitive.canvas.HTMLCanvas');
                    end
                end

                key=char(key);

                if obj.isValidButtonForAxes(key,ax)
                    btnStruct=currentMap(key);



                    if strcmpi(btnStruct.Type,'dropdown')
                        btn=obj.getContainer(key,btnStruct,varargin{:});
                        return;
                    end



                    callback=btnStruct.Callback;

                    if isWebButton
                        callback=btnStruct.WebCallback;
                    end



                    if~isempty(callback)

                        if strcmpi(btnStruct.Type,'push')
                            btn=matlab.ui.controls.ToolbarPushButton();
                            btn.ButtonPushedFcn=callback;
                        else
                            btn=matlab.ui.controls.ToolbarStateButton();
                            btn.ValueChangedFcn=callback;
                        end

                        btn.Icon=key;
                        btn.Tag=key;

                        catalogKey=btnStruct.CatalogKey;

                        btn.Tooltip=matlab.internal.Catalog(catalogKey)...
                        .getString(btnStruct.Tooltip);




                        if btnStruct.StayEnabled
                            stayEnabledProp=addprop(btn,'StayEnabled');
                            btn.StayEnabled=false;
                            stayEnabledProp.Hidden=true;
                        end
                    end
                end
            end
        end

        function[val,ratios]=getButtonIcon(obj,key)

            if obj.IconCacheMap.isKey(key)

                val=obj.IconCacheMap(key);
                ratios=1;

                if isempty(val)

                    filename=[char(key),'.mat'];

                    imageMATFile=fullfile(toolboxdir('matlab'),...
                    "graphics","+matlab","+graphics",...
                    "+controls","icons","indexed",filename);

                    imageData=load(imageMATFile);
                    val=imageData.data;

                    obj.IconCacheMap(key)=val;

                end
            else
                val=[];
                ratios=1;
            end
        end

        function dd=getContainer(obj,key,btnStruct,varargin)


            dd=matlab.ui.controls.ToolbarDropdown();
            dd.Icon=key;
            dd.Tag=key;

            for i=1:numel(btnStruct.ChildKeys)
                childKey=btnStruct.ChildKeys(i);
                btn=obj.getButton(childKey,varargin{:});
                btn.Parent=dd;
            end
        end

        function result=isValidButtonForAxes(obj,buttonType,ax)
            currentMap=obj.CartesianMap;


            if isa(ax,'matlab.graphics.axis.GeographicAxes')||...
                isa(ax,'map.graphics.axis.MapAxes')
                currentMap=obj.GeographicMap;
            end

            keyList=string(keys(currentMap));



            result=any(buttonType==keyList);
        end
    end
end
