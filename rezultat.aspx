<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageSajt.master" AutoEventWireup="true" CodeFile="rezultat.aspx.cs" Inherits="rezultat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var prikazPoStrani_1 = 4;
            var brProizvoda_1 = $('#stranicenje').children().size();
            var brStrana_1 = Math.ceil(brProizvoda_1 / prikazPoStrani_1);
            $('#trenutnaStrana_1').val(0);
            $('#prikazPoStrani_1').val(prikazPoStrani_1);
            var strLinkoviHtml_1 = '<a class="prethodniLink_1" href="javascript:prethodna_1();"><<</a>';
            var trenutniLink_1 = 0;
            while (brStrana_1 > trenutniLink_1) {
                strLinkoviHtml_1 += '<a class="linkStrane_1" href="javascript:idiNaStranu_1(' + trenutniLink_1 + ')" longdesc="' + trenutniLink_1 + '">' + (trenutniLink_1 + 1) + '</a>';
                trenutniLink_1++;
            }
            strLinkoviHtml_1 += '<a class="sledeciLink_1" href="javascript:sledeca_1();">>></a>';
            $('#strLinkovi_1').html(strLinkoviHtml_1);
            $('#strLinkovi_1 .linkStrane_1:first').addClass('aktivnaStrana_1');
            $('#stranicenje').children().css('display', 'none');
            $('#stranicenje').children().slice(0, prikazPoStrani_1).css('display', 'block');
        });

        function prethodna_1() {
            novaStrana_1 = parseInt($('#trenutnaStrana_1').val()) - 1;
            if ($('.aktivnaStrana_1').prev('.linkStrane_1').length == true) {
                idiNaStranu_1(novaStrana_1);
            }
        };

        function sledeca_1() {
            novaStrana_1 = parseInt($('#trenutnaStrana_1').val()) + 1;
            if ($('.aktivnaStrana_1').next('.linkStrane_1').length == true) {
                idiNaStranu_1(novaStrana_1);
            }
        };

        function idiNaStranu_1(brStrane_1) {
            var prikazPoStrani_1 = parseInt($('#prikazPoStrani_1').val());
            kreni_1 = brStrane_1 * prikazPoStrani_1;
            zavrsi_1 = kreni_1 + prikazPoStrani_1;
            $('#stranicenje').children().css('display', 'none').slice(kreni_1, zavrsi_1).css('display', 'block');
            $('.linkStrane_1[longdesc=' + brStrane_1 + ']').addClass('aktivnaStrana_1').siblings('.aktivnaStrana_1').removeClass('aktivnaStrana_1');
            $('#trenutnaStrana_1').val(brStrane_1);
        };
	
</script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderSadrzaj" Runat="Server">
    <asp:Label ID="LabelPostovi" runat="server"></asp:Label>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderOAutoru" Runat="Server">
</asp:Content>

