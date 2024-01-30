<%@ Page Title="Received Voucher" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="GLCashRecievedVoucher.aspx.cs" Inherits="Transactions_GLCashRecievedVoucher" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <%--<script src="Script/jquery-1.6.2.min.js" type="text/javascript" charset="utf-8"></script>

    <script src="Script/jquery-ui-1.8.16.custom.min.js" type="text/javascript" charset="utf-8"></script>--%>

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            CreateModalPopUp("#PrintReport", 820, 630, "Print Report");
            CreateModalPopUp('#Confirmation', 280, 120, 'ALERT');
            //  $(".ui-icon-closethick:eq(0)").click(function() {
            //   $("[id $= txtBalance]").text("0");
            //         });
            //            $("[id $= lbtnNo]").click(function() {
            //               $("[id $= txtBalance]").text("0");
            //                        });
            MyDate();
            ChangeDateEvent();
            Load_AutoComplete_Code();
            Load_AutoComplete_Code2();
     
            $('#FindAccount,#FindAccount2,#FindJobs').dialog({
                autoOpen: false,
                draggable: true,
                title: "Find",                
                width: 972,
                height: 450,
                open: function(type, data) {
                    $(this).parent().appendTo("form");
                }
            });
        });
        
       

       
        function Load_AutoComplete_Code() {  
        
            $("[id$=txtCodeGrid]").autocomplete({
                source: function(request, response) {
                $("[id $= txtTitleGrid]").val('');  
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: '/Services/GetData.asmx/GetAccountCodeTitle',
                        data: "{ 'Match': '" + request.term + "'}",
                        dataType: "json",
                        success: function(data) {
                            response($.map(data.d, function(item) {
                                return {
                                    label: item.CodeTitle,
                                    value: item.AccCode,
                                    Title: item.Title,
                                    accMain: item.AccMain,
                                    accControl: item.AccControl,
                                    accSub: item.AccSubsidary
                                }
                            }))
                        }
                    });
                },
                minLength: 3,
                select: function(event, ui) {
                
                    $("[id$=txtTitleGrid]").val(ui.item.Title);
                    $("[id$=HidTitle]").val(ui.item.Title);
                }
            });
            $('.autoCompleteCodes').autocomplete({
                source: function(request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: '/Services/GetData.asmx/GetAccountCodeTitle',
                        data: "{ 'Match': '" + request.term + "'}",
                        dataType: "json",
                        success: function(data) {
                            response($.map(data.d, function(item) {
                                return {
                                    label: item.CodeTitle,
                                    value: item.AccCode,
                                    Title: item.Title,
                                    currBal: item.Balance
                                }

                            }))
                        }
                    });
                },
                minLength: 3,
                select: function(event, ui) {
                //if ($(this).attr("id").slice($(this).attr("id").lastIndexOf("_") + 1) != "") 
                if ($(this).attr("id").indexOf("txtAccountNo") < 0)
                {
                        $('#' + $(this).attr('id') + 'lbl').text(ui.item.Title);
                        $("[id$=txtBalance]").text(ui.item.currBal);
                        $("[id$=txtBalanceHidden]").val(ui.item.currBal);
                        $("[id$=titlecode]").val(ui.item.Title);
                    }
                }
            });
        }
        
        function Load_AutoComplete_Code2() {

            $("[id$=txtCode]").autocomplete({
                source: function (request, response) {
                    $("[id $= txtTitleGrid]").val('');
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: '/Services/GetData.asmx/GetAccountCodeTitle2',
                        data: "{ 'Match': '" + request.term + "'}",
                        dataType: "json",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.CodeTitle,
                                    value: item.AccCode,
                                    Title: item.Title,
                                    accMain: item.AccMain,
                                    accControl: item.AccControl,
                                    accSub: item.AccSubsidary
                                }
                            }))
                        }
                    });
                },
                minLength: 3,
                select: function (event, ui) {

                    $("[id$=txtTitleGrid]").val(ui.item.Title);
                    $("[id$=HidTitle]").val(ui.item.Title);
                }
            });
            $('.autoCompleteCodes2').autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: '/Services/GetData.asmx/GetAccountCodeTitle2',
                        data: "{ 'Match': '" + request.term + "'}",
                        dataType: "json",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.CodeTitle,
                                    value: item.AccCode,
                                    Title: item.Title,
                                    currBal: item.Balance
                                }

                            }))
                        }
                    });
                },
                minLength: 3,
                select: function (event, ui) {
                    //if ($(this).attr("id").slice($(this).attr("id").lastIndexOf("_") + 1) != "") 
                    if ($(this).attr("id").indexOf("txtAccountNo2") < 0) {
                        $('#' + $(this).attr('id') + 'lbl').text(ui.item.Title);
                        $("[id$=txtBalance]").text(ui.item.currBal);
                        $("[id$=txtBalanceHidden]").val(ui.item.currBal);
                        $("[id$=titlecode]").val(ui.item.Title);
                    }
                }
            });


            $("[id$=txtJobNumber]").autocomplete({
                source: function (request, response) {
                    $("[id $= txtTitle],[id$=hdnJobNumber]").val('');
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: '/Services/GetData.asmx/GetJobByNumber',
                        data: "{ 'Match': '" + request.term + "'}",
                        dataType: "json",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.JobNumber,
                                    value: item.JobNumber,
                                    JobID: item.JobID
                                }
                            }))
                        }
                    });
                },
                minLength: 2,
                select: function (event, ui) {
                    $("[id$=txtJobNumber]").val(ui.item.value);
                    $("[id$=hdnJobNumber]").val(ui.item.JobID);
                }
            });
        }       
       

        function MyDate() {
        dateMin = $("[id $= hdnMinDate]").val();
        dateMax = $("[id $= hdnMaxDate]").val();
        $(".DateTimePicker").datepicker({ minDate: new Date(dateMin), maxDate: new Date(dateMax) });
    }
        
        
        
        
         function ChangeDateEvent() {

            $("[id $= txtDate]").change(function() {

                dateMin = $("[id $= hdnMinDate]").val();
                dateMax = $("[id $= hdnMaxDate]").val();
                var invoiceDate = $("[id$=txtDate]").val();


                if (Date.parse(invoiceDate) < Date.parse(dateMin) || Date.parse(invoiceDate) > Date.parse(dateMax)) {
                    $("[id$=txtDate]").val('');
                }


            });
        }
        function ValidateDebitCredit(){    
        if($('.Credit').val() == "")
        {
	        $('.Credit').css('border-color','red');
	        return false;
        }
        else
        {
            $('.Credit').removeAttr('border-color');
        }
        return validate('codeadd');
        }
        function Verify(event) {
         var charCode = (event.which) ? event.which : event.keyCode
         if (charCode != 9) {
         if (charCode > 31 && (charCode < 48 || charCode > 57))
            if(charCode != 46)
            {
                event.preventDefault();
            } 
        }
        return true;
        }
        function NullVal() {
            if ($("[id$=txtCodeGrid]").val().length < 3) {
                $("[id$=txtCodeGrid]").val("");
            }
        }
        function CheckNullVal(elem) {
            if ($(elem).val().length < 2) {
                $("[id$=hdnJobNumber]").val("");
            }
        }
        $(document).ready(function () {
            $('#btnFind').click(function () {
                $('#ModalFindJobs').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
                $('#ModalFindJobs').find('select').val('0');
                enabledModal('ModalFindJobs');
                showhidecontrol('btnSave', true);
            })
        });
        $(document).ready(function () {
            $('#btnFindACNO').click(function () {
                $('#ModalFindACNO').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
                $('#ModalFindACNO').find('select').val('0');
                enabledModal('ModalFindACNO');
                showhidecontrol('btnSave', true);
            })
        });

        $(document).ready(function () {
            $('#btnNew').click(function () {
                $('#AdditionalInfo').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
                $('#AdditionalInfo').find('select').val('0');
                showhidecontrol('btnSave', true);
                enabledModal('AdditionalInfo');
            })
        });

        function isFloatNumber(e, t) {
            var n;
            var r;
            if (navigator.appName == "Microsoft Internet Explorer" || navigator.appName == "Netscape") {
                n = t.keyCode;
                r = 1;
                if (navigator.appName == "Netscape") {
                    n = t.charCode;
                    r = 0
                }
            } else {
                n = t.charCode;
                r = 0
            }
            if (r == 1) {
                if (!(n >= 48 && n <= 57 || n == 46)) {
                    t.returnValue = false
                }
            } else {
                if (!(n >= 48 && n <= 57 || n == 0 || n == 46)) {
                    t.preventDefault()
                }
            }
        }

       
    </script>

    <style type="text/css">
        /*td[align='right'] > span
        {
            float: none !important;
        }
        td[align='center'] > span
        {
            float: none !important;
        }
        td[align='left'] > span
        {
            float: none !important;
        }
        .textarea > .alertbox div
        {
            margin-top: -20px;
        }
        .alertbox div
        {
            margin-top: 0px;
        }*/
        #ctl00_ContentPlaceHolder1_btnFindJob{
            border:none;
            color:white;
            background:#009688;
            font-style:normal;
        }
        #ctl00_ContentPlaceHolder1_btnFindAcc{
            border:none;
            color:white;
            background:#009688;
            font-style:normal;
        }
        #ctl00_ContentPlaceHolder1_btnFindAcc2{
            border:none;
            color:white;
            background:#009688;
            font-style:normal;
        }

      
        
