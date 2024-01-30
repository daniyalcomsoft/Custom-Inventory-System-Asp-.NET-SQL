<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta charset="UTF-8" />
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <title>Accounts Expert - Accounting Solution</title>
       <link rel="shortcut icon" href="App_Images/favicon.png" />   
    <link href="App_Script/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
     <link rel="stylesheet" href="App_Script/global/fonts/font-awesome/font-awesome.min.css?v2.1.0" />
    <link href="App_Script/css/loginutil.css" rel="stylesheet" />
    <link href="App_Script/css/loginmain.css" rel="stylesheet" />
      
</head>
<body style="overflow:hidden !important;">

    
    <div class="limiter">

        <div class="container-login100">

            <div class="wrap-login100">
                <nav class="navbar bg-light navbar-fixed-top" >
                   
                </nav>

                <form class="login100-form validate-form" runat="server" >

                    <span class="login100-form-title p-b-30">
                        <img src="App_Images/logo.png" width="330" class="img-responsive" />
                        <%--<h2 style="font-size:50px; color:#ffffff; border:2px solid #43a047; border-radius:10px; background:#43a047;">Hussain Brothers</h2>--%>

                    </span>
                      <p runat="server" id="lbmsg" class="text-center txt-red"></p>
                     <%-- <div class="wrap-input100 validate-input" >
                             <asp:DropDownList runat="server" ID="ddlFinYear" CssClass="form-control" style="height:60px;"
                            Require="Select Year" ValidationGroup="Login" />
                        <span class="focus-input100"></span>
                        <span class="label-input100" style="line-height:0px;padding-left:15px;top:12px;">Financial Year</span>                   
           
                       </div>--%>

                       <div class="wrap-input100 validate-input" >
                     
                           <%--  <asp:TextBox runat="server" ID="txtappCode" CssClass="input100 has-val" Width="100%"
                            Require="Enter App Code" ValidationGroup="Login" />--%>
                            <asp:DropDownList runat="server" ID="ddlCompany" CssClass="form-control" style="height:60px;"
                            Require="Enter App Code" ValidationGroup="Login" >
                                <asp:ListItem Value="2" Text="Hussain & AB Brothers"></asp:ListItem>

                            </asp:DropDownList>
                        <span class="focus-input100"></span>
                        <span class="label-input100" style="line-height:0px;padding-left:15px;top:12px;">Company</span>
                    
                     </div>
                    <div class="wrap-input100 validate-input"  data-validate="Username is required">
                     
                         <asp:TextBox runat="server" ID="txtUserID" CssClass="input100 has-val" Width="100%"
                            Require="Enter User ID" ValidationGroup="Login" />
                        <span class="focus-input100"></span>
                        <span class="label-input100">User Name</span>
                    </div>
                    

                    <div class="wrap-input100 validate-input" data-validate="Password is required">
                     
                        <asp:TextBox runat="server" TextMode="Password" ID="txtPassword" CssClass="input100 has-val" Width="100%"
                            Require="Enter Password" ValidationGroup="Login" />
                        <span class="focus-input100"></span>
                        <span class="label-input100">Password</span>
                    </div>

                  

   
                    <div class="container-login100-form-btn">
                         <asp:Button runat="server" ID="btnLogin" OnClick="btnLogin_Click" ValidationGroup="Login" CssClass="login100-form-btn" data-loading-text="<i class='fa fa-circle-o-notch fa-spin'></i>  Processing" Text="Login" />
                    
                    </div>

                   

  </form>



                <div class="login100-more Image">
                    <img class="img-responsive " src="App_Images/bg.png" width="420" />
                </div>
            </div>
        </div>
    </div>


    <div class="footer text-center">
        Powered by <b><a href="http://webtechsolution.com.pk" target="_blank" > Webtech Solutions Pvt Ltd.</a></b> All rights reserved.	

    </div>


    <!-- End Page -->
    <!-- Core  -->
    <script src="App_Script/js/jquery-2.2.3.min.js"></script>
    <script src="App_Script/assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="App_Script/js/loginmain.js"></script>

    <script type="text/javascript">
       
            $(document).ready(function () {
             
           
                localStorage.removeItem("remark.materialiconbar.skinTools");
            });
      

      
        </script>
  
</body>
</html>
