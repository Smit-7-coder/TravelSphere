<%@ Page Language="C#"
    AutoEventWireup="true"
    CodeBehind="ResetPassword.aspx.cs"
    Inherits="TravelSphere.Account.ResetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reset Password - TravelSphere</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f8f5;
            color: #333;
        }

        .page-container {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }

        .reset-card {
            width: 100%;
            max-width: 450px;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.10);
        }

        .logo {
            text-align: center;
            font-size: 30px;
            font-weight: bold;
            color: #198754;
            margin-bottom: 10px;
        }

        .title {
            text-align: center;
            font-size: 25px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }

        .subtitle {
            text-align: center;
            color: #777;
            font-size: 14px;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #444;
        }

        .password-input {
            width: 100%;
            padding: 13px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
            outline: none;
        }

        .password-input:focus {
            border-color: #198754;
        }

        .reset-button {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 6px;
            background: #198754;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .reset-button:hover {
            background: #157347;
        }

        .message {
            display: block;
            margin-bottom: 20px;
            padding: 12px;
            border-radius: 6px;
            font-size: 14px;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #198754;
            text-decoration: none;
            font-size: 14px;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .validator {
            color: #d32f2f;
            font-size: 13px;
            display: block;
            margin-top: 5px;
        }
    </style>
</head>

<body>

<form id="form1" runat="server">

    <div class="page-container">

        <div class="reset-card">

            <div class="logo">
                TravelSphere
            </div>

            <div class="title">
                Reset Password
            </div>

            <div class="subtitle">
                Enter your new password below.
            </div>

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message"
                Visible="false">
            </asp:Label>

            <asp:Panel ID="pnlReset" runat="server">

                <div class="form-group">

                    <asp:Label
                        ID="lblNewPassword"
                        runat="server"
                        Text="New Password">
                    </asp:Label>

                    <asp:TextBox
                        ID="txtNewPassword"
                        runat="server"
                        CssClass="password-input"
                        TextMode="Password">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="rfvNewPassword"
                        runat="server"
                        ControlToValidate="txtNewPassword"
                        ErrorMessage="Please enter a new password."
                        CssClass="validator"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>

                </div>

                <div class="form-group">

                    <asp:Label
                        ID="lblConfirmPassword"
                        runat="server"
                        Text="Confirm Password">
                    </asp:Label>

                    <asp:TextBox
                        ID="txtConfirmPassword"
                        runat="server"
                        CssClass="password-input"
                        TextMode="Password">
                    </asp:TextBox>

                    <asp:RequiredFieldValidator
                        ID="rfvConfirmPassword"
                        runat="server"
                        ControlToValidate="txtConfirmPassword"
                        ErrorMessage="Please confirm your password."
                        CssClass="validator"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>

                    <asp:CompareValidator
                        ID="cvPassword"
                        runat="server"
                        ControlToValidate="txtConfirmPassword"
                        ControlToCompare="txtNewPassword"
                        ErrorMessage="Passwords do not match."
                        CssClass="validator"
                        Display="Dynamic">
                    </asp:CompareValidator>

                </div>

                <asp:Button
                    ID="btnResetPassword"
                    runat="server"
                    Text="Reset Password"
                    CssClass="reset-button"
                    OnClick="btnResetPassword_Click">
                </asp:Button>

            </asp:Panel>

            <a href="Login.aspx" class="back-link">
                Back to Login
            </a>

        </div>

    </div>

</form>

</body>
</html>