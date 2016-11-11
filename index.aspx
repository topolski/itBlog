<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageSajt.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="poll.css" rel="stylesheet" type="text/css" />
<script src="scripts/jquery-latest.js" type="text/javascript"></script>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script type="text/javascript">
	$(document).ready(function() {
		var prikazPoStrani_1 = 4; 
		var brProizvoda_1 = $('#stranicenje').children().size();
		var brStrana_1 = Math.ceil(brProizvoda_1/prikazPoStrani_1);
		$('#trenutnaStrana_1').val(0);  
		$('#prikazPoStrani_1').val(prikazPoStrani_1);
		var strLinkoviHtml_1 = '<a class="prethodniLink_1" href="javascript:prethodna_1();"><<</a>';  
		var trenutniLink_1 = 0;  
		while(brStrana_1 > trenutniLink_1){  
			strLinkoviHtml_1 += '<a class="linkStrane_1" href="javascript:idiNaStranu_1(' + trenutniLink_1 +')" longdesc="' + trenutniLink_1 +'">'	+ (trenutniLink_1 + 1) +'</a>';  
			trenutniLink_1++;  
		} 
		strLinkoviHtml_1 += '<a class="sledeciLink_1" href="javascript:sledeca_1();">>></a>';
		$('#strLinkovi_1').html(strLinkoviHtml_1);  
		$('#strLinkovi_1 .linkStrane_1:first').addClass('aktivnaStrana_1');
		$('#stranicenje').children().css('display', 'none') ;
		$('#stranicenje').children().slice(0, prikazPoStrani_1).css('display', 'block');
	});	
	
	function prethodna_1(){  
		novaStrana_1 = parseInt($('#trenutnaStrana_1').val()) - 1;  
		if($('.aktivnaStrana_1').prev('.linkStrane_1').length==true){  
			idiNaStranu_1(novaStrana_1);  
		}
	};

	function sledeca_1(){  
		novaStrana_1 = parseInt($('#trenutnaStrana_1').val()) + 1;   
		if($('.aktivnaStrana_1').next('.linkStrane_1').length==true){  
			idiNaStranu_1(novaStrana_1);  
		}  
	};
	
	function idiNaStranu_1(brStrane_1){  
		var prikazPoStrani_1 = parseInt($('#prikazPoStrani_1').val());  
		kreni_1 = brStrane_1 * prikazPoStrani_1;  
		zavrsi_1 = kreni_1 + prikazPoStrani_1;  
		$('#stranicenje').children().css('display', 'none').slice(kreni_1, zavrsi_1).css('display', 'block');  
		$('.linkStrane_1[longdesc=' + brStrane_1 +']').addClass('aktivnaStrana_1').siblings('.aktivnaStrana_1').removeClass('aktivnaStrana_1');  
		$('#trenutnaStrana_1').val(brStrane_1);
};

$(document).ready(function () {
    var imgPoll = new Image();
    imgPoll.src = 'images/red-bar.png';

    if ($("#divVoted").length > 0) 
    {
        animateResults();
    }
    else {
        $("#rdoPoll0").attr("checked", "checked"); 
        $("#btnSubmit").click(function () {
            $("#divPoll").css("cursor", "wait"); 
            $("#btnSubmit").attr("disabled", "true") 

            var pID = $("input[id$=hidPollID]").val(); 
            var cID = $("input[name='rdoPoll']:checked").val(); 
            var data = "{'pID':'" + pID + "', 'cID':'" + cID + "'}"; 

            $.ajax(
                { 
                    type: "POST",
                    url: "index.aspx/UpdatePollCount",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg)  
                    {

                        $("#divPoll").css("cursor", "default"); 
                        $("#btnSubmit").attr("disabled", "false") 

                        $("div[id$=divAnswers]").fadeOut("fast").html(msg.d).fadeIn("fast", function () { animateResults(); });
                    }
                });
        });
    }

    function animateResults() {
        $("div[id$=divAnswers] img").each(function () {
            var percentage = $(this).attr("val");
            $(this).css({ width: "0%" }).animate({ width: percentage }, 'slow');
        });
    }
});
	
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderSadrzaj" Runat="Server">
    <asp:Label ID="LabelPostovi" runat="server"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderOAutoru" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderAnketa" runat="server">
    <h3>Asp.Net AJAX Anketa</h3>
    <br />
    <div runat="server" id="divMsg" class="mInfo" visible="false" />
    <div id="divPoll" class="poll-box" runat="server">
        <div class="poll-question">
            <asp:Literal ID="litQuestion" runat="server" />
        </div>
        <div id="divAnswers" runat="server">
            <asp:Repeater runat="server" ID="rptChoices">
                <ItemTemplate>
                    <p>
                        <label>
                            <input type="radio" value='<%# Eval("PollChoiceID") %>' name="rdoPoll" id='rdoPoll<%# Container.ItemIndex %>' />
                            <%# Eval("Choice") %>
                        </label>
                    </p>
                </ItemTemplate>
                <FooterTemplate>
                    <p>
                        <input type="button" value="Glasajte" class="submit" id="btnSubmit" />
                    </p>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </div>
    <asp:HiddenField runat="server" ID="hidPollID" />
</asp:Content>

