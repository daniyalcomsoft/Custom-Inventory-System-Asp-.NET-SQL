<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="VendorForm.aspx.cs" Inherits="Purchase_VendorForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script type="text/javascript" language="javascript">

        $(document).ready(function() {
            MyDate();
            //$(".datepicker").datepicker();
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
    text-align:center;
    width:100%;
    font-size:12px;
}

select 
{
    border: 1px solid #CCC;
    height: 25px;
    line-height: 20px;
    border-image: initial;
}
.bodyarea
{
    width:800px;
    height:480px auto;
}
.bodyarea h1
{
    font-family:Arial;
    font-weight:bold;
    font-size:18px;
    text-align:left;
}
.name
{
    width:150px;
    text-align:left;
}
.title
{
    width:50px;
    text-align:left;
}
.fname
{
    width:120px;
    text-align:left;
}
.lname
{
    width:120px;
    text-align:left;
}
.suffix
{
    width:70px;
    text-align:left;
}
.email
{
    text-align:left;
}
input[type=text],textarea,input[type=password]
{
	border-radius: 2px 2px 2px 2px;
    border:1px solid #CCCCCC;
    height:25px;   
}
.email label{margin-left:20px;}
.company
{
    text-align:left;
}
.phone
{text-align:left;
}
.mobile
{text-align:left;
}
.fax
{
    text-align:left;
}
.phone label{margin-left:20px;}
.mobile label{margin-left:0px;}
.fax label{margin-left:0px;}
.disp
{
    text-align:left;
}
.other
{
    text-align:left;
}
.website
{
    text-align:left;
}
.disp span{color:#ee0000;}
.other label{margin-left:20px;}
.website label{margin-left:0px;}

.bill
{
    text-align:left;
}
.ship
{
    text-align:left;
}
.ship label{margin-left:20px;}
.chkship
{
    margin-left:40px;
}
.terms
{
    text-align:left;
}
.openBlnc
{
    text-align:left;
}
.AsofDate label
{
    text-align:left;
    margin-left:20px;
}

  table tr td
        {
             font-size: 12px;
    font-weight: bold;
            padding-right: 1px;
            text-align: left;
            font-family: Verdana, Geneva, sans-serif;
            font-size: 12px;
        }
.tabfieldsbottom {
width: 864px;
height: 90%;
margin: 0px 0px 0px -20px;
}

.highlight,highlight:focus
{
    /*background-image: none !important;
    background-color: #fffacd !important;	
	background: url("../images/arrow.png") repeat-x scroll 50% 50% #FEF1EC;*/
    border: 1px solid #CD0A0A !important;
    color: Black;line-height: 33px;
}

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <asp:HiddenField ID="hdnMinDate" runat="server" />
           <asp:HiddenField ID="hdnMaxDate" runat="server" />
     <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title">Create/Modify Vendor</h3>
                </div>
    <div class="Update_area">
    <div id="StausMsg"></div>
    
        <div class="container">
            <div class="row">
                <div class="col-md-2">
                    <label>Title</label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Mr."></asp:TextBox>
                </div>
                <div class="col-md-2">
                    <label>First Name</label>
                    <asp:TextBox ID="txtfirstName" runat="server" CssClass="form-control" ValidationGroup="validate" placeholder="First Name"></asp:TextBox>
                    <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtfirstName"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-2">
                    <label>Last Name</label>
                     <asp:TextBox ID="txtlastName" runat="server" CssClass="form-control" placeholder="Last Name"></asp:TextBox>
                </div>
                <div class="col-md-2">
                    <label>Suffix</label>
                     <asp:TextBox ID="txtSuffix" runat="server" CssClass="form-control" placeholder="Suffix"></asp:TextBox>
                </div>
                <div class="col-md-4">
                     <label>Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ValidationGroup="validate" email="example@address.com" placeholder="Email" ></asp:TextBox>
                    <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtEmail"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                </div>

                </div>
            
                <div class="row">
                <div class="col-md-6">
                    <label>Company/ Vendor</label>
                    <asp:TextBox ID="txtCompany" runat="server" ValidationGroup="validate" CssClass="form-control" placeholder="Comapny Name" ></asp:TextBox>
                    <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtCompany"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-2">
                    <label>Phone</label>
                    <asp:TextBox ID="txtPhone" runat="server" ValidationGroup="validate" CssClass="form-control" placeholder="Phone" ></asp:TextBox>
                    <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtPhone"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-2">
                    <label>Mobile</label>
                     <asp:TextBox ID="txtMobile" runat="server" ValidationGroup="validate" CssClass="form-control" placeholder="Mobile" ></asp:TextBox>
                    <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtMobile"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-2">
                    <label>Fax</label>
                    <asp:TextBox ID="txtFax" runat="server" CssClass="form-control" placeholder="Fax" ></asp:TextBox>
                </div>



                     </div>
            
                <div class="row">


                <div class="col-md-6">
                    <label>Display Name As</label>
                    <asp:TextBox ID="txtDisplayName" runat="server" ValidationGroup="validate" require="Please enter a unique Display Name" CssClass="form-control" placeholder="Display Name" ></asp:TextBox> 
                    <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtDisplayName"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-2">
                    <label>Other</label>
                    <asp:TextBox ID="txtOther" runat="server" CssClass="form-control" placeholder="Other" ></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <label>Website</label>
                     <asp:TextBox ID="txtWebsite" runat="server" CssClass="form-control" placeholder="Website" ></asp:TextBox> 
                </div>

                 </div>
            
                
            
                <div class="row">

                <div class="col-md-6">
                    <label> Print On Check As</label>
                     <asp:CheckBox ID="chkPrintDispName" Text="&#160;Use Display Name" runat="server" />
                    <asp:TextBox ID="txtPrint" runat="server" CssClass="form-control" ></asp:TextBox>
                </div>
                <div class="col-md-2">
                    <label>Bank</label>
                    <asp:TextBox ID="txtBank" runat="server" ValidationGroup="validate" CssClass="form-control" placeholder="Bank" ></asp:TextBox>
                    <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtBank"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-2">
                    <label>Account No.</label>
                    <asp:TextBox ID="txtAccNo" runat="server" ValidationGroup="validate" CssClass="form-control" placeholder="Account No." ></asp:TextBox>
                    <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtAccNo"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-2">
                    <label>IBAN No.</label>
                    <asp:TextBox ID="TxtIBAN" runat="server" ValidationGroup="validate" CssClass="form-control" placeholder="IBAN No." ></asp:TextBox>
                    <asp:RequiredFieldValidator  runat="server" ControlToValidate="TxtIBAN"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                </div>
               
            </div>

            <div class="row">
                <div class="col-md-3">
                    <label>NTN No.</label>
                    <asp:TextBox ID="txtntn" runat="server" ValidationGroup="validate" require="Please enter NTN No" CssClass="form-control" placeholder="NTN No" ></asp:TextBox> 
                    <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtntn"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-3">
                    <label>CNIC No.</label>
                    <asp:TextBox ID="txtcnic" runat="server" ValidationGroup="validate" require="Please enter CNIC No" CssClass="form-control" placeholder="CNIC No" ></asp:TextBox> 
                    <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtcnic"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-3">
                    <label>GST No.</label>
                    <asp:TextBox ID="txtgst" runat="server" ValidationGroup="validate" require="Please enter GST No" CssClass="form-control" placeholder="GST No" ></asp:TextBox> 
                    <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtgst"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate" ></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-3">
                    <label>Opening balance</label>
                    <asp:TextBox ID="txtOpeningBlnc" Text="0.00" CssClass="form-control" runat="server" class="textfield decimalOnly" placeholder="Balance"></asp:TextBox>
                </div>

                     </div>

            <div class="row">
                <div class="col-md-12">
                    <label>Note</label>
                    <asp:TextBox ID="txtNote" TextMode="MultiLine" runat="server" CssClass="form-control" class="textfield" ></asp:TextBox>
                </div>
            </div>
            
                      <br />              
                               
                                    
                               


                
                <div id="tabMemberShip" style="width: 1120px; margin-top: 7px;margin-bottom:10px;">
             <ul class="nav nav-tabs" style="height:55px; background:#00897b;">
                        <li class="nav-item">
                            <a class="nav-link btn btn-default" href="#Address"><span">Address</span></a>

                        </li>
                       <%-- <li class="nav-item">
                            <a class="nav-link btn btn-default" href="#Note"><span>Note</span></a>

                        </li>--%>
                    </ul>
            <div id="Address" style="">
                <div class="tabfieldsbottom" align="left" style="margin-top: -12px;">
                    <asp:UpdatePanel ID="UpdPnlResidenceInf" runat="server">
                        <ContentTemplate>
                            <div class="Resiinfo" style="width: 371px; float: left; margin-left: 5px;">
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
                                    <asp:TextBox ID="txtStreet" runat="server" Style="width: 550px; padding-right: 1px;"
                                        class="textfield" placeholder="Street" CssClass="form-control" ></asp:TextBox>
                                        </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtShipStreet" runat="server" Style="width: 520px; margin-left:20px; padding-right: 1px;"
                                        class="textfield" placeholder="Street" CssClass="form-control" ></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtCity" runat="server" Style="width: 179px; padding-right: 1px; margin-top:10px;"
                                        class="textfield" placeholder="City" CssClass="form-control" ></asp:TextBox></td>
                                <td>
                                    <asp:TextBox ID="txtState" runat="server" Style="width: 179px; margin-left:190px; padding-right: 1px;"
                                        class="textfield" placeholder="State" CssClass="form-control" ></asp:TextBox>
                                </td>
                                <td style="width: 180px;">
                                <asp:TextBox ID="txtShipCity" runat="server" Style="width: 194px; margin-left:20px; padding-right: 1px;"
                                        class="textfield" placeholder="City" CssClass="form-control" ></asp:TextBox></td>
                                <td><asp:TextBox ID="txtShipState" runat="server" Style="width: 194px; margin-left:131px; padding-right: 1px;"
                                        class="textfield" placeholder="State" CssClass="form-control" ></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtZip" runat="server" Style="width: 179px; padding-right: 1px; margin-top:5px;"
                                        class="textfield" onkeypress="return Verify(event);" placeholder="Zip Code" CssClass="form-control" ></asp:TextBox></td>
                                <td><asp:TextBox ID="txtCountry" runat="server" Style="width: 179px; margin-left:190px; padding-right: 1px;"
                                        class="textfield" placeholder="Country" CssClass="form-control" ></asp:TextBox></td>
                                <td><asp:TextBox ID="txtShipZip" onkeypress="return Verify(event);" runat="server" Style="width: 194px; margin-left:20px; padding-right: 1px;"
                                        class="textfield" placeholder="Zip Code" CssClass="form-control" ></asp:TextBox></td>
                                <td><asp:TextBox ID="txtShipCountry" runat="server" Style="width: 194px; margin-left:131px; padding-right: 1px;"
                                        class="textfield" placeholder="Country" CssClass="form-control" ></asp:TextBox></td>
                            </tr>
                        </table>
                                        </ContentTemplate>
                                 </asp:UpdatePanel>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                
            </div><div style="clear:both"></div>
            <%--<div id="Note" style="border-radius: 3px;">
                <div class="tabfieldsbottom" align="left" style="margin-top: -12px;">
                    <asp:UpdatePanel ID="UpdPnlAdditionInf" runat="server">
                        <ContentTemplate>
                            <div class="Resiinfo" style="width: 524px;height: 82px; float: left; margin-left: 5px;">
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
                            <div style="clear:both"></div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>--%>
            
        </div>
                
                
            
                            <div class="row" style="display:none">
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
                                        
                                   
                                    
                            <div class="row" style="display:none">
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
              
            <div class="row">
                                <div class="col-md-10"></div>
                                <div class="col-md-2" style="margin-top:5px; margin-bottom:5px;">
                                     <asp:LinkButton ID="btnSave" runat="server" Text="Save" ValidationGroup="validate" CssClass="btn btn-primary" onclick="btnSave_Click" />
                                    <asp:LinkButton ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-primary" onclick="btnCancel_Click" />
                                </div>
            </div>
                   
                                   
                                
           
        </div>
    
</div>
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

</asp:Content>

