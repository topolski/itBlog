using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class rezultat : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "IT Blog | Rezultat pretrage";

        if (ClientQueryString == "" || ClientQueryString == "kr=Unesite+klju%u010dnu+re%u010d...")
        {
            Response.Redirect("~/index.aspx");
        }
        else 
        {
            if (!this.IsPostBack)
            {
                string kr = null;
                string upit = "";
                if (Request.QueryString["kr"] != null)
                {
                    kr = Request.QueryString["kr"].ToString();
                    upit = "RezultatNaslov";
                }
                else if (Request.QueryString["k"] != null)
                {
                    kr = Request.QueryString["k"].ToString();
                    upit = "RezultatKategorija";
                }
                else if (Request.QueryString["a"] != null)
                {
                    kr = Request.QueryString["a"].ToString();
                    upit = "RezultatAutor";
                }
                List<Model.Post> postovi = Data.DAL.getPosts(upit, kr);
                LabelPostovi.Text = "<input type='hidden' id='trenutnaStrana_1' /> "
                                 + " <input type='hidden' id='prikazPoStrani_1' /> "
                                 + " <div id='stranicenje'> ";
                foreach (Model.Post post in postovi)
                {
                    if (post.OpisPosta.Length > 230)
                        LabelPostovi.Text += "<div class='post_box'><h2><a href='detaljnije.aspx?post=" + post.idPost + "'>" + post.Naslov + "</a></h2><br/><div class='post_info'><div class='post_date'>Datum:<br/> " + post.Datum.ToString("dd.MM.yyyy.") + "</div> "
                                            + " <div class='post_author'>Autor:<br/> <a href='rezultat.aspx?a=" + post.idAutor + "'>" + post.KorisničkoIme + "</a></div><div class='post_comment'>Komentara:<br/> ?" 
                                            + " </div><div class='cleaner'></div></div><div class='post_body'><table><tr><td><a href='detaljnije.aspx?post=" + post.idPost + "'><img style='margin-right:15px; margin-top:10px;' src=" + post.Slika + " alt=" + post.OpisSlike + " /></a></td><td> "
                                            + " <p>" + post.OpisPosta.ToString().Substring(0, 230) + "...</p></div><div class='continue'><a href='detaljnije.aspx?post=" + post.idPost + "'>Pročitajte više</a></td></tr></table></div></div>";


                    else
                        LabelPostovi.Text += "<div class='post_box'><h2><a href='detaljnije.aspx?post=" + post.idPost + "'>" + post.Naslov + "</a></h2><br/><div class='post_info'><div class='post_date'>Datum:<br/> " + post.Datum.ToString("dd.MM.yyyy.") + "</div> "
                                            + " <div class='post_author'>Autor:<br/> <a href='rezultat.aspx?a=" + post.idAutor + "'>" + post.KorisničkoIme + "</a></div><div class='post_comment'>Komentara:<br/> ?"
                                            + " </div><div class='cleaner'></div></div><div class='post_body'><table><tr><td><a href='detaljnije.aspx?post=" + post.idPost + "'><img style='margin-right:15px; margin-top:10px;' src=" + post.Slika + " alt=" + post.OpisSlike + " /></a></td><td> "
                                            + " <p>" + post.OpisPosta + "...</p></div><div class='continue'><a href='detaljnije.aspx?post=" + post.idPost + "'>Pročitajte više</a></td></tr></table></div></div>";
                }
                LabelPostovi.Text += " </div><div id='strLinkovi_1'></div> ";
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
}