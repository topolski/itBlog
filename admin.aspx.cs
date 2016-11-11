using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Web.Services;

public partial class admin : System.Web.UI.Page
{
    private string folderZaFajlove;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "IT Blog | Admin panel";

        divMsg.Visible = false;

        if (!this.IsPostBack) 
        {
            if (User.IsInRole("admin"))
            {
                Master.FindControl("LabelLinkoviAdmin").Visible = true;
            }
            else
            {
                Response.Redirect("index.aspx");
                Master.FindControl("LabelLinkoviAdmin").Visible = false;
            }

            if (Request.QueryString["pid"] != null) 
            {
                hidPollID.Value = Request.QueryString["pid"]; 
                ShowExistingPoll();
            }
        }

        folderZaFajlove = Path.Combine(Request.PhysicalApplicationPath, "Fajlovi");
    }
    protected void DetailsViewPostovi_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        GridViewPostovi.DataBind();
    }
    protected void DetailsViewPostovi_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
    {
        GridViewPostovi.DataBind();
        GridViewTekstovi.DataBind();
        GridViewPK.DataBind();
    }
    protected void DetailsViewPostovi_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        Calendar datum = (Calendar)DetailsViewPostovi.FindControl("Calendar1");
        DateTime dt = Convert.ToDateTime(datum.SelectedDate.ToShortDateString());
        TimeSpan ts = new TimeSpan(DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second);
        dt = dt.Add(ts);
        SqlDataSourcePostoviDetails.InsertParameters["Datum"].DefaultValue = dt.ToShortTimeString();
    }
    protected void DetailsViewPostovi_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        GridViewPostovi.DataBind();
    }
    protected void DetailsViewDetaljiOAutoru_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
    {
        GridViewAutori.DataBind();
        GridViewPostovi.DataBind();
    }
    protected void DetailsViewDetaljiOAutoru_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        GridViewAutori.DataBind();
    }
    protected void DetailsViewDetaljiOAutoru_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        GridViewAutori.DataBind();
    }
    protected void DetailsViewDOTekstovima_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
    {
        GridViewTekstovi.DataBind();
    }
    protected void DetailsViewDOTekstovima_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        GridViewTekstovi.DataBind();
    }
    protected void DetailsViewDOTekstovima_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        GridViewTekstovi.DataBind();
    }
    protected void DetailsViewKategorije_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
    {
        GridViewKategorije.DataBind();
    }
    protected void DetailsViewKategorije_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        GridViewKategorije.DataBind();
    }
    protected void DetailsViewKategorije_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        GridViewKategorije.DataBind();
    }
    protected void DetailsViewPK_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
    {
        GridViewPK.DataBind();
    }
    protected void DetailsViewPK_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        GridViewPK.DataBind();
    }
    protected void DetailsViewPK_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        GridViewPK.DataBind();
    }
    protected void DetailsViewDKA_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
    {
        GridViewKA.DataBind();
    }
    protected void DetailsViewDKA_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        GridViewKA.DataBind();
    }
    protected void DetailsViewDKA_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        GridViewKA.DataBind();
    }
    protected void ButtonUploadFajla_Click(object sender, EventArgs e)
    {
        string relativnaPutanja;
        string idPost = null;

        if (FileUploadFajl.PostedFile.FileName == "" || TextBoxNazivFajla.Text == "" || TextBoxOpisFajla.Text == "")
        {
            LabelInfo.Text = "Niste dobro popunili stavke za upload!";
        }
        else
        {
            string ekstenzija = Path.GetExtension(FileUploadFajl.PostedFile.FileName);
            switch (ekstenzija.ToLower())
            {
                case ".png":
                case ".bmp":
                case ".gif":
                case ".jpg":
                case ".jpeg": 
                case ".zip":
                case ".rar":
                case ".aspx":
                case ".cs": break;
                default: LabelInfo.Text = "Niste odabrali odgovarajući fajl!"; return;
            }

            if (RadioButtonListFilter.SelectedValue.ToString() == "autor")
            {
                folderZaFajlove += "/Slike/Autori/";
                relativnaPutanja = "Fajlovi/Slike/Autori/";
            }
            else if (RadioButtonListFilter.SelectedValue.ToString() == "post")
            {
                folderZaFajlove += "/Slike/Postovi/V/";
                relativnaPutanja = "Fajlovi/Slike/Postovi/V/";
                idPost = DropDownListPost.SelectedValue.ToString();
            }
            else if (RadioButtonListFilter.SelectedValue.ToString() == "kod")
            {
                folderZaFajlove += "/Kodovi/";
                relativnaPutanja = "Fajlovi/Kodovi/";
            }
            else if (RadioButtonListFilter.SelectedValue.ToString() == "stranica")
            {
                folderZaFajlove = Request.PhysicalApplicationPath;
                relativnaPutanja = "";
            }
            else 
            {
                LabelInfo.Text = "Niste odabrali stavku radioButtonListe!!!";
                return;
            }

            string ime = TextBoxNazivFajla.Text;
            string celokupnaPutanja = Path.Combine(folderZaFajlove, ime + ekstenzija);
            try
            {
                FileUploadFajl.PostedFile.SaveAs(celokupnaPutanja);
                LabelInfo.Text = "Fajl sa imenom: " + ime + ekstenzija;
                LabelInfo.Text += " je uploadovana uspesno u: " + celokupnaPutanja;
            }
            catch (Exception ex)
            {
                LabelInfo.Text = ex.Message;
            }
            try
            {
                LabelInfo.Text += "<br/>Broj upisanih redova: " +Data.DAL.upisFajla(User.Identity.Name, relativnaPutanja, Int32.Parse(idPost), ekstenzija, TextBoxOpisFajla.Text, ime).ToString();
            }
            catch (Exception ex)
            {
                LabelInfo.Text = ex.Message;
            }
        }
    }

    private void ShowExistingPoll()
    {

        Poll objPoll = new Poll();
        DataSet dsPoll = objPoll.SelectPoll(int.Parse(hidPollID.Value));

        if (dsPoll.Tables[0].Rows.Count > 0)
        {
            txtQuestion.Text = dsPoll.Tables[0].Rows[0]["Question"].ToString();
            string blockMode = dsPoll.Tables[0].Rows[0]["BlockMode"].ToString();
            if (blockMode == Poll.BlockMode.COOKIE.ToString())
                rdoCookie.Checked = true;
            else if (blockMode == Poll.BlockMode.IP_ADDRESS.ToString())
                rdoIP.Checked = true;
            else
                rdoNone.Checked = true;
            chkActive.Checked = bool.Parse(dsPoll.Tables[0].Rows[0]["Active"].ToString());

            ShowChoices(dsPoll.Tables[1]);
            hidRowIndex.Value = dsPoll.Tables[1].Rows.Count.ToString();
            btnSave.Text = "Ažuriraj anketu";
        }
        else 
        {
            hidPollID.Value = "";
            btnSave.Text = "Sačuvaj anketu";
        }
    }

    private void ShowChoices(DataTable dtChoice)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<table id='tableChoices' width='100%'>\n");
        for (int i = 0; i < dtChoice.Rows.Count; i++)
        {
            sb.Append("<tr id='pRow").Append(i).Append("'>\n");
            sb.Append("<td width='200' class='tdLabel'>Odgovor ").Append(i+1).Append("</td>\n");
            sb.Append("<td><input type='hidden' id='hidPollChoiceID").Append(i).Append("' name='hidPollChoiceID").Append(i).Append("' Value='").Append(dtChoice.Rows[i]["PollChoiceID"]).Append("' />\n");
            sb.Append("<input type='text' class='text' id='txtChoice").Append(i).Append("' name='txtChoice").Append(i).Append("' value='").Append(dtChoice.Rows[i]["Choice"]).Append("'/>&nbsp;\n");
            sb.Append("<a href='#' onclick='removeFormField(\"#pRow").Append(i).Append("\");return false;'>Obriši</a></td>\n");
            sb.Append("</tr>");
        }
        sb.Append("</table>");
        hidRowIndex.Value = dtChoice.Rows.Count.ToString();
        divChoices.InnerHtml = sb.ToString();
    }

    protected void rptChoices_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            if (e.Item.ItemIndex <= 1) 
                e.Item.FindControl("linkRemove").Visible = false;
            else if (e.Item.ItemIndex > 1) 
            {
                ((RequiredFieldValidator)e.Item.FindControl("rqvChoice")).Visible = false;
            }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (txtQuestion.Text != "")
        {
            Poll objPoll = new Poll();
            int pollID = 0;

            string blockMode;
            if (rdoCookie.Checked)
                blockMode = Poll.BlockMode.COOKIE.ToString();
            else if (rdoIP.Checked)
                blockMode = Poll.BlockMode.IP_ADDRESS.ToString();
            else
                blockMode = Poll.BlockMode.NONE.ToString();


            if (hidPollID.Value == string.Empty)
            {
                pollID = objPoll.InsertPoll(txtQuestion.Text.Trim(), blockMode, chkActive.Checked);


                if (pollID > 0)
                {
                    hidPollID.Value = pollID.ToString();
                    divMsg.InnerHtml = "<b>Obaveštenje:</b> Nova anketa je uspešno dodata.";
                    divMsg.Visible = true;

                    GridViewListaAnketa.DataBind();
                }
            }
            else
            {
                pollID = int.Parse(hidPollID.Value);
                objPoll.UpdatePoll(pollID, txtQuestion.Text.Trim(), blockMode, chkActive.Checked);

                divMsg.InnerHtml = "<b>Obaveštenje:</b> Vaša anketa je izmenjena uspešno.";
                divMsg.Visible = true;
            }

            if (pollID > 0)
            {
                InsertUpdateChoices(pollID);
                ShowExistingPoll();
            }
            else
            {
                divMsg.InnerHtml = "<b>Greška:</b> Došlo je do greške, anketa ne može biti snimljena.";
                divMsg.Attributes.Add("class", "mWarn");
                divMsg.Visible = true;
            }
        }
        else 
        {
            divMsg.InnerHtml = "<b>Pitanje je obavezno.</b>";
            divMsg.Visible = true;
        }
    }

    private void InsertUpdateChoices(int pollID)
    {
        Poll objPoll = new Poll();
        
        foreach (string key in Request.Form)
        {
            if (key.IndexOf("txtChoice") >= 0)
            {
                string hidPollChoiceID = "hidPollChoiceID" + key.Substring(key.Length - 1, 1);
                int choiceID = 0;
                if (Request.Form[hidPollChoiceID] != null && int.TryParse(Request.Form[hidPollChoiceID], out choiceID))
                {
                    if (Request.Form[key].Trim().Length > 0) 
                        objPoll.UpdateChoice(choiceID, Request.Form[key]);
                    else 
                        objPoll.DeleteChoice(choiceID);
                }
                else if (Request.Form[key].Trim().Length > 0)
                {
                    objPoll.InsertChoice(pollID, Request.Form[key].Trim());
                }
            }
        }
    }

    [WebMethod]
    public static int DeletePollChoice(int cID)
    {
        Poll objPoll = new Poll();
        return objPoll.DeleteChoice(cID);
    }
    protected void RadioButtonListFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RadioButtonListFilter.SelectedValue.ToString() == "post")
        {
            DropDownListPost.Visible = true;
            LabelIdPost.Visible = true;
        }
        else
        {
            DropDownListPost.Visible = false;
            LabelIdPost.Visible = false;
        }
    }
}