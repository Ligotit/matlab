function lines=getHtmlIncludeLines()




    lines=[...
    "<link rel=""stylesheet"" href=""/toolbox/shared/comparisons/web/templates/text/css/report.css"" />",...
    "<link rel=""stylesheet"" href=""/toolbox/shared/comparisons/web/templates/text/css/merge.css"" />",...
    "<script type=""text/javascript"" src=""/toolbox/shared/comparisons/web/templates/text/js/report.js""></script>",...
"<script type=""text/javascript"" src=""/toolbox/shared/comparisons/web/templates/text/js/merge.js""></script>"...
    ];
    lines=lines.cellstr();
end