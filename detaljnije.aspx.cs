using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class detaljnije : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "IT Blog | Detaljnije";

        if (Request.QueryString.ToString() == "") 
        {
            Response.Redirect("index.aspx");
        }

         if (User.Identity.IsAuthenticated == true)
         {
             TextBoxIme.Enabled = false;
             TextBoxIme.Text = User.Identity.Name;
         }
         else
         {
             TextBoxIme.Enabled = true;
         }

         if (!this.IsPostBack)
         {
             string id = Request.QueryString["post"].ToString();
             string brojKomentara = Data.DAL.getBrKomentara(id);
             List<Model.Post> postovi = Data.DAL.getPost(id);
             foreach (Model.Post post in postovi)
             {
                 LabelDetaljnijeOpis.Text = "<div class='post_boxDetaljnije'><h2>" + post.Naslov + "</h2><br/><div class='post_info'><div class='post_date'>Datum:<br/> " + post.Datum.ToString("dd.MM.yyyy.") + "</div> "
                                             + " <div class='post_author'>Autor:<br/> <a href='rezultat.aspx?a=" + post.idAutor + "'>" + post.KorisničkoIme + "</a></div><div class='post_comment'>Komentara:<br/>" + brojKomentara + "</div><div class='cleaner'></div></div></div>";

                 LabelOAutoru.Text = "<div class='side_column_section'><div class='OZaAutora'><div class='HZaAutora'>O autoru</div><div class='SiTOA'><table><tr><td><p class='PZaA'><img class='SA' align='left' src=" + post.SlikaAutora + " alt='slikaAutora' />" + post.TekstOAutoru + "</p></td></tr></table><hr/><p>Kontakt:</p><a href=" + post.WebSite + ">Web site</a><br/><a href=" + post.Facebook + ">Facebook profil</a><br/><a href=" + post.LinkedIn + ">LinkedIn profil</a><br/><a href=" + post.Twitter + ">Twitter profil</a></div></div></div><div class='cleaner_h30'>&nbsp;</div>";

                 LabelDetaljnijeTekst.Text += " <br/><div class='post_boxDetaljnije'><div class='post_body'><h3>" + post.Podnaslov + "</h3> "
                                         + " <p>" + post.Teskt + "</p></div></div>";

                 LabelPDF.Text = "<a href='Fajlovi/Postovi PDF/" + post.Naslov + ".pdf'>" + post.Naslov + "</a>";
             }

             List<Model.Fajl> slike = Data.DAL.getSlike(id);
             foreach (Model.Fajl slika in slike)
             {
                 LabelSlike.Text += "<div class='image'><a href='" + slika.Putanja + "'><img src='" + slika.Putanja + "' alt='" + slika.OpisFajla + "' height='300' width='450' /></a></div></br>";
             }

             List<Model.Komentar> komentari = Data.DAL.getKomentare(id);
             foreach (Model.Komentar kom in komentari)
             {
                 LabelDetaljnijeKomentari.Text += "<table class='komentari' style='width: 100%; border-width:1px; border-style:dotted; border-color:grey;'><tr><td rowspan='2' style='width:100px;'><img width='80px' height='80px' src=" + kom.Putanja + " alt='SlikaAutoraKomentara' style='margin:10px;' /></td> "
                                                   + " <td><p>Napisao:&nbsp;<a href=" + kom.WebSite + ">" + kom.AutorKomentara + "</a></p><p>Dana:&nbsp;" + kom.Datum.ToString("dd.MM.yyyy. u HH:mm") + "</p></td></tr><tr><td></td><td></td></tr><tr><td colspan='3'><p style='margin:0px 10px 10px 10px;'>&nbsp;&nbsp;&nbsp;&nbsp;" + kom.Koment + "</p></td></tr></table><br />";
             }

             if (User.IsInRole("admin"))
             {
                 Master.FindControl("LabelLinkoviAdmin").Visible = true;
             }
             else
             {
                 Master.FindControl("LabelLinkoviAdmin").Visible = false;
             }
             if (User.IsInRole("korisnik"))
             {
                 Master.FindControl("LabelLinkoviKorisnici").Visible = true;
             }
             else
             {
                 Master.FindControl("LabelLinkoviKorisnici").Visible = false;
             }
             if (User.IsInRole("autor"))
             {
                 Master.FindControl("LabelLinkoviAutori").Visible = true;
             }
             else
             {
                 Master.FindControl("LabelLinkoviAutori").Visible = false;
             }
         }
    }
    
    protected void ButtonDodajKomentar_Click(object sender, EventArgs e)
    {
        List<string> korisniciSaSlikom = Data.DAL.getKorisnikeSaSlikom();

        if (this.IsValid)
        {
            string imeZaSliku = "";
            string ime = TextBoxIme.Text; 
            string email = TextBoxEmail.Text;
            string site = TextBoxSite.Text;
            string komentar = TextBoxKomentar.Text;
            string id = Request.QueryString["post"].ToString();

            if (User.Identity.Name != "")
            {
                foreach (string korisnik in korisniciSaSlikom)
                {
                    if (User.Identity.Name == korisnik)
                    {
                        imeZaSliku = User.Identity.Name;
                        break;
                    }
                }
                if (User.Identity.Name != imeZaSliku)
                {
                    imeZaSliku = "nemaSlike";
                }
            }
            else
            {
                imeZaSliku = "nemaSlike";
            }

            Data.DAL.ubaciKomentar(ime, email, site, komentar, id, imeZaSliku);

            if (User.Identity.IsAuthenticated == true)
            {
                TextBoxIme.Text = User.Identity.Name;
            }
            else 
            {
                TextBoxIme.Text = "";
            }
            TextBoxEmail.Text = "";
            TextBoxSite.Text = "";
            TextBoxKomentar.Text = "";
            LabelDetaljnijeKomentari.Text = "";

            List<Model.Komentar> komentari = Data.DAL.getKomentare(id);
            foreach (Model.Komentar kom in komentari)
            {
                LabelDetaljnijeKomentari.Text += "<table class='komentari' style='width: 100%; border-width:1px; border-style:dotted; border-color:grey;'><tr><td rowspan='2' style='width:100px;'><img width='80px' height='80px' src=" + kom.Putanja + " alt='SlikaAutoraKomentara' style='margin:10px;' /></td> "
                                                  + " <td><p>Napisao:&nbsp;<a href=" + kom.WebSite + ">" + kom.AutorKomentara + "</a></p><p>Dana:&nbsp;" + kom.Datum.ToString("dd.MM.yyyy. u HH:mm") + "</p></td></tr><tr><td></td><td></td></tr><tr><td colspan='3'><p style='margin:0px 10px 10px 10px;'>&nbsp;&nbsp;&nbsp;&nbsp;" + kom.Koment + "</p></td></tr></table><br />";
            }
        }
    }
}