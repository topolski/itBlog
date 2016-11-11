using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;

public partial class index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "IT Blog | Početna";
        divMsg.Visible = false;
        if (!this.IsPostBack)
        {
            List<string> brojKomentara = Data.DAL.getBrKomentara();
            List<Model.Post> postovi = Data.DAL.getPosts();
            LabelPostovi.Text = "<input type='hidden' id='trenutnaStrana_1' /> "
                                 + " <input type='hidden' id='prikazPoStrani_1' /> "
                                 + " <div id='stranicenje'> ";
            int i = 0;
            foreach (Model.Post post in postovi)
            {
                if (post.OpisPosta.Length > 230)
                {
                    LabelPostovi.Text += "<div class='post_box'><h2><a href='detaljnije.aspx?post=" + post.idPost + "'>" + post.Naslov + "</a></h2><br/><div class='post_info'><div class='post_date'>Datum:<br/> " + post.Datum.ToString("dd.MM.yyyy.") + "</div> "
                                            + " <div class='post_author'>Autor:<br/> <a href='rezultat.aspx?a=" + post.idAutor + "'>" + post.KorisničkoIme + "</a></div><div class='post_comment'>Komentara:<br/> " + brojKomentara[i] 
                                            +" </div><div class='cleaner'></div></div><div class='post_body'><table><tr><td><a href='detaljnije.aspx?post=" + post.idPost + "'><img style='margin-right:15px; margin-top:10px;' src=" + post.Slika + " alt=" + post.OpisSlike + " /></a></td><td> "
                                            + " <p>" + post.OpisPosta.ToString().Substring(0, 230) + "...</p></div><div class='continue'><a href='detaljnije.aspx?post=" + post.idPost + "'>Pročitajte više</a></td></tr></table></div></div>";
                    i++;
                }
                else
                {
                    LabelPostovi.Text += "<div class='post_box'><h2><a href='detaljnije.aspx?post=" + post.idPost + "'>" + post.Naslov + "</a></h2><br/><div class='post_info'><div class='post_date'>Datum:<br/> " + post.Datum.ToString("dd.MM.yyyy.") + "</div> "
                                            + " <div class='post_author'>Autor:<br/> <a href='rezultat.aspx?a=" + post.idAutor + "'>" + post.KorisničkoIme + "</a></div><div class='post_comment'>Komentara:<br/> " + brojKomentara[i]
                                            + " </div><div class='cleaner'></div></div><div class='post_body'><table><tr><td><a href='detaljnije.aspx?post=" + post.idPost + "'><img style='margin-right:15px; margin-top:10px;' src=" + post.Slika + " alt=" + post.OpisSlike + " /></a></td><td> "
                                            + " <p>" + post.OpisPosta + "...</p></div><div class='continue'><a href='detaljnije.aspx?post=" + post.idPost + "'>Pročitajte više</a></td></tr></table></div></div>";
                    i++;
                }      
            }
            LabelPostovi.Text += " </div><div id='strLinkovi_1'></div> ";

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

            if (!String.IsNullOrEmpty(Request.QueryString["pid"]))
            {
                hidPollID.Value = Request.QueryString["pid"];
            }
            else  
            {
                Poll objPoll = new Poll();
                int pollID = objPoll.getRandomActivePollID();

                if (pollID > 0)
                    hidPollID.Value = pollID.ToString();
                else
                {
                    divMsg.InnerHtml = "<b>Obaveštenje: </b>Nema aktivnih anketa.";
                    divPoll.Visible = false;
                    divMsg.Visible = true;
                    return;
                }
            }
            showPoll();
        }
    }

    private void showPoll()
    {
        Poll objPoll = new Poll();
        DataSet dsPoll = objPoll.SelectPoll(int.Parse(hidPollID.Value));

        if (dsPoll.Tables[0].Rows.Count > 0)
        {
            litQuestion.Text = dsPoll.Tables[0].Rows[0]["Question"].ToString();

            string blockMode = dsPoll.Tables[0].Rows[0]["BlockMode"].ToString();

            bool isPolled = isPolled = CheckAlreadyPolled(blockMode);


            if (isPolled) 
            {
                divAnswers.InnerHtml = getResultHTML(dsPoll);
                divAnswers.InnerHtml += "<div class='poll-total' id='divVoted'>Vaš glas je upisan.</div>";
            }
            else
            {
                rptChoices.DataSource = dsPoll.Tables[1];
                rptChoices.DataBind();
                rptChoices.Visible = rptChoices.Items.Count > 0;
            }
        }
        else
        {
            divMsg.InnerHtml = "<b>Obaveštenje: </b>Anketu koju ste tražili nije nađena.";
            divMsg.Visible = true;
        }
    }

    private bool CheckAlreadyPolled(string blockMode)
    {
        bool isPolled = false;
        
        if (blockMode == Poll.BlockMode.IP_ADDRESS.ToString())
        {
            string ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            Poll objPoll = new Poll();
            int id = objPoll.SelectPollIP(int.Parse(hidPollID.Value), ip);
            if (id > 0) isPolled = true;
        }
        else if (blockMode == Poll.BlockMode.COOKIE.ToString()) 
        {
            if (Request.Cookies["Poll"] != null && Request.Cookies["Poll"]["ID"] != null)
            {
                string commaSeperatedPollIDs = Request.Cookies["Poll"]["ID"];
                
                string[] pollIDs = commaSeperatedPollIDs.Split(",".ToCharArray());
                
                foreach (string pID in pollIDs)
                {
                    if (pID == hidPollID.Value)
                    {
                        isPolled = true;
                        break;
                    }
                }
            }
        }
        return isPolled;
    }

    [WebMethod]
    public static string UpdatePollCount(int pID, int cID)
    {
        Poll objPoll = new Poll();
        objPoll.UpdateChoiceVote(cID);

        string ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        objPoll.InsertPollIP(pID, ip);

        HttpCookie pollCookie;
        string valueToStore = ""; 

        if (HttpContext.Current.Request.Cookies["Poll"] != null && HttpContext.Current.Request.Cookies["Poll"]["ID"] != null)
        {
            pollCookie = HttpContext.Current.Request.Cookies["Poll"];
            valueToStore = HttpContext.Current.Request.Cookies["Poll"]["ID"] + "," + pID.ToString(); 
        }
        else 
        {
            pollCookie = new HttpCookie("Poll");
            valueToStore = pID.ToString();
        }
        pollCookie.Values["ID"] = valueToStore;
        pollCookie.Expires = DateTime.MaxValue;
        HttpContext.Current.Response.Cookies.Add(pollCookie);

        DataSet dsPoll = objPoll.SelectPoll(pID);
        return getResultHTML(dsPoll);
    }

    private static string getResultHTML(DataSet dsPoll)
    {
        int totalVotes = int.Parse(dsPoll.Tables[1].Compute("Sum(VoteCount)", String.Empty).ToString());
        System.Text.StringBuilder sbResult = new System.Text.StringBuilder();

        foreach (DataRow dr in dsPoll.Tables[1].Rows)
        {
            decimal percentage = 0;
            if (totalVotes > 0)
                percentage = decimal.Round((decimal.Parse(dr["VoteCount"].ToString()) / decimal.Parse(totalVotes.ToString())) * 100, MidpointRounding.AwayFromZero);

            string alt = dr["VoteCount"].ToString() + " votes out of " + totalVotes.ToString();

            sbResult.Append("<label class='poll-result'>").Append(dr["Choice"]).Append(" (").Append(dr["VoteCount"]).Append(" glas/a - ").Append(percentage).Append("%)</label>");
            sbResult.Append("<div class='poll-chart'><img src='images/red-bar.png' width='0%' val='").Append(percentage).Append("%' height='15px' alt='").Append(alt).Append("' title='").Append(alt).Append("' /> ").Append("</div>");
        }
        sbResult.Append("<div class='poll-total'>Ukupno glasova: ").Append(totalVotes).Append("</div>");
        return sbResult.ToString();
    }
}