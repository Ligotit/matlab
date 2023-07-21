classdef Format<Rptgen.TitlePage.PDF.Format




    methods

        function this=Format()
            this@Rptgen.TitlePage.PDF.Format('recto');
            this.IncludeElements=...
            {
            Rptgen.TitlePage.PDF.Recto.Title(),...
            Rptgen.TitlePage.PDF.Recto.Subtitle(),...
            Rptgen.TitlePage.PDF.Recto.Author(),...
            Rptgen.TitlePage.PDF.Recto.Image(),...
            Rptgen.TitlePage.PDF.Recto.Copyright(),...
            Rptgen.TitlePage.PDF.Recto.PubDate(),...
            Rptgen.TitlePage.PDF.Recto.LegalNotice(),...
            Rptgen.TitlePage.PDF.Recto.Abstract()
            };
        end

    end

end
