<%@ Page Title="General Voucher" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="GLGeneralVoucher.aspx.cs" Inherits="Transactions_GLGeneralVoucher" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            CreateModalPopUp("#PrintReport", 820, 630, "Print Report");
            CreateModalPopUp('#Confirmation', 280, 120, 'ALERT');
            ChangeDateEvent();
            MyDate();
            Load_AutoComplete_Code();
            Load_AutoComplete_JobNumber();

            //$('#FindAccount,#FindJobs').dialog({
            //    autoOpen: false,
            //    draggable: true,
            //    title: "Find",
            //    width: 726,
            //    height: 449,
            //    open: function (type, data) {
            //        $(this).parent().appendTo("form");
            //    }
            //});
            
        });
        function Load_AutoComplete_Code() {
            $("[id$=txtCode]").autocomplete({
                source: function (request, response) {
                    $("[id $= txtTitle]").val('');
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: 'Services/GetData.asmx/GetAccountCodeTitle',
                        data: "{ 'Match': '" + request.term + "'}",
                        dataType: "json",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.CodeTitle,
                                    value: item.AccCode,
                                    Title: item.Title
                                }
                            }))
                        }
                    });
                },
                minLength: 3,
                select: function (event, ui) {
                    $("[id$=txtTitle]").val(ui.item.Title);
                    $("[id$=HidTitle]").val(ui.item.Title);
                    $("[id$=lblSubCode]").val(ui.item.accSub);
                }
            });
        }

        function Load_AutoComplete_JobNumber() {
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

        function Check(trn, event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if (charCode != 9) {
                if ($('.Credit').val() != '' && trn == 'd') {
                    return false;
                }
                if ($('.Debit').val() != '' && trn == 'c') {
                    return false;
                }
                var charCode = (event.which) ? event.which : event.keyCode
                if (charCode != 9) {
                    if (charCode > 31 && (charCode < 48 || charCode > 57))
                        if (charCode != 46) {
                            event.preventDefault();
                        }
                }
                return true;
            }
            if (($('.Debit').val() != "") || ($('.Credit').val() != "")) {
                $('.Debit').removeAttr('style');
                $('.Credit').removeAttr('style');
            }
            return true;
        }
        function ValidateDebitCredit() {

            if (($('.Debit').val() == "") && ($('.Credit').val() == "")) {
                $('.Debit').css('border-color', 'red');
                $('.Credit').css('border-color', 'red');
                return false;
            }
            else {
                $('.Debit').removeAttr('border-color');
                $('.Credit').removeAttr('border-color');
            }
            return validate('checkcode');
        }
        //function OpenUserPermission() {
        //    ShowDialog('FindAccount');
        //    return false;
        //}
        function SelectRow(row) {
            var _selectColor = "#303030";
            var _normalColor = "#909090";
            var _selectFontSize = "3em";
            var _normalFontSize = "2em";
            // get all data rows - siblings to current
            var _rows = row.parentNode.childNodes;
            // deselect all data rows
            try {
                for (i = 0; i < _rows.length; i++) {
                    var _firstCell = _rows[i].getElementsByTagName("td")[0];
                    _firstCell.style.color = _normalColor;
                    _firstCell.style.fontSize = _normalFontSize;
                    _firstCell.style.fontWeight = "normal";
                }
            }
            catch (e) { }
            // select current row (formatting applied to first cell)
            var _selectedRowFirstCell = row.getElementsByTagName("td")[0];
            _selectedRowFirstCell.style.color = _selectColor;
            _selectedRowFirstCell.style.fontSize = _selectFontSize;
            _selectedRowFirstCell.style.fontWeight = "bold";
        }
        function NullVal() {
            if ($("[id $= _txtCode]").val().length < 3) {
                $("[id $= _txtCode]").val("");
            }
        }

        function CheckNullVal(elem) {
            if ($(elem).val().length < 2) {
                $("[id$=hdnJobNumber]").val("");
            }
        }


        function MyDate() {
            dateMin = $("[id $= hdnMinDate]").val();
            dateMax = $("[id $= hdnMaxDate]").val();
            $(".DateTimePicker").datepicker({ minDate: new Date(dateMin), maxDate: new Date(dateMax) });
        }




        function ChangeDateEvent() {

            $("[id $= txtDate]").change(function () {

                dateMin = $("[id $= hdnMinDate]").val();
                dateMax = $("[id $= hdnMaxDate]").val();
                var invoiceDate = $("[id$=txtDate]").val();


                if (Date.parse(invoiceDate) < Date.parse(dateMin) || Date.parse(invoiceDate) > Date.parse(dateMax)) {
                    $("[id$=txtDate]").val('');
                }


            });
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





    </script>

    <style>
        /*.DivStyle {
            display: block;
            height: 22px;
        }

            .DivStyle > span > label {
                white-space: nowrap;
                width: 160px;
            }

        .toggler {
            width: 500px;
            height: 200px;
        }

        #effectInterest, #effectDetail {
            margin-bottom: 9px;
            padding: 0.4em;
            position: relative;
            width: 870px;
        }

            #effectInterest h3, #effectDetail h3 {
                margin: 0;
                padding: 0.4em;
                text-align: center;
            }*/

        /*.messages {
            border: solid 1px black;
            margin: 10px 0px;
            background-color: #FFCA2A;
            font-size: 12px;
            font-weight: bold;
            padding: 5px 0px;
        }

            .messages p {
                color: rgb(36,60,130);
                margin: 7px;
            }

            .messages a {
                color: rgb(36,60,130);
                font-weight: bold;
                text-decoration: underline;
            }

        td[align='right'] > span {
            float: none !important;
        }

        td[align='center'] > span {
            float: none !important;
        }

        td[align='left'] > span {
            float: none !important;
        }

        .textarea > .alertbox div {
            margin-top: -20px;
        }

        .alertbox div {
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
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:HiddenField ID="hdnMinDate" runat="server" />
    <asp:HiddenField ID="hdnMaxDate" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">

        <ContentTemplate>
            
            <div class="panel panel-bordered panel-primary">

                <div class="panel-heading form-group">
                    <h3 class="panel-title">  Journal Voucher</h3>
                </div>
            <div class="Update_area">                
                        
               
                <div id="StausMsg"></div>

                <asp:UpdatePanel ID="UpdatePanel7" runat="server">
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

                        </script>
                        <div class="container">
                           <div class="row" style="margin:10px;">
                                    <div class="col-md-4">
                                    <label>Number:</label>
                                    <asp:TextBox ID="txtVoucherNumber" runat="server" Width="300" ReadOnly="True"
                                        AutoPostBack="True" placeholder="Number" CssClass="form-control"></asp:TextBox>
                                     </div>

                                    <div class="col-md-2">
                                    <label>Job Number :</label>                                   
                                    <asp:TextBox ID="txtJobNumber" Width="250" runat="server" CssClass="form-control"></asp:TextBox>
                                    
                                         
                                    <%--onblur='CheckNullVal(this);' require="Enter JobNumber" validate="savevoucher"--%>
                                         </div>
                                    
                                    <div class="col-md-2" style="margin-top:4px;" >
                                        <label></label> 
                                         <div class="SearchDiv" style="margin-left: 68px;">
                                        <asp:LinkButton ID="btnFind" data-toggle="modal" data-target="#ModalFindJobs" runat="server" Text="Search" CssClass="search btn btn-primary"  CausesValidation="False" OnClientClick="return ShowDialog('FindJobs');">
                                            <i class="fa fa-search"></i>
                                            </asp:LinkButton>
                                             
                                    </div>
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
                                
                           
                             <div class="col-md-5">
                                
                                    <label>Date:</label>
                                
                                    <asp:TextBox ID="txtDate" Width="300" CssClass="DateTimePicker form-control" runat="server"
                                        require="Enter Voucher Date"  ValidationGroup="Validate" AutoComplete="Off"
                                        placeholder="Date"></asp:TextBox>
                                 </div>
                                
                           </div>

                           <div class="col-md-2"></div>

                           <div class="row" style="margin:10px;">
                                <div class="col-md-12">
                                    <label>Narration:</label>
                                
                                    <asp:TextBox ID="txtNarration" runat="server"
                                        TextMode="MultiLine" CssClass="form-control" placeholder="Narration"></asp:TextBox>                                                   
                                      </div>
                                <div class="col-md-6"></div>
                                
                           </div>

                        <div style="float: right; margin-top: 6px;">
                            <asp:LinkButton ID="LinkButtonBack" CssClass="buttonImp" runat="server"
                                Text="Back To List" OnClick="LinkButtonBack_Click" />
                        </div>

                         
                    </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
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
                                       <div class="container"> 
                                    <asp:GridView ID="GridTrans" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-responsive"
                                        DataKeyNames="TransactionID" ShowFooter="True" OnRowDataBound="GridTrans_RowDataBound"
                                        EnableTheming="True">
                                        <Columns>
                                            <%--yahan--%>

                                            <asp:TemplateField HeaderText="SNo.">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSno" runat="server" Text='<%# Eval("Sno") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Code" ItemStyle-Width="160px">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCode" runat="server" Text='<%# Eval("Code") %>'></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:HiddenField ID="HidtxtCode" runat="server" />
                                                    <asp:TextBox ID="txtCode" runat="server" CssClass="form-control" require="Enter Code" validate="checkcode" onblur='NullVal()'></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCode"
                                            ErrorMessage="Required!" Display="Dynamic" ForeColor="Red" ValidationGroup="Validate"></asp:RequiredFieldValidator>
                                                    <div class="SearchDiv">
                                                        <asp:LinkButton ID="btnFindACNO" data-toggle="modal" data-target="#ModalFindACNO" runat="server" Text="Search" CssClass="search" CausesValidation="False" OnClientClick="return ShowDialog('FindAccount');" />
                                                    </div>
                                                    <asp:RequiredFieldValidator ID="Required1" runat="server" ErrorMessage01="*"
                                                        ControlToValidate="txtCode" ValidationGroup="VGTrans"></asp:RequiredFieldValidator>
                                                </FooterTemplate>
                                                <FooterStyle Width="121px" />
                                                <ItemStyle Width="160px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Title">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTitle" runat="server" onkeypress="return Check('c',event);" Text='<%# Eval("Title") %>'></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" require="Title not Select on Given Code" validate="checkcode" ReadOnly="true"></asp:TextBox>
                                                    <asp:HiddenField ID="HidTitle" runat="server" />

                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Debit">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDebit" Style="float: none;" runat="server" Text='<%# Eval("Debit","{0:n}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtDebit" runat="server" CssClass="Debit form-control" onkeypress="return Check('d',event);"
                                                        AutoComplete="Off" CausesValidation="False" AutoCompleteType="None"></asp:TextBox>
                                                    <label id="lblDebit" style="color: Red;" runat="server" visible="false">*</label>
                                                </FooterTemplate>
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Credit">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCredit" Style="float: none;" runat="server" Text='<%# Eval("Credit","{0:n}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtCredit" runat="server" CssClass="Credit form-control" onkeypress="return Check('c',event);"
                                                        AutoComplete="Off"></asp:TextBox>
                                                    <label id="lblCrdt" style="color: Red;" runat="server" visible="false">*</label>
                                                </FooterTemplate>
                                                <ItemStyle HorizontalAlign="Right" />
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
                                                    <asp:DropDownList ID="cmbCostCenter" runat="server" Width="116px" DataTextField="CostCenterName" DataValueField="CostCenterID">
                                                        <%--custom="Coster Center Name" validate="checkcode" customFn="var age = parseInt(this.value); return age > 0;"--%>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Edit">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnEdit" runat="server" CssClass="edit" CommandArgument='<%# Eval("Sno") %>'
                                                        CausesValidation="False" OnCommand="btnEdit_Command">
                                                        <i class="icon fa-edit icon_custom" aria-hidden="true"></i>
                                                     </asp:LinkButton>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:LinkButton ID="btnSave" Style="" CssClass="buttonTnew btn btn-primary" runat="server" Text="Add" CommandName="Add"
                                                        OnClick="btnSave_Click" OnClientClick="return validate('checkcode');"  ValidationGroup="Validate"  />
                                                       <%-- ValidationGroup="VGTrans"--%>
                                                    <asp:Label ID="lblSno2" runat="server" Text='<%# Eval("Sno") %>' Visible="False"></asp:Label>
                                                </FooterTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Delete">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LbtnRemoveGridRow" CssClass="delete" runat="server" CausesValidation="False"
                                                        CommandArgument='<%# ((GridViewRow)Container).RowIndex%>' CommandName="Del" OnCommand="LbtnRemoveGridRow_Command"
                                                        Style="width: 18px" Text="">
                                                          <i class="icon fa-trash-o icon_custom" aria-hidden="true"></i>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="buttonNew btn"
                                                        Visible="false" Text="Cancel" OnClick="btnCancel_Click1"></asp:LinkButton>
                                                </FooterTemplate>
                                                <ControlStyle Width="50px" />
                                                <ItemStyle Width="50px" />
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                           <div class="row">
                                               <div class="col-md-4" style="padding:10px;">
                                                    <asp:LinkButton ID="btnSaveVoucher" CssClass="buttonImp btn btn-primary" runat="server" OnClientClick="return validate('savevoucher');"
                                Text="Save Voucher" OnClick="btnSaveVoucher_Click" />
                                                    <asp:LinkButton ID="lnkNew" CssClass="buttonImp btn btn-primary" runat="server" OnClick="lnkNew_Click">New Journal Voucher</asp:LinkButton>
                                               </div>

                                             


                                               <div class="col-md-4">
                                                   <div style="display: none;">
                            <asp:LinkButton ID="btnPrint" runat="server" CssClass="buttonImp"
                                Visible="False" OnClick="btnPrint_Click">Print View</asp:LinkButton>
                        </div>
                                               </div>
                                               
                                           </div>

                                           <div class="row" style="padding-bottom:10px;">
                                               <div class="col-md-4"></div>
                                               <div class="col-md-2">
                                                   <asp:Label ID="lbltotal" runat="server" Text="Total" Font-Bold="True" ForeColor="#2C8CB4"></asp:Label>
                                               </div>

                                               <div class="col-md-2">
                                                   <asp:Label ID="lbltotaldbt" runat="server" Font-Bold="True" ForeColor="#2C8CB4" Style="text-align: right"></asp:Label>
                                               </div>
                                           
                                               
                                               <div class="col-md-2">
                                                   <asp:Label ID="lbltotalcrdt" runat="server" Font-Bold="True" ForeColor="#2C8CB4"></asp:Label>
                                               </div>
                                               <div class="col-md-2"></div>
                                           </div>

                                           <div class="row">
                                                <div class="col-md-4">
                                                   <asp:Label ID="lblValidation" runat="server" Text="Debit and Credit should be equal"
                                                    Font-Bold="False" ForeColor="Red" Visible="False"></asp:Label>
                                               </div>
                                            </div>
                       
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
                </div>
                
        </ContentTemplate>

    </asp:UpdatePanel>

    <div id="PrintReport">
        <asp:UpdatePanel ID="UpdatePanel20" runat="server">
            <ContentTemplate>
                <asp:Button ID="ButtonPrint" runat="server" Text="Print"
                    OnClick="ButtonPrint_Click" OnClientClick="printSelection(document.getElementById('Reports'));return false" CssClass="buttonNew" />
                <div id="Reports">
          <%--          <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" SeparatePages="False"
                        AutoDataBind="true" EnableDrillDown="False" DisplayGroupTree="False"
                        DisplayToolbar="False" OnInit="CrystalReportViewer1_Init" OnNavigate="CrystalReportViewer1_Navigate1" />--%>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>



    <%--//this--%>
    
                <div class="modal fade modal-primary" id="ModalFindACNO" aria-hidden="true"
        aria-labelledby="ModalUserRole" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
          <div class="modal-dialog" style="width:800px;">
            <div class="modal-content">
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                
                 <div class="modal-header">
                    <h4 class="modal-title">Find</h4>
                </div> 

                 <div class="container">
                    <div class="row" style="padding:10px;">
                        <div class="col-md-6">
                <label style="padding-left: 20px">Enter Account No. </label>
                &nbsp;
                <asp:TextBox ID="txtAccountNo" CssClass="form-control" runat="server"> </asp:TextBox>
                            </div>
                        <div class="col-md-6" style="margin-top:26px;">
                <asp:Button ID="btnFindAcc" runat="server" Text="Find" CssClass="buttonImp btn btn-primary" Style="float: none" OnClick="btnFindAcc_Click" />
                            </div>
                
                </div>

                <asp:GridView ID="GrdAccounts" runat="server" CssClass="data main table table-bordered"
                    AllowPaging="True" PageSize="15"
                    OnPageIndexChanging="GrdAccounts_PageIndexChanging"
                    AutoGenerateColumns="False" OnRowCommand="GrdAccounts_RowCommand"
                    OnRowDataBound="GrdAccounts_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="Select">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkSelect" runat="server" OnClick="lnkSelect_Click">Select</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
                        <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                        <asp:BoundField DataField="CurrentBal" HeaderText="Current Balance" ReadOnly="True"
                            SortExpression="CurrentBal" DataFormatString="{0:n}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                 </div>

                 <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                    ConnectionString="<%$ ConnectionStrings:ASCS %>"
                    SelectCommand="SP_GetSubCodeTitleLikeAlls"
                    SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="Match" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
              </div>
</div>
    

        <div class="modal fade modal-primary" id="ModalFindJobs" aria-hidden="true"
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
                <asp:LinkButton ID="lbtnNo" CssClass="Button1" runat="server" OnClientClick="return closeDialog('Confirmation');">OK</asp:LinkButton>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>
