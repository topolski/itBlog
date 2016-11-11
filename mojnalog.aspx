<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageSajt.master" AutoEventWireup="true" CodeFile="mojnalog.aspx.cs" Inherits="mojnalog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderSadrzaj" Runat="Server">
    <h3>Dodavanje slike na Vaš nalog:</h3>
    <table style="width: 100%;">
        <tr>
            <td class="style1">
                <asp:Label ID="LabelSlikaZaNalog" runat="server" Text="Izaberite sliku:"></asp:Label>
            </td>
            <td>
                <asp:FileUpload ID="FileUploadSlika" runat="server" />
            </td>
            <td></td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Button ID="ButtonUplooad" runat="server" Text="Dodaj sliku" 
                        onclick="ButtonUplooad_Click" /></td>
        </tr>
        <tr>
            <td colspan="3"><asp:Label ID="Label1" runat="server" Text=""></asp:Label></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderOAutoru" Runat="Server">
    <asp:Label ID="LabelMojNalog" runat="server"></asp:Label><br />
</asp:Content>

