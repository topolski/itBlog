using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.Text;

public partial class Autor : System.Web.UI.Page
{
    private string folderZaFajlove;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "IT Blog | AD autor";

        if (!this.IsPostBack)
        {
            if (User.IsInRole("autor"))
            {
                Master.FindControl("LabelLinkoviAutori").Visible = true;
                SqlDataSourcePostovi.SelectParameters["ime"].DefaultValue = User.Identity.Name;
                SqlDataSourcePostovi.DataBind();
            }
            else
            {
                Response.Redirect("index.aspx");
                Master.FindControl("LabelLinkoviAutori").Visible = false;
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

            folderZaFajlove += "/Slike/Postovi/V/";
            relativnaPutanja = "Fajlovi/Slike/Postovi/V/";

            string ime = FileUploadSlika.PostedFile.FileName;
            string celokupnaPutanja = Path.Combine(folderZaFajlove, ime);
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
                int idPost = Int32.Parse(DropDownListPost.SelectedValue.ToString());
                Label1.Text += "<br/>Broj upisanih redova: " + Data.DAL.upisSlikeZaPost(User.Identity.Name, relativnaPutanja, idPost, ime).ToString();
            }
            catch (Exception ex)
            {
                Label1.Text = ex.Message;
            }
        }
    }
    protected void DetailsViewPostovi_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
    {
        GridViewPostovi.DataBind();
    }
    protected void DetailsViewPostovi_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        GridViewPostovi.DataBind();
    }
    protected void DetailsViewPostovi_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        Model.Post post = Data.DAL.getPostAutor(User.Identity.Name);
        SqlDataSourcePostoviDetails.UpdateParameters["idAutor"].DefaultValue = post.idAutor.ToString();
    }
    protected void DetailsViewPostovi_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        GridViewPostovi.DataBind();
    }
    protected void DetailsViewPostovi_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        Model.Post post = Data.DAL.getPostAutor(User.Identity.Name);
        SqlDataSourcePostoviDetails.InsertParameters["idAutor"].DefaultValue = post.idAutor.ToString();
        Calendar datum = (Calendar)DetailsViewPostovi.FindControl("Calendar1");
        DateTime dt = Convert.ToDateTime(datum.SelectedDate.ToShortDateString());
        TimeSpan ts = new TimeSpan(DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second);
        dt = dt.Add(ts);
        SqlDataSourcePostoviDetails.InsertParameters["Datum"].DefaultValue = dt.ToShortTimeString();
    }
    protected void DetailsViewDOTekstovima_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
    {
        GridViewTekst.DataBind();
    }
    protected void DetailsViewDOTekstovima_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        GridViewTekst.DataBind();
        lblMessage.Text = GridViewPostovi.SelectedDataKey.Value.ToString();
        
        string text1 = "";
        string text2 = "";
        string post = "";
        string idPost = GridViewPostovi.SelectedDataKey.Value.ToString();
        List<Model.Post> postovi = Data.DAL.getPost(idPost);
        foreach (Model.Post po in postovi)
        {
            post = po.Naslov.ToString();
            text1 = "<h2>" + post + "<h2>";
            text2 += "<h3>" + po.Podnaslov + "</h3><br/> " + " <h4>" + po.Teskt + "</h4><br/>";
        }
        
        string path = Server.MapPath("~/Fajlovi/Postovi PDF/");
        string fileName = post + ".pdf";
        Document doc = new Document();
        try
        {
            PdfWriter.GetInstance(doc, new FileStream(path + fileName, FileMode.Append));
            StringBuilder strB = new StringBuilder();
            doc.Open();

            strB.Append(text1 + "<br/><br/>" + text2);
            using (TextReader sReader = new StringReader(strB.ToString()))
            {
                List<IElement> list = HTMLWorker.ParseToList(sReader, new StyleSheet());
                foreach (IElement elm in list)
                {
                    doc.Add(elm);
                }
            }

            List<Model.Fajl> slike = Data.DAL.getSlike(idPost);
            foreach (Model.Fajl sl in slike)
            {
                iTextSharp.text.Image slika = iTextSharp.text.Image.GetInstance(Server.MapPath(sl.Putanja.ToString()));
                slika.ScaleToFit(400f, 400f);
                doc.Add(slika);
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text = ex.ToString();
        }
        finally
        {
            doc.Close();
        }
    }
    protected void DetailsViewDOTekstovima_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        GridViewTekst.DataBind();
        string text1 = "";
        string text2 = "";
        string post = "";
        string idPost = GridViewPostovi.SelectedDataKey.Value.ToString();
        List<Model.Post> postovi = Data.DAL.getPost(idPost);
        foreach (Model.Post po in postovi)
        {
            post = po.Naslov.ToString();
            text1 = "<h2>" + post + "<h2>";
            text2 += "<h3>" + po.Podnaslov + "</h3><br/> " + " <h4>" + po.Teskt + "</h4><br/>";
        }

        string path = Server.MapPath("~/Fajlovi/Postovi PDF/");
        string fileName = post + ".pdf";
        /*if (System.IO.File.Exists(path + fileName))
        {
            System.IO.File.Delete(path + fileName);
        }*/
        Document doc = new Document();
        try
        {
            PdfWriter.GetInstance(doc, new FileStream(path + fileName, FileMode.Append));
            StringBuilder strB = new StringBuilder();
            doc.Open();

            strB.Append(text1 + "<br/><br/>" + text2);
            using (TextReader sReader = new StringReader(strB.ToString()))
            {
                List<IElement> list = HTMLWorker.ParseToList(sReader, new StyleSheet());
                foreach (IElement elm in list)
                {
                    doc.Add(elm);
                }
            }

            List<Model.Fajl> slike = Data.DAL.getSlike(idPost);
            foreach (Model.Fajl sl in slike)
            {
                iTextSharp.text.Image slika = iTextSharp.text.Image.GetInstance(Server.MapPath(sl.Putanja.ToString()));
                slika.ScaleToFit(400f, 400f);
                doc.Add(slika);
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text = ex.ToString();
        }
        finally
        {
            doc.Close();
        }
    }
    protected void DetailsViewDOTekstovima_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        SqlDataSourceDOTekstovima.InsertParameters["idPost"].DefaultValue = GridViewPostovi.SelectedDataKey.Value.ToString();
    }
    protected void DetailsView1_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        SqlDataSourcePK.InsertParameters["idPost"].DefaultValue = GridViewPostovi.SelectedDataKey.Value.ToString();
    }
    protected void GridViewPostovi_SelectedIndexChanged(object sender, EventArgs e)
    {
        LabelTekstoviPosta.Visible = true;
        LabelSlikePosta.Visible = true;
        LabelKategorijePosta.Visible = true;
    }
}