<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageSajt.master" AutoEventWireup="true" CodeFile="registracija.aspx.cs" Inherits="registracija" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 128px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderSadrzaj" Runat="Server">
    <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" 
        AnswerLabelText="Odgovor:" 
        AnswerRequiredErrorMessage="Odgovor na sigurnosno pitanje je neophodan." 
        BackColor="#F7F6F3" BorderColor="#E6E2D8" BorderStyle="Solid" BorderWidth="1px" 
        CancelButtonText="Odustani" CompleteSuccessText="Vaš nalog je uspešno kreiran." 
        ConfirmPasswordCompareErrorMessage="Lozinke se moraju poklapati." 
        ConfirmPasswordLabelText="Potvrdite lozinku:" 
        ConfirmPasswordRequiredErrorMessage="Potvrda lozinke je neophodna." 
        ContinueButtonText="Nastavite" ContinueDestinationPageUrl="~/index.aspx" 
        CreateUserButtonText="Registracija" 
        DuplicateEmailErrorMessage="Email adresa već postoji u bazi, molimo Vas unesite drugu email adresu." 
        DuplicateUserNameErrorMessage="Korisničko ime je zauzeto, molimo Vas da uneste drugo." 
        EmailRegularExpressionErrorMessage="Unesite drugu email adresu." 
        EmailRequiredErrorMessage="Email adresa je neophodna." 
        FinishCompleteButtonText="Gotovo" FinishPreviousButtonText="Prethodna" 
        Font-Names="Verdana" Font-Size="0.8em" 
        InvalidAnswerErrorMessage="Unesite drugi odgovor." 
        InvalidEmailErrorMessage="Email adresa nije u ispravnom formatu." 
        InvalidPasswordErrorMessage="Dužina lozinke minimum: {0}. Specijalni karakter neophodan: {1}." 
        InvalidQuestionErrorMessage="Molimo vas unesite drugo sigurnosno pitanje." 
        oncreateduser="CreateUserWizard1_CreatedUser" PasswordLabelText="Lozinka:" 
        PasswordRegularExpressionErrorMessage="Molimo Vas unesite drugu lozinku." 
        PasswordRequiredErrorMessage="Lozinka je neophodna." 
        QuestionLabelText="Sigurnosno pitanje:" 
        QuestionRequiredErrorMessage="Sigurnosno pitanje je neophodno." 
        StartNextButtonText="Sledeća" StepNextButtonText="Sledeća" 
        StepPreviousButtonText="Prethodna" 
        UnknownErrorMessage="Vaš nalog nije kreiran. Molimo Vas pokušajte ponovo." 
        UserNameLabelText="Korisničko ime:" 
        UserNameRequiredErrorMessage="Korisničko ime je neophodno." 
        DisplaySideBar="True">
        <ContinueButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" 
            BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" 
            ForeColor="#284775" />
        <CreateUserButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" 
            BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" 
            ForeColor="#284775" />
        <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <WizardSteps>
            <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server" 
                Title="Registrujte Vaš nalog">
            </asp:CreateUserWizardStep>
            <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" Title="Gotovo">
            </asp:CompleteWizardStep>
        </WizardSteps>
        <HeaderStyle BackColor="#5D7B9D" BorderStyle="Solid" Font-Bold="True" 
            Font-Size="0.9em" ForeColor="White" HorizontalAlign="Center" />
        <NavigationButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" 
            BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" 
            ForeColor="#284775" />
        <SideBarButtonStyle BorderWidth="0px" Font-Names="Verdana" ForeColor="White" />
        <SideBarStyle BackColor="#5D7B9D" BorderWidth="0px" Font-Size="0.9em" 
            VerticalAlign="Top" />
        <StepStyle BorderWidth="0px" />
    </asp:CreateUserWizard><br />
    <asp:PasswordRecovery ID="PasswordRecovery1" runat="server" 
        AnswerRequiredErrorMessage="Odgovor je neophodan." BackColor="#F7F6F3" 
        BorderColor="#E6E2D8" BorderPadding="4" BorderStyle="Solid" BorderWidth="1px" 
        Font-Names="Verdana" Font-Size="0.8em" 
        GeneralFailureText="Pokušaj slanja lozinke nije uspeo. Pokušajte ponovo." 
        QuestionFailureText="Vaš odgovor ne može biti verifikovan. Pokušajte ponovo." 
        QuestionInstructionText="Odgovorite na pitanje da dobijete lozinku." 
        QuestionLabelText="Pitanje:" QuestionTitleText="Potvrda identiteta" 
        SubmitButtonText="Pošaljite" SuccessText="Vaša lozinka Vam je poslata." 
        UserNameFailureText="Nismo uspeli da prepoznamo Vaše podatke. Pokušajte ponovo." 
        UserNameInstructionText="Upišite Vaše korisničko ime da dobijete lozinku." 
        UserNameLabelText="Korisničko ime:" 
        UserNameRequiredErrorMessage="Korisničko ime je neophodno." 
        UserNameTitleText="Zaboravili ste Vašu lozinku?">
        <SubmitButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" 
            BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" 
            ForeColor="#284775" />
        <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
        <SuccessTextStyle Font-Bold="True" ForeColor="#5D7B9D" />
        <TextBoxStyle Font-Size="0.8em" />
        <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="0.9em" 
            ForeColor="White" />
    </asp:PasswordRecovery>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderOAutoru" Runat="Server">
</asp:Content>

