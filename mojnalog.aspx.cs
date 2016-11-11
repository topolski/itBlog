using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class mojnalog : System.Web.UI.Page
{
    private string folderZaFajlove;
    private string uloga;

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "IT Blog | Moj nalog";

        if (!User.Identity.IsAuthenticated) 
        {
            Response.Redirect("index.aspx");
        }

        if (User.IsInRole("admin"))
        {
            Master.FindControl("LabelLinkoviAdmin").Visible = true;
            uloga = "Admin";
        }
        else
        {
            Master.FindControl("LabelLinkoviAdmin").Visible = false;
        }
        if (User.IsInRole("korisnik"))
        {
            Master.FindControl("LabelLinkoviKorisnici").Visible = true;
            uloga = "Korisnik";
        }
        else
        {
            Master.FindControl("LabelLinkoviKorisnici").Visible = false;
        }
        if (User.IsInRole("autor"))
        {
            Master.FindControl("LabelLinkoviAutori").Visible = true;
            uloga = "Autor";
        }
        else
        {
            Master.FindControl("LabelLinkoviAutori").Visible = false;
        }

        if (!this.IsPostBack) 
        {
            Model.Fajl slika = Data.DAL.getSlikaMojNalog(User.Identity.Name);
            if (slika == null)
            {
                LabelMojNalog.Text = "<div class='side_column_section'><div class='OZaAutora'><div class='HZaAutora'>Moj nalog</div><div class='SiTOA'><table><tr><td><p class='PZaA'><img width='80px' height='80px'class='SA' align='left' src='Fajlovi/Slike/Korisnici/bezSlike.jpeg' alt='slikaKorisnika' />Korisničko ime:&nbsp;" + User.Identity.Name + "<br/>Uloga na blogu:&nbsp;" + uloga + "</p></td></tr></table><hr/></div></div></div>";
            }
            else 
            {
                LabelMojNalog.Text = "<div class='side_column_section'><div class='OZaAutora'><div class='HZaAutora'>Moj nalog</div><div class='SiTOA'><table><tr><td><p class='PZaA'><img width='80px' height='80px'class='SA' align='left' src=" + slika.Putanja + " alt='slikaKorisnika' />Korisničko ime:&nbsp;" + User.Identity.Name + "<br/>Uloga na blogu:&nbsp;" + uloga + "</p></td></tr></table><hr/></div></div></div>";
            }
        }

        folderZaFajlove = Path.Combine(Request.PhysicalApplicationPath, "Fajlovi");
    }
    protected void ButtonUplooad_Click(object sender, EventArgs e)
    {
        string relativnaPutanja;

        if (FileUploadSlika.PostedFile.FileName != "")
        {

            string ekstenzija = Path.GetExtension(FileUploadSlika.PostedFile.FileName);
            switch (ekstenzija.ToLower())
            {
                case ".png":
                case ".bmp":
                case ".gif":
                case ".jpg":
                case ".jpeg": break;
                default: Label1.Text = "Niste odabrali sliku!"; return;
            }

            folderZaFajlove += "/Slike/Korisnici/";
            relativnaPutanja = "Fajlovi/Slike/Korisnici/";

            string ime = FileUploadSlika.PostedFile.FileName;
            string celokupnaPutanja = Path.Combine(folderZaFajlove, User.Identity.Name + ekstenzija);
            try
            {
                FileUploadSlika.PostedFile.SaveAs(celokupnaPutanja);
                Label1.Text = "Fajl sa imenom: " + ime;
                Label1.Text += " je uploadovana uspesno u: " + celokupnaPutanja;
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message;
            }
            try
            {
                Label1.Text += "<br/>Broj upisanih redova: " + Data.DAL.upisSlikeKorisnika(User.Identity.Name, relativnaPutanja, ekstenzija).ToString();
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message;
            }
        }
    }
}