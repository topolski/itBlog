using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class registracija : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.IsInRole("korisnik") || User.IsInRole("autor")) 
        {
            Response.Redirect("~/index.aspx");
        }
        this.Title = "IT Blog | Registracija";

        if (!this.IsPostBack) 
        {
            if (User.IsInRole("admin"))
            {
                Master.FindControl("LabelLinkoviAdmin").Visible = true;
            }
            else
            {
                Master.FindControl("LabelLinkoviAdmin").Visible = false;
            }
        }
    }
    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
    {
        Roles.AddUserToRole(CreateUserWizard1.UserName, "korisnik");
    }
}