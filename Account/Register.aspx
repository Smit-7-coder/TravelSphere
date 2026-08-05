<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Register.aspx.cs"
    Inherits="TravelSphere.Account.Register" %>

<!DOCTYPE html>

<html>
<head runat="server">

    <title>Register - TravelSphere</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="../Assets/css/register.css" rel="stylesheet" />
</head>


<body>

<form id="form1" runat="server">


    <div class="register-box">


        <h2>Welcome to TravelSphere</h2>


        <!-- FULL NAME -->

        <div class="form-group">

            <label>Full Name:</label>

            <asp:TextBox
                ID="txtFullName"
                runat="server"
                CssClass="form-control">
            </asp:TextBox>


            <asp:RequiredFieldValidator
                ID="rfvFullName"
                runat="server"
                ControlToValidate="txtFullName"
                ErrorMessage="Full Name is required."
                CssClass="validation"
                Display="Dynamic">
            </asp:RequiredFieldValidator>

        </div>



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
                ErrorMessage="Enter a valid email address."
                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
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


            <asp:RegularExpressionValidator
                ID="revPassword"
                runat="server"
                ControlToValidate="txtPassword"
                ValidationExpression="^.{6,}$"
                ErrorMessage="Password must be at least 6 characters."
                CssClass="validation"
                Display="Dynamic">
            </asp:RegularExpressionValidator>

        </div>



        <!-- CONFIRM PASSWORD -->

        <div class="form-group">

            <label>Confirm Password:</label>

            <asp:TextBox
                ID="txtConfirmPassword"
                runat="server"
                TextMode="Password"
                CssClass="form-control">
            </asp:TextBox>


            <asp:RequiredFieldValidator
                ID="rfvConfirmPassword"
                runat="server"
                ControlToValidate="txtConfirmPassword"
                ErrorMessage="Confirm Password is required."
                CssClass="validation"
                Display="Dynamic">
            </asp:RequiredFieldValidator>


            <asp:CompareValidator
                ID="cvPassword"
                runat="server"
                ControlToValidate="txtConfirmPassword"
                ControlToCompare="txtPassword"
                Operator="Equal"
                Type="String"
                ErrorMessage="Passwords do not match."
                CssClass="validation"
                Display="Dynamic">
            </asp:CompareValidator>

        </div>



        <!-- PHONE -->

        <div class="form-group">

            <label>Phone No:</label>

            <asp:TextBox
                ID="txtPhone"
                runat="server"
                MaxLength="10"
                CssClass="form-control">
            </asp:TextBox>


            <asp:RequiredFieldValidator
                ID="rfvPhone"
                runat="server"
                ControlToValidate="txtPhone"
                ErrorMessage="Phone number is required."
                CssClass="validation"
                Display="Dynamic">
            </asp:RequiredFieldValidator>


            <asp:RegularExpressionValidator
                ID="revPhone"
                runat="server"
                ControlToValidate="txtPhone"
                ValidationExpression="^[6-9][0-9]{9}$"
                ErrorMessage="Enter a valid 10-digit mobile number."
                CssClass="validation"
                Display="Dynamic">
            </asp:RegularExpressionValidator>

        </div>



        <!-- ADDRESS -->

        <div class="form-group">

            <label>Address:</label>

            <asp:TextBox
                ID="txtAddress"
                runat="server"
                TextMode="MultiLine"
                Rows="2"
                CssClass="form-control">
            </asp:TextBox>


            <asp:RequiredFieldValidator
                ID="rfvAddress"
                runat="server"
                ControlToValidate="txtAddress"
                ErrorMessage="Address is required."
                CssClass="validation"
                Display="Dynamic">
            </asp:RequiredFieldValidator>

        </div>



        <!-- REGISTER BUTTON -->

        <asp:Button
            ID="btnRegister"
            runat="server"
            Text="Register"
            CssClass="register-btn"
            OnClick="btnRegister_Click" />



        <!-- DATABASE MESSAGE -->

        <asp:Label
            ID="lblMessage"
            runat="server"
            CssClass="message">
        </asp:Label>



        <!-- LOGIN -->

        <div class="login-section">

            Already have an account?

            <a href="Login.aspx">Login</a>

        </div>


    </div>


</form>

</body>

</html>