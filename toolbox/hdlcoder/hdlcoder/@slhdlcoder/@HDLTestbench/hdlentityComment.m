function hdlcode=hdlentityComment(this,node,level,nname)



    comment_char=hdlgetparameter('comment_char');
    separatorline=[comment_char,' ','-'*ones(1,63-length(comment_char)),'\n'];

    if hdlgetparameter('datecomment')==1
        createdate=[comment_char,' Created: ',datestr(now,31),'\n'];
    else
        createdate='';
    end
    rcs_cvs_tag=hdlgetparameter('rcs_cvs_tag');

    pathstr=fileparts(fullfile(this.CodeGenDirectory,...
    [this.TestBenchName,this.TBFileNameSuffix]));
    fp=strrep(pathstr,'\','\\');
    dispname=strrep(fp,char(10),'_');

    slVer=hdlgetparameter('tool_file_comment');

    hdlcode=[...
    separatorline,...
    comment_char,'\n',...
    comment_char,' Module: ',nname,'\n',...
    comment_char,' Path: ',dispname,'\n',...
    createdate,...
    slVer,...
    comment_char,' Hierarchy Level:',sprintf(' %d',level),'\n',...
    comment_char,'\n',...
    rcs_cvs_tag,...
    comment_char,'\n',...
    separatorline,...
    hdlannotationcomments(node)];

