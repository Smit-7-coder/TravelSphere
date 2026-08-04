<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="TravelSphere.Account.Register" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Register - TravelSphere</title>
</head>

<body>

    <form id="form1" runat="server">

        <h1>Welcome to TravelSphere</h1>

        <h2>Create Account</h2>

        <div>
            <label>Full Name</label>

            <asp:TextBox ID="txtFullName" runat="server"></asp:TextBox>

            <asp:RequiredFieldValidator
                ID="rfvFullName"
                runat="server"
                ControlToValidate="txtFullName"
                ErrorMessage="Full Name is required."
                ForeColor="Red"
                Display="Dynamic">
            </asp:RequiredFieldValidator>
        </div>


        <div>
            <label>Email</label>

            <asp:TextBox
                ID="txtEmail"
                runat="server"
                TextMode="Email">
            </asp:TextBox>

            <asp:RequiredFieldValidator
                ID="rfvEmail"
                runat="server"
                ControlToValidate="txtEmail"
                ErrorMessage="Email is required."
                ForeColor="Red"
                Display="Dynamic">
            </asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator
                ID="revEmail"
                runat="server"
                ControlToValidate="txtEmail"
                ErrorMessage="Enter a valid email address."
                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                ForeColor="Red"
                Display="Dynamic">
            </asp:RegularExpressionValidator>
        </div>


        <div>
            <label>Password</label>

            <asp:TextBox
                ID="txtPassword"
                runat="server"
                TextMode="Password">
            </asp:TextBox>

            <asp:RequiredFieldValidator
                ID="rfvPassword"
                runat="server"
                ControlToValidate="txtPassword"
                ErrorMessage="Password is required."
                ForeColor="Red"
                Display="Dynamic">
            </asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator
                ID="revPassword"
                runat="server"
                ControlToValidate="txtPassword"
                ValidationExpression="^.{6,}$"
                ErrorMessage="Password must be at least 6 characters."
                ForeColor="Red"
                Display="Dynamic">
            </asp:RegularExpressionValidator>
        </div>


        <div>
            <label>Confirm Password</label>

            <asp:TextBox
                ID="txtConfirmPassword"
                runat="server"
                TextMode="Password">
            </asp:TextBox>

            <asp:RequiredFieldValidator
                ID="rfvConfirmPassword"
                runat="server"
                ControlToValidate="txtConfirmPassword"
                ErrorMessage="Confirm Password is required."
                ForeColor="Red"
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
                ForeColor="Red"
                Display="Dynamic">
            </asp:CompareValidator>
        </div>


        <div>
            <label>Phone</label>

            <asp:TextBox
                ID="txtPhone"
                runat="server"
                MaxLength="10">
            </asp:TextBox>

            <asp:RequiredFieldValidator
                ID="rfvPhone"
                runat="server"
                ControlToValidate="txtPhone"
                ErrorMessage="Phone number is required."
                ForeColor="Red"
                Display="Dynamic">
            </asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator
                ID="revPhone"
                runat="server"
                ControlToValidate="txtPhone"
                ValidationExpression="^[6-9][0-9]{9}$"
                ErrorMessage="Enter a valid 10-digit mobile number."
                ForeColor="Red"
                Display="Dynamic">
            </asp:RegularExpressionValidator>
        </div>


        <div>
            <label>Address</label>

            <asp:TextBox
                ID="txtAddress"
                runat="server"
                TextMode="MultiLine"
                Rows="3">
            </asp:TextBox>

            <asp:RequiredFieldValidator
                ID="rfvAddress"
                runat="server"
                ControlToValidate="txtAddress"
                ErrorMessage="Address is required."
                ForeColor="Red"
                Display="Dynamic">
            </asp:RequiredFieldValidator>
        </div>

        <br />

        <asp:Button
            ID="btnRegister"
            runat="server"
            Text="Register"
            OnClick="btnRegister_Click" />

        <br />
        <br />

        <asp:Label
            ID="lblMessage"
            runat="server">
        </asp:Label>

    </form>

</body>
</html>
