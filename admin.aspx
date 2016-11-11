<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageSajt.master" AutoEventWireup="true" CodeFile="admin.aspx.cs" Inherits="admin" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    <script src="scripts/jquery-latest.js" type="text/javascript"></script>
    
    <script language="javascript" type="text/javascript">
        function showRowIndexs() {
            var i = 0;
            $("#tableChoices tr td.tdLabel").each(function () {
                i++;
                $(this).html("Odgovor " + i);
            });
        }

        function addFormField() {
            var ctrlID = $("#<%= hidRowIndex.ClientID %>").val();
            $("#tableChoices").append("<tr class='row' id='pRow" + ctrlID + "'><td width='200' class='tdLabel'>Odgovor:</td><td><input class='text' type='text' name='txtChoice" + ctrlID + "' id='txtChoice" + ctrlID + "'> <a href='#' onClick='removeFormField(\"#pRow" + ctrlID + "\"); return false;'>Obriši</a></td></tr>");
            $("#<%= hidRowIndex.ClientID %>").val(++ctrlID);

            showRowIndexs();
        }

        function removeFormField(id) {
            var cID = $("input:hidden", id).val();
            var data = "{'cID':'" + cID + "'}"; 
            if (cID > 0) 
            {
                $.ajax(
            {
                type: "POST",
                url: "admin.aspx/DeletePollChoice",
                data: data,
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            });
            }

            $(id).remove();

            showRowIndexs();
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderSadrzaj" Runat="Server">

    <h3>Upload fajlova:</h3>
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Label ID="LabelNazivFajla" runat="server" Text="Naziv fajla: "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="TextBoxNazivFajla" runat="server"></asp:TextBox>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelOpisFajla" runat="server" Text="Opis fajla: "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="TextBoxOpisFajla" runat="server" TextMode="MultiLine"></asp:TextBox>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
       <tr>
            <td>
                <asp:Label ID="LabelIzbor" runat="server" Text="Izaberite folder: "></asp:Label>
            </td>
            <td>
                <asp:RadioButtonList ID="RadioButtonListFilter" runat="server" 
                    onselectedindexchanged="RadioButtonListFilter_SelectedIndexChanged" 
                    AutoPostBack="True">
                    <asp:ListItem Value="autor">Slika za autora</asp:ListItem>
                    <asp:ListItem Value="post">Slika za post</asp:ListItem>
                    <asp:ListItem Value="kod">Kod</asp:ListItem>
                    <asp:ListItem Value="stranica">Stranica</asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td>
               &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LabelIdPost" runat="server" Text="Izaberite post:" Visible="false"></asp:Label>
            </td>
            <td colspan="2">
                <asp:DropDownList ID="DropDownListPost" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSourceZaDropDownListuPost" DataTextField="Naslov" 
                    DataValueField="idPost" Visible="False" Width="230px"></asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSourceZaDropDownListuPost" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    SelectCommand="AdminListaPostova" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
        </tr>
         <tr>
            <td>
                <asp:Label ID="LabelFajl" runat="server" Text="Fajl: "></asp:Label>
            </td>
            <td>
                <asp:FileUpload ID="FileUploadFajl" runat="server" />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Button ID="ButtonUploadFajla" runat="server" Text="Upload fajlova" onclick="ButtonUploadFajla_Click" />
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Label ID="LabelInfo" runat="server"></asp:Label>
            </td>
        </tr>
    </table><br />
   <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        <h3>Dodavanje/Izmena ankete:</h3>
    <br />
    <div runat="server" id="divMsg" class="mInfo" visible="false">
    </div>
    <div class="form" id="form">
        <table width="100%">
            <tr>
                <td width="200">
                    <asp:Label runat="server" ID="lblQuestion" AssociatedControlID="txtQuestion" Text="Pitanje:" />
                </td>
                <td>
                    <asp:TextBox ID="txtQuestion" runat="server" CssClass="text" />&nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lblBlock" AssociatedControlID="rdoCookie" Text="Zabrani ponovno glasanje pomoću:" />
                </td>
                <td>
                    <asp:RadioButton Checked="true" GroupName="block" ID="rdoCookie" runat="server" Text="Kolačića(najbezbednije)" />&nbsp;&nbsp;<br />
                    <asp:RadioButton GroupName="block" ID="rdoIP" runat="server" Text="IP adrese" ToolTip="Ovo može izazvati problem kod glasanja više glasača na istoj mreži." />&nbsp;&nbsp;<br />
                    <asp:RadioButton GroupName="block" ID="rdoNone" runat="server" Text="Nemoj zabraniti" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lblActive" AssociatedControlID="chkActive" Text="Status aktivnosti:" />
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="chkActive" Checked="true" />
                </td>
            </tr>
        </table>
        <div runat="server" id="divChoices">
            <table id='tableChoices' width='100%'>
                <tr id='pRow0'>
                    <td width='200' class='tdLabel'>
                        Odgovor 1
                    </td>
                    <td>
                        <input type='text' class='text' id='txtChoice0' name='txtChoice0' /> 
                        <a onclick="removeFormField('#pRow0'); return false;" href="#">Obriši</a>
                    </td>
                </tr>
                <tr id='pRow1'>
                    <td width='200' class='tdLabel'>
                        Odgovor 2
                    </td>
                    <td>
                        <input type='text' class='text' id='txtChoice1' name='txtChoice1' /> 
                        <a onclick="removeFormField('#pRow1'); return false;" href="#">Obriši</a>
                    </td>
                </tr>
            </table>
        </div>
        <asp:HiddenField runat="server" ID="hidRowIndex" Value="2" /> 
        <asp:HiddenField ID="hidPollID" runat="server" />
        
        <input type="button" onclick="addFormField();return false;" value="Dodajte još odgovora" class="submit" />
        <asp:Button ID="btnSave" runat="server" Text="Sačuvaj" OnClick="btnSave_Click" CssClass="submit" />
    </div><br /><br />
         <h3>Lista anketa:</h3>
    <br />
    <asp:GridView ID="GridViewListaAnketa" runat="server" CellPadding="4" 
                ForeColor="#333333" GridLines="None" 
                AutoGenerateColumns="False" DataSourceID="SqlDataSourceListaAnketa" 
                DataKeyNames="PollID">
            
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            
        <HeaderStyle CssClass="gridHead" BackColor="#5D7B9D" Font-Bold="True" 
            ForeColor="White" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="PollID" HeaderText="PollID" InsertVisible="False" 
                ReadOnly="True" SortExpression="PollID" Visible="False" />
            <asp:BoundField DataField="Question" HeaderText="Pitanje:" 
                SortExpression="Question" />
            <asp:BoundField DataField="Active" HeaderText="Aktivna:" 
                SortExpression="Active" />
            <asp:HyperLinkField DataNavigateUrlFields="PollID" DataNavigateUrlFormatString="~/admin.aspx?pid={0}"
                Text="Izmeni" />
            <asp:HyperLinkField DataNavigateUrlFields="PollID" DataNavigateUrlFormatString="~/index.aspx?pid={0}"
                Text="Probaj"  />
            <asp:CommandField DeleteText="Obriši" ShowDeleteButton="True" />
        </Columns>
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView><br />
      <asp:SqlDataSource ID="SqlDataSourceListaAnketa" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                DeleteCommand="AdminBrisanjeAnkete" DeleteCommandType="StoredProcedure" 
                SelectCommand="AdminListaAnketa" SelectCommandType="StoredProcedure">
          <DeleteParameters>
              <asp:Parameter Name="PollID" Type="Int32" />
          </DeleteParameters>
      </asp:SqlDataSource>
        <h3>Postovi:</h3>
            <asp:GridView ID="GridViewPostovi" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" CellPadding="4" DataKeyNames="idPost" 
            DataSourceID="SqlDataSourcePostovi" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="idPost" HeaderText="idPost" InsertVisible="False" 
                        ReadOnly="True" SortExpression="idPost" />
                    <asp:BoundField DataField="Naslov" HeaderText="Naslov" 
                        SortExpression="Naslov" />
                    <asp:BoundField DataField="Datum" HeaderText="Datum" SortExpression="Datum" 
                        DataFormatString="{0:d}" />
                    <asp:CommandField ShowSelectButton="True" />
                </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView><br />
        <asp:SqlDataSource ID="SqlDataSourcePostovi" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            OldValuesParameterFormatString="original_{0}" 
                SelectCommand="AdminListaPostova" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DetailsView ID="DetailsViewPostovi" runat="server" Height="50px" 
                Width="440px" AutoGenerateRows="False" CellPadding="4" DataKeyNames="idPost" 
                DataSourceID="SqlDataSourcePostoviDetails" ForeColor="#333333" GridLines="None" 
                HeaderText="Detalji o postu" 
                onitemupdated="DetailsViewPostovi_ItemUpdated" 
                onitemdeleted="DetailsViewPostovi_ItemDeleted" 
                oniteminserted="DetailsViewPostovi_ItemInserted" 
                oniteminserting="DetailsViewPostovi_ItemInserting">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:BoundField DataField="idPost" HeaderText="idPost" InsertVisible="False" 
                        ReadOnly="True" SortExpression="idPost" />
                    <asp:BoundField DataField="Naslov" HeaderText="Naslov" 
                        SortExpression="Naslov" />
                    <asp:TemplateField HeaderText="Slika">
                        <ItemTemplate>
                            <asp:Label ID="LabelSlikaZaPost" runat="server" Text='<%# Eval("Slika") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBoxSlikaZaPost" runat="server" 
                                Text='<%# Bind("Slika") %>' ></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBoxSlikaZaPostInsert" runat="server" 
                                Text='<%# Bind("Slika") %>'>Fajlovi/Slike/Postovi/V/default.png</asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="OpisSlike" HeaderText="OpisSlike" 
                        SortExpression="OpisSlike" />
                    <asp:TemplateField HeaderText="Autor">
                        <ItemTemplate>
                            <asp:Label ID="LabelPostAutor" runat="server" 
                                Text='<%# Eval("KorisničkoIme") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownListPostAutorEdit" runat="server" DataSourceID="SqlDataSourceAutori" 
                                DataTextField="KorisničkoIme" DataValueField="idAutor" 
                                SelectedValue='<%# Bind("idAutor") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="DropDownListPostAutorInsert" runat="server" 
                                DataSourceID="SqlDataSourceAutori" DataTextField="KorisničkoIme" 
                                DataValueField="idAutor" SelectedValue='<%# Bind("idAutor") %>'>
                            </asp:DropDownList>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Datum">
                        <ItemTemplate>
                            <asp:Label ID="LabelDatum" runat="server" Text='<%# Eval("Datum", "{0:d}") %>'></asp:Label>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:Calendar ID="Calendar1" runat="server" BackColor="White" 
                                BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" 
                                ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px">
                                <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                                <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" 
                                    VerticalAlign="Bottom" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                                <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" 
                                    Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                                <TodayDayStyle BackColor="#CCCCCC" />
                            </asp:Calendar>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="OpisPosta">
                        <ItemTemplate>
                            <asp:Label ID="LabelOpisPosta" runat="server" Text='<%# Eval("OpisPosta") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBoxOpisPostaEdit" runat="server" Height="286px" 
                                Text='<%# Bind("OpisPosta") %>' TextMode="MultiLine" Width="346px"></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBoxOpisPostaUnos" runat="server" TextMode="MultiLine" Height="286px" 
                                Width="346px" Text='<%# Bind("OpisPosta") %>'></asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" 
                        ShowInsertButton="True" />
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:DetailsView><br />
            <h3>Autori:</h3>
            <asp:SqlDataSource ID="SqlDataSourcePostoviDetails" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                OldValuesParameterFormatString="original_{0}" 
                DeleteCommand="AdminPostDelete" DeleteCommandType="StoredProcedure" 
                InsertCommand="AdminPostInsert" InsertCommandType="StoredProcedure" 
                SelectCommand="AdminPostDetalji" SelectCommandType="StoredProcedure" 
                UpdateCommand="AdminPostUpdate" UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="original_idPost" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Naslov" Type="String" />
                    <asp:Parameter Name="Slika" Type="String" />
                    <asp:Parameter Name="OpisSlike" Type="String" />
                    <asp:Parameter Name="idAutor" Type="Int32" />
                    <asp:Parameter Name="Datum" Type="DateTime" />
                    <asp:Parameter Name="OpisPosta" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridViewPostovi" Name="idPost" 
                        PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Naslov" Type="String" />
                    <asp:Parameter Name="Slika" Type="String" />
                    <asp:Parameter Name="OpisSlike" Type="String" />
                    <asp:Parameter Name="idAutor" Type="Int32" />
                    <asp:Parameter Name="OpisPosta" Type="String" />
                    <asp:Parameter Name="original_idPost" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="GridViewAutori" runat="server" AutoGenerateColumns="False" 
                CellPadding="4" DataKeyNames="idAutor" DataSourceID="SqlDataSourceAutori" 
                ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="idAutor" HeaderText="idAutor" InsertVisible="False" 
                        ReadOnly="True" SortExpression="idAutor" />
                    <asp:BoundField DataField="KorisničkoIme" HeaderText="KorisničkoIme" 
                        SortExpression="KorisničkoIme" />
                    <asp:CommandField ShowSelectButton="True" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView><br />
            <asp:SqlDataSource ID="SqlDataSourceAutori" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="AdminListaAutora" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DetailsView ID="DetailsViewDetaljiOAutoru" runat="server" Height="50px" 
                Width="440px" AutoGenerateRows="False" CellPadding="4" DataKeyNames="idAutor" 
                DataSourceID="SqlDataSourceDetaljiOAutoru" ForeColor="#333333" 
                GridLines="None" onitemdeleted="DetailsViewDetaljiOAutoru_ItemDeleted" 
                oniteminserted="DetailsViewDetaljiOAutoru_ItemInserted" 
                onitemupdated="DetailsViewDetaljiOAutoru_ItemUpdated" 
                HeaderText="Detalji o autorima">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:BoundField DataField="idAutor" HeaderText="idAutor" InsertVisible="False" 
                        ReadOnly="True" SortExpression="idAutor" />
                    <asp:BoundField DataField="KorisničkoIme" HeaderText="KorisničkoIme" 
                        SortExpression="KorisničkoIme" />
                    <asp:BoundField DataField="SlikaAutora" HeaderText="SlikaAutora" SortExpression="SlikaAutora" />
                    <asp:TemplateField HeaderText="TekstOAutoru">
                        <ItemTemplate>
                            <asp:Label ID="LabelOAutoru" runat="server" Text='<%# Eval("TekstOAutoru") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBoxOAutoruEdit" runat="server" 
                                Text='<%# Bind("TekstOAutoru") %>' TextMode="MultiLine" Width="300px" Height="125px"></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBoxOAutoruNovi" runat="server" 
                                Text='<%# Bind("TekstOAutoru") %>' TextMode="MultiLine" Width="300px" Height="125px"></asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                        ShowInsertButton="True" />
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:DetailsView><br />
            <asp:SqlDataSource ID="SqlDataSourceDetaljiOAutoru" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                DeleteCommand="AdminAutorDelete" DeleteCommandType="StoredProcedure" 
                InsertCommand="AdminAutorInsert" InsertCommandType="StoredProcedure" 
                SelectCommand="AdminAutorDetaljno" SelectCommandType="StoredProcedure" 
                UpdateCommand="AdminAutorUpdate" UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="idAutor" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="KorisničkoIme" Type="String" />
                    <asp:Parameter Name="SlikaAutora" Type="String" />
                    <asp:Parameter Name="TekstOAutoru" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridViewAutori" Name="idAutor" 
                        PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="KorisničkoIme" Type="String" />
                    <asp:Parameter Name="SlikaAutora" Type="String" />
                    <asp:Parameter Name="TekstOAutoru" Type="String" />
                    <asp:Parameter Name="idAutor" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <h3>Kontakti za autore:</h3>
            <asp:GridView ID="GridViewKA" runat="server" AutoGenerateColumns="False" 
                CellPadding="4" DataKeyNames="idKontakt" DataSourceID="SqlDataSourceKA" 
                ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="idKontakt" HeaderText="idKontakt" 
                        InsertVisible="False" ReadOnly="True" SortExpression="idKontakt" />
                    <asp:BoundField DataField="KorisničkoIme" HeaderText="KorisničkoIme" 
                        SortExpression="KorisničkoIme" />
                    <asp:CommandField ShowSelectButton="True" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView><br />
            <asp:SqlDataSource ID="SqlDataSourceKA" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="AdminSelectKA" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DetailsView ID="DetailsViewDKA" runat="server" Height="50px" Width="440px" 
                AutoGenerateRows="False" CellPadding="4" DataKeyNames="idKontakt" 
                DataSourceID="SqlDataSourceDKA" ForeColor="#333333" GridLines="None" 
                onitemdeleted="DetailsViewDKA_ItemDeleted" 
                oniteminserted="DetailsViewDKA_ItemInserted" 
                onitemupdated="DetailsViewDKA_ItemUpdated" 
                HeaderText="Detalji o kontaktu za autora">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:BoundField DataField="idKontakt" HeaderText="idKontakt" InsertVisible="False" 
                        ReadOnly="True" SortExpression="idKontakt" />
                    <asp:TemplateField HeaderText="Autor">
                        <ItemTemplate>
                            <asp:Label ID="LabelKontaktAutor" runat="server" 
                                Text='<%# Eval("KorisničkoIme") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownListKontaktAutorEdit" runat="server" DataSourceID="SqlDataSourceAutori" 
                                DataTextField="KorisničkoIme" DataValueField="idAutor" 
                                SelectedValue='<%# Bind("idAutor") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="DropDownListKontaktAutorInsert" runat="server" 
                                DataSourceID="SqlDataSourceAutori" DataTextField="KorisničkoIme" 
                                DataValueField="idAutor" SelectedValue='<%# Bind("idAutor") %>'>
                            </asp:DropDownList>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="WebSite" HeaderText="WebSite" 
                        SortExpression="WebSite" />
                    <asp:BoundField DataField="LinkedIn" HeaderText="LinkedIn" 
                        SortExpression="LinkedIn" />
                    <asp:BoundField DataField="Facebook" HeaderText="Facebook" 
                        SortExpression="Facebook" />
                    <asp:BoundField DataField="Twitter" HeaderText="Twitter" 
                        SortExpression="Twitter" />
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                        ShowInsertButton="True" />
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:DetailsView><br />
            <asp:SqlDataSource ID="SqlDataSourceDKA" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                DeleteCommand="AdminDKADelete" DeleteCommandType="StoredProcedure" 
                InsertCommand="AdminDKAInsert" InsertCommandType="StoredProcedure" 
                SelectCommand="AdminDKASelect" SelectCommandType="StoredProcedure" 
                UpdateCommand="AdminDKAUpdate" UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="idKontakt" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="idAutor" Type="Int32" />
                    <asp:Parameter Name="WebSite" Type="String" />
                    <asp:Parameter Name="LinkedIn" Type="String" />
                    <asp:Parameter Name="Facebook" Type="String" />
                    <asp:Parameter Name="Twitter" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridViewKA" Name="idKontakt" 
                        PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="idAutor" Type="Int32" />
                    <asp:Parameter Name="WebSite" Type="String" />
                    <asp:Parameter Name="LinkedIn" Type="String" />
                    <asp:Parameter Name="Facebook" Type="String" />
                    <asp:Parameter Name="Twitter" Type="String" />
                    <asp:Parameter Name="idKontakt" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
              <h3>Tekstovi postova:</h3>
            <asp:GridView ID="GridViewTekstovi" runat="server" AutoGenerateColumns="False" 
                CellPadding="4" DataKeyNames="idTekst" DataSourceID="SqlDataSourceTekstovi" 
                ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="idTekst" HeaderText="idTekst" InsertVisible="False" 
                        ReadOnly="True" SortExpression="idTekst" />
                    <asp:BoundField DataField="idPost" HeaderText="idPost" 
                        SortExpression="idPost" />
                    <asp:BoundField DataField="Podnaslov" HeaderText="Podnaslov" 
                        SortExpression="Podnaslov" />
                    <asp:BoundField DataField="Tekst" HeaderText="Tekst" SortExpression="Tekst" 
                        Visible="False" />
                    <asp:CommandField ShowSelectButton="True" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView><br />
            <asp:SqlDataSource ID="SqlDataSourceTekstovi" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="AdminTekstoviSelect" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DetailsView ID="DetailsViewDOTekstovima" runat="server" Height="50px" 
                Width="440px" AutoGenerateRows="False" CellPadding="4" DataKeyNames="idTekst" 
                DataSourceID="SqlDataSourceDOTekstovima" ForeColor="#333333" GridLines="None" 
                HeaderText="Detalji o tekstovima" 
                onitemdeleted="DetailsViewDOTekstovima_ItemDeleted" 
                oniteminserted="DetailsViewDOTekstovima_ItemInserted" 
                onitemupdated="DetailsViewDOTekstovima_ItemUpdated">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:BoundField DataField="idTekst" HeaderText="idTekst" InsertVisible="False" 
                        ReadOnly="True" SortExpression="idTekst" />
                    <asp:TemplateField HeaderText="Post(Naslov)">
                        <ItemTemplate>
                            <asp:Label ID="LabelDT" runat="server" Text='<%# Eval("Naslov") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownListDTEdit" runat="server" 
                                DataSourceID="SqlDataSourcePostovi" DataTextField="Naslov" 
                                DataValueField="idPost" SelectedValue='<%# Bind("idPost") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="DropDownListDTInsert" runat="server" 
                                DataSourceID="SqlDataSourcePostovi" DataTextField="Naslov" 
                                DataValueField="idPost" SelectedValue='<%# Bind("idPost") %>'>
                            </asp:DropDownList>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Podnaslov" HeaderText="Podnaslov" 
                        SortExpression="Podnaslov" />
                    <asp:TemplateField HeaderText="Tekst">
                        <ItemTemplate>
                            <asp:Label ID="LabelTekst" runat="server" Text='<%# Eval("Tekst") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBoxTekstEdit" runat="server" TextMode="MultiLine" 
                                Text='<%# Bind("Tekst") %>' Width="300px" Height="125px"></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBoxTekstNovi" runat="server" TextMode="MultiLine" 
                                Text='<%# Bind("Tekst") %>' Height="125px" Width="300px"></asp:TextBox>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                        ShowInsertButton="True" />
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:DetailsView><br />
            <asp:SqlDataSource ID="SqlDataSourceDOTekstovima" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                DeleteCommand="AdminDTDelete" DeleteCommandType="StoredProcedure" 
                InsertCommand="AdminDTInsert" InsertCommandType="StoredProcedure" 
                SelectCommand="AdminDTSelect" SelectCommandType="StoredProcedure" 
                UpdateCommand="AdminDTUpdate" UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="idTekst" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="idPost" Type="Int32" />
                    <asp:Parameter Name="Podnaslov" Type="String" />
                    <asp:Parameter Name="Tekst" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridViewTekstovi" Name="idTekst" 
                        PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="idTekst" Type="Int32" />
                    <asp:Parameter Name="idPost" Type="Int32" />
                    <asp:Parameter Name="Podnaslov" Type="String" />
                    <asp:Parameter Name="Tekst" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <h3>Kategorije postova:</h3>
            <asp:GridView ID="GridViewKategorije" runat="server" 
                AutoGenerateColumns="False" CellPadding="4" DataKeyNames="idKategorija" 
                DataSourceID="SqlDataSourceKategorije" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="idKategorija" HeaderText="idKategorija" 
                        InsertVisible="False" ReadOnly="True" SortExpression="idKategorija" />
                    <asp:BoundField DataField="Naziv" HeaderText="Naziv" SortExpression="Naziv" />
                    <asp:CommandField ShowSelectButton="True" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView><br />
            <asp:SqlDataSource ID="SqlDataSourceKategorije" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="AdminKategorijeSelect" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DetailsView ID="DetailsViewKategorije" runat="server" Height="50px" 
                Width="350px" AutoGenerateRows="False" CellPadding="4" 
                DataKeyNames="idKategorija" DataSourceID="SqlDataSourceDKategorije" 
                ForeColor="#333333" GridLines="None" HeaderText="Detalji o kategorijama" 
                onitemdeleted="DetailsViewKategorije_ItemDeleted" 
                oniteminserted="DetailsViewKategorije_ItemInserted" 
                onitemupdated="DetailsViewKategorije_ItemUpdated">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:BoundField DataField="idKategorija" HeaderText="idKategorija" 
                        InsertVisible="False" ReadOnly="True" SortExpression="idKategorija" />
                    <asp:BoundField DataField="Naziv" HeaderText="Naziv" SortExpression="Naziv" />
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                        ShowInsertButton="True" />
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:DetailsView><br />
            <asp:SqlDataSource ID="SqlDataSourceDKategorije" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                DeleteCommand="AdminDKDelete" DeleteCommandType="StoredProcedure" 
                InsertCommand="AdminDKInsert" InsertCommandType="StoredProcedure" 
                SelectCommand="AdminDKSelect" SelectCommandType="StoredProcedure" 
                UpdateCommand="AdminDKUpdate" UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="idKategorija" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Naziv" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridViewKategorije" Name="idKategorija" 
                        PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Naziv" Type="String" />
                    <asp:Parameter Name="idKategorija" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <h3>Povezivanje postova i kategorija:</h3>
            <asp:GridView ID="GridViewPK" runat="server" AutoGenerateColumns="False" 
                CellPadding="4" DataSourceID="SqlDataSourcePK" ForeColor="#333333" 
                GridLines="None" DataKeyNames="id">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" 
                        ReadOnly="True" SortExpression="id" />
                    <asp:BoundField DataField="Naziv" HeaderText="Kategorija(Naziv)" 
                        SortExpression="Naziv" />
                    <asp:BoundField DataField="Naslov" HeaderText="Post(Naslov)" 
                        SortExpression="Naslov" />
                    <asp:CommandField ShowSelectButton="True" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView><br />
            <asp:SqlDataSource ID="SqlDataSourcePK" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="AdminPKSelect" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DetailsView ID="DetailsViewPK" runat="server" Height="50px" Width="400px" 
                AutoGenerateRows="False" CellPadding="4" DataKeyNames="id" 
                DataSourceID="SqlDataSourceDPK" ForeColor="#333333" GridLines="None" 
                HeaderText="Detalji o vezi postova i kategorija" 
                onitemdeleted="DetailsViewPK_ItemDeleted" 
                oniteminserted="DetailsViewPK_ItemInserted" 
                onitemupdated="DetailsViewPK_ItemUpdated">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" 
                        ReadOnly="True" SortExpression="id" />
                    <asp:TemplateField HeaderText="Kategorija">
                        <ItemTemplate>
                            <asp:Label ID="LabelPKKategorija" runat="server" Text='<%# Eval("Naziv") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownListPKKEdit" runat="server" 
                                DataSourceID="SqlDataSourceKategorije" DataTextField="Naziv" 
                                DataValueField="idKategorija" SelectedValue='<%# Bind("idKategorija") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="DropDownListPKKInsert" runat="server" 
                                DataSourceID="SqlDataSourceKategorije" DataTextField="Naziv" 
                                DataValueField="idKategorija" SelectedValue='<%# Bind("idKategorija") %>'>
                            </asp:DropDownList>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Post">
                        <ItemTemplate>
                            <asp:Label ID="LabelPKPost" runat="server" Text='<%# Eval("Naslov") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownListPKPEdit" runat="server" 
                                DataSourceID="SqlDataSourcePostovi" DataTextField="Naslov" 
                                DataValueField="idPost" SelectedValue='<%# Bind("idPost") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="DropDownListPKPInsert" runat="server" 
                                DataSourceID="SqlDataSourcePostovi" DataTextField="Naslov" 
                                DataValueField="idPost" SelectedValue='<%# Bind("idPost") %>'>
                            </asp:DropDownList>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                        ShowInsertButton="True" />
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:DetailsView><br />
            <asp:SqlDataSource ID="SqlDataSourceDPK" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                DeleteCommand="AdminDPKDelete" DeleteCommandType="StoredProcedure" 
                InsertCommand="AdminDPKInsert" InsertCommandType="StoredProcedure" 
                SelectCommand="AdminDPKSelect" SelectCommandType="StoredProcedure" 
                UpdateCommand="AdminDPKUpdate" UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="idKategorija" Type="Int32" />
                    <asp:Parameter Name="idPost" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridViewPK" Name="id" 
                        PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="idKategorija" Type="Int32" />
                    <asp:Parameter Name="idPost" Type="Int32" />
                    <asp:Parameter Name="id" Type="Int32" />
                </UpdateParameters>
           </asp:SqlDataSource>
            <h3>Spisak fajlova:</h3>
            <asp:GridView ID="GridViewFajlovi" runat="server" AllowPaging="True" 
                AutoGenerateColumns="False" CellPadding="4" DataKeyNames="idFajla" 
                DataSourceID="SqlDataSourceFajlovi" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="idFajla" HeaderText="idFajla" InsertVisible="False" 
                        ReadOnly="True" SortExpression="idFajla" />
                    <asp:BoundField DataField="idPost" HeaderText="idPost" 
                        SortExpression="idPost" />
                    <asp:BoundField DataField="Putanja" HeaderText="Putanja" 
                        SortExpression="Putanja" />
                    <asp:BoundField DataField="OpisFajla" HeaderText="OpisFajla" 
                        SortExpression="OpisFajla" />
                    <asp:BoundField DataField="Datum" DataFormatString="{0:d}" HeaderText="Datum" 
                        SortExpression="Datum" />
                    <asp:CommandField ShowDeleteButton="True" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView><br />
            <asp:SqlDataSource ID="SqlDataSourceFajlovi" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                DeleteCommand="AdminFajloviDelete" DeleteCommandType="StoredProcedure" 
                SelectCommand="AdminFajlovi" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="idFajla" Type="Int32" />
                </DeleteParameters>
            </asp:SqlDataSource>
            <h3>Glavni meni:</h3>
            <asp:GridView ID="GridViewGlavniMeni" runat="server" 
                AutoGenerateColumns="False" CellPadding="4" DataKeyNames="idStrane" 
                DataSourceID="SqlDataSourceGlavniMeni" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="idStrane" HeaderText="idStrane" 
                        InsertVisible="False" ReadOnly="True" SortExpression="idStrane" />
                    <asp:BoundField DataField="Putanja" HeaderText="Putanja" 
                        SortExpression="Putanja" />
                    <asp:BoundField DataField="ImeStrane" HeaderText="ImeStrane" 
                        SortExpression="ImeStrane" />
                    <asp:CommandField ShowSelectButton="True" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView><br />
            <asp:SqlDataSource ID="SqlDataSourceGlavniMeni" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="AdminGMeni" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DetailsView ID="DetailsViewGlavniMeni" runat="server" Height="50px" 
                Width="400px" AutoGenerateRows="False" CellPadding="4" DataKeyNames="idStrane" 
                DataSourceID="SqlDataSourceDGlavniMeni" ForeColor="#333333" GridLines="None" 
                HeaderText="Detalji o linkovima za stranice">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:BoundField DataField="idStrane" HeaderText="idStrane" 
                        InsertVisible="False" ReadOnly="True" SortExpression="idStrane" />
                    <asp:BoundField DataField="Putanja" HeaderText="Putanja" 
                        SortExpression="Putanja" />
                    <asp:BoundField DataField="ImeStrane" HeaderText="ImeStrane" 
                        SortExpression="ImeStrane" />
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                        ShowInsertButton="True" />
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:DetailsView><br />
            <asp:SqlDataSource ID="SqlDataSourceDGlavniMeni" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                DeleteCommand="AdminDGMDelete" DeleteCommandType="StoredProcedure" 
                InsertCommand="AdminDGMInsert" InsertCommandType="StoredProcedure" 
                SelectCommand="AdminDGMSelect" SelectCommandType="StoredProcedure" 
                UpdateCommand="AdminDGMUpdate" UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="idStrane" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Putanja" Type="String" />
                    <asp:Parameter Name="ImeStrane" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridViewGlavniMeni" Name="idStrane" 
                        PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Putanja" Type="String" />
                    <asp:Parameter Name="ImeStrane" Type="String" />
                    <asp:Parameter Name="idStrane" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <h3>Povezivanje prikaza stranica u zavisnosti od uloge korisnika:</h3>
            <asp:GridView ID="GridViewPovezivanjeStranica" runat="server" 
                AutoGenerateColumns="False" CellPadding="4" DataKeyNames="id" 
                DataSourceID="SqlDataSourcePovezivanjeStranica" ForeColor="#333333" 
                GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" 
                        ReadOnly="True" SortExpression="id" />
                    <asp:BoundField DataField="ImeStrane" HeaderText="Strana" 
                        SortExpression="ImeStrane" />
                    <asp:BoundField DataField="NazivUloge" HeaderText="Uloga" 
                        SortExpression="NazivUloge" />
                    <asp:CommandField ShowSelectButton="True" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView><br />
            <asp:SqlDataSource ID="SqlDataSourcePovezivanjeStranica" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="AdminPS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:DetailsView ID="DetailsViewPovezivanjeStranica" runat="server" 
                Height="50px" Width="300px" AutoGenerateRows="False" CellPadding="4" 
                DataKeyNames="id" DataSourceID="SqlDataSourceDPovezivanjeStranica" 
                ForeColor="#333333" GridLines="None" HeaderText="Detalji o povezivanju">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" 
                        ReadOnly="True" SortExpression="id" />
                    <asp:TemplateField HeaderText="Strana">
                        <ItemTemplate>
                            <asp:Label ID="LabelUGS" runat="server" Text='<%# Eval("ImeStrane") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownListPKKEdit" runat="server" 
                                DataSourceID="SqlDataSourceGlavniMeni" DataTextField="ImeStrane" 
                                DataValueField="idStrane" SelectedValue='<%# Bind("idStrane") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="DropDownListPKKInsert" runat="server" 
                                DataSourceID="SqlDataSourceGlavniMeni" DataTextField="ImeStrane" 
                                DataValueField="idStrane" SelectedValue='<%# Bind("idStrane") %>'>
                            </asp:DropDownList>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Uloga">
                        <ItemTemplate>
                            <asp:Label ID="LabelUGU" runat="server" Text='<%# Eval("NazivUloge") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownListPKPEdit" runat="server" 
                                DataSourceID="SqlDataSourceUlogeKorisnika" DataTextField="NazivUloge" 
                                DataValueField="idUloga" SelectedValue='<%# Bind("idUloga") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="DropDownListPKPInsert" runat="server" 
                                DataSourceID="SqlDataSourceUlogeKorisnika" DataTextField="NazivUloge" 
                                DataValueField="idUloga" SelectedValue='<%# Bind("idUloga") %>'>
                            </asp:DropDownList>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                        ShowInsertButton="True" />
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:DetailsView><br />
            <asp:SqlDataSource ID="SqlDataSourceDPovezivanjeStranica" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                DeleteCommand="AdminDPSDelete" DeleteCommandType="StoredProcedure" 
                InsertCommand="AdminDPSInsert" InsertCommandType="StoredProcedure" 
                SelectCommand="AdminDPSSelect" SelectCommandType="StoredProcedure" 
                UpdateCommand="AdminDPSUpdate" UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="idStrane" Type="Int32" />
                    <asp:Parameter Name="idUloga" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridViewPovezivanjeStranica" Name="id" 
                        PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="idStrane" Type="Int32" />
                    <asp:Parameter Name="idUloga" Type="Int32" />
                    <asp:Parameter Name="id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <h3>Uloge korisnika:</h3>
            <asp:DetailsView ID="DetailsViewUlogeKorisnika" runat="server" Height="50px" 
                Width="300px" AllowPaging="True" AutoGenerateRows="False" CellPadding="4" 
                DataKeyNames="idUloga" DataSourceID="SqlDataSourceUlogeKorisnika" 
                ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:BoundField DataField="idUloga" HeaderText="idUloga" InsertVisible="False" 
                        ReadOnly="True" SortExpression="idUloga" />
                    <asp:BoundField DataField="NazivUloge" HeaderText="NazivUloge" 
                        SortExpression="NazivUloge" />
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                        ShowInsertButton="True" />
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:DetailsView><br />
            <asp:SqlDataSource ID="SqlDataSourceUlogeKorisnika" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                DeleteCommand="AdminUKDelete" DeleteCommandType="StoredProcedure" 
                InsertCommand="AdminUKInsert" InsertCommandType="StoredProcedure" 
                SelectCommand="AdminUKSelect" SelectCommandType="StoredProcedure" 
                UpdateCommand="AdminUKUpdate" UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="idUloga" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="NazivUloge" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="NazivUloge" Type="String" />
                    <asp:Parameter Name="idUloga" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
 </asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderOAutoru" Runat="Server">
</asp:Content>

