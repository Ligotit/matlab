function makeContentType(thisCM)




    fid=thisCM.openFile('getContentType.m');

    fwrite(fid,sprintf('function ct=getContentType(thisComp)\n%%GETCONTENTTYPE returns the type of DocBook element the component makes\n'));
    helpStr=['%    CTYPE=H.GETCONTENTTYPE returns the type of DocBook element',char(10)...
    ,'%    the component creates.  Possible return values are',char(10)...
    ,'%',char(10)...
    ,'%    * ''book'' for a book element.',char(10)...
    ,'%    * ''section'' for chapter, sect1-5, simplesect',char(10)...
    ,'%    * ''titlepage'' for a titlepage',char(10)...
    ,'%    * ''paragraph'' for a paragraph',char(10)...
    ,'%    * ''table'' for any element which can be parented by a',char(10)...
    ,'%              section or paragraph.  Works for tables, lists,',char(10)...
    ,'%              programlistings, etc.',char(10)...
    ,'%    * ''text'' for CDATA, links, or any other character mix',char(10)...
    ,'%             which can not stand alone in a section and must',char(10)...
    ,'%             be embedded in a paragraph.',char(10)...
    ,'%    * '''' for anything which either does not insert content into',char(10)...
    ,'%         the report or inserts content which can live anywhere.',char(10)...
    ,'%         (such as linking anchors or comments)',char(10)...
    ,'%    ',char(10)...
    ,'%    This method is heavily used by checkComponentTree to make sure',char(10)...
    ,'%    that the component hierarchy will produce valid DocBook.',char(10)];

    fwrite(fid,helpStr);

    thisCM.writeHeader(fid);

    fprintf(fid,'ct='''';\n');

    fclose(fid);

    thisCM.viewFile('getContentType.m',3);