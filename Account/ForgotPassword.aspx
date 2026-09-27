<%@ Page Language="C#"
    AutoEventWireup="true"
    CodeBehind="ForgotPassword.aspx.cs"
    Inherits="TravelSphere.Account.ForgotPassword" %>

<!DOCTYPE html>

<html lang="en">

<head runat="server">

    <meta charset="utf-8" />

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0" />

    <title>Forgot Password | TravelSphere</title>
    <link rel="stylesheet" href="../Assets/css/forgot-password.css"

</head>


<body>

<form
    id="form1"
    runat="server">


    <div class="forgot-card">


        <h1 class="brand">
            Forgot Password?
        </h1>


        <p class="subtitle">

            Enter your registered email address
            and we'll send you a secure link
            to reset your password.

        </p>


        <asp:Label
            ID="lblEmail"
            runat="server"
            AssociatedControlID="txtEmail"
            CssClass="field-label"
            Text="Email Address">
        </asp:Label>


        <asp:TextBox
            ID="txtEmail"
            runat="server"
            CssClass="email-input"
            TextMode="Email"
            placeholder="Enter your email address">
        </asp:TextBox>


        <asp:RequiredFieldValidator
            ID="rfvEmail"
            runat="server"
            ControlToValidate="txtEmail"
            ErrorMessage="Please enter your email address."
            CssClass="validation"
            Display="Dynamic">
        </asp:RequiredFieldValidator>


        <asp:RegularExpressionValidator
            ID="revEmail"
            runat="server"
            ControlToValidate="txtEmail"
            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
            ErrorMessage="Please enter a valid email address."
            CssClass="validation"
            Display="Dynamic">
        </asp:RegularExpressionValidator>


        <asp:Button
            ID="btnReset"
            runat="server"
            Text="Send Reset Link"
            CssClass="reset-button"
            OnClick="btnReset_Click" />


        <div class="back-row">

            Remember your password?

            <a href="Login.aspx">
                Back to Login
            </a>

        </div>


    </div>

</form>

</body>

</html>