.box {
  width: 40%;
  margin: 0 auto;
  background: rgba(255,255,255,0.2);
  padding: 35px;
  border: 2px solid #fff;
  border-radius: 20px/50px;
  background-clip: padding-box;
  text-align: center;
}

.overlay {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.7);
  transition: opacity 500ms;
  visibility: hidden;
  opacity: 0;
}
.overlay:target {
  visibility: visible;
  opacity: 2;
}

.popup {
    margin-top:30px;
  margin: 70px auto;
  padding: 20px;
  background: #fff;
  border-radius: 5px;
  width: 30% !important;
  position: relative;
  
}

.popup h2 {
  margin-top: 0;
  color: #333;
  font-family: Tahoma, Arial, sans-serif;
}
.popup .close {
  position: absolute;
  top: 20px;
  right: 30px;
  transition: all 200ms;
  font-size: 30px;
  font-weight: bold;
  text-decoration: none;
  color: #333;
}
.popup .close:hover {
  color: #06D85F;
}
.popup .content {
  max-height: 30%;
}

.content{
    width:90% !important;
}

@media screen and (max-width: 700px){
  .box{
    width: 70%;
  }
  .popup{
    width: 70%;
  }
}
 

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanelMain" runat="server">
        <ContentTemplate>
             
            <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title">   Cash Receipt Voucher</h3>
                </div>
            <div class="Update_area">
                <div class="Heading">
                
                   
                            
                </div>
                <div id="StausMsg">
                </div>
                <br />
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <script type="text/javascript">

                            $(document).ready(function () {
                                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                                function EndRequestHandler(sender, args) {
                                    $('#btnFind').click(function () {
                                        $('#ModalFindJobs').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
                                        $('#ModalFindJobs').find('select').val('0');
                                        enabledModal('ModalFindJobs');

                                        showhidecontrol('btnSave', true);
                                    });

                                }
                            });

                            function showHideDiv(ele) {
                                var srcElement = document.getElementById(ele);
                                if (srcElement != null) {
                                    if (srcElement.style.display == "block") {
                                        srcElement.style.display = 'none';
                                    }
                                    else {
                                        srcElement.style.display = 'block';
                                    }
                                    return false;
                                }
                            }


                        </script>
                       
                    
        
                                    <div class="col-md-8"></div>
                             <div class="row" style="margin:10px;">
                                    <div class="col-md-4">
                                        <label>Voucher Type:</label>
                                        <asp:DropDownList ID="cmbVoucherType" runat="server" CssClass="form-control" Width="300">
                                        <asp:ListItem Enabled="true" Text="-- Select Voucher Type --" Value="-1"></asp:ListItem>
                                        <asp:ListItem Text="Cash Receipt" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Bank Receipt" Value="2"></asp:ListItem>
                                        </asp:DropDownList>
                                     </div>
                                     <div class="col-md-4">
                                    <label>Number:</label>
                                   
                                   
                                    <asp:TextBox ID="txtVoucherNumber" runat="server" Width="300" ReadOnly="True"
                                        AutoPostBack="True" placeholder="Number" CssClass="form-control"></asp:TextBox>
                                        </div>

                                  <div class="col-md-4">
                                    <label>Reference Number:</label>
                                
                                    <asp:TextBox ID="txtRefNumber" 
                                        runat="server" MaxLength="50" Width="300" CssClass="form-control" placeholder="Reference Number">
                                    </asp:TextBox>
                                    
                                </div>
                               <asp:Label ID="lblRefNo" runat="server" ForeColor="Red"></asp:Label>
                                   
                                </div>


                                    <asp:HiddenField ID="hdnJobNumber" runat="server" />
                               
                            
                          
                            <div class="row" style="margin:10px;">
                               
                                <div class="col-md-4">
                                
                                    <label>Date:</label>
                                
                                    <asp:TextBox ID="txtDate" Width="300" CssClass="DateTimePicker form-control" runat="server"
                                        require="Enter Voucher Date"  validate="savevoucher" AutoComplete="Off"
                                        placeholder="Date"></asp:TextBox>
                                 </div>
                                

                                <div class="col-md-2">
                                            <label>Account (from Debit):</label>
                                        
                                            <asp:Label ID="lblTransID" runat="server" Text="" Visible="false"></asp:Label>
                                            <asp:TextBox require="Enter Cash Account" CssClass="autoCompleteCodes2 form-control" Width="250"
                                                validate="savevoucher" ID="txtCode" runat="server" 
                                                placeholder="Cash Account" ></asp:TextBox>
                                    </div>
                                 <div class="col-md-3" style="margin-top:26px; margin-left:73px;">
                                            <asp:LinkButton ID="lnkbtnfind2" data-toggle="modal" data-target="#ModalFindACNO2" Text="Search" runat="server" CausesValidation="False" CssClass="search btn btn-primary"
                                                OnClick="lnkbtnfind2_Click">
                                                <i class="fa fa-search"></i>
                                            </asp:LinkButton>
                                        </div>
                                 </div>
                                            <asp:Label ID="txtCodelbl" runat="server" Text="" ForeColor="#2C8CB4"></asp:Label>
                                            <input id="titlecode" runat="server" type="hidden" />
                                        
                                            <asp:Label ID="lblbalance" runat="server" ForeColor="#2C8CB4" Text=""></asp:Label>
                                            <asp:HiddenField ID="txtBalanceHidden" runat="server" />
                                            <asp:Label ID="txtBalance" ForeColor="#2C8CB4" runat="server" Text=""></asp:Label>
                                       
                                
                           
                      
                         <div class="row" style="margin:10px;">
                                <div class="col-md-12">
                                    <label>Narration:</label>
                                
                                    <asp:TextBox ID="txtNarration" runat="server"
                                        TextMode="MultiLine" CssClass="form-control" placeholder="Narration"></asp:TextBox>                                                   
                                      </div>
                                <div style="float: right; margin-top: 6px;">
                                <asp:LinkButton ID="LinkButtonBack" CssClass="btn btn-primary" runat="server" Text="Back To List"
                                    OnClick="LinkButtonBack_Click" />
                            </div>
                           </div> 

                        <div style="clear: both;">
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <script type="text/javascript">

                            $(document).ready(function () {
                                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                                function EndRequestHandler(sender, args) {
                                    $('#btnFindACNO').click(function () {
                                        $('#ModalFindACNO').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
                                        $('#ModalFindACNO').find('select').val('0');
                                        enabledModal('ModalFindACNO');

                                        showhidecontrol('btnSave', true);
                                    });

                                }
                            });

                            

                        </script>


                            <div class="container-fluid">
                           
                            <asp:GridView ID="GridTrans" CssClass="data main table table-bordered table-responsive" runat="server" AutoGenerateColumns="False"
                                DataKeyNames="TransactionID" ShowFooter="True" OnRowDataBound="GridTrans_RowDataBound">
                                <Columns>

                                    <asp:TemplateField HeaderText="SNo.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSno" runat="server" Text='<%# Eval("Sno") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Code">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCode" runat="server" Text='<%# Eval("Code") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <div>
                                                <asp:TextBox require="Enter Code" validate="codeadd" ID="txtCodeGrid" onblur='NullVal()'
                                                    runat="server" ValidationGroup="VGTrans" CssClass="form-control"></asp:TextBox>
                                                 <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCodeGrid"
                                            ErrorMessage="Required!" Display="Dynamic" ForeColor="Red" ValidationGroup="Validate"></asp:RequiredFieldValidator>
                                               
                                                <div class="SearchDiv">
                                                    <asp:LinkButton ID="btnFindACNO" data-toggle="modal" data-target="#ModalFindACNO"  runat="server" Text="Search" CssClass="search" CausesValidation="False"
                                                        OnClick="btnFind_Click" />
                                                </div>
                                            </div>
                                        </FooterTemplate>
                                        <HeaderStyle Width="155px"></HeaderStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Title">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txtTitleGrid"  CssClass="form-control" require="Title not Select on Given Code" validate="codeadd"
                                                runat="server" ReadOnly="true"></asp:TextBox>
                                            <asp:HiddenField ID="HidTitle" runat="server" />
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount (Credit)" HeaderStyle-Width="128px">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCredit" Style="float: none;" runat="server" Text='<%# Eval("Credit","{0:n}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txtCredit" runat="server" CssClass="Credit form-control" require="Enter Amount"
                                                validate="codeadd" onkeypress="return Verify(event);" AutoComplete="Off"></asp:TextBox>
                                        </FooterTemplate>
                                        <HeaderStyle Width="128px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:TemplateField>

                                    
                                    <%-- <asp:TemplateField HeaderText="Tax">
                                        <ItemTemplate>
                                             <asp:Label ID="lblSalesTaxID" runat="server" Text='<%# Eval("TaxID") %>' Visible="False"></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:DropDownList ID="cmbTax" runat="server" AutoPostBack="true" CssClass="form-control" Width="150px" OnSelectedIndexChanged="cmbTax_SelectedIndexChanged" DataTextField="Tax"
                                                DataValueField="TaxID" >
                                            </asp:DropDownList>
                                        </FooterTemplate>
                                    </asp:TemplateField> --%>                                   
                                    
                                    <%--<asp:TemplateField HeaderText="Tax Amount">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTaxAmount" runat="server" Text='<%# Eval("Total") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txtTotal" Text=""  CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                        </FooterTemplate>
                                    </asp:TemplateField>--%>

                                     <asp:TemplateField HeaderText="Cost Center" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCosterCenterName" runat="server" Text='<%# Eval("CostCenterName") %>'></asp:Label>
                                            <asp:Label ID="lblCostCenterID" runat="server" Text='<%# Eval("CostCenterID") %>'
                                                Visible="False"></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:DropDownList ID="cmbCostCenter" runat="server" Width="116px" DataTextField="CostCenterName"
                                                DataValueField="CostCenterID" >
                                            </asp:DropDownList>
                                        </FooterTemplate>
                                    </asp:TemplateField>

                                   

                                     <asp:TemplateField HeaderText="Material">
                                        <ItemTemplate>
                                             <asp:Label ID="lblGoods" runat="server" Text='<%# Eval("Goods") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txtGoods"  CssClass="form-control" onkeypress="return isFloatNumber(this,event);" runat="server" placeholder="Material" ></asp:TextBox>
                                        </FooterTemplate>
                                    </asp:TemplateField>

                                     <asp:TemplateField HeaderText="Services">
                                        <ItemTemplate>
                                            <asp:Label ID="lblServices" runat="server" Text='<%# Eval("Services") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txtServices"  CssClass="form-control" onkeypress="return isFloatNumber(this,event);" runat="server" placeholder="Services"></asp:TextBox>
                                        </FooterTemplate>
                                    </asp:TemplateField>

                                     <asp:TemplateField HeaderText="Remarks">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txtRemarks"  CssClass="form-control" runat="server"></asp:TextBox>
                                        </FooterTemplate>
                                    </asp:TemplateField>

                                  
                                      <asp:TemplateField HeaderText="Additional Info">
                                          <%--<ItemTemplate>
                                               <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                                </ItemTemplate>
                                           <ItemTemplate>
                                               <asp:Label ID="lblChequeNo" runat="server" Text='<%# Eval("ChequeNo") %>'></asp:Label>
                                                </ItemTemplate>
                                           <ItemTemplate>
                                               <asp:Label ID="lblChequeDate" runat="server" Text='<%# Eval("ChequeDate") %>'></asp:Label>
                                                </ItemTemplate>
                                           <ItemTemplate>
                                               <asp:Label ID="lblMemoNo" runat="server" Text='<%# Eval("MemoNo") %>'></asp:Label>
                                                </ItemTemplate>
                                           <ItemTemplate>
                                               <asp:Label ID="lblOnAccOff" runat="server" Text='<%# Eval("OnAccOff") %>'></asp:Label>
                                                </ItemTemplate>
                                           <ItemTemplate>
                                               <asp:Label ID="lblProjectID" runat="server" Text='<%# Eval("ProjectID") %>'></asp:Label>
                                                </ItemTemplate>
                                           <ItemTemplate>
                                               <asp:Label ID="lblMaintanenceID" runat="server" Text='<%# Eval("MaintanenceID") %>'></asp:Label>
                                                </ItemTemplate>
                                           <ItemTemplate>
                                               <asp:Label ID="lblGoods" runat="server" Text='<%# Eval("Goods") %>'></asp:Label>
                                                </ItemTemplate>
                                          <ItemTemplate>
                                               <asp:Label ID="lblServices" runat="server" Text='<%# Eval("Services") %>'></asp:Label>
                                               </ItemTemplate>--%>
                                        <ItemTemplate>
                                            <div>
                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                                </div>
                                            <div>
                                            <asp:Label ID="lblChequeNo" runat="server" Text='<%# Eval("ChequeNo") %>'></asp:Label>
                                           </div>
                                            <div>
                                            <asp:Label ID="lblChequeDate" runat="server" Text='<%# Eval("ChequeDate") %>'></asp:Label>
                                           </div>
                                            <div>
                                            <asp:Label ID="lblMemoNo" runat="server" Text='<%# Eval("MemoNo") %>'></asp:Label>
                                            </div>
                                            <div>
                                            <asp:Label ID="lblOnAccOff" runat="server" Text='<%# Eval("OnAccOff") %>'></asp:Label>
                                            </div>
                                            <div>
                                             <asp:Label ID="lblProjectID" runat="server" Text='<%# Eval("ProjectID") %>'></asp:Label>
                                            </div>
                                            <div>
                                             <asp:Label ID="lblMaintanenceID" runat="server" Text='<%# Eval("MaintanenceID") %>'></asp:Label>
                                            </div>

                                            
                                                
                                        </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:LinkButton ID="btnAddInfo" runat="server" class="buttonImp btn btn-primary" Text="Additional Info" OnClick="btnAddInfo_Click" />
                                               <%-- <input type="button" style="background:#009688; height:35px; border-radius:5px; font-style:normal" class=" btn-primary" id="addit" value="Additional Info" onclick="showHideDiv('divMsg')"/><br>
                                            <div id="divMsg" style="display:none">
                                            <asp:TextBox ID="txtName"  CssClass="form-control" Width="170" Height="20" runat="server" placeholder="Name" style="margin:5px;"></asp:TextBox>
                                            <asp:TextBox ID="txtcheque"  CssClass="form-control" Width="170" Height="20" runat="server" placeholder="Cheque No" style="margin:5px;"></asp:TextBox>
                                            <asp:TextBox ID="txtchequeDate"  CssClass="form-control DateTimePicker" Width="170" Height="20" runat="server" placeholder="Cheque Date" style="margin:5px;"></asp:TextBox>
                                            <asp:TextBox ID="txtMemo"  CssClass="form-control" Width="170" Height="20" runat="server" placeholder="Memo No" style="margin:5px;"></asp:TextBox>
                                            <asp:TextBox ID="txtOnAcoff"  CssClass="form-control" Width="170" Height="20" runat="server" placeholder="On Acc Off" style="margin:5px;"></asp:TextBox>
                                            <asp:TextBox ID="txtProID"  CssClass="form-control" Width="170" Height="20" runat="server" placeholder="Project ID" style="margin:5px;"></asp:TextBox>
                                            <asp:TextBox ID="txtMaintID"  CssClass="form-control" Width="170" Height="20" runat="server" placeholder="Maintanence ID" style="margin:5px;"></asp:TextBox>
                                            <asp:TextBox ID="txtGoods"  CssClass="form-control" Width="170" Height="20" runat="server" placeholder="Goods" style="margin:5px;"></asp:TextBox>
                                            <asp:TextBox ID="txtServices"  CssClass="form-control" Width="170" Height="20" runat="server" placeholder="Services" style="margin:5px;"></asp:TextBox>
                                                 </div>  --%> 
                                                
                                            
	                                        <%--<a class="button btn btn-primary" href="#popup1">Additional Info</a>
                                           

                                            <div id="popup1" class="overlay">
	                                            <div class="popup">
		                                            <h2>Add Additional Info</h2>
		                                            <a class="close" href="#">&times;</a>
		                                            <div class="content">
			                                            <asp:TextBox ID="txtName"  CssClass="form-control" runat="server" placeholder="Name" style="margin:5px;"></asp:TextBox>
                                                        <asp:TextBox ID="txtcheque"  CssClass="form-control" runat="server" placeholder="Cheque No" style="margin:5px;"></asp:TextBox>
                                                        <asp:TextBox ID="txtchequeDate"  CssClass="form-control DateTimePicker" runat="server" placeholder="Cheque Date" style="margin:5px;"></asp:TextBox>
                                                        <asp:TextBox ID="txtMemo"  CssClass="form-control" runat="server" placeholder="Memo No" style="margin:5px;"></asp:TextBox>
                                                        <asp:TextBox ID="txtOnAcoff"  CssClass="form-control" runat="server" placeholder="On Acc Off" style="margin:5px;"></asp:TextBox>
                                                        <asp:TextBox ID="txtProID"  CssClass="form-control" runat="server" placeholder="Project ID" style="margin:5px;"></asp:TextBox>
                                                        <asp:TextBox ID="txtMaintID"  CssClass="form-control" runat="server" placeholder="Maintanence ID" style="margin:5px;"></asp:TextBox>
                                                        <asp:TextBox ID="txtGoods"  CssClass="form-control" runat="server" placeholder="Goods" style="margin:5px;"></asp:TextBox>
                                                        <asp:TextBox ID="txtServices"  CssClass="form-control" runat="server" placeholder="Services" style="margin:5px;"></asp:TextBox>
		                                            </div>
	                                            </div>
                                            </div>--%>



                                                 <div class="modal fade modal-primary" id="ModalAdditionalInfo" aria-hidden="true"
        aria-labelledby="ModalUserRole" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                 <asp:UpdatePanel ID="UpdatePanel7" runat="server"><ContentTemplate>
                <div class="modal-header">
                    <h4 class="modal-title">Add Additional Info</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div id="StatusMsgPopup">
                        </div>
                        <div class="col-sm-12">
                            <div class="form-horizontal" id="ModalForm">        
                                 <div class="form-group">
                                    <label class="col-sm-3 control-label">Name :</label>
                                    <div class="col-sm-7">
                                      
                                        <asp:TextBox runat="server" ID="txtName" CssClass="form-control"  Width="100%" placeholder="Name"  />
                                    </div>
                                </div>

                                 <div class="form-group">
                                    <label class="col-sm-3 control-label">Cheque No :</label>
                                    <div class="col-sm-7">
                                        <asp:TextBox ID="txtcheque"  CssClass="form-control"  runat="server" placeholder="Cheque No" ></asp:TextBox>
                                    </div>
                                </div>
                                
                                 <div class="form-group">
                                    <label class="col-sm-3 control-label">Cheque Date :</label>
                                    <div class="col-sm-7">
                                        <asp:TextBox ID="txtchequeDate"  CssClass="form-control DateTimePicker" runat="server" placeholder="Cheque Date" ></asp:TextBox>
                                    </div>
                                </div>
                                
                                 <div class="form-group">
                                    <label class="col-sm-3 control-label">Memo No :</label>
                                     <div class="col-sm-7">
                                        <asp:TextBox ID="txtMemo"  CssClass="form-control" runat="server" placeholder="Memo No" ></asp:TextBox>
                                     </div>
                                </div>
                                
                                 <div class="form-group">
                                    <label class="col-sm-3 control-label">On Acc Off :</label>
                                    <div class="col-sm-7">
                                         <asp:TextBox ID="txtOnAcoff"  CssClass="form-control" runat="server" placeholder="On Acc Off" ></asp:TextBox>
                                    </div>
                                </div>
                                
                                 <div class="form-group">
                                    <label class="col-sm-3 control-label">Project ID :</label>
                                    <div class="col-sm-7">
                                        <asp:TextBox ID="txtProID"  CssClass="form-control" runat="server" placeholder="Project ID" ></asp:TextBox>
                                    </div>
                                </div>
                                
                                 <div class="form-group">
                                    <label class="col-sm-3 control-label">Maintanence ID :</label>
                                    <div class="col-sm-7">
                                       <asp:TextBox ID="txtMaintID"  CssClass="form-control" runat="server" placeholder="Maintanence ID" ></asp:TextBox>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                   <%--<asp:Button runat="server" ID="btnAddition" OnClick="btnAddition_Click" CssClass="btn1 btn-primary waves-effect waves-light"  Text="Add" />--%>
                </div>
             </ContentTemplate></asp:UpdatePanel>
            </div>
        </div>
    </div>

 
                                                
                                                                        
                                                </FooterTemplate>
                                    </asp:TemplateField>
                                


                                   

                                    
                                    <asp:TemplateField ItemStyle-Width="15%" HeaderText="Actions">
                                        <ItemTemplate>


                                            <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%# Eval("Sno") %>'
                                                CausesValidation="False" OnCommand="btnEdit_Command">
                                                <i class="icon icon_custom fa fa-edit" aria-hidden="true"></i>
                                                     </asp:LinkButton>

                                            <asp:LinkButton ID="LbtnRemoveGridRow" CssClass="delete" runat="server" CausesValidation="False"
                                                CommandArgument='<%# ((GridViewRow)Container).RowIndex%>' CommandName="Del" OnCommand="LbtnRemoveGridRow_Command">
                                                 <i class="icon icon_custom fa-trash-o" aria-hidden="true"></i>
                                            </asp:LinkButton>


                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:LinkButton ID="btnAdd" Style="float: left;" CssClass="buttonTnew btn btn-primary" runat="server"
                                                Text="Add" CommandName="Add" ValidationGroup="Validate" OnClick="btnAdd_Click"
                                                OnClientClick="return validate('codeadd');" />
                                            <asp:Label ID="lblSno2" runat="server" Text='<%# Eval("Sno") %>' Visible="False"></asp:Label>
                                            &nbsp;
                                             <asp:LinkButton runat="server" Text="Cancel" CssClass="btn btn-default" Visible="false"
                                                ID="btnCancel" OnClick="btnCancel_Click"></asp:LinkButton>
                                              
                                        </FooterTemplate>
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                    </asp:TemplateField>
                                </Columns>
                                

                                 
                            </asp:GridView>

                              


                                <div class="row" style="padding:10px;">
                                    <div class="col-md-4">
                                         <asp:LinkButton ID="btnSave" OnClientClick="return validate('savevoucher');" CssClass="buttonImp btn btn-primary"
                                    runat="server" Text="Save Voucher" OnClick="btnSave_Click" />
                                        <asp:LinkButton ID="lnkNew" CssClass="buttonImp btn btn-primary" runat="server" OnClick="lnkNew_Click">New Cash Receive</asp:LinkButton>
                                        
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <asp:Label ID="lblTotal" runat="server" Font-Bold="True" ForeColor="#2C8CB4" Text="Total"></asp:Label>
                                    </div>
                                    <div class="col-md-3">
                                         <asp:Label ID="lblTotalAmt" runat="server" Font-Bold="True" ForeColor="#2C8CB4"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                       
                                    </div>
                                </div>
                                <div class="row">
                                     <div class="col-md-12">
                                         <asp:Label ID="lblValidation" runat="server" Font-Bold="True" ForeColor="Red" Visible="false"
                                    Text="Balance Should be greater or equal to Amount"></asp:Label>
                                     </div>
                                </div> 
                                <div class="row">
                                    <div class="col-md-12">
                                        <asp:LinkButton ID="btnPrint" runat="server" CssClass="buttonImp" OnClick="btnPrint_Click"
                                    Visible="False">Print View</asp:LinkButton>
                                    </div>
                                </div>                                                           
                               
                           
                               
                            </div>
                                
                            
                                
                            
                                
                            
                                
                            
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
                </div>
           
        </ContentTemplate>
    </asp:UpdatePanel>


    <asp:HiddenField ID="hdnMinDate" runat="server" />
    <asp:HiddenField ID="hdnMaxDate" runat="server" />
    <div id="PrintReport">
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <asp:Button ID="ButtonPrint" runat="server" Text="Print" CssClass="buttonNew" OnClick="ButtonPrint_Click"
                    OnClientClick="printSelection(document.getElementById('Reports'));return false" />
                <div id="Reports">
                  <%--  <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" SeparatePages="False"
                        AutoDataBind="true" EnableDrillDown="False" DisplayGroupTree="False" OnNavigate="CrystalReportViewer1_Navigate1"
                        DisplayToolbar="False" OnInit="CrystalReportViewer1_Init" />--%>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    
        <div class="modal fade modal-primary" id="ModalFindACNO" aria-hidden="true"
        aria-labelledby="ModalUserRole" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
          <div class="modal-dialog" style="width:800px;">
            <div class="modal-content">
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <div class="modal-header">
                    <h4 class="modal-title">Find</h4>
                </div> 
                <div class="container">
                    <div class="row" style="padding:10px;">
                        <div class="col-md-6">
                <label >Enter Account No. </label>
                &nbsp;<asp:TextBox CssClass="autoCompleteCodes form-control " ID="txtAccountNo" runat="server"></asp:TextBox>
                            </div>
                        <div class="col-md-6" style="margin-top:26px;">
                            <asp:Button ID="btnFindAcc"
                    runat="server" Text="Find" CssClass="buttonImp btn btn-primary" Style="float: none" OnClick="btnFindAcc_Click" />
                            </div>
                        </div>
                   
               
                <asp:GridView ID="GrdAccounts" runat="server" CssClass="data main table table-bordered table-responsive" AllowPaging="true"
                    PageSize="15" OnPageIndexChanging="GrdAccounts_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkSelect" runat="server" OnClick="lnkSelect_Click">Select</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                     </div>
                 <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
                <asp:HiddenField ID="HdnFindCode" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
                </div>
              </div>
