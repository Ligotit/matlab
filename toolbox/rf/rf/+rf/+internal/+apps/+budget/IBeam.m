classdef IBeam<handle





    properties
Panel
TopLine
LineIn
VerticalLine
LineOut
BottomLine
Layout
Width
Height
        UseAppContainer=false;
    end

    properties(Constant)
        IBeamWidth=10
        LineWidth=2
    end

    properties(Dependent)
LayoutRowHeight
LayoutColumnWidth
    end

    methods

        function self=IBeam(parent,varargin)











            p=inputParser;
            p.addRequired('Parent');
            p.addParameter('UseAppContainer',false,@islogical);
            parse(p,parent,varargin{:});
            self.UseAppContainer=p.Results.UseAppContainer;
            createIBeam(self,p.Results.Parent)
            layoutIBeam(self)
        end

        function rtn=get.LayoutRowHeight(self)
            rtn={self.LineWidth,'9x',self.LineWidth,'9x',self.LineWidth};
        end

        function rtn=get.LayoutColumnWidth(self)
            rtn={'3x',self.LineWidth,'3x'};
        end
    end

    methods(Hidden)

        function createIBeam(self,panelParent)




            if self.UseAppContainer
                self.Layout=uigridlayout(...
                'BackgroundColor','w',...
                'Parent',panelParent,...
                'RowHeight',self.LayoutRowHeight,...
                'ColumnWidth',self.LayoutColumnWidth,...
                'Tag','iBeamLayout',...
                'Padding',[0,0,0,0],...
                'RowSpacing',0,...
                'ColumnSpacing',0);

                self.TopLine=uipanel(...
                'Tag','iBeamTopLinePanel',...
                'Parent',self.Layout,...
                'Units','pixels',...
                'ForegroundColor',[.8,.2,.2],...
                'BackgroundColor',[.8,.2,.2],...
                'BorderType','none',...
                'Visible','on');
                self.LineIn=uipanel(...
                'Tag','iBeamLineInPanel',...
                'Parent',self.Layout,...
                'Units','pixels',...
                'ForegroundColor','k',...
                'BackgroundColor','k',...
                'BorderType','none',...
                'Visible','on');
                self.VerticalLine=uipanel(...
                'Tag','iBeamVerticalLinePanel',...
                'Parent',self.Layout,...
                'Units','pixels',...
                'ForegroundColor',[.8,.2,.2],...
                'BackgroundColor',[.8,.2,.2],...
                'BorderType','none',...
                'Visible','on');
                self.LineOut=uipanel(...
                'Tag','iBeamLineOutPanel',...
                'Parent',self.Layout,...
                'Units','pixels',...
                'ForegroundColor','k',...
                'BackgroundColor','k',...
                'BorderType','none',...
                'Visible','on');
                self.BottomLine=uipanel(...
                'Tag','iBeamBottomLinePanel',...
                'Parent',self.Layout,...
                'Units','pixels',...
                'ForegroundColor',[.8,.2,.2],...
                'BackgroundColor',[.8,.2,.2],...
                'BorderType','none',...
                'Visible','on');
            else

                self.Panel=uipanel(...
                'Tag','iBeamPanel',...
                'Parent',panelParent,...
                'Units','pixels',...
                'Title','',...
                'BackgroundColor','w',...
                'BorderType','none',...
                'Visible','on');

                self.TopLine=uicontrol(...
                self.Panel,...
                'Style','frame',...
                'Units','pixels',...
                'ForegroundColor',[.8,.2,.2],...
                'BackgroundColor',[.8,.2,.2],...
                'Visible','on');
                self.VerticalLine=uicontrol(...
                self.Panel,...
                'Style','frame',...
                'Units','pixels',...
                'ForegroundColor',[.8,.2,.2],...
                'BackgroundColor',[.8,.2,.2],...
                'Visible','on');
                self.BottomLine=uicontrol(...
                self.Panel,...
                'Style','frame',...
                'Units','pixels',...
                'ForegroundColor',[.8,.2,.2],...
                'BackgroundColor',[.8,.2,.2],...
                'Visible','on');
            end
        end


        function layoutIBeam(self)




            if self.UseAppContainer

                self.TopLine.Layout.Row=1;
                self.TopLine.Layout.Column=[1,3];

                self.LineIn.Layout.Row=3;
                self.LineIn.Layout.Column=1;

                self.VerticalLine.Layout.Row=[2,4];
                self.VerticalLine.Layout.Column=2;

                self.LineOut.Layout.Row=3;
                self.LineOut.Layout.Column=3;

                self.BottomLine.Layout.Row=5;
                self.BottomLine.Layout.Column=[1,3];
            else

                self.Layout=...
                matlabshared.application.layout.GridBagLayout(...
                self.Panel,...
                'VerticalGap',0,...
                'HorizontalGap',0,...
                'VerticalWeights',[0,0,0],...
                'HorizontalWeights',0);

                add(...
                self.Layout,self.TopLine,1,1,...
                'MinimumWidth',rf.internal.apps.budget.IBeam.IBeamWidth,...
                'MinimumHeight',rf.internal.apps.budget.IBeam.LineWidth,...
                'MaximumHeight',rf.internal.apps.budget.IBeam.LineWidth,...
                'Anchor','North')

                add(...
                self.Layout,self.VerticalLine,2,1,...
                'MinimumWidth',rf.internal.apps.budget.IBeam.LineWidth,...
                'MaximumWidth',rf.internal.apps.budget.IBeam.LineWidth,...
                'MinimumHeight',rf.internal.apps.budget.ElementView.IconHeight,...
                'Anchor','North')

                add(...
                self.Layout,self.BottomLine,3,1,...
                'MinimumWidth',rf.internal.apps.budget.IBeam.IBeamWidth,...
                'MinimumHeight',rf.internal.apps.budget.IBeam.LineWidth,...
                'MaximumHeight',rf.internal.apps.budget.IBeam.LineWidth,...
                'Anchor','North')

                [self.Width,self.Height]=getMinimumSize(self.Layout);
            end
        end
    end
end

