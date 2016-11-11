using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class omeni : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "IT Blog | O meni";
        if (!this.IsPostBack) 
        {
            LabelTextOmeni.Text = "<h3>Milanko Topolski 25/10</h3><p>Rođen sam 20.12.1991. u Beogradu. Živim u Staroj Pazovi gde sam završio i osnovnu školu 2006 godine. "
                                + " Srednju elektrotehničku školu (smer elektrotehničar računara) završio sam 2010 godine u Inđiji. Trenutno studiram na Visokoj ICT školi smer internet tehnologije (treća godina).</p>";

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