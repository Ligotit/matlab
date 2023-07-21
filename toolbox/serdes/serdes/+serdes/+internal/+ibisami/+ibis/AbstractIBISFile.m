classdef(Abstract)AbstractIBISFile<handle&matlab.mixin.Heterogeneous




























    events
FileChanged
    end
    properties(Constant,Hidden)
        NA="NA"
    end
    properties(Access=private)
        HiddenModels=string.empty
    end
    properties(SetAccess=protected)

        IBISVersion(1,1){mustBeReal,mustBeFinite}=6.1
        FileRev(1,1){mustBeReal,mustBeFinite}=0.1
        Source(1,1)string=""
        Notes(1,1)string="Use this section for any special notes related to the file."
        Disclaimer(1,1)string=""
        Copyright(1,1)string="Copyright , All Rights Reserved"
        Component{serdes.utilities.mustBeA(Component,'serdes.internal.ibisami.ibis.AbstractIBISComponent'),...
        serdes.utilities.mustBeScalarOrEmpty}...
        =serdes.internal.ibisami.ibis.SerDesIBISComponent.empty
        Models(1,:){serdes.utilities.mustBeA(Models,'serdes.internal.ibisami.ibis.AbstractIBISModel')}...
        =serdes.internal.ibisami.ibis.AbstractIBISModel.empty
    end

    properties
        FileName(1,1)string="serdes.ibs";
        dirty(1,1)logical=true;
    end
    methods(Access=protected)
        function fileChanged(ibs)
            ibs.dirty=true;
            ibs.notify('FileChanged')
        end
    end
    methods
        function set.FileName(ibs,fileName)
            ibs.FileName=fileName;
            ibs.fileChanged
        end
        function writeIBISFile(ibisFile,path)


            fid=fopen(fullfile(path,ibisFile.FileName),'w');
            ibisString=ibisFile.getIBISString;
            fprintf(fid,'%s',ibisString);
            fclose(fid);
        end
        function ibisString=getIBISString(ibisFile,prettyPrint)
            if nargin<2
                prettyPrint=false;
            end
            ibisString="|***************************************************************************"+newline+...
            "| SerDes IBIS-AMI model generated by MathWorks SerDes Toolbox"+newline+...
            "|***************************************************************************"+newline;
            ibisString=ibisString+string(sprintf('[IBIS Ver]     %.1f\n',ibisFile.IBISVersion));
            ibisString=ibisString+string(sprintf('[File Name]    %s\n',ibisFile.FileName));
            ibisString=ibisString+string(sprintf('[Date]         %s\n',date));
            ibisString=ibisString+string(sprintf('[File Rev]     %.1f\n',ibisFile.FileRev));
            ibisString=ibisString+string(sprintf('[Source]       %s\n',ibisFile.Source));
            ibisString=ibisString+"|"+newline;
            ibisString=ibisString+string(sprintf('[Notes]        %s\n',ibisFile.Notes));
            ibisString=ibisString+"|"+newline;
            ibisString=ibisString+string(sprintf('[Disclaimer]   %s\n',ibisFile.Disclaimer));
            ibisString=ibisString+"|"+newline;
            ibisString=ibisString+string(sprintf('[Copyright]    %s\n',ibisFile.Copyright));
            ibisString=ibisString+"|"+newline;
            if~isempty(ibisFile.Component)
                ibisString=ibisString+ibisFile.Component.getIBISString(prettyPrint);
            end
            if~isempty(ibisFile.Models)
                for modelNum=1:numel(ibisFile.Models)
                    model=ibisFile.Models(modelNum);
                    ibisString=ibisString+model.getIBISString(prettyPrint);
                end
            end
            ibisString=ibisString+string(sprintf('[End]\n'));
        end
    end
end
