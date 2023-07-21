

function finalJson=customJSONHelper(obj,uiJsonSid,uiJsonCodeLines,...
    msg,uiJsonCommentThread)


    uiJsonCommentThreadTable=[];
    if(~isequal(uiJsonCommentThread.Size,0))
        for i=1:uiJsonCommentThread.Size
            modifiedJsonCommentThread.summary=uiJsonCommentThread(i).summary;
            modifiedJsonCommentThread.user=uiJsonCommentThread(i).user;
            modifiedJsonCommentThread.description=uiJsonCommentThread(i).description;
            modifiedJsonCommentThread.timeStamp=datetime(uiJsonCommentThread(i).timeStamp,...
            'InputFormat','dd-MMM-yyyy HH:mm:ss','Locale','en_US','Format','dd-MMM-yyyy HH:mm:ss');
            modifiedJsonCommentThread.updatedDescription=false;
            modifiedJsonCommentThread.id=i;
            uiJsonCommentThreadTable=[uiJsonCommentThreadTable,modifiedJsonCommentThread];
        end

        if numel(uiJsonCommentThreadTable)>1
            finalJson=struct('BlockSID',uiJsonSid,'loggedInUser',obj.getUsername...
            ,'CodeLines',uiJsonCodeLines,'JustificationLog',{uiJsonCommentThreadTable},...
            'dataFor',msg.dataFor,...
            'MsgForJustificationDialog',obj.getMsgForJustificationDialog,...
            'newJustification','');
        else
            finalJson=struct('BlockSID',uiJsonSid,'loggedInUser',obj.getUsername,...
            'CodeLines',uiJsonCodeLines,'JustificationLog',{{uiJsonCommentThreadTable}},...
            'dataFor',msg.dataFor,...
            'MsgForJustificationDialog',obj.getMsgForJustificationDialog,...
            'newJustification','');
        end
    else
        finalJson=struct('BlockSID',uiJsonSid,'loggedInUser',obj.getUsername,...
        'CodeLines',uiJsonCodeLines,'JustificationLog',{uiJsonCommentThreadTable},...
        'dataFor',msg.dataFor,...
        'MsgForJustificationDialog',obj.getMsgForJustificationDialog,...
        'newJustification','');
    end
end
