<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="TravelSphere.Account.ForgotPassword" %>

<!DOCTYPE html>
<html lang="en">

<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Forgot Password | TravelSphere</title>
    <link rel="stylesheet" href="../Assets/css/forgot-password.css"
</head>

<body>

    <div class="page-overlay"></div>

    <form id="form1" runat="server">

        <main class="forgot-card">

            <!-- Heading -->
            <h1 class="brand">
                Forgot Password
            </h1>

            <!-- Description -->
            <p class="subtitle">
                Enter your registered email address and
                we'll help you reset your password.
            </p>


            <!-- Email Label -->
            <asp:Label
                ID="lblEmail"
                runat="server"
                AssociatedControlID="txtEmail"
                CssClass="field-label"
                Text="Enter Email:">
            </asp:Label>


            <!-- Email Input -->
            <asp:TextBox
                ID="txtEmail"
                runat="server"
                CssClass="email-input"
                TextMode="Email"
                placeholder="Enter your email address">
            </asp:TextBox>


            <!-- Reset Button -->
            <asp:Button
                ID="btnReset"
                runat="server"
                CssClass="reset-button"
                Text="Send Reset Link"
                CausesValidation="false">
            </asp:Button>


            <!-- Back to Login -->
            <div class="back-row">

                Remember your password?

                <a href="Login.aspx">
                    Login
                </a>

            </div>

        </main>

    </form>

</body>

</html>
