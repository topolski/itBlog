<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageSajt.master" AutoEventWireup="true" CodeFile="detaljnije.aspx.cs" Inherits="detaljnije" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        
        <script type="text/javascript" src="lightBox/js/jquery.js"></script>
		<script type="text/javascript" src="lightBox/js/jquery.lightbox-0.5.js"></script>
		<link rel="stylesheet" type="text/css" href="lightBox/css/jquery.lightbox-0.5.css" media="screen" />
        
        
		<script language="JavaScript" type="text/javascript">
        $(function () {
            $('.image a').lightBox();
        });

        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderSadrzaj" Runat="Server">
    <asp:Label ID="LabelDetaljnijeOpis" runat="server" 
        Text="Post sa traženim ID-jem ne postoji!"></asp:Label>
    <asp:Label ID="LabelDetaljnijeTekst" runat="server"></asp:Label>
    <asp:Label ID="LabelSlike" runat="server" ></asp:Label>
    <hr /><br />
    <h3>PDF verzija posta:</h3>
    <asp:Label ID="LabelPDF" runat="server" Text=""></asp:Label>
    <hr /><br />
    <h3>Komentari:</h3>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Label ID="LabelDetaljnijeKomentari" runat="server" Text=""></asp:Label><br />
            <h3>Da li imate nešto da dodate?</h3>
            <table style="width: 100%;">
                <tr>
                    <td>
                        <asp:Label ID="LabelIme" runat="server" Text="Ime:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxIme" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorIme" runat="server" ErrorMessage="<img align='absmiddle' src='images/warn.gif' />" ControlToValidate="TextBoxIme" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="LabelEmail" runat="server" Text="E-mail:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxEmail" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ErrorMessage="<img align='absmiddle' src='images/warn.gif' />" ControlToValidate="TextBoxEmail"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail" 
                            runat="server" ErrorMessage="<img align='absmiddle' src='images/warn.gif' /> Format" 
                            ControlToValidate="TextBoxEmail" 
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="LabelSite" runat="server" Text="WebSite:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxSite" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorSite" 
                            runat="server" ErrorMessage="<img align='absmiddle' src='images/warn.gif' /> Format" 
                            ControlToValidate="TextBoxSite" 
                            ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?" ></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="LabelKomentar" runat="server" Text="Komentar:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TextBoxKomentar" runat="server" TextMode="MultiLine" 
                            Height="88px" Width="291px"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorKomentar" runat="server" ErrorMessage="<img align='absmiddle' src='images/warn.gif' />" ControlToValidate="TextBoxKomentar"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <asp:Button ID="ButtonDodajKomentar" runat="server" Text="Komentar"
                            onclick="ButtonDodajKomentar_Click" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel><br />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderOAutoru" Runat="Server">
    <asp:Label ID="LabelOAutoru" runat="server" Text="Label"></asp:Label><br />
</asp:Content>

