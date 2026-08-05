<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs"
    Inherits="TravelSphere.Account.Login" %>

<!DOCTYPE html>

<html>
<head runat="server">

    <title>Login - TravelSphere</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link href="../Assets/css/login.css" rel="stylesheet" />

</head>

<body>

<form id="form1" runat="server">

    <div class="login-box">

        <h2>Welcome to TravelSphere</h2>

        <!-- EMAIL -->

        <div class="form-group">

            <label>Enter Email:</label>

            <asp:TextBox
                ID="txtEmail"
                runat="server"
                TextMode="Email"
                CssClass="form-control">
            </asp:TextBox>

            <asp:RequiredFieldValidator
                ID="rfvEmail"
                runat="server"
                ControlToValidate="txtEmail"
                ErrorMessage="Email is required."
                CssClass="validation"
                Display="Dynamic">
            </asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator
                ID="revEmail"
                runat="server"
                ControlToValidate="txtEmail"
                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                ErrorMessage="Enter a valid email address."
                CssClass="validation"
                Display="Dynamic">
            </asp:RegularExpressionValidator>

        </div>


        <!-- PASSWORD -->

        <div class="form-group">

            <label>Password:</label>

            <asp:TextBox
                ID="txtPassword"
                runat="server"
                TextMode="Password"
                CssClass="form-control">
            </asp:TextBox>

            <asp:RequiredFieldValidator
                ID="rfvPassword"
                runat="server"
                ControlToValidate="txtPassword"
                ErrorMessage="Password is required."
                CssClass="validation"
                Display="Dynamic">
            </asp:RequiredFieldValidator>

        </div>


        <!-- FORGOT PASSWORD -->

        <div class="forgot-password">

            <a href="ForgotPassword.aspx">
                Forgot Password?
            </a>

        </div>


        <!-- LOGIN BUTTON -->

        <asp:Button
            ID="btnLogin"
            runat="server"
            Text="Login"
            CssClass="login-btn"
            OnClick="btnLogin_Click" />


        <!-- MESSAGE -->

        <asp:Label
            ID="lblMessage"
            runat="server"
            CssClass="message">
        </asp:Label>


        <!-- REGISTER -->

        <div class="register-section">

            <span>Don't have an account?</span>

            <a href="Register.aspx">
                Register
            </a>

        </div>

    </div>

</form>

</body>
</html>