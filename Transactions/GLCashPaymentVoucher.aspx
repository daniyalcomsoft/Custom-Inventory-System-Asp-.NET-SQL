<%@ Page Title="Payment Voucher" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="GLCashPaymentVoucher.aspx.cs" Inherits="Transactions_GLCashPaymentVoucher" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script type="text/javascript" language="javascript">

        $(document).ready(function() {
            CreateModalPopUp("#PrintReport", 820, 630, "Print Report");
            CreateModalPopUp('#Confirmation', 280, 120, 'ALERT');
            Get_Current_Bal();
            MyDate();
            ChangeDateEvent();
            Load_AutoComplete_Code();
            Load_AutoComplete_Code2();
            $('#FindAccount,#FindJobs,#FindAccount2').dialog({
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
                        url: 'Services/GetData.asmx/GetAccountCodeTitle',
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
                minLength: 2,
                select: function(event, ui) {
                    $("[id$=txtTitleGrid]").val(ui.item.Title);
                    $("[id$=HiddenFieldTitle]").val(ui.item.Title);
                    $("[id$=lblMainCodeGrid]").val(ui.item.accMain);
                    $("[id$=lblControlCodeGrid]").val(ui.item.accControl);
                    $("[id$=lblSubCodeGrid]").val(ui.item.accSub);

                }

            });
        }
            function Get_Current_Bal() {
                $('.autoCompleteCodes').autocomplete({
                    source: function(request, response) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: 'Services/GetData.asmx/GetAccountCodeTitle',
                            data: "{ 'Match': '" + request.term + "'}",
                            dataType: "json",
                            success: function(data) {
                                response($.map(data.d, function(item) {
                                    return {
                                        label: item.CodeTitle,
                                        value: item.AccCode,
                                        Title: item.Title,
                                        currBal: item.Balance,
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
                        //$('#ctl00_ContentPlaceHolder1_GridTrans_ctl03_txtTitleGrid').val(ui.item.Title);
                        if ($(this).attr("id").indexOf("txtAccountNo") < 0) {
                            $('#' + $(this).attr('id') + 'lbl').text(ui.item.Title);
                            $("[id$=txtBalance]").text(ui.item.currBal);
                            $("[id$=txtBalanceHidden]").val(ui.item.currBal);
                            $("[id$=titlecode]").val(ui.item.Title);
                            $("[id$=lblMainCode]").val(ui.item.accMain);
                            $("[id$=lblControlCode]").val(ui.item.accControl);
                            $("[id$=lblSubCode]").val(ui.item.accSub);
                        } 
                    }

                });
            }
            
            function Load_AutoComplete_Code2() {  
        
            $("[id$=txtCode]").autocomplete({
                source: function(request, response) {
                $("[id $= txtTitleGrid]").val('');  
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: 'Services/GetData.asmx/GetAccountCodeTitle2',
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
            $('.autoCompleteCodes2').autocomplete({
                source: function(request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: 'Services/GetData.asmx/GetAccountCodeTitle2',
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
                if ($(this).attr("id").indexOf("txtAccountNo2") < 0)
                {
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
                        url: 'Services/GetData.asmx/GetJobByNumber',
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
        
        
        function ValidateDebitCredit(){    
        if($('.Credit').val() == "")
        {
            //$("#comment").validate();
            
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
                if (charCode != 46) {
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
    function MyDate() {
        dateMin = $("[id $= hdnMinDate]").val();
        dateMax = $("[id $= hdnMaxDate]").val();
        $(".DateTimePicker").datepicker({ minDate: new Date(dateMin), maxDate: new Date(dateMax) });
    }

    function CheckNullVal(elem) {
        if ($(elem).val().length < 2) {
            $("[id$=hdnJobNumber]").val("");
        }
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
    $(document).ready(function () {
        $('#btnFindJ').click(function () {
            $('#ModalFindJobs').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
            $('#ModalFindJobs').find('select').val('0');
            enabledModal('ModalFindJobs');
            showhidecontrol('btnSave', true);
        })
    });

    $(document).ready(function () {
        $('#btnFindAc').click(function () {
            $('#ModalFindAcc').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
            $('#ModalFindAcc').find('select').val('0');
            enabledModal('ModalFindAcc');
            showhidecontrol('btnSave', true);
        })
    });

    </script>
    <style type="text/css">
       td[align='right'] > span
       {
             float:none !important;
       }
       td[align='center'] > span
       {
            float:none !important;
       }
       td[align='left'] > span
       {
            float:none !important;
       }
       .textarea>.alertbox div
       {
           margin-top:-20px;
       }
       .alertbox div
       {
           margin-top:0px;
       }
       #ctl00_ContentPlaceHolder1_btnFindJob{
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
       #ctl00_ContentPlaceHolder1_btnFindAcc{
            border:none;
            color:white;
            background:#009688;
            font-style:normal;
       }
    </style>

    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<cc1:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </cc1:ToolkitScriptManager>--%>
    <asp:HiddenField ID="hdnMinDate" runat="server" />
       <asp:HiddenField ID="hdnMaxDate" runat="server" />
    
    <asp:UpdatePanel ID="UpdatePanelMain" runat="server">
    <ContentTemplate>
     <div class="container">
            <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title"> Cash Payment Voucher</h3>
                </div>
    <div class="Update_area">
        <asp:UpdatePanel ID="UpdatePanel5" runat="server">
            <ContentTemplate>
                <script type="text/javascript">

                            $(document).ready(function () {
                                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                                function EndRequestHandler(sender, args) {
                                    $('#btnFindJ').click(function () {
                                        $('#ModalFindJobs').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
                                        $('#ModalFindJobs').find('select').val('0');
                                        enabledModal('ModalFindJobs');

                                        showhidecontrol('btnSave', true);
                                    });

                                }
                            });
                            $(document).ready(function () {
                                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                                function EndRequestHandler(sender, args) {
                                    $('#btnFindAc').click(function () {
                                        $('#ModalFindAcc').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
                                        $('#ModalFindAcc').find('select').val('0');
                                        enabledModal('ModalFindAcc');

                                        showhidecontrol('btnSave', true);
                                    });

                                }
                            });
                            $(document).ready(function () {
                                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                                function EndRequestHandler(sender, args) {
                                    $('#btnFindA').click(function () {
                                        $('#ModalFindAccount').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
                                        $('#ModalFindAccount').find('select').val('0');
                                        enabledModal('ModalFindAccount');

                                        showhidecontrol('btnSave', true);
                                    });

                                }
                            });

                        </script>
        
                                 
          
            <div id="StausMsg"></div>
                   
                              <div class="row" style="margin:10px;">
                                     <div class="col-md-5">
                                    <label>Number:</label>
                                   
                                   
                                    <asp:TextBox ID="txtVoucherNumber" runat="server" Width="300" ReadOnly="True"
                                        AutoPostBack="True" placeholder="Number" CssClass="form-control"></asp:TextBox>
                                        </div>

                                     <div class="col-md-2">
                                    <label>Job Number :</label>                                   
                                    <asp:TextBox ID="txtJobNumber" Width="250" runat="server" CssClass="form-control"></asp:TextBox>
                                    <%--onblur='CheckNullVal(this);' require="Enter JobNumber" validate="savevoucher"--%>
                                         </div>
                                    <div class="col-md-3" style="margin-left:68px; margin-top:4px;">
                                        <label></label> 
                                         <div class="SearchDiv">
                                        <asp:LinkButton ID="btnFindJ" runat="server" data-toggle="modal" data-target="#ModalFindJobs" Text="Search" CssClass="search btn btn-primary"  CausesValidation="False" OnClientClick="return ShowDialog('FindJobs');">
                                            <i class="fa fa-search"></i>
                                            </asp:LinkButton>
                                    </div>
                                    </div>
                                   
                                </div>
                                    <asp:HiddenField ID="hdnJobNumber" runat="server" />
                    <div style="display: none;">        
              <label>Reference Number:</label>
                
                        <asp:TextBox ID="txtRefNumber" Width="130px"
                        runat="server" MaxLength="50" placeholder="Reference Number"  ></asp:TextBox><asp:Label ID="lblRefNo" runat="server" ForeColor="#2C8CB4"></asp:Label> 
                            </div>   
             <div class="row" style="margin:10px;">
                 <div class="col-md-5">
                                
                                    <label>Date:</label>
                                
                                    <asp:TextBox ID="txtDate" Width="300" CssClass="DateTimePicker form-control" runat="server"
                                        require="Enter Voucher Date"  validate="savevoucher" AutoComplete="Off"
                                        placeholder="Date"></asp:TextBox>
                                 </div>
                                <div class="col-md-2" style="margin:1px;">
                                            <label>Cash Account:</label>
                                            <asp:Label ID="lblTransID" runat="server" Text="" Visible="false"></asp:Label>

                                            <asp:TextBox require="Enter Cash Account" CssClass="autoCompleteCodes2 form-control" Width="250"
                                                validate="savevoucher" ID="txtCode" runat="server" 
                                                placeholder="Cash Account" ></asp:TextBox>
                                    </div>
                                <div class="col-md-3" style="margin-left:66px; margin-top:27px;">
                                    <div class="SearchDiv" style="margin-left:1px;">
                                        <asp:LinkButton ID="btnFindAc" runat="server"
                                            CausesValidation="False" Text="Search" data-toggle="modal" data-target="#ModalFindAcc"   CssClass="search btn btn-primary" onclick="btnFind_Click">
                                             <i class="fa fa-search"></i>
                                            </asp:LinkButton>
                                    </div>
                                </div>
                           
                                <div class="col-md-12">
                                    <label>Narration:</label>
                                
                                    <asp:TextBox ID="txtNarration" runat="server"
                                        TextMode="MultiLine" CssClass="form-control" placeholder="Narration"></asp:TextBox>                                                   
                                      </div>
                                <div class="col-md-6"></div>
                          
                             
                                
                           </div>
                                    <asp:Label ID="txtCodelbl" ForeColor="#2C8CB4" runat="server" Text=""></asp:Label>
                                    <input id="titlecode" runat="server" type="hidden" />
                                
                                    <asp:Label ID="lblbalance" ForeColor="#2C8CB4" runat="server" Text=""></asp:Label>
                                    <input id="txtBalanceHidden" runat="server" type="hidden" />
                                    <asp:Label ID="txtBalance" ForeColor="#2C8CB4" runat="server" Text=""></asp:Label>
                                    <asp:HiddenField ID="HdnFindAccount" runat="server" />
                            
             
                </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtCode" EventName="TextChanged" />
                    </Triggers>
        </asp:UpdatePanel>
                
                            <div style="float: right; margin-top: 6px;">
                                <asp:LinkButton ID="LinkButtonBack" CssClass="buttonImp" runat="server" Text="Back To List"
                                    OnClick="LinkButtonBack_Click" />
                            </div>
                <div style="clear:both;"></div>
        
   <asp:UpdatePanel ID="UpdatePanel2" runat="server">

     <ContentTemplate>
                <div class="container">
                <asp:GridView CssClass="data main table table-bordered table-responsive" ID="GridTrans" runat="server" AutoGenerateColumns="False" DataKeyNames="TransactionID"
                    ShowFooter="True" onrowdatabound="GridTrans_RowDataBound">
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
                                  <asp:TextBox ID="txtCodeGrid" require="Enter Code" validate="codeadd" onblur='NullVal()'
                                      runat="server" CssClass="form-control" ValidationGroup="VGTrans"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCodeGrid"
                                            ErrorMessage="Required!" Display="Dynamic" ForeColor="Red" ValidationGroup="Validate"></asp:RequiredFieldValidator>
                            <div class="SearchDiv">
                            <asp:LinkButton ID="btnFindA" Text="Search" data-toggle="modal" data-target="#ModalFindAccount" runat="server" CssClass="search" CausesValidation="False" onclick="btnFind_Click1"/>
                             </div>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Title">
                            <ItemTemplate>
                                <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                 <asp:TextBox ID="txtTitleGrid" CssClass="form-control" runat="server" require="Title not Select on Given Code" validate="codeadd" ReadOnly="true"/>
                                 <asp:HiddenField ID="HiddenFieldTitle" runat="server" />
                                 <%--<input ID="HiddenFieldTitle" runat="server" type="hidden" />--%>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount">
                            <ItemTemplate>
                                <asp:Label ID="lblDebit" style="float:right;"  runat="server" Text='<%# Eval("Debit","{0:n}") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtDebit" runat="server" CssClass="Credit form-control" require="Enter Amount" validate="codeadd" onkeypress="return Verify(event);" AutoComplete="Off"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Remarks">
                            <ItemTemplate>
                                <asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtRemarks" CssClass="form-control" runat="server"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
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
                        <asp:TemplateField HeaderText="Edit">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" Text="Edit" CssClass="edit" runat="server" CommandArgument='<%# Eval("Sno") %>' 
                                    CausesValidation="False" oncommand="btnEdit_Command">
                                    <i class="icon fa-edit icon_custom" aria-hidden="true"></i>
                                                     </asp:LinkButton>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:LinkButton ID="btnAdd" style="float:left;" CssClass="buttonTnew btn btn-primary" runat="server" Text="Add" CommandName="Add" 
                                    onclick="btnAdd_Click" OnClientClick="return validate('codeadd');" ValidationGroup="Validate" />
                                <asp:Label ID="lblSno2" runat="server" Text='<%# Eval("Sno") %>' Visible="False"></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delete">
                    <ItemTemplate>
                         <asp:LinkButton ID="LbtnRemoveGridRow" CssClass="delete" runat="server" CausesValidation="False" 
                                CommandArgument='<%# ((GridViewRow)Container).RowIndex%>'
                                CommandName="Del" oncommand="LbtnRemoveGridRow_Command" Text="" style="width: 18px;">
                             <i class="icon fa-trash-o icon_custom" aria-hidden="true"></i>
                         </asp:LinkButton>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:LinkButton ID="btnCancel" CssClass="buttonNew" Text="Cancel" 
                            Visible="false" runat="server" OnClick="btnCancel_Click">                             
                        </asp:LinkButton>
                    </FooterTemplate>
                    <ControlStyle Width="50px" />
                    <ItemStyle Width="50px" />
                </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                    <div class="row">
                        <div class="col-md-4">
                            <asp:LinkButton ID="btnSave" OnClientClick="return validate('savevoucher');" CssClass="buttonImp btn btn-primary" runat="server" Text="Save Voucher" OnClick="btnSave_Click" />
                            <asp:LinkButton ID="lnkNew" CssClass="buttonImp btn btn-primary" runat="server" 
                                onclick="lnkNew_Click">New Cash Received</asp:LinkButton>
                        </div>
                        
                        <div class="col-md-3">
                            <asp:Label ID="lbltotal" runat="server" ForeColor="#2C8CB4" Text="Total" Font-Bold="True"></asp:Label>
                        </div>
                        <div class="col-md-3">
                            <asp:Label ID="lblTotalAmt" ForeColor="#2C8CB4" runat="server" Font-Bold="True"></asp:Label>
                        </div>
                    </div>

                    
            <div style="float:left; margin-top:6px;">
                        <asp:LinkButton ID="btnPrint" runat="server" CssClass="buttonImp" 
                                 Visible="False" onclick="btnPrint_Click" >Print View</asp:LinkButton>
                        </div>
            
            <div style="white-space:nowrap; color:green; padding-left:495px">
            
          </div>
            
            <div style="padding-left:427px; white-space:nowrap">
            <asp:Label ID="lblValidation" runat="server" ForeColor="Red"></asp:Label>
          </div>
                    </div>
            
    </ContentTemplate>
   </asp:UpdatePanel> 
        
</div>
   </div>
            </div>
          </ContentTemplate>
    </asp:UpdatePanel>
        <div id="PrintReport">
            <asp:UpdatePanel ID="UpdatePanel20" runat="server">
                <ContentTemplate>
                   <asp:Button ID="ButtonPrint" runat="server" Text="Print" CssClass="buttonNew" 
                        OnClick="ButtonPrint_Click" OnClientClick="printSelection(document.getElementById('Reports'));return false" />
                <div id="Reports">
                  <%--  <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" SeparatePages="False"
                        AutoDataBind="true" EnableDrillDown="False" DisplayGroupTree="False" 
                        onnavigate="CrystalReportViewer1_Navigate1" DisplayToolbar="False"
                        oninit="CrystalReportViewer1_Init" />--%>
                </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

    <div class="modal fade modal-primary" id="ModalFindAccount" aria-hidden="true"
        aria-labelledby="ModalUserRole" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
          <div class="modal-dialog" style="width:800px;">
            <div class="modal-content">
          <asp:UpdatePanel ID="UpdatePanel3" runat="server">
             <ContentTemplate>
                 <div class="modal-header">
                    <h4 class="modal-title">Find</h4>
                </div>
                 <div class="container">
                    <div class="row" style="margin:5px;">
                        <div class="col-md-6">
                <label style="padding-left: 20px">Enter Account No.. </label>
                &nbsp;
                <asp:TextBox ID="txtAccountNo" CssClass="form-control" runat="server"> </asp:TextBox>
                            </div>
                        <div class="col-md-6" style="margin-top:26px;">
                <asp:Button ID="btnFindAcc" runat="server" Text="Find" CssClass="buttonImp btn btn-primary" Style="float: none" OnClick="btnFindAcc_Click" />
                            </div>
                
                </div>

                
                     
                 <asp:GridView ID="GrdAccounts" runat="server" CssClass="data main table table-bordered table-responsvie" 
                     AllowPaging="true" PageSize="15" 
                     onpageindexchanging="GrdAccounts_PageIndexChanging">
                     <Columns>
                         <asp:TemplateField>
                             <ItemTemplate>
                                 <asp:LinkButton ID="lnkSelect" runat="server" onclick="lnkSelect_Click">Select</asp:LinkButton>
                             </ItemTemplate>
                         </asp:TemplateField>
                     </Columns>
                  </asp:GridView>
                     </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
             </ContentTemplate>
          </asp:UpdatePanel>
      </div>
              </div> 
          </div> 
       
 


        <div class="modal fade modal-primary" id="ModalFindAcc" aria-hidden="true"
        aria-labelledby="ModalUserRole" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
          <div class="modal-dialog" style="width:800px;">
            <div class="modal-content">
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <div class="modal-header">
                    <h4 class="modal-title">Find</h4>
                </div> 
                 <div class="container">
                    <div class="row" style="margin:5px;">
                        <div class="col-md-6">
                <label >Enter Account No... </label>
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
                <div class="row" style="margin:5px;">
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
               
                <asp:GridView ID="grdJobs" runat="server" CssClass="table table-bordered table-responsive"                    
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
                    <asp:LinkButton ID="lbtnNo" CssClass="Button1" runat="server" OnClientClick="return closeDialog('Confirmation');">OK</asp:LinkButton>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
      
</asp:Content>