</div>
   
     
          <div class="modal fade modal-primary" id="ModalFindACNO2" aria-hidden="true"
        aria-labelledby="ModalUserRole" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
          <div class="modal-dialog" style="width:800px;">
            <div class="modal-content">
        <asp:UpdatePanel ID="UpdatePanel5" runat="server">
            <ContentTemplate>
               <div class="modal-header">
                    <h4 class="modal-title">Find</h4>
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-md-6">
                <label style="padding-left: 20px">Enter Account No. </label>
                &nbsp;
                <asp:TextBox CssClass="autoCompleteCodes2 form-control" ID="txtAccountNo2" runat="server">
                      </asp:TextBox>
                            </div>
                        <div class="col-md-6" style="margin-top:26px;">
                            <asp:Button ID="btnFindAcc2"
                    runat="server" Text="Find" CssClass="buttonImp btn btn-primary" Style="float: none" OnClick="btnFindAcc2_Click" />
                            </div>
                
                </div>

                
                
                <asp:GridView ID="GrdAccounts2" runat="server" CssClass="data main table table-bordered table-responsvie" AllowPaging="true"
                    PageSize="15" OnPageIndexChanging="GrdAccounts2_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkSelect2" runat="server" OnClick="lnkSelect2_Click">Select</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                    </div>
                 <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
                <asp:HiddenField ID="HdnFindCode2" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
                </div>
              </div>
