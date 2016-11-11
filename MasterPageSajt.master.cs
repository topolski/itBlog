using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            List<Model.Strana> strane1 = Data.DAL.getStrane("4");
            foreach (Model.Strana str in strane1)
            {
                LabelLinkoviSvi.Text += "<li><a href=" + str.Putanja + "><span></span>" + str.ImeStrane + "</a></li>";
            }
            List<Model.Strana> strane2 = Data.DAL.getStrane("2");
            foreach (Model.Strana str in strane2)
            {
                LabelLinkoviAdmin.Text += "<li><a href=" + str.Putanja + "><span></span>" + str.ImeStrane + "</a></li>";
            }
            List<Model.Strana> strane3 = Data.DAL.getStrane("1");
            foreach (Model.Strana str in strane3)
            {
                LabelLinkoviKorisnici.Text += "<li><a href=" + str.Putanja + "><span></span>" + str.ImeStrane + "</a></li>";
            }
            List<Model.Strana> strane4 = Data.DAL.getStrane("3");
            foreach (Model.Strana str in strane4)
            {
                LabelLinkoviAutori.Text += "<li><a href=" + str.Putanja + "><span></span>" + str.ImeStrane + "</a></li>";
            }
            List<Model.Kategorija> kategorije = Data.DAL.getKategorije();
            foreach (Model.Kategorija kat in kategorije)
            {
                LabelKategorije.Text += "<li><a href='rezultat.aspx?k=" + kat.idKategorija + "'>" + kat.Naziv + "</a></li>";
            }
            List<Model.Komentar> komentari = Data.DAL.getPoslednjih5Komentara();
            foreach (Model.Komentar kom in komentari)
            {
                LabelNKomentari.Text += "<div class='recent_post'> "
                                            + " <a href=" + kom.WebSite + ">" + kom.AutorKomentara + " </a> na postu  "
                                            + "<a href='detaljnije.aspx?post=" + kom.idPost + "'> " + kom.Naslov + "</a> "
                                          + " </div>";
            }
        }
    }

    protected void searchbutton_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/rezultat.aspx?kr="+searchfield.Text);
    }
}
