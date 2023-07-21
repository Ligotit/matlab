classdef WhatToImportFinishSandbox<internal.CodeImporterUI.QuestionBase
    methods
        function obj=WhatToImportFinishSandbox(env)
            id='WhatToImportFinishSandbox';
            topic=message('Simulink:CodeImporterUI:Topic_Analyze').getString;
            obj@internal.CodeImporterUI.QuestionBase(id,topic,env);
            obj.getAndAddOption(env,'WhatToImportFinishSandbox_Option');
            obj.SinglePane=false;
            obj.HasHintMessage=true;
            obj.HasNext=true;
        end
        function preShow(obj)
            codeImporter=obj.Env.CodeImporter;
            sbxFolder=codeImporter.SandboxPath.char;
            sbxFolderHyperlink=message(...
            'Simulink:CodeImporterUI:SandboxFolderCDHyperlink').getString;

            autoStubSrcHyperlink=message(...
            'Simulink:CodeImporterUI:AutostubSourceHyperlink').getString;
            autoStubHrdHyperlink=message(...
            'Simulink:CodeImporterUI:AutostubHeaderHyperlink').getString;
            manStubSrcHyperlink=message(...
            'Simulink:CodeImporterUI:ManualstubSourceHyperlink').getString;
            manStubHrdHyperlink=message(...
            'Simulink:CodeImporterUI:ManualstubHeaderHyperlink').getString;

            sandboxFolder=['<br/>'...
            ,'<a href="matlab:cd(''',sbxFolder,''')">',sbxFolderHyperlink,'</a>'];

            autoGeneratedFiles='<ul>';
            autoStubSource=fullfile(codeImporter.SandboxPath,...
            'autostub','auto_stub.c');
            if isfile(autoStubSource)
                autoGeneratedFiles=[autoGeneratedFiles,'<li>'...
                ,'<a href="matlab:open(''',autoStubSource.char,''')">',autoStubSrcHyperlink,'</a>'...
                ,'</li>'];
            end

            autoStubHeader=fullfile(codeImporter.SandboxPath,...
            'autostub','auto_stub.h');
            if isfile(autoStubHeader)
                autoGeneratedFiles=[autoGeneratedFiles,'<li>'...
                ,'<a href="matlab:open(''',autoStubHeader.char,''')">',autoStubHrdHyperlink,'</a>'...
                ,'</li>'];
            end

            autoGeneratedFiles=[autoGeneratedFiles,'</ul>'];

            manulaStubFiles='<ul>';
            manStubSource=fullfile(codeImporter.SandboxPath,...
            'manualstub','man_stub.c');
            if isfile(manStubSource)
                manulaStubFiles=[manulaStubFiles,'<li>'...
                ,'<a href="matlab:open(''',manStubSource.char,''')">',manStubSrcHyperlink,'</a>'...
                ,'</li>'];
            end

            manStubHeader=fullfile(codeImporter.SandboxPath,...
            'manualstub','man_stub.h');
            if isfile(manStubHeader)
                manulaStubFiles=[manulaStubFiles,'<li>'...
                ,'<a href="matlab:open(''',manStubHeader.char,''')">',manStubHrdHyperlink,'</a>'...
                ,'</li>'];
            end

            manulaStubFiles=[manulaStubFiles,'</ul>'];


            obj.QuestionMessage=message(...
            'Simulink:CodeImporterUI:Question_WhatToImportFinishSandbox',...
            sandboxFolder,autoGeneratedFiles,manulaStubFiles).getString;
        end

        function onNext(obj)
            onNext@internal.CodeImporterUI.QuestionBase(obj);
            env=obj.Env;

            try
                assert(~isempty(obj.Env.State.ProcessedOutputFolder));
                resetPath=obj.Env.CodeImporter.OutputFolder;
                obj.Env.CodeImporter.OutputFolder=obj.Env.State.ProcessedOutputFolder;
                pathCleanUpVar=onCleanup(@()obj.resetOutputFolderPath(resetPath));


                env.Gui.send_command('start_spin');
                cleanupVar=onCleanup(@()env.Gui.send_command('stop_spin'));
                env.CodeImporter.parse;
                if env.CodeImporter.Options.ValidateBuild
                    env.CodeImporter.build;
                end
            catch ME
                if isequal(ME.identifier,...
                    'Simulink:CodeImporter:SandboxUpdateError')
                    err=MException(message('Simulink:CodeImporterUI:SandboxUpdateErrorUI'));
                elseif isequal(ME.identifier,...
                    'Simulink:CodeImporter:CustomCodeChangedSandboxUpdateError')
                    err=MException(message('Simulink:CodeImporterUI:CustomCodeChangedSandboxUpdateErrorUI'));
                elseif isequal(ME.identifier,...
                    'Simulink:CodeImporter:MissingSymbolsInSandbox')
                    err=MException(message('Simulink:CodeImporter:MissingSymbolsInSandboxUI'));
                    err=addCause(err,ME.cause{1});
                else

                    rethrow(ME);
                end
                throw(err);
            end
            parseInfo=env.CodeImporter.ParseInfo;
            assert(~isempty(parseInfo));
            if parseInfo.hasGlobalVariable()
                obj.NextQuestionId='OptionsGlobalIO';
            else
                obj.NextQuestionId='WhatToImportFunction';
            end

        end

        function resetOutputFolderPath(obj,resetPath)
            obj.Env.CodeImporter.OutputFolder=resetPath;
        end
    end
end
