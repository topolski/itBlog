using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;

public partial class kontakt : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "IT Blog | Kontakt";

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

            Dictionary<int, string> osobe = new Dictionary<int, string>();
            osobe.Add(0, "Izaberite...");
            osobe.Add(1, "Autora");
            osobe.Add(2, "Administratora");

            DropDownListOsoba.DataSource = osobe;
            DropDownListOsoba.DataTextField = "Value";
            DropDownListOsoba.DataValueField = "Key";
            DropDownListOsoba.DataBind();
            
        }
    }
    
    protected void ButtonPosalji_Click(object sender, EventArgs e)
    {
        if (this.IsValid)
        {
            string imePrezime = TextBoxImePrezime.Text;
            string email = TextBoxEmail.Text;
            string osoba = DropDownListOsoba.SelectedValue;
            string poruka = TextBoxPoruka.Text;
            bool kopija = CheckBoxKopija.Checked;

            BulletedList podaci = new BulletedList();
            podaci.Items.Add(new ListItem(imePrezime));
            podaci.Items.Add(new ListItem(email));
            podaci.Items.Add(new ListItem(osoba));
            podaci.Items.Add(new ListItem(poruka));
            podaci.Items.Add(new ListItem(kopija.ToString()));

            try
            {
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(imePrezime, "Poslato od: " + imePrezime);
                mail.To.Add(new MailAddress(email, "Poslato na mail " + email));
                mail.Subject = "Kontakt";
                mail.Body = "<html><body><p>Ovo je mail poslat sa sajta: </p><p><b>" + poruka + "</b></p></body></html>";
                mail.IsBodyHtml = true;
                mail.Priority = MailPriority.Normal;
                SmtpClient klijent = new SmtpClient("smtp.gmail.com");
                klijent.Credentials = new System.Net.NetworkCredential("sourcekontakt@gmail.com", "pass");
                klijent.Send(mail);
                podaci.Items.Add(new ListItem("E-mail je poslat!"));
            }
            catch
            {
                podaci.Items.Add(new ListItem("E-mail nije poslat!"));
            }

            podaciForma.Controls.Add(podaci);
            podaciForma.Attributes["class"] = "post";
        }
    }
    protected void CustomValidatorOsoba_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (args.Value != "0")
        {
            args.IsValid = true;
        }
        else
        {
            args.IsValid = false;
        }
    }
    protected void CustomValidatorPoruka_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (args.Value.Length > 10)
        {
            args.IsValid = true;
        }
        else
        {
            args.IsValid = false;
        }
    }
}