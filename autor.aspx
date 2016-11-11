<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageSajt.master" AutoEventWireup="true" CodeFile="autor.aspx.cs" Inherits="Autor" ValidateRequest="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderSadrzaj" Runat="Server">

<h3>Dodavanje slike za Vaš post:</h3>
    <table style="width: 100%;">
        <tr>
            <td class="style1">
                <asp:Label ID="LabelidPost" runat="server" Text="Izaberite post:"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="DropDownListPost" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSourcePostovi" DataTextField="Naslov" 
                    DataValueField="idPost" Width="230px">
                </asp:DropDownList>
               
            </td>
            <td></td>
        </tr>
        <tr>
            <td class="style1">
                <asp:Label ID="LabelSlikaZaPost" runat="server" Text="Izaberite sliku:"></asp:Label>
            </td>
            <td>
                <asp:FileUpload ID="FileUploadSlika" runat="server" />
            </td>
            <td></td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Button ID="ButtonUplooad" runat="server" Text="Dodaj sliku" onclick="ButtonUplooad_Click" />
            </td>
        </tr>
        <tr>
            <td colspan="3"><asp:Label ID="Label1" runat="server" Text=""></asp:Label></td>
        </tr>
    </table><br />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
<h3>Postovi:</h3>
    <asp:GridView ID="GridViewPostovi" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" CellPadding="4" DataKeyNames="idPost" 
            DataSourceID="SqlDataSourcePostovi" ForeColor="#333333" GridLines="None" 
            onselectedindexchanged="GridViewPostovi_SelectedIndexChanged">
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
        SelectCommand="AutorPostovi" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="ime" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource><br />
    <asp:DetailsView ID="DetailsViewPostovi" runat="server" Height="50px" 
                Width="440px" AutoGenerateRows="False" CellPadding="4" DataKeyNames="idPost" 
                DataSourceID="SqlDataSourcePostoviDetails" ForeColor="#333333" GridLines="None" 
                HeaderText="Detalji o postu" 
                onitemupdated="DetailsViewPostovi_ItemUpdated" 
                onitemdeleted="DetailsViewPostovi_ItemDeleted" 
                oniteminserted="DetailsViewPostovi_ItemInserted" 
            oniteminserting="DetailsViewPostovi_ItemInserting" 
            onitemupdating="DetailsViewPostovi_ItemUpdating">
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
                    <asp:BoundField DataField="idAutor" HeaderText="idAutor" ReadOnly="True" 
                        SortExpression="idAutor" InsertVisible="False" />
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
            </asp:DetailsView>
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
                    <asp:Parameter Name="idAutor" Type="Int32"/>
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
        <br />

    <asp:Label ID="LabelTekstoviPosta" runat="server" Text="<h3>Tekstovi posta:</h3>" 
            Visible="False"></asp:Label>
    <asp:GridView ID="GridViewTekst" runat="server" AllowPaging="True" 
        AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSourceDPosta" 
        ForeColor="#333333" GridLines="None" DataKeyNames="idTekst">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="idTekst" HeaderText="idTekst" 
                SortExpression="idTekst" InsertVisible="False" ReadOnly="True" />
            <asp:BoundField DataField="Podnaslov" HeaderText="Podnaslov" 
                SortExpression="Podnaslov" />
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
    </asp:GridView>
    <br />
    <asp:SqlDataSource ID="SqlDataSourceDPosta" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="AutorTekst" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridViewPostovi" Name="idPost" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource><br />
        <asp:DetailsView ID="DetailsViewDOTekstovima" runat="server" Height="50px" 
                Width="440px" AutoGenerateRows="False" CellPadding="4" DataKeyNames="idTekst" 
                DataSourceID="SqlDataSourceDOTekstovima" ForeColor="#333333" GridLines="None" 
                HeaderText="Detalji o tekstovima" 
                onitemdeleted="DetailsViewDOTekstovima_ItemDeleted" 
                oniteminserted="DetailsViewDOTekstovima_ItemInserted" 
                onitemupdated="DetailsViewDOTekstovima_ItemUpdated" 
            oniteminserting="DetailsViewDOTekstovima_ItemInserting">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:BoundField DataField="idTekst" HeaderText="idTekst" InsertVisible="False" 
                        ReadOnly="True" SortExpression="idTekst"  />
                    <asp:BoundField DataField="idPost" HeaderText="idPost" 
                        SortExpression="idPost" InsertVisible="False" />
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
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            DeleteCommand="AdminFajloviDelete" DeleteCommandType="StoredProcedure" 
            SelectCommand="DetaljnijeSlike" SelectCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="idFajla" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="GridViewPostovi" Name="idPost" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="LabelSlikePosta" runat="server" Text="<h3>Slike posta:</h3>" 
            Visible="False"></asp:Label>
        <asp:GridView ID="GridViewFajlovi" runat="server" CellPadding="4" ForeColor="#333333" 
            GridLines="None" AutoGenerateColumns="False" DataKeyNames="idFajla" 
            DataSourceID="SqlDataSource2">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="idFajla" HeaderText="idFajla" InsertVisible="False" 
                    ReadOnly="True" SortExpression="idFajla" />
                <asp:BoundField DataField="Putanja" HeaderText="Putanja" 
                    SortExpression="Putanja" />
                <asp:BoundField DataField="OpisFajla" HeaderText="OpisFajla" 
                    SortExpression="OpisFajla" />
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
        </asp:GridView>
        <br />
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
                    <asp:ControlParameter ControlID="GridViewTekst" Name="idTekst" 
                        PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="idTekst" Type="Int32" />
                    <asp:Parameter Name="idPost" Type="Int32" />
                    <asp:Parameter Name="Podnaslov" Type="String" />
                    <asp:Parameter Name="Tekst" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Label ID="LabelKategorijePosta" runat="server" 
            Text="<h3>Kategorije posta:</h3>" Visible="False"></asp:Label>
            <asp:DetailsView ID="DetailsView1" runat="server" AllowPaging="True" 
            AutoGenerateRows="False" CellPadding="4" DataKeyNames="id" 
            DataSourceID="SqlDataSourcePK" ForeColor="#333333" GridLines="None" 
            Height="50px" Width="414px" oniteminserting="DetailsView1_ItemInserting">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
            <EditRowStyle BackColor="#999999" />
            <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
            <Fields>
                
                <asp:TemplateField HeaderText="Tekst">
                        <ItemTemplate>
                            <asp:Label ID="Labelk" runat="server" Text='<%# Eval("Naziv") %>'></asp:Label>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                                DataSourceID="SqlDataSource1" DataTextField="Naziv" 
                                DataValueField="idKategorija" SelectedValue='<%# Bind("idKategorija") %>'>
                            </asp:DropDownList>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                <asp:CommandField ShowInsertButton="True" ShowDeleteButton="True" />
            </Fields>
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSourcePK" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="AutorPKSelect" SelectCommandType="StoredProcedure"
            InsertCommand="AutorPKInsert" InsertCommandType="StoredProcedure"
            DeleteCommand="AdminDPKDelete" DeleteCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="idPost" />
                <asp:Parameter Name="idKategorija" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="GridViewPostovi" Name="idPost" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="AdminKategorijeSelect" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderOAutoru" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderAnketa" Runat="Server">
</asp:Content>

