<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/MasterPage.master" CodeFile="Company.aspx.cs"
 Inherits="BusinessSettings_Company" Title="Super Admin Setup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
            CreateModalPopUp('#Msg', 350, 90, 'Create/Modify Setup');
            });     
    </script>
    
    
    <script language="javascript" type="text/javascript">
    function Verify(evet) {
            var charCode = (evet.which) ? evet.which : event.keyCode
            if (charCode != 9) {
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;
            }
            return true;
            }
            </script>

    <style type="text/css">
        
        table tr td
        {
            padding-right: 1px;
            text-align: left;
            font-family: Verdana, Geneva, sans-serif;
            font-size: 12px;
        }
        .forsmallfwidth
        {
            width: 105px;
        }
        .addresswidth
        {
            width: 264px;
        }
        .cumodifywidth
        {
            width: 121px;
        }
        
        label
        {
            color: #525252;
            font-family: verdana !important;
            font-size: 12px;
            padding: 1px;
            margin-bottom: 4px;
            float: left;
        }
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


       
   
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
         <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title">Company Information</h3>
                </div>
              
                        <div id="StausMsg"></div>
                    <div class="container">
                        

                            
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label> Company Code:</label>
                                            <asp:TextBox ID="txtSiteCode" runat="server" class="txtSiteCode" CssClass="form-control" placeholder="Code" require="Code" validate="UserValidate"></asp:TextBox><span>&nbsp</span>
                                        </div>
                                        <%--<div class="col-md-6">
                                             <label> Name:</label>
                                            <asp:TextBox ID="txtName" runat="server" class="txtName" CssClass="form-control" placeholder="Name" require="Enter Name" validate="UserValidate"></asp:TextBox><span>&nbsp</span>
                                        </div>--%>
                                        <div class="col-md-6">
                                            <label>Business Name:</label>
                                        
                                    <asp:TextBox ID="txtSiteName" runat="server" class="txtSiteName" CssClass="form-control" placeholder="SiteName" require="Enter SiteName" validate="UserValidate"></asp:TextBox><span>&nbsp</span>
                                        </div>
                                   
                                       
                               
                                            
                                     
                                        <div class="col-md-6">
                                            <label>
                                        Description:
                                    </label>
                                            <asp:TextBox ID="txtDescription" runat="server" 
                                        class="txtDescription" placeholder="Description" CssClass="form-control" require="Enter Description" validate="UserValidate"></asp:TextBox><span>&nbsp</span>
                                        </div>
                                        <div class="col-md-6">
                                            <label>
                                                Email:
                                            </label>
                                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" email="example@address.com" placeholder="Contact Person Email"
                                                require="Enter Email" validate="UserValidate"></asp:TextBox><span>&nbsp</span>
                                        </div>
                                                                
                                       
                                     
                                        <div class="col-md-6">
                                            <label>
                                        Contact Person:
                                    </label>
                                            <asp:TextBox ID="txtContactPerson" runat="server" 
                                        class="txtContactPerson" placeholder="ContactPerson" CssClass="form-control"  validate="UserValidate"></asp:TextBox><span>&nbsp</span>
                                        </div>
                                        <div class="col-md-6">
                                             <label>Contact Phone:</label>
                                            <asp:TextBox ID="txtContactPhone" runat="server" CssClass="form-control"  placeholder="ContactPhone" require="Enter Phone" validate="UserValidate" onkeypress="return Verify(event);"></asp:TextBox><span>&nbsp</span>
                                        </div>
                                    
                             <%--<div class="row">
                                        <div class="col-md-6">
                                            <label>
                                        Designation:
                                    </label>
                                            <asp:TextBox ID="txtDesignation" runat="server" CssClass="form-control"
                                        class="txtDesignation" placeholder="Designation"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6">
                                            <label>
                                                Custom Agent:
                                            </label>
                                            <asp:TextBox ID="txtCustomAgent" runat="server" CssClass="form-control" class="textfield cumodifywidth" placeholder="Custom Agent" require="Enter Custom Agent" validate="UserValidate"></asp:TextBox>
                                        </div>
                                    </div>         
                             <br />--%>
                          
                                        <div class="col-md-6">
                                            <label>NTN:</label>
                                            <asp:TextBox ID="txtSNTN" runat="server" CssClass="form-control"
                                         placeholder="SNTN" require="Enter SNTN" validate="UserValidate"></asp:TextBox><span>&nbsp</span>
                                        </div>
                                        <div class="col-md-6">
                                            <label> STRN:</label>
                                            <asp:TextBox ID="txtSalesTaxRegNo" runat="server" CssClass="form-control" placeholder="Sales Tax Reg No." require="Enter Sales Tax Reg No." validate="UserValidate"></asp:TextBox><span>&nbsp</span>
                                        </div>
                                    
                            
                                        <div class="col-md-12">
                                            <label>
                                        Address:
                                    </label>
                                            <asp:TextBox ID="txtContactAddress" runat="server" CssClass="form-control"
                                        class="txtContactAddress" placeholder="ContactAddress"></asp:TextBox>
                                        </div>
                                        
                                    </div>
                            <div class="row" style="margin-top:10px; margin-bottom:10px;">
                                        <div class="col-md-6">
                                            
                                        </div>
                                        <div class="col-md-6" style="text-align:right;">
                                            <asp:LinkButton ID="btnSave" class="Button1 btn btn-primary" runat="server" 
                                            OnClientClick="return validate('UserValidate');" onclick="btnSave_Click">Save</asp:LinkButton>
                                        <%--<asp:LinkButton ID="btnCancel" class="Button1 btn btn-primary" runat="server" 
                                            OnClientClick='javascript:history.back()' onclick="btnCancel_Click">Cancel</asp:LinkButton>--%>
                                            <asp:HiddenField ID="HiddenSetupID" runat="server" />
                                        </div>
                                    </div>           
                            
                                        <div style="float: left; margin-top: 2px; display:none;">
                                            <asp:CheckBox ID="ChkFinancials" Text="Financials" runat="server" CssClass="CheckBox" />
                                        </div>
                                    

                            
                                        <div style="float: left; margin-top: 2px;display:none;">
                                            <asp:CheckBox ID="ChkDepAccount" Text="Deposit Account" runat="server" CssClass="CheckBox" />
                                        </div>
                                    
                                        <div style="float: left; margin-top: 2px;display:none;">
                                            <asp:CheckBox ID="ChkTermDep" Text="Term Desposit" runat="server" CssClass="CheckBox" />
                                        </div>
                                    
                                        <div style="float: left; margin-top: 2px;display:none;">
                                            <asp:CheckBox ID="ChkLoan" Text="Loan" runat="server" CssClass="CheckBox" />
                                        </div>
                                    

                            
                     
                    </div>
              
          
         </div>
        </ContentTemplate>
    </asp:UpdatePanel>


      <%--  <div id="Msg">
            <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                <ContentTemplate>
                    <asp:Label ID="lblMainErrMsg" runat="server" Text="Label"></asp:Label>      
                     <asp:LinkButton ID="LinkButton1" CssClass="Button1" runat="server"  style="float:right;" OnClientClick="return closeDialog('Msg');">Ok</asp:LinkButton>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>--%>
       
           

</asp:Content>
