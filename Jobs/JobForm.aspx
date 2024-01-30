<%@ Page Title="Create/Modify Job" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="JobForm.aspx.cs" Inherits="Jobs_JobForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
 <script src="Script/jquery-1.6.2.min.js" type="text/javascript" charset="utf-8"></script>
 <script src="Script/jquery-ui-1.8.16.custom.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        $(document).ready(function() {
         MyDate();

        

        
            
   });

        $(document).ready(function () {
            $('#Shippingline').click(function () {
                $('#ModalNewShippingLine').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
                $('#ModalNewShippingLine').find('select').val('0');
                enabledModal('ModalNewShippingLine');
                showhidecontrol('btnSave', true);
            })
        });

        
//        $(function () {
//            $("#txtDeliveryDate").datepicker();
        //        });

        function MyDate() {

            $(".DateTimePicker").datepicker();
        }      

    </script>
    <style type="text/css">
        .btn_1
        {
            height: 30px;
            width: 100px;
            line-height: 27px;
            background-color: #029FE2;
            border-radius: 4px;
            color: #EDF6E3;
            font-size: 12px;
            border: 1px solid #029FE2;
        }
        .btn_1:hover
        {
            background-color: #2C8CB4;
        }
        .btn_spacing
        {
            margin-right: 5px;
        }
 
        .float_right
        {
            float: right;
        }
        #ctl00_ContentPlaceHolder1_btnSave{
             border:none;
            color:white;
            background:#009688;
            font-style:normal;
        }
        #ctl00_ContentPlaceHolder1_btnCancel{
             border:none;
            color:white;
            background:#009688;
            font-style:normal;
        }
        #ctl00_ContentPlaceHolder1_btnSaveShippingLine{
             border:none;
            color:white;
            background:#009688;
            font-style:normal;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <script type="text/javascript">

                            $(document).ready(function () {
                                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                                function EndRequestHandler(sender, args) {
                                    $('#Shippingline').click(function () {
                                        $('#ModalNewShippingLine').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
                                        $('#ModalNewShippingLine').find('select').val('0');
                                        enabledModal('ModalNewShippingLine');

                                        showhidecontrol('btnSave', true);
                                    });

                                }
                            });

                        </script>
    
        <div class="modal fade modal-primary" id="ModalNewShippingLine" aria-hidden="true"
        aria-labelledby="ModalUserRole" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
          <div class="modal-dialog" style="width:800px;">
            <div class="modal-content">
        <asp:UpdatePanel ID="UpShippingLine" runat="server">
            <ContentTemplate>
                 <div class="modal-header">
                    <h4 class="modal-title">New Shipping Line</h4>
                </div> 
               <div class="container">
                 <div class="row" style="padding:10px;">
                    <div class="col-md-6">
                         <label>Shipping Line</label>
                            <asp:TextBox ID="txtShippingLine" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-2" style="margin-top:26px;">
               <asp:Button ID="btnSaveShippingLine" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSaveShippingLine_Click" />
                </div>
                    <div class="col-md-2"></div>
                </div>
                   </div>
                 <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
                </div> 
          </div> 
        </div> 
    

   <div class="panel panel-bordered panel-primary">

                <div class="panel-heading form-group">
                    <h3 class="panel-title">Create/Modify Job</h3>
                </div>
            <div class="Update_area">                
                <div id="StausMsg"></div>

        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate> 
      
                <table style="float: left; width: 800px; margin-left: 15px;">
                <tr>
                    <td rowspan="6" style="text-align: left">
                        <%-- Success --%>
                        <div id="Notification_Success" style="display: none; width: 98%; margin: auto;">
                            <div class="alert-green">
                                <h4>Success:</h4>
                                <asp:Label ID="lblmsg" runat="server" Style="color: White"></asp:Label>
                            </div>
                        </div>
                        <%--Error Message--%>
                        <div id="Notification_Error" style="display: none; width: 98%; margin: auto;">
                            <div class="alert-red">
                                <h4>Error!</h4>
                                <asp:Label ID="lblNewError" runat="server" Style="color: White">
                                </asp:Label>
                            </div>
                        </div>
                        <%-- End --%>
                    </td>
                </tr>
            </table>

            <div style="clear:both;"></div>

                            <div class="container">
                                <div class="row" style="padding:10px;">
                                    <div class="col-md-4">
                                        <label>Job Number</label>
                                        <asp:TextBox ID="txtJobNumber" runat="server" CssClass="form-control" placeholder="Job Number" require="Enter Job Number" validate="group"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                         <label>Contact Number</label>
                                         <asp:TextBox ID="txtContactNum" CssClass="form-control" runat="server" placeholder="Contact Number"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                        <label>Customer</label>
                                    <asp:DropDownList DataSourceID="sqlDSUser" DataValueField="CustomerID" DataTextField="DisplayName"
                                            ID="ddlUser" runat="server"
                                            custom="Select User" customFn="var u = parseInt(this.value); return u > 0;"
                                            validate="group" CssClass="form-control">
                                        </asp:DropDownList>
                                    <asp:SqlDataSource ID="sqlDSUser" ConnectionString="<%$ ConnectionStrings:ASCS %>"
                                        SelectCommand="SELECT CustomerID,DisplayName FROM Customer" SelectCommandType="Text" runat="server"></asp:SqlDataSource>
                                    </div>
                               


                               
                                     <div class="col-md-4">
                                     <label>Job Description</label>
                                    <asp:TextBox ID="txtJobDescription" runat="server" require="Enter Job Description" validate="group"
                                        CssClass="form-control" placeholder="Job Description"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                        <label>Container</label>
                         <asp:TextBox ID="txtContainer" runat="server" CssClass="form-control" placeholder="Container"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                        <label>Container No</label>
                        <asp:TextBox ID="txtContainerNo" runat="server" CssClass="form-control" placeholder="Container No"></asp:TextBox>
                                    </div>
                                

                                    <div class="col-md-4">
                                        <label>L/C No.</label>
                        <asp:TextBox ID="txtLCNo" runat="server" CssClass="form-control" placeholder="L/C No."></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                        <label>L/C Date</label>
                         <asp:TextBox ID="txtContainerDate" runat="server" CssClass="DateTimePicker form-control" placeholder="L/C Date"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                        <label>IGM No</label>
                    <asp:TextBox ID="txtIGMNo" runat="server" CssClass="form-control" placeholder="IGM No"></asp:TextBox>
                                    </div>


                                    <div class="col-md-4">
                                        <label>IGM Date</label>
                    <asp:TextBox ID="txtIGMDate" runat="server" CssClass="DateTimePicker form-control" placeholder="IGM Date"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                         <label>Index No</label>
                     <asp:TextBox ID="txtIndexNo" runat="server" CssClass="form-control" placeholder="Index No"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                        <label>S.S/Flight No.</label>
                    <asp:TextBox ID="txtSS" runat="server" CssClass="form-control" placeholder="S.S"></asp:TextBox>
                                    </div>

                                    <div class="col-md-4">
                                        <label>QTY</label>
                    <asp:TextBox ID="txtQTY" runat="server" CssClass="form-control" placeholder="Quantity"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                        <label>B.E.Cash No</label>
                    <asp:TextBox ID="txtBECashNo" runat="server" CssClass="form-control" placeholder="B.E.Cash No"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                         <label>Machine No.</label>
                    <asp:TextBox ID="txtMachineNo" runat="server" class="form-control" placeholder="Machine No."></asp:TextBox>
                                    </div>

                                    <div class="col-md-4">
                                        <label>Machine Date</label>
                    <asp:TextBox ID="txtMachineDate" runat="server" CssClass="DateTimePicker form-control" placeholder="Machine Date"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                         <label>Delivery Date</label>
                    <asp:TextBox ID="txtDeliveryDate" runat="server" CssClass="DateTimePicker form-control" placeholder="Delivery Date"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                        <label>CNF Value</label>
                    <asp:TextBox ID="txtCNFValue" runat="server" CssClass="decimalOnly form-control" placeholder="CNF Value"></asp:TextBox>
                                    </div>



                                    <div class="col-md-4">
                                        <label>Import Value</label>
                     <asp:TextBox ID="txtImportValue" runat="server" CssClass="decimalOnly form-control" placeholder="Import Value"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                         <label>B/L NO./AWB</label>
                    <asp:TextBox ID="txtBLNo" runat="server" CssClass="form-control" placeholder="B/L No."></asp:TextBox>
                                    </div>
                                    <div class="col-md-3">
                                         <label>Shipping Line</label>
                    <asp:DropDownList ID="ddlShippingLine" style="width: 120%;" runat="server" CssClass="form-control" validate="group" custom="Select Shipping Line" customFn="var IDescID = parseInt(this.value); return IDescID > 0;"></asp:DropDownList>
                                    </div>
                                    <div class="col-md-1">
                                        <asp:LinkButton runat="server" CssClass="btn btn-primary" ID="Shippingline" data-toggle="modal" data-target="#ModalNewShippingLine" style="margin-left: 23px;margin-top: 26px;">
                                             <i class="fa fa-plus"></i>
                                        </asp:LinkButton>
                                    </div>


                                    <div class="col-md-4">
                                         <label class="company"></label>
                            <asp:CheckBox ID="chkComplete" runat="server" Text="Complete" />
                                    </div>
                                    

                                 </div>
                                <div class="row" style="margin:10px;">
                                    <div class="col-md-8"></div>
                                    <div class="col-md-4" style="text-align:right;">
                                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClientClick="return validate('group');" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                                    
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-default" PostBackUrl="~/JobFormList.aspx" />
                                    </div>
                                    
                                </div>
                            </div>
               
                        
                        
       
        </ContentTemplate>
                </asp:UpdatePanel>
                </div>
                </div>
                
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
