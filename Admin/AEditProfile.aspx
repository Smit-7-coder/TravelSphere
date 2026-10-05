<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="AEditProfile.aspx.cs"
    Inherits="TravelSphere.Admin.AEditProfile"
    MasterPageFile="~/Admin/Admin.Master" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

    <link rel="stylesheet"
        href="../Assets/Admincss/AEditProfile.css" />

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="edit-profile-page">

        <!-- =====================================================
             PAGE HEADER
             ===================================================== -->

        <section class="edit-profile-header">

            <div class="header-content">

                <h1>Edit Profile</h1>

                <p>
                    Update your admin profile information
                </p>

            </div>

        </section>


        <!-- =====================================================
             EDIT PROFILE CONTAINER
             ===================================================== -->

        <section class="edit-profile-container">

            <div class="profile-form-card">


                <!-- =================================================
                     PROFILE IMAGE
                     ================================================= -->

                <div class="profile-image-section">

                    <div class="profile-image-wrapper">

                        <div class="profile-image">

                            <img id="profilePreview"
                                 src="../Assets/Images/admin-avatar.png"
                                 alt="Admin Profile" />

                        </div>

                        <!-- Hidden image input -->
                        <input type="file"
                               id="profilePhoto"
                               accept="image/*"
                               style="display: none;" />

                    </div>


                    <div class="profile-image-info">

                        <h2>Aaryan Bharvadiya</h2>

                        <p>
                            Administrator
                        </p>

                        <!-- Change Photo -->
                        <label for="profilePhoto"
                               class="change-photo-btn">

                            <i class="bi bi-camera"></i>

                            Change Photo

                        </label>

                    </div>

                </div>


                <!-- =================================================
                     PERSONAL INFORMATION
                     ================================================= -->

                <div class="form-section">

                    <h2>
                        Personal Information
                    </h2>

                    <div class="section-line"></div>


                    <!-- ROW 1 -->

                    <div class="form-row">

                        <!-- Full Name -->

                        <div class="form-group">

                            <label for="txtName">
                                Full Name
                            </label>

                            <input type="text"
                                   id="txtName"
                                   class="form-input"
                                   value="Aaryan Bharvadiya" />

                        </div>


                        <!-- Email -->

                        <div class="form-group">

                            <label for="txtEmail">
                                Email Address
                            </label>

                            <input type="email"
                                   id="txtEmail"
                                   class="form-input"
                                   value="aaryan123@travelsphere.com" />

                        </div>

                    </div>


                    <!-- ROW 2 -->

                    <div class="form-row">

                        <!-- Phone -->

                        <div class="form-group">

                            <label for="txtPhone">
                                Phone Number
                            </label>

                            <input type="text"
                                   id="txtPhone"
                                   class="form-input"
                                   value="+91 98765 43210" />

                        </div>


                        <!-- Role -->

                        <div class="form-group">

                            <label for="txtRole">
                                Role
                            </label>

                            <input type="text"
                                   id="txtRole"
                                   class="form-input"
                                   value="Administrator"
                                   readonly />

                        </div>

                    </div>


                    <!-- ADDRESS -->

                    <div class="form-group full-width">

                        <label for="txtAddress">
                            Address
                        </label>

                        <input type="text"
                               id="txtAddress"
                               class="form-input"
                               value="Gujarat, India" />

                    </div>

                </div>



                <!-- =================================================
                     COMPANY INFORMATION
                     ================================================= -->

                <div class="form-section">

                    <h2>
                        Company Information
                    </h2>

                    <div class="section-line"></div>


                    <!-- ROW 1 -->

                    <div class="form-row">

                        <!-- Company Name -->

                        <div class="form-group">

                            <label for="txtCompany">
                                Company Name
                            </label>

                            <input type="text"
                                   id="txtCompany"
                                   class="form-input"
                                   value="TravelSphere" />

                        </div>


                        <!-- Website -->

                        <div class="form-group">

                            <label for="txtWebsite">
                                Website
                            </label>

                            <input type="text"
                                   id="txtWebsite"
                                   class="form-input"
                                   value="www.travelsphere.com" />

                        </div>

                    </div>


                    <!-- COMPANY ADDRESS -->

                    <div class="form-group full-width">

                        <label for="txtCompanyAddress">
                            Company Address
                        </label>

                        <input type="text"
                               id="txtCompanyAddress"
                               class="form-input"
                               value="Ahmedabad, Gujarat, India" />

                    </div>

                </div>



                <!-- =================================================
                     ACTION BUTTONS
                     ================================================= -->

                <div class="form-actions">

                    <!-- Cancel -->

                    <a href="AdminProfile.aspx"
                       class="cancel-btn">

                        Cancel

                    </a>


                    <!-- Save -->

                    <a href="AdminProfile.aspx"
                       class="save-btn">

                        <i class="bi bi-check-lg"></i>

                        Save Changes

                    </a>

                </div>


            </div>

        </section>

    </div>


    <!-- =========================================================
         CHANGE PROFILE PHOTO
         ========================================================= -->

    <script>

        const profilePhoto =
            document.getElementById("profilePhoto");

        const profilePreview =
            document.getElementById("profilePreview");


        profilePhoto.addEventListener("change", function () {

            const file = this.files[0];


            if (file) {

                /*
                 * Check whether selected file is an image
                 */

                if (!file.type.startsWith("image/")) {

                    alert("Please select a valid image.");

                    this.value = "";

                    return;
                }


                /*
                 * Create temporary preview
                 */

                const reader = new FileReader();


                reader.onload = function (event) {

                    profilePreview.src =
                        event.target.result;

                };


                reader.readAsDataURL(file);

            }

        });

    </script>

</asp:Content>