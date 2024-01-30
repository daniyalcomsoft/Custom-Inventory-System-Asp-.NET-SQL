<%@ Page Title="Create Customer" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CustomerForm.aspx.cs" Inherits="Sales_CustomerForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            MyDate();
            $('#tabMemberShip').tabs();
            $('#btnSave').hide();

        });
        function MyDate() {
            dateMin = $("[id $= hdnMinDate]").val();
            dateMax = $("[id $= hdnMaxDate]").val();
            $(".DateTimePicker").datepicker({ minDate: new Date(dateMin), maxDate: new Date(dateMax) });
        }
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
        body
        {
           
        }
        label
        {
            font-size: 12px;
            font-weight: bold;
        }
        select
        {
            border: 1px solid #CCC;
            height: 25px;
            line-height: 20px;
            border-image: initial;
        }
        input[type=text], textarea, input[type=password]
        {
            border-radius: 2px 2px 2px 2px;
            border: 1px solid #CCCCCC;
            height: 25px;
        }
        .bottomleftheading
        {
            font-family: Verdana, Geneva, sans-serif;
            font-size: 18px;
            float: left;
            margin-top: 14px;
            width: 227px;
            height: 40px;
            color: #525252;
        }
        .head
        {
            text-align: center;
            width: 100%;
            font-size: 12px;
        }
        .bodyarea
        {
             font-size: 12px;
            font-weight: bold;
            width: 800px;
            height: 480px auto;
        }
        .bodyarea h1
        {
            font-family: Arial;
            font-weight: bold;
            font-size: 18px;
            text-align: left;
        }
        .name
        {
            width: 150px;
            text-align: left;
        }
        .title
        {
            width: 50px;
            text-align: left;
        }
        .fname
        {
            width: 120px;
            text-align: left;
        }
        .lname
        {
            width: 120px;
            text-align: left;
        }
        .suffix
        {
            width: 70px;
            text-align: left;
        }
        .email
        {
            text-align: left;
        }
        .email label
        {
            margin-left: 20px;
        }
        .company
        {
            text-align: left;
        }
        .phone
        {
            text-align: left;
        }
        .mobile
        {
            text-align: left;
        }
        .fax
        {
            text-align: left;
        }
        .PortofDischarge
        {
            text-align: left;
        }
        .Dest
        {
            text-align: left;
        }
        .Consignee
        {
            text-align: left;
        }
        .Buyer
        {
            text-align: left;
        }
        .phone label
        {
            margin-left: 20px;
        }
        
        .mobile label
        {
            margin-left: 0px;
        }
        .fax label
        {
            margin-left: 0px;
        }
        .PortofDischarge label
        {
            margin-left: 0px;
        }
        .Dest label
        {
            margin-left: 0px;
        }
        .Consignee label
        {
            margin-left: 20px;
        }
        .Buyer label
        {
            margin-left: 0px;
        }
        
        .disp
        {
            text-align: left;
        }
        .other
        {
            text-align: left;
        }
        .website
        {
            text-align: left;
        }
        .disp span
        {
            color: #ee0000;
        }
        .other label
        {
            margin-left: 20px;
        }
        .website label
        {
            margin-left: 0px;
        }
        .bill
        {
            text-align: left;
        }
        .ship
        {
            text-align: left;
        }
        .ship label
        {
            margin-left: 20px;
        }
        .chkship
        {
            margin-left: 0px;
            float: left;
            width: 194px;
        }
        .terms
        {
            text-align: left;
        }
        .openBlnc
        {
            text-align: left;
        }
        .AsofDate label
        {
            text-align: left;
            margin-left: 20px;
        }
        table tr td
        {
            padding-right: 1px;
            text-align: left;
            font-family: Verdana, Geneva, sans-serif;
            font-size: 12px;
        }
        .tabfieldsbottom
        {
            width: 760px;
            height: 90%;
            margin: 0px 0px 0px -20px;
        }
        .highlight, highlight:focus
        {
            /*background-image: none !important;
    background-color: #fffacd !important;	
	background: url("../images/arrow.png") repeat-x scroll 50% 50% #FEF1EC;*/
            border: 1px solid #CD0A0A !important;
            color: Black;
            line-height: 33px;
        }
        #ctl00_ContentPlaceHolder1_btnSave{
            border:none;
            background:#00897b;
            font-style:normal;
        }
        #ctl00_ContentPlaceHolder1_btnCancel{
            border:none;
            background:#00897b;
            font-style:normal;
        }
       
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:HiddenField ID="hdnMinDate" runat="server" />
           <asp:HiddenField ID="hdnMaxDate" runat="server" />

     <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title">Create / Modify Customer</h3>
                </div>
    <div class="Update_area">
        <div id="StausMsg">
        </div>        
        <table style="float: left; width: 800px; margin-left: 15px;">
                                <tr>
                                    <td rowspan="6" style="text-align: left">
                                        <%-- Success --%>
                                        <div id="Notification_Success" style="display: none; width: 98%; margin: auto;">
                                            <div class="alert-green">
                                                <h4>
                                                    Success:
                                                </h4>
                                                <asp:Label ID="lblmsg" runat="server" Style="color: White"></asp:Label>
                                            </div>
                                        </div>
                                        <%--Error Message--%>
                                        <div id="Notification_Error" style="display: none; width: 98%; margin: auto;">
                                            <div class="alert-red">
                                                <h4>
                                                    Error!</h4>
                                                <asp:Label ID="lblNewError" runat="server" Style="color: White">
                                                </asp:Label>
                                            </div>
                                        </div>
                                        <%-- End --%>
                                    </td>
                                </tr>
          </table>          
        
                <div class="container">

                    <div class="row">
                        <div class="col-md-6">
                            <label>Customer Type :</label>
                             <asp:DropDownList runat="server" ID="cmbCusType" data-live-search="true" CssClass="form-control" Width="100%" />
                        </div>
                        <div class="col-md-6">
                            <label>Tax Rule :</label>
                             <asp:DropDownList runat="server" ID="cmbTaxCompany" data-live-search="true" CssClass="form-control" Width="100%" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-2">
                            <label>Title</label>
                             <asp:TextBox ID="txtTitle" runat="server" class="textfield" CssClass="form-control" placeholder="Mr."></asp:TextBox>
                        </div>
                        <div class="col-md-2">
                            <label>First name</label>
                            <asp:TextBox ID="txtfirstName" runat="server" class="textfield" ValidationGroup="validate" CssClass="form-control" placeholder="First name"></asp:TextBox>
                             <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtfirstName"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-2">
                             <label>Last name</label>
                            <asp:TextBox ID="txtlastName" runat="server" class="textfield" CssClass="form-control" placeholder="Last name"></asp:TextBox>

                        </div>
                        <div class="col-md-2">
                             <label>Suffix</label>
                            <asp:TextBox ID="txtSuffix" runat="server" class="textfield" CssClass="form-control" placeholder="Suffix"></asp:TextBox>
                        </div>
                        <div class="col-md-2">
                            <label>NTN</label>
                             <asp:TextBox ID="txtNTN" runat="server" class="textfield" ValidationGroup="validate" CssClass="form-control" placeholder="NTN"></asp:TextBox>
                             <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtNTN"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-2">
                            <label>Sales Tax Reg No.</label>
                            <asp:TextBox ID="txtSalesTaxReg" runat="server" class="textfield" ValidationGroup="validate" CssClass="form-control" placeholder="Sales Tax Reg No."></asp:TextBox>
                             <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtSalesTaxReg"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    
                                
                                
                               <div class="row">
                                   <div class="col-md-6">
                                       <label>Company/ Customer</label>
                                       <asp:TextBox ID="txtCompany" runat="server" ValidationGroup="validate" CssClass="form-control" class="textfield" placeholder="Company Name"></asp:TextBox>
                                        <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtCompany"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                                   </div>
                                   <div class="col-md-2">
                                       <label>Phone</label>
                                       <asp:TextBox ID="txtPhone" runat="server" ValidationGroup="validate" CssClass="form-control" class="textfield" placeholder="Phone"></asp:TextBox>
                                        <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtPhone"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                                   </div>
                                   <div class="col-md-2">
                                        <label>Mobile</label>
                                        <asp:TextBox ID="txtMobile" runat="server" ValidationGroup="validate" CssClass="form-control" class="textfield" placeholder="Mobile"></asp:TextBox>
                                        <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtMobile"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                                   </div>
                                   <div class="col-md-2">
                                        <label>Fax</label>
                                       <asp:TextBox ID="txtFax" runat="server" CssClass="form-control" class="textfield" placeholder="Fax"></asp:TextBox>
                                   </div>
                               </div>
                               
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Display name as</label>
                                        <asp:TextBox ID="txtDisplayName" runat="server" ValidationGroup="validate" CssClass="form-control" require="Please enter a unique Display Name" class="textfield" placeholder="Display Name"></asp:TextBox>
                                         <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtDisplayName"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-md-6">
                                        <label>Email</label>
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ValidationGroup="validate" class="textfield" email="example@address.com" placeholder="Email"></asp:TextBox>
                                         <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtEmail"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                   
                    <div class="row">
                        <div class="col-md-6">
                            Print on check as <asp:CheckBox ID="chkPrintDispName" Text="&#160;Use display name" runat="server" />
                             <asp:TextBox ID="txtPrint" runat="server" CssClass="form-control" class="textfield"></asp:TextBox>
                        </div>
                        <div class="col-md-2">
                            <label>Bank</label>
                            <asp:TextBox ID="txtBank" runat="server" ValidationGroup="validate" CssClass="form-control" class="textfield" placeholder="Bank"></asp:TextBox>
                             <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtBank"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-2">
                            <label>Account No.</label>
                            <asp:TextBox ID="txtAccNo" runat="server" ValidationGroup="validate" CssClass="form-control" class="textfield" placeholder="Account No."></asp:TextBox>
                             <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtAccNo"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-2">
                            <label>IBAN No.</label>
                            <asp:TextBox ID="TxtIBAN" runat="server" ValidationGroup="validate" CssClass="form-control" class="textfield" placeholder="IBAN No."></asp:TextBox>
                             <asp:RequiredFieldValidator  runat="server" ControlToValidate="TxtIBAN"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="row" style="display:none;">
                        <div class="col-md-6">
                            <label>Port of Discharge</label>
                            <asp:TextBox ID="txtportofdischarge" runat="server" CssClass="form-control" class="textfield" placeholder="Port of Discharge"></asp:TextBox>
                        </div>
                        <div class="col-md-2">
                            <label> Dest:Country</label>
                            <asp:TextBox ID="txtdestination" runat="server" CssClass="form-control" placeholder="Dest:Country" class="textfield"></asp:TextBox>
                        </div>
                        <div class="col-md-2">
                            <label>Consignee</label>
                            <asp:TextBox ID="txtconsignee" runat="server" CssClass="form-control" placeholder="Consignee" class="textfield"></asp:TextBox>
                        </div>
                        <div class="col-md-2">
                            <label>Buyer</label>
                            <asp:TextBox ID="txtbuyer" runat="server" CssClass="form-control" class="textfield" placeholder="Buyer" ></asp:TextBox>
                        </div>
                    </div>   
                     <div class="row">
                         <div class="col-md-3">
                             <label>Opening balance</label>
                             <asp:TextBox ID="txtOpeningBlnc" Text="0.00" CssClass="form-control" runat="server" class="textfield decimalOnly" placeholder="Balance"></asp:TextBox>
                         </div>
                    </div>
                    <div class="row">
                    <div class="col-md-12">
                        <label>Note</label>
                        <asp:TextBox ID="txtNote" TextMode="MultiLine" runat="server" CssClass="form-control" placeholder="Note"></asp:TextBox>
                    </div>
                </div>                     
                </div>
                
                        <%-- <ul class="nav nav-tabs">
                          <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="#">Active</a>
                          </li>
                          <li class="nav-item">
                            <a class="nav-link" href="#">Link</a>
                          </li>
                          <li class="nav-item">
                            <a class="nav-link" href="#">Link</a>
                          </li>
                          <li class="nav-item">
                            <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
                          </li>
                        </ul>--%>

       <br />

                <div id="tabMemberShip" style="width: 1130px; margin-top: 7px; margin-bottom: 10px; margin-left: 10px;">
                    <ul class="nav nav-tabs" style="height:55px; background:#00897b;">
                        <li class="nav-item">
                            <a class="nav-link btn btn-default" href="#Address"><span">Address</span></a>

                        </li>
                       <%-- <li class="nav-item">
                            <a class="nav-link btn btn-default" href="#Note"><span>Note</span></a>

                        </li>--%>
                    </ul>
                    <div id="Address">
                        <div class="tabfieldsbottom">
                            <div class="Resiinfo" >
                                <div style="width: 700px;">
                                    <asp:UpdatePanel ID="updateAddress" runat="server">
                                        <ContentTemplate>
                                            <table id="tblAdd" runat="server" visible="true">
                                                <tr>
                                                    <td colspan="2" class="bill">
                                                        <label>Bill Address</label>
                                                    </td>
                                                    <td class="ship" style="width: 194px;">
                                                        <label style="float: left; width: 194px;">Shipping Address</label>
                                                    </td>
                                                    <td style="width: 194px;">
                                                        <asp:CheckBox ID="chkShipAddress" AutoPostBack="true" Text="&#160;Same as billing address" CssClass="chkship" runat="server" OnCheckedChanged="chkShipAddress_CheckedChanged"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:TextBox ID="txtStreet" runat="server" Style="width: 490px; padding-right: 1px; margin:5px;"
                                                            class="textfield" CssClass="form-control" placeholder="Street"></asp:TextBox>
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:TextBox ID="txtShipStreet" runat="server" Style="width: 590px; margin-left: 20px; 
                                                            padding-right: 1px;" CssClass="form-control" class="textfield" placeholder="Street"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtCity" runat="server" Style="width: 179px; padding-right: 1px; margin:5px;" 
                                                            class="textfield" CssClass="form-control" placeholder="City"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtState" runat="server" Style="width: 179px; margin-left: 0px;
                                                            padding-right: 1px;" CssClass="form-control" class="textfield" placeholder="State"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 180px;">
                                                        <asp:TextBox ID="txtShipCity" runat="server" Style="width: 194px; margin-left: 20px;
                                                            padding-right: 1px;" CssClass="form-control" class="textfield" placeholder="City"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtShipState" runat="server" Style="width: 194px; margin-left: 0px;
                                                            padding-right: 1px;" CssClass="form-control" class="textfield" placeholder="State"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtZip" runat="server" Style="width: 299px; padding-right: 1px; margin:5px;"
                                                            class="textfield" CssClass="form-control"  onkeypress="return Verify(event);" placeholder="Zip Code"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtCountry" runat="server" Style="width: 179px; margin-left: 0px;
                                                            padding-right: 1px;" CssClass="form-control" class="textfield" placeholder="Country"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtShipZip" CssClass="form-control" runat="server" Style="width: 390px; margin-left: 20px;
                                                            padding-right: 1px;" class="textfield"  onkeypress="return Verify(event);"
                                                             placeholder="Zip Code"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtShipCountry" CssClass="form-control" runat="server" Style="width: 194px; margin-left: 0px;
                                                            padding-right: 1px;" class="textfield" placeholder="Country"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div style="clear: both">
                    </div>
                   <%-- <div id="Note" style="border-radius: 3px;">
                        <div class="tabfieldsbottom" align="left" style="margin-top: -12px;">
                            <asp:UpdatePanel ID="UpdPnlAdditionInf" runat="server">
                                <ContentTemplate>
                                    <div class="Resiinfo" style="width: 524px; height: 82px; float: left; margin-left: 5px;">
                                        <div class="bottomleftheading" style="font-size: 18px;">
                                            <table id="tblNote" runat="server">
                                                <tr>
                                                    <td>
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div>
                                        </div>
                                    </div>
                                    <div style="clear: both">
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>--%>
                </div>

                <div class="container">
                   
                            <div class="row" style="display:none;">
                                <div class="col-md-3">
                                    <asp:TextBox ID="txtFacebook" runat="server" CssClass="form-control"
                                            class="textfield" placeholder="Facebook"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="txtMessanger" runat="server" CssClass="form-control"
                                            class="textfield" placeholder="(Messanger Type) ID"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="txtSkype" runat="server" CssClass="form-control"
                                            class="textfield" placeholder="Skype"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <asp:TextBox ID="txtGooglePlus" runat="server"  CssClass="form-control"
                                          class="textfield" placeholder="Google+"></asp:TextBox>
                                </div>
                            </div>
                                        
                                   
                                    
                            <div class="row"  style="display:none;">
                                <div class="col-md-4">
                                    <span>Terms</span>
                                        <asp:DropDownList ID="txtTerms" CssClass="form-control" style="height:28px;" runat="server" class="textfield">
                                            <asp:ListItem Value="0">Select</asp:ListItem>
                                            <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                            <asp:ListItem Value="No">No</asp:ListItem>
                                        </asp:DropDownList>
                                </div>
                                <div class="col-md-4">
                                    
                                </div>
                                <div class="col-md-4">
                                    <span style="margin-left: 20px;">As of</span>
                                        <asp:TextBox ID="txtASDate" CssClass="DateTimePicker form-control" runat="server" class="textfield" placeholder="Date"></asp:TextBox>
                                </div>
                                    
                                        
                                    
                                        
                                    
                                        
                                    
                               
                            </div>
                      
                   
                            <table style="float: right; width: 200px; margin:5px;">
                                <tr>
                                    <td rowspan="2">
                                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save" Style="width: 80px; height: 25px;
                                            margin: 5px 0 0 20px;" ValidationGroup="validate" OnClick="btnSave_Click"
                                             />
                                    </td>
                                    <td rowspan="2">
                                        <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-primary" Text="Cancel" Style="width: 80px; height: 25px;
                                            margin: 5px 0 0 08px;" OnClick="btnCancel_Click"  />
                                    </td>
                                    <td rowspan="2">
                                    </td>
                                </tr>
                            </table>
                       
                   
                </div>
            
       
    </div>
         </div>
</asp:Content>
