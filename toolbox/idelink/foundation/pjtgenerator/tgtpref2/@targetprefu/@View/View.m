function this=View(varargin)




    this=targetprefu.View;


    this.mLabels.IDE=getIDELabels();
    this.mLabels.Board=getBoardLabels();
    this.mLabels.BoardSupport=getBoardSupportLabels();
    this.mLabels.Memory=getMemoryLabels();
    this.mLabels.Section=getSectionLabels();
    this.mLabels.RTOS=getRTOSLabels();

    this.mToolTips.IDE=getIDETips();
    this.mToolTips.Board=getBoardTips();
    this.mToolTips.Memory=getMemoryTips();
    this.mToolTips.Section=getSectionTips();
    this.mToolTips.RTOS=getRTOSTips();

    this.mCurSelection=struct('Board','','MemoryBank','','RTOS','');
    this.mCurSelection.MemoryBank.Row=0;
    this.mCurSelection.RTOS.Row=0;


    function IDE=getIDELabels()

        IDE=struct('IDEName','',...
        'Help','');
        IDE=getXlateEntries('IDE',IDE);


        function IDE=getIDETips()

            IDE=struct('IDEName','');
            IDE=getXlateEntries('IDETip',IDE);


            function Board=getBoardLabels()

                Board=struct('BoardName','',...
                'ProcessorName','',...
                'AddProcessor','',...
                'NewProcName','',...
                'BasedOn','',...
                'EditProcessor','',...
                'DeleteProcessor','',...
                'CpuClock','',...
                'CpuClockUnit','',...
                'Properties','',...
                'OperatingSystem','',...
                'CustomCode','',...
                'CodeGenProperties','',...
                'IDERefresh','',...
                'IDEProperties','',...
                'Name','');
                Board=getXlateEntries('Board',Board);


                function Board=getBoardTips()

                    Board=struct(...
                    'BoardName','',...
                    'BoardNameFactory','',...
                    'ProcessorName','',...
                    'NewProcName','',...
                    'BasedOn','',...
                    'AddProcessor','',...
                    'CpuClock','',...
                    'OperatingSystem','',...
                    'SourceFiles','',...
                    'IncludePaths','',...
                    'LibrariesAll','',...
                    'LibrariesLE','',...
                    'LibrariesBE','',...
                    'InitFunction','',...
                    'TerminateFunction','',...
                    'IDERefresh','',...
                    'IDECurSetting',''...
                    );
                    Board=getXlateEntries('BoardTip',Board);


                    function BoardSupport=getBoardSupportLabels()

                        BoardSupport=struct('SourceFiles','',...
                        'IncludePaths','',...
                        'Libraries','',...
                        'Libraries_Little','',...
                        'Libraries_Big','',...
                        'InitializeFunctions','',...
                        'TerminateFunctions','',...
                        'CompilerOptions','',...
                        'LinkerOptions','');
                        BoardSupport=getXlateEntries('BoardSupport',BoardSupport);


                        function Memory=getMemoryLabels()
                            Memory=struct('BankContents','',...
                            'Banks','',...
                            'BankAdd','',...
                            'BankRemove','',...
                            'PhysicalMemory','',...
                            'CacheConfig','',...
                            'Cache','',...
                            'CacheConfiguration','',...
                            'Name','');
                            Memory=getXlateEntries('Memory',Memory);


                            function Memory=getMemoryTips()

                                Memory=struct(...
                                'BankAdd','',...
                                'BankRemove',''...
                                );
                                Memory=getXlateEntries('MemoryTip',Memory);


                                function Section=getSectionLabels()
                                    Section=struct('Placement','',...
                                    'Description','',...
                                    'Attributes','',...
                                    'Commands','',...
                                    'Contents','',...
                                    'Sections','',...
                                    'CompilerSections','',...
                                    'CustomSections','',...
                                    'AddSection','',...
                                    'DeleteSection','',...
                                    'SectionName','',...
                                    'Name','');
                                    Section=getXlateEntries('Section',Section);


                                    function Section=getSectionTips()

                                        Section=struct(...
                                        'Placement','',...
                                        'PlacementCustom','',...
                                        'Attributes',''...
                                        );
                                        Section=getXlateEntries('SectionTip',Section);


                                        function RTOS=getRTOSLabels()
                                            RTOS=struct('HeapAssignment','',...
                                            'HeapAdd','',...
                                            'HeapRemove','',...
                                            'Heap','',...
                                            'DataPlacement','',...
                                            'CodePlacement','',...
                                            'Placement','',...
                                            'StackSize','',...
                                            'StaticTasks','',...
                                            'DynamicTasks','',...
                                            'TaskManagement','',...
                                            'SchedulingMode','',...
                                            'BaseRatePriority','',...
                                            'ScheduleManagement','');
                                            RTOS=getXlateEntries('RTOS',RTOS);


                                            function RTOS=getRTOSTips()

                                                RTOS=struct(...
                                                'HeapAdd','',...
                                                'BankRemove','',...
                                                'DataPlacement','',...
                                                'CodePlacement','',...
                                                'StackSize','',...
                                                'StaticTasks','',...
                                                'DynamicTasks','',...
                                                'SchedulingMode','',...
                                                'BaseRatePriority','');
                                                RTOS=getXlateEntries('RTOSTip',RTOS);


                                                function entries=getXlateEntries(prefix,entries)


                                                    productKey=linkfoundation.util.getProductKey(mfilename('fullpath'));
                                                    entries=linkfoundation.util.getXlateEntries(productKey,'tgtpref',prefix,entries);
