<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageSajt.master" AutoEventWireup="true" CodeFile="kontakt.aspx.cs" Inherits="kontakt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
    function ValidacijaOsoba(objSource, objArgs) {
        if (objArgs.Value != "0") {
            objArgs.IsValid = true;
        } else {
            objArgs.IsValid = false;
        }
    }
    function ValidacijaPoruka(objSource, objArgs) {
        if (objArgs.Value.length > 10) {
            objArgs.IsValid = true;
        } else {
            objArgs.IsValid = false;
        }
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderSadrzaj" Runat="Server">
 <table class="tabela">
        <tr>
            <th colspan="3">
                Kontakt forma
            </th>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelImePrezime" runat="server" Text="Ime i prezime:" AssociatedControlID="TextBoxImePrezime" CssClass="label"></asp:Label> 
            </td>
            <td>
                <asp:TextBox ID="TextBoxImePrezime" runat="server" CssClass="text-box"></asp:TextBox> 
            </td>
            <td class="error">
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorImePrezime" runat="server" ErrorMessage="Ime i prezime je obavezno !!!" Text="*" ControlToValidate="TextBoxImePrezime"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidatorImePrezime" 
                    runat="server" ErrorMessage="Ime i prezime nije u dobrom formatu !!!" Text="*" 
                    ControlToValidate="TextBoxImePrezime" ValidationExpression="^\w{3,}\s\w{3,}$"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelEmail" runat="server" Text="Vaša email adresa:" AssociatedControlID="TextBoxEmail" CssClass="label"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="TextBoxEmail" runat="server" CssClass="text-box"></asp:TextBox> 
            </td>
            <td class="error">
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ErrorMessage="Email je obavezan !!!" Text="*" ControlToValidate="TextBoxEmail"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail" 
                    runat="server" ErrorMessage="Email nije u dobrom formatu !!!" Text="*" 
                    ControlToValidate="TextBoxEmail" 
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelOsoba" runat="server" Text="Pitanje za:" AssociatedControlID="DropDownListOsoba" CssClass="label"></asp:Label> 
            </td>
            <td>
                <asp:DropDownList ID="DropDownListOsoba" runat="server" CssClass="drop-down-list">
                </asp:DropDownList>
            </td>
            <td class="error">
                
                <asp:CustomValidator ID="CustomValidatorOsoba" runat="server" 
                    ErrorMessage="Morate izabrati osobu !!!" ControlToValidate="DropDownListOsoba" 
                    Text="*" onservervalidate="CustomValidatorOsoba_ServerValidate" ClientValidationFunction="ValidacijaOsoba"></asp:CustomValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelPoruka" runat="server" Text="Poruka:" AssociatedControlID="TextBoxPoruka" CssClass="label"></asp:Label> 
            </td>
            <td>
                <asp:TextBox ID="TextBoxPoruka" runat="server" TextMode="MultiLine" CssClass="text-box"></asp:TextBox>
            </td>
            <td class="error">
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorPoruka" runat="server" ErrorMessage="Morate uneti nešto u polje Poruka !!!" Text="*" ControlToValidate="TextBoxPoruka"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="CustomValidatorPoruka" runat="server" 
                    ErrorMessage="Morate uneti poruku duzu od 10 karaktera" Text="*" 
                    ControlToValidate="TextBoxPoruka" 
                    onservervalidate="CustomValidatorPoruka_ServerValidate" ClientValidationFunction="ValidacijaPoruka"></asp:CustomValidator> 
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelSlanjeKopije" runat="server" Text="Pošalji kopiju:" AssociatedControlID="CheckBoxKopija" CssClass="label"></asp:Label> 
            </td>
            <td>
                <asp:CheckBox ID="CheckBoxKopija" runat="server" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3" align="center">
                <asp:Button ID="ButtonPosalji" runat="server" Text="Pošalji" CssClass="button" 
                    onclick="ButtonPosalji_Click" />
            </td> 
        </tr>
    </table>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validacija-error" />
    <div id="podaciForma" class="post sakri" runat="server">
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderOAutoru" Runat="Server">
</asp:Content>

