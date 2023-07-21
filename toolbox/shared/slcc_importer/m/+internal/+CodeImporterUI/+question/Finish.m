

classdef Finish<internal.CodeImporterUI.QuestionBase
    methods
        function obj=Finish(env)
            id='Finish';
            topic=message('Simulink:CodeImporterUI:Topic_Finish').getString;
            obj@internal.CodeImporterUI.QuestionBase(id,topic,env);
            obj.NextQuestionId='NextStep';
            obj.getAndAddOption(env,'Finish_Create');
            obj.HasHelp=false;
            obj.SinglePane=true;
            obj.HasHintMessage=false;
            obj.HasSummaryMessage=false;
        end
        function preShow(obj)
            ci=obj.Env.CodeImporter;
            if ci.CustomCode.GlobalVariableInterface
                GlobalVariableInterface='Yes';
            else
                GlobalVariableInterface='No';
            end

            if obj.Env.IsSLTest
                obj.QuestionMessage=sprintf(['%s\n<small>'...
                ,'<b>Function:</b> %s\n'...
                ,'<b>Types:</b> %s\n'...
                ,'<b>Library name:</b> %s\n'...
                ,'<b>Output folder:</b> %s\n'...
                ,'<b>Support global variables as function IO:</b> %s\n'...
                ,'</small>'],...
                message('Simulink:CodeImporterUI:Question_Finish').getString,...
                strjoin(ci.FunctionsToImport,', '),...
                strjoin(ci.TypesToImport,', '),...
                ci.LibraryFileName,...
                ci.qualifiedSettings.OutputFolder,...
                GlobalVariableInterface);
            else
                obj.QuestionMessage=sprintf(['%s\n<small>'...
                ,'<b>Function:</b> %s\n'...
                ,'<b>Types:</b> %s\n'...
                ,'<b>Library name:</b> %s\n'...
                ,'<b>Output folder:</b> %s\n'...
                ,'<b>Support global variables as function IO:</b> %s\n'...
                ,'</small>'],...
                message('Simulink:CodeImporterUI:Question_Finish').getString,...
                strjoin(ci.FunctionsToImport,', '),...
                strjoin(ci.TypesToImport,', '),...
                ci.LibraryFileName,...
                ci.qualifiedSettings.OutputFolder,...
GlobalVariableInterface...
                );
            end

        end

        function onNext(obj)
            env=obj.Env;
            if env.CodeImporter.foundExistingLibrary()
                obj.NextQuestionId='ConfigUpdateMode';
            else


                if obj.Env.CodeImporter.HasSLTest
                    obj.NextQuestionId='CreateTestHarness';
                else
                    obj.NextQuestionId='NextStep';
                    onNext@internal.CodeImporterUI.QuestionBase(obj);
                end
            end

        end

    end
end