</div>
    
  
         <div class="modal fade modal-primary" id="ModalFindJobs" aria-hidden="true"
        aria-labelledby="ModalUserRole" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
          <div class="modal-dialog" style="width:800px;">
            <div class="modal-content">
        <asp:UpdatePanel ID="UpdatePanel6" runat="server">
            <ContentTemplate>
                <div class="modal-header">
                    <h4 class="modal-title">Find</h4>
                </div> 
                <div class="container">
                <div class="row" style="padding:10px;">
                    <div class="col-md-6">
                <label >Enter Job Number. </label>
                &nbsp;<asp:TextBox ID="txtJobNumberSearch" CssClass="form-control" runat="server">
                      </asp:TextBox>
                    </div>
                    <div class="col-md-2" style="margin-top:26px;">
                <asp:Button ID="btnFindJob" runat="server" Text="Find" CssClass="buttonImp btn btn-primary" Style="float: none" OnClick="btnFindJob_Click"/>
                </div>
                    <div class="col-md-2"></div>
                </div>
           
                <asp:GridView ID="grdJobs" runat="server" CssClass="data main table table-bordered table-responsive"                    
                    AutoGenerateColumns="False" DataSourceID="sqlDSJobs" EnableModelValidation="True">
                    <Columns>
                        <asp:TemplateField HeaderText="Select">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkSelectJob" runat="server" OnClick="lnkSelectJob_Click" JobID='<%#Eval("JobID") %>'>Select</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="JobNumber" HeaderText="Job Number" SortExpression="JobNumber" />
                        <asp:BoundField DataField="JobDescription" HeaderText="Job Description" SortExpression="JobDescription" />
                        <asp:BoundField DataField="DisplayName" HeaderText="Customer Name" SortExpression="DisplayName" />
                    </Columns>
                </asp:GridView>
                </div>
                <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
                <asp:SqlDataSource ID="sqlDSJobs" runat="server"
                    ConnectionString="<%$ ConnectionStrings:ASCS %>"
                    SelectCommand="SELECT J.[JobID],J.[JobNumber],J.[JobDescription],C.[DisplayName]
	                            ,CASE WHEN J.[Completed] = 1 THEN 'TRUE' ELSE 'FALSE' END Completed FROM [Job] J
	                            INNER JOIN [Customer] C ON J.[CustomerID] = C.[CustomerID]">                    
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
                </div> 
          </div> 
        </div>
       
     
    <div id="Confirmation" style="display: none;">
        <asp:UpdatePanel ID="upConfirmation" runat="server">
            <ContentTemplate>
                <asp:Label ID="lblDeleteMsg" runat="server" Text="No Record Found"></asp:Label>
                <asp:HiddenField ID="HidDeleteID" runat="server" />
                <br />
                <br />
                <br />
                <asp:LinkButton ID="lbtnNo" CssClass="Button1" runat="server"  OnClientClick="return closeDialog('Confirmation');">OK</asp:LinkButton>
            </ContentTemplate>
        </asp:UpdatePanel>

    </div>

    <div class="row">
        <div class="col-md-2"> </div>
        <div class="col-md-8"> 
<rsweb:ReportViewer  ID="ReportViewer1"  Height="820px"  Width="105%"  runat="server" ></rsweb:ReportViewer></div>
         <div class="col-md-2"> </div>
        </div>
</asp:Content>
