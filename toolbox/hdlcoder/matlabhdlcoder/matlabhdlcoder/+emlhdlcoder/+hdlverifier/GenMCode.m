


classdef GenMCode<handle


    properties
        mText;
        mFileName;
        mFid=-1;
        mIndentLevel=0;


        bufferText;
    end


    methods
        function this=GenMCode(aFileName)
            this.mText='';



            if nargin==0
                this.mFid=-1;
                return;
            end

            this.mFileName=aFileName;
            this.mFid=fopen(aFileName,'w');
            if this.mFid<0
                error('hdlcoder:hdlverifier:CannotOpenFile','Cannot open file %s',aFileName);
            end
        end
        function delete(this)
            if this.mFid>0
                if~isempty(this.mText)
                    fwrite(this.mFid,this.mText);
                end
                fclose(this.mFid);
            end
        end
        function appendCode(this,text)

            if this.mIndentLevel>0
                text=[repmat('   ',1,this.mIndentLevel),text];
            end

            this.mText=[this.mText,text,char(10)];
        end
        function prependCode(this,text)
            this.mText=[text,char(10),this.mText];
        end
        function addComment(this,comment)
            text=['% ',comment];
            appendCode(this,text);
        end

        function addNewLine(this)
            this.mText=[this.mText,char(10)];
        end

        function addFuncDecl(this,varargin)
            newCode=l_getFuncCode(varargin{:});
            newCode=['function ',newCode];
            appendCode(this,newCode);
        end

        function addExecFunction(this,varargin)
            newCode=l_getFuncCode(varargin{:});
            newCode=[newCode,';'];
            appendCode(this,newCode);
        end

        function addIfStatement(this,condition)
            newCode=['if ',condition];
            appendCode(this,newCode);
            this.mIndentLevel=this.mIndentLevel+1;
        end

        function addElseIfStatement(this,condition)
            this.mIndentLevel=this.mIndentLevel-1;
            newCode=['elseif ',condition];
            appendCode(this,newCode);
            this.mIndentLevel=this.mIndentLevel+1;
        end

        function addElseStatement(this)
            this.mIndentLevel=this.mIndentLevel-1;
            newCode='else ';
            appendCode(this,newCode);
            this.mIndentLevel=this.mIndentLevel+1;
        end

        function addEndStatement(this)
            this.mIndentLevel=this.mIndentLevel-1;
            appendCode(this,'end');
        end

        function addGeneratedHeader(this)
            mver=ver('matlab');
            sver=ver('hdlcoder');
            text=['Generated by MATLAB ',mver.Version,' and HDL Coder ',sver.Version];
            addComment(this,text);
        end

        function addIndent(this,level)
            if nargin==1
                level=1;
            end
            this.mIndentLevel=this.mIndentLevel+level;
        end
        function reduceIndent(this,level)
            if nargin==1
                level=1;
            end
            this.mIndentLevel=this.mIndentLevel-level;
        end

        function addPersistentVarDecl(this,varName)
            newCode=['persistent ',varName,';'];
            appendCode(this,newCode);
        end
        function addIsEmptyTest(this,varName)
            newCode=['isempty(',varName,')'];
            addIfStatement(this,newCode);
        end

        function addAssignVar(this,varName,varValue)
            if iscell(varValue)
                varValue=l_printCellArray(varValue);
            elseif ischar(varValue)
                varValue=l_printChar(varValue);
            elseif isnumeric(varValue)
                varValue=mat2str(varValue);
            elseif islogical(varValue)
                varValue=l_printLogical(varValue);
            end

            newCode=[varName,' = ',varValue,';'];
            appendCode(this,newCode);
        end

        function addPersistentVar(this,varName)
            newCode=['persistent ',varName,';'];
            this.appendCode(newCode);
        end


        function appendToBufferStore(this,txt)
            this.bufferText=[this.bufferText,txt];
        end




        function flushBuffer(this)
            if~isempty(this.bufferText)
                this.appendCode(this.bufferText);
            end
            this.bufferText=[];
        end
    end

end


function r=l_printList(list,useBracket)

    if~iscell(list)
        list={list};
    end

    r='';
    for m=1:numel(list)
        tmp=list{m};
        if ischar(tmp)
            r=[r,tmp,','];%#ok<AGROW>
        elseif isnumeric(tmp)
            r=[r,mat2str(tmp),','];%#ok<AGROW>
        elseif islogical(tmp)
            if tmp
                r=[r,'true,'];%#ok<AGROW>
            else
                r=[r,'false,'];%#ok<AGROW>
            end
        end
    end
    r(end)=[];

    if nargin==2
        if strcmpi(useBracket,'{')||strcmpi(useBracket,'}')
            r=['{',r,'}'];
        elseif strcmpi(useBracket,'(')||strcmpi(useBracket,')')
            r=['(',r,')'];
        elseif strcmpi(useBracket,'[')||strcmpi(useBracket,']')
            if numel(list)>1
                r=['[',r,']'];
            end
        end
    end
end

function newCode=l_getFuncCode(fcnName,invar,outvar)
    if nargin<3
        outvar=[];
    end
    if nargin<2
        invar=[];
    end

    if numel(invar)>0
        argList=l_printList(invar);
        argList=['(',argList,')'];
    else
        argList='';
    end

    if numel(outvar)>0
        outList=l_printList(outvar,'[');
        outList=[outList,' = '];
    else
        outList='';
    end

    newCode=[outList,fcnName,argList];

end


function r=l_printCellArray(cellarray)
    r='{';
    for m=1:numel(cellarray)
        tmp=cellarray{m};
        if ischar(tmp)
            r=[r,'''',tmp,''','];%#ok<AGROW>
        elseif isnumeric(tmp)
            r=[r,num2str(tmp),','];%#ok<AGROW>
        elseif islogical(tmp)
            if tmp
                r=[r,'true,'];
            else
                r=[r,'false,'];
            end
        end
    end
    r(end)=[];
    r=[r,'}'];
end

function r=l_printChar(text)
    nline=length(strfind(text,char(10)))+1;
    if nline>1
        tmp=strrep(text,char(10),[''' char(10) ...',char(10),'    ''']);
        r=['[....',char(10),'    ''',tmp,''']'];
    else
        r=['''',text,''''];
    end
end

function r=l_printLogical(varValue)
    if length(varValue)==1
        if varValue
            r='true';
        else
            r='false';
        end
    else
        r='[';
        for m=1:length(varValue)
            if varValue(m)
                r=[r,'true'];
            else
                r=[r,'false'];
            end
            r=[r,','];
        end
        r(end)=']';
    end

end
