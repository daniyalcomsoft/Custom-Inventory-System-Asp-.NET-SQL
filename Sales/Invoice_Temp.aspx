<%@ Page Title="Create Commercial Invoice" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Invoice_Temp.aspx.cs" Inherits="Sales_Invoice_Temp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <%--<script src="Script/jquery-1.6.2.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="Script/jquery-ui-1.8.16.custom.min.js" type="text/javascript" charset="utf-8"></script>--%>


    <script type="text/javascript">

//    function ChangeConversionRate() {
//    $("[id $= txtConversionRate]").change(function() {

//    GrandPKRTotals();

//    });
//    }

//    function TotalGridAmount() {
//    total = 0;
//    GrandInvoiceTotal = 0;
//    GrandTotal = 0;

//    $("[id $= txttotal2],[id $= txtDiscount]").change(function() {
//    GrandTotals();

//    });
//    }

//    function GrandTotals() {
//    var tot1 = $("[id $= txttotal2]").val();

//    var discount = $("[id $= txtDiscount]").val();
//    if (discount == "") {
//    discount = 0;
//    }
//    //   var dis = discount.toFixed(3);
//    GrandInvoiceTotal = parseFloat(tot1 - discount);
//    $("[id $= txtTot]").val(GrandInvoiceTotal.toFixed(2));
//    GrandPKRTotals();
//    }


//    function GrandPKRTotals() {
//    var tot1 = $("[id $= txtTot]").val();

//    var ConversionRate = $("[id $= txtConversionRate]").val();
//    var NetTotalAmount = parseFloat(tot1 * ConversionRate);
//    //   var dis = discount.toFixed(3);
//    //GrandInvoiceTotal = parseFloat(tot1 * ConversionRate);
//    $("[id $= txtPKRTotal]").val(NetTotalAmount.toFixed(2));
//    }

//    function ChangeConversionRate() {
//    $("[id $= txtConversionRate]").change(function() {

//    GrandPKRTotals();

//    });
//    }



//    //    function vale() {
//    //        $("[id $= txtQuantity]").blur(function() {
//    //            var quantity = $(this).val();
//    //            var rate = $(this).parent().siblings().find("[id $= txtRate]").val();
//    //            var TotalPrice = parseFloat(quantity * rate);
//    //            var Fixed = TotalPrice.toFixed(2);
//    //            var Total = $(this).parent().siblings().find("[id $= txtAmount]").val(Fixed);
//    //            GrossTotalDeduction();
//    //        });
//    //        
//    //              
//    //        
//    //        

//    //        $("[id $= txtRate]").blur(function() {
//    //            var DeductionType = $(this).parent().siblings().find("[id $= txtDescription]").val();
//    //            var units = $(this).val();
//    //            if (DeductionType == "Amount") {

//    //                var Total = $(this).parent().siblings().find("[id $= txtAmount]").val(units);
//    //            }
//    //            else {
//    //                var quantity = $(this).parent().siblings().find("[id $= txtQuantity]").val();
//    //                var TotalPrice = parseFloat(quantity * units);
//    //                var Fixed = TotalPrice.toFixed(2);
//    //                var Total = $(this).parent().siblings().find("[id $= txtAmount]").val(Fixed);
//    //            }
//    //            GrossTotalDeduction();
//    //            
//    //            
//    //        });
//    //    }
//    //    var gross;


//    //    function GrossTotalDeduction() {
//    //        grosstotal = 0;
//    //        $("[id $= GV_InvoiceDetail] [id $= txtAmount]").each(function(index, item) {

//    //        if ($(item).val() == "") { $(item).val(0); }
//    //        grosstotal = grosstotal + parseFloat($(item).val());});
//    //        $("[id $= txtGrandInvoiceTotal]").val(grosstotal.toFixed(2)).change();
//    //    }
//    //    var grossdeduction;


//    /**/



//    function vale() {

//    $(".gv_txtQuantity").blur(function() {
//    var quantity = $(this).val();
//    var rate = $(this).parent().siblings().find(".gv_txtRate").val();
//    var TotalPrice = parseFloat(quantity * rate);
//    var Fixed = TotalPrice.toFixed(2);
//    var Total = $(this).parent().siblings().find(".gv_txtAmount").val(Fixed);
//    GrossTotalDeduction();
//    });
//    $(".gv_txtRate").blur(function() {
//    var DeductionType = $(this).parent().siblings().find(".gv_txtDescription").val();
//    var units = $(this).val();
//    if (DeductionType == "Amount") {

//    var Total = $(this).parent().siblings().find(".gv_txtAmount").val(units);
//    }
//    else {
//    var quantity = $(this).parent().siblings().find(".gv_txtQuantity").val();
//    var TotalPrice = parseFloat(quantity * units);
//    var Fixed = TotalPrice.toFixed(2);
//    var Total = $(this).parent().siblings().find(".gv_txtAmount").val(Fixed);
//    }
//    GrossTotalDeduction();
//    });

//    }
//    var gross;


//    function GrossTotalDeduction() {
//    grosstotal = 0;
//    $(".gv_txtAmount").each(function(index, item) {
//    if ($(item).val() == "") { $(item).val(0); }

//    grosstotal = grosstotal + parseFloat($(item).val());
//    });
//    $("[id $= txttotal2]").val(grosstotal.toFixed(2)).change();

//    }
//    var grossdeduction;
//    var selectedRow = -1;

        $(document).ready(function() {
            //        $("input[id$='btnaddlines2']").click(function() {
            //        });

            MyDate();
            ChangeDateEvent();
            //vale();
            //GrossTotalDeduction();
            //TotalGridAmount();
            totalAmount();
            //ChangeConversionRate();
            Job_AutoCom_Dialog();
            recalculate();
        });

//        function recalculate() {
//            $("[id$=txtByParty],[id$=txtCustomByParty],[id$=txtSalesTaxByParty],[id$=txtIncomeTaxByParty],[id$=txtCEDByParty],[id$=txtEOCByParty],[id$=txtFEDByParty],[id$=txtOthersByParty],[id$=txtExcessShortDutyByParty],[id$=txtByUs],[id$=txtCustomByUs],[id$=txtSalesTaxByUs],[id$=txtIncomeTaxByUs],[id$=txtCEDByUs],[id$=txtEOCByUs],[id$=txtFEDByUs],[id$=txtOthersByUs],[id$=txtExcessShortDutyByUs]").change(function() 
//            {
//                totalAmount();
//            });
//        }

        function recalculate() {
            $("[id$=txtByParty],[id$=txtByParty_duties],[id$=txtByUs],[id$=txtByUs_duties]").change(function() {
                totalAmount();
            });
        }
         
        function MyDate() {
            dateMin = $("[id $= hdnMinDate]").val();
            dateMax = $("[id $= hdnMaxDate]").val();
            $("[id$=txtInvoiceDate],[id$=txtCustomPODate],[id$=txtReceivedDate]").datepicker({ minDate: new Date(dateMin), maxDate: new Date(dateMax) });
        }

        function totalAmount() {
            var TotalByParty = 0;
            $("[id$=txtByParty],[id$=txtByParty_duties]").each(function() {
                if (!isNaN(this.value) && this.value.length != 0) {
                    TotalByParty += parseFloat(this.value);
                }
            });
            $("[id $= txttotalByParty]").val(TotalByParty.toFixed(2)).change();
            var TotalByUS = 0;
            $("[id$=txtByUs],[id$=txtByUs_duties]").each(function() {
                if (!isNaN(this.value) && this.value.length != 0) {
                    TotalByUS += parseFloat(this.value);
                }
            });
            $("[id $= txtTotalByUS]").val(TotalByUS.toFixed(2)).change();
        }

        function ChangeDateEvent() {
            $("[id $= txtInvoiceDate]").change(function() {
                dateMin = $("[id $= hdnMinDate]").val();
                dateMax = $("[id $= hdnMaxDate]").val();
                var invoiceDate = $(this).val();
                if (Date.parse(invoiceDate) < Date.parse(dateMin) || Date.parse(invoiceDate) > Date.parse(dateMax)) {
                    $(this).val('');
                }
            });
        }

        function Job_AutoCom_Dialog() {
            if ($("[id$=hdnJobNumber]").val() != "")
                $("[id $= tblJobDetail]").show();

            $("[id$=txtJobNumber]").autocomplete({
                source: function(request, response) {
                    $("[id $= txtTitle],[id$=hdnJobNumber]").val('');
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: 'Services/GetData.asmx/GetJobByNumber',
                        data: "{ 'Match': '" + request.term + "'}",
                        dataType: "json",
                        success: function(data) {
                            response($.map(data.d, function(item) {
                                return {
                                    label: item.JobNumber,
                                    value: item.JobNumber,
                                    JobID: item.JobID,
                                    Job: item
                                }
                            }))
                        }
                    });
                },
                minLength: 2,
                select: function(event, ui) {
                    $("[id$=txtJobNumber]").val(ui.item.value);
                    $("[id$=hdnJobNumber]").val(ui.item.JobID);
                    fillJobdetail(ui.item.Job);
                }
            });

            $('#FindJobs').dialog({
                autoOpen: false,
                draggable: true,
                title: "Find",
                width: 972,
                height: 450,
                open: function(type, data) {
                    $(this).parent().appendTo("form");
                }
            });

            $('#NewInvoiceDesc').dialog({
                autoOpen: false,
                draggable: true,
                title: "New Invoice Description",
                width: 900,
                height: 330,
                open: function(type, data) {
                    $(this).parent().appendTo("form");
                }
            });

            $('#NewInvoiceDutiesDesc').dialog({
                autoOpen: false,
                draggable: true,
                title: "New Invoice Duties Description",
                width: 900,
                height: 330,
                open: function(type, data) {
                    $(this).parent().appendTo("form");
                }
            });

            $("[id$=GV_CommercialInvoiceDetail] select[id$=ddlDescription]").change(function() {
                if ($(this).val() == "-1") {
                    ShowDialog('NewInvoiceDesc');
                    return false;
                }
                else {
                    return true;
                }
            });

            $("[id$=GV_CommercialInvoiceDutiesDetail] select[id$=ddlDescription_duties]").change(function() {
                if ($(this).val() == "-1") {
                    ShowDialog('NewInvoiceDutiesDesc');
                    return false;
                }
                else {
                    return true;
                }
            });

            //$("[ID$=txtDate]").datepicker();
        }

        function fillJobdetail(j) {
            $("[id $= lblCustomerName]").text(j.CustomerName);
//            $("[id $= lblContNumber]").text(j.ContactNo);
//            $("[id $= lblContDated]").text("");
            $("[id $= lblDescription]").text(j.JobDescription);
            $("[id $= lblContainer]").text(j.Container);
            $("[id $= lblContainerNo]").text(j.ContainerNo);
            $("[id $= lblContainerDate]").text(j.ContainerDate);
            $("[id $= lblIGMNo]").text(j.IGMNo);
            $("[id $= lblIGMDated]").text(toDateFromJson(j.IGMDate));
            $("[id $= lblIndexNo]").text(j.IndexNo);
            $("[id $= lblSS]").text(j.SS);
            $("[id $= lblQty]").text(j.QTY);
            $("[id $= lblBECashNo]").text(j.BECashNo);
            $("[id $= lblBECashDated]").text(toDateFromJson(j.MachineDate));
            $("[id $= lblMachineNo]").text(j.MachineNo);
            $("[id $= lblMachineDate]").text(toDateFromJson(j.MachineDate));
            $("[id $= lblDeliveryDate]").text(toDateFromJson(j.DeliveryDate));
            $("[id $= lblCNFValue]").text(j.CNFValue);
            $("[id $= lblImportValue]").text(j.ImportValue);
            $("[id $= tblJobDetail]").show();
        }

        function CheckNullVal(elem) {
            if ($(elem).val().length < 2) {
                $("[id$=hdnJobNumber]").val("");
            }
        }

        function toDateFromJson(src) {
            return convertDate(new Date(parseInt(src.substr(6))));
        }

        function convertDate(inputFormat) {
            function pad(s) { return (s < 10) ? '0' + s : s; }
            var d = new Date(inputFormat);
            return [pad(d.getMonth() + 1), pad(d.getDate()), d.getFullYear()].join('/');
        }
    </script>

    <style type="text/css">
        .block, .block-fluid
        {
            border: 1px solid #CCC;
            border-top: 0px;
            background-color: #F9F9F9;
            margin-bottom: 05px;
            -moz-border-bottom-left-radius: 3px;
            -moz-border-bottom-right-radius: 3px;
            -webkit-border-bottom-left-radius: 3px;
            -webkit-border-bottom-right-radius: 3px;
            -o-border-bottom-left-radius: 3px;
            -o-border-bottom-right-radius: 3px;
            -ms-border-bottom-left-radius: 3px;
            -ms-border-bottom-right-radius: 3px;
            border-bottom-left-radius: 3px;
            border-bottom-right-radius: 3px;
        }
        
        .top_heading
        {
            text-align: center;
        }
        select
        {
            border: 01px solid #ccc;
            height: 30px;
            width: 250px;
        }
        
        
        }
        .ui-tabs .ui-tabs-panel
        {
            display: block;
            border-width: 0;
            padding: 0.2em 0.2em;
            background: none;
        }
        .blance
        {
            text-align: right;
            font-size: 16px;
            font-weight: bold;
        }
        .amount
        {
            font-size: 16px;
        }
        .textarea
        {
            width: 200px;
            position: relative;
            top: -1px;
        }
        .sam_textbox
        {
            width: 120px;
        }
        .sam_textbox1
        {
            width: 70px;
        }
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
        .subtotal
        {
            float: right;
        }
        .subtotal table
        {
            width: 480px;
            text-align: right;
        }
        .subtotal table tr
        {
            line-height: 40px;
        }
        .subtotal table tr td div select
        {
            line-height: 20px;
        }
        .discount_value
        {
            width: 150px;
            height: 35px;
        }
        .comment_box
        {
            height: 86px;
            width: 350px;
            resize: none;
        }
        hr
        {
            border-bottom: 1px solid #CCC;
        }
        .file_uploader
        {
            margin-top: 15px;
        }
        .subtotal_txt
        {
            float: right;
            max-width: 150px;
            border: 1px solid transparent !important;
            text-align: right;
            font-weight: bold;
        }
        .float_right
        {
            float: right;
        }
        select .alertbox div
        {
            margin-top: -50px !important;
        }
       
        
        
       
        .data tr td:nth-child(8)
        {
            text-align: center;
            width: 75px;
        }
        .note
        {
            width: 96.4%;
            padding-left: 10px;
            height: 130px;
            min-height: 130px;
            max-height: 130px;
        }
        #attachments tr td
        {
        	border: 1px solid black;
       }
 
        
        input[type="checkbox"]
        {
        	width: 15px;
            height: 15px;
            padding-left:5px;
            padding-right:5px;
            float:right;
       }
        
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="NewInvoiceDesc" style="padding: 0;">
        <asp:UpdatePanel ID="UpInvoiceDesc" runat="server">
            <ContentTemplate>

                 <div class="row" style="margin-top:20px;">
                            <div class="col-md-4">
                                <label> Invoice Description</label>
                           <asp:TextBox ID="txtInvoiceDesc" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                      <div class="col-md-2"  style="margin-top:27px;">
                            <asp:Button ID="btnSaveInvoiceDesc" runat="server" Text="Save" CssClass="btn btn-primary"
                                OnClick="btnSaveInvoiceDesc_Click" />
                            </div>
                        </div>                               
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="NewInvoiceDutiesDesc">
        <asp:UpdatePanel ID="UpInvoiceDutiesDesc" runat="server">
            <ContentTemplate>
                        <div class="row" style="margin-top:20px;">
                            <div class="col-md-4">
                                <label>Invoice Duties Description</label>
                            <asp:TextBox ID="txtInvoiceDutiesDesc" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-2"  style="margin-top:27px;">
                                  <asp:Button ID="btnSaveInvoiceDutiesDesc" runat="server" Text="Save" CssClass="btn btn-primary"
                                OnClick="btnSaveInvoiceDutiesDesc_Click" />
                            </div>
                        </div>
                            
                       
                          
                   
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="FindJobs" style="margin-top:20px;">
        <asp:UpdatePanel ID="UpdatePanel6" runat="server">
            <ContentTemplate>  
                <div class="row">
                    <div class="col-md-6">
                         <label style="padding-left: 20px">Enter Job Number.</label>
                <asp:TextBox ID="txtJobNumberSearch" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-3" style="margin-top:27px;">
                        <asp:Button ID="btnFindJob" runat="server" Text="Find" CssClass="buttonImp btn btn-primary" Style="float: none"
                    OnClick="btnFindJob_Click" />
                    </div>
                    <div class="col-md-3"></div>
                </div>             
              <br />
                
                <asp:GridView ID="grdJobs" runat="server" CssClass="data main table table-bordered" AutoGenerateColumns="False"
                    DataSourceID="sqlDSJobs" EnableModelValidation="True" style="clear:both;" >
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
                <asp:SqlDataSource ID="sqlDSJobs" runat="server" ConnectionString="<%$ ConnectionStrings:ASCS %>"
                    SelectCommand="SELECT J.[JobID],J.[JobNumber],J.[JobDescription],C.[DisplayName]
	                            ,CASE WHEN J.[Completed] = 1 THEN 'TRUE' ELSE 'FALSE' END Completed FROM [vt_SCGL_Job] J
	                            INNER JOIN vt_SCGL_Customer C ON J.[CustomerID] = C.[CustomerID]">
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    
        <div id="StausMsg">
        </div>
        <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title">Commercial Invoices</h3>
                </div>
    <div class="container">

        <asp:UpdatePanel ID="UpJobDetail" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="row">
                    <div class="col-md-4">
                        <asp:Label ID="Label1" runat="server" Text="Invoice Date:" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="txtInvoiceDate" CssClass="form-control" runat="server" require="Select Invoice Date" ValidationGroup="Validate" validate="SaveInvoice"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <asp:Label ID="Label2" runat="server" Text="Reference No:" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="txtReferenceNo" CssClass="form-control" runat="server" 
                                ontextchanged="txtReferenceNo_TextChanged" AutoPostBack="true"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <asp:Label ID="Label18" runat="server" Text="Cust Inv. No:" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="txtCustInvoiceNo" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3">
                         <asp:Label runat="server" Text="Job Number:" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="txtJobNumber" CssClass="form-control" runat="server" require="Enter JobNumber" ValidationGroup="Validate" onblur='CheckNullVal(this);'
                                    validate="SaveInvoice" ontextchanged="txtJobNumber_TextChanged" AutoPostBack="true"></asp:TextBox>                                               
                    </div>
                    <div class="col-md-1" style="margin-top:23px;">
                         <asp:LinkButton style="margin-left:-18px;" ID="btnFind" Text="Search" runat="server" CssClass="search btn btn-primary btn-sm" CausesValidation="False"
                                        OnClientClick="return ShowDialog('FindJobs');" />
                    </div>
                    <div class="col-md-4">
                        <asp:Label runat="server" Text="Bill Number:" Font-Bold="true"></asp:Label>
                        <asp:TextBox ID="txtBillNumber" CssClass="form-control" runat="server"></asp:TextBox>
                         <asp:HiddenField ID="hdnJobNumber" runat="server" />
                    </div>
                    <div class="col-md-2" style="margin-top:15px;">
                        <asp:Label ID="Label23" runat="server" Text="No Advance:" Font-Bold="true"></asp:Label>
                            <asp:CheckBox ID="chkNoAdvance" runat="server" style="float:left;"  />
                        </div>
                    <div class="col-md-2" style="margin-top:15px;">
                         <asp:Label ID="Label19" runat="server" Text="Abbott Invoice:" Font-Bold="true"></asp:Label>
                            <asp:CheckBox ID="chkAbbottInvoice" runat="server" style="float:left;"  />
                        </div>
                    
                </div>

           <br />
                    <table style="width: 100%;display:none;">
                    <tr>
                        
                        <td>
                            <asp:Label ID="Label6" runat="server" Text="Custom P.O No:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCustomPONo" runat="server" Width="120px"></asp:TextBox>
                                
                        </td>
                        <td>
                            <asp:Label ID="Label7" runat="server" Text="Custom P.O Date:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCustomPODate" runat="server" Width="120px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="Label8" runat="server" Text="By Party:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCustomByParty" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                                
                        </td>
                        <td>
                            <asp:Label ID="Label9" runat="server" Text="By Us:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCustomByUs" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                        </td>
                        
                        
                    </tr>
                    <tr>
                                                                      
                         <td>
                            <asp:Label ID="Label3" runat="server" Text="Sales Tax PO No:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSalesTaxPONo" runat="server" Width="120px"></asp:TextBox>
                                
                        </td>
                        <td>
                            <asp:Label ID="Label4" runat="server" Text="Fine:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSalesTaxFine" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="Label5" runat="server" Text="By Party:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSalesTaxByParty" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                                
                        </td>
                        <td>
                            <asp:Label ID="Label10" runat="server" Text="By Us:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSalesTaxByUs" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                        </td>
                      
                    </tr>
                    <tr>
                        <%--<td>
                            <asp:Label ID="Label5" runat="server" Text="Income Tax:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtIncomeTax" runat="server"></asp:TextBox>
                        </td>--%>
                        
                         <td>
                            <asp:Label ID="Label11" runat="server" Text="Income Tax PO No:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtIncomeTaxPONo" runat="server" Width="120px"></asp:TextBox>
                              
                        </td>
                        <td>
                            <asp:Label ID="Label12" runat="server" Text="Addition:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtIncomeTaxAddition" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="Label13" runat="server" Text="By Party:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtIncomeTaxByParty" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                                
                        </td>
                        <td>
                            <asp:Label ID="Label14" runat="server" Text="By Us:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtIncomeTaxByUs" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                        </td>
                      
                    </tr>
                    <tr>
                                                                      
                         
                        <td>
                            <asp:Label ID="Label20" runat="server" Text="C.E.D%:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCEDPercent" runat="server" Width="120px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="Label21" runat="server" Text="By Party:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCEDByParty" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                                
                        </td>
                        <td>
                            <asp:Label ID="Label22" runat="server" Text="By Us:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCEDByUs" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                        </td>
                        <td></td>
                        <td></td>
                      
                    </tr>
                    <tr>
                                                                      
                         
                        <td>
                            <asp:Label ID="Label24" runat="server" Text="E.O.C%:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEOCPercent" runat="server" Width="120px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="Label25" runat="server" Text="By Party:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEOCByParty" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                                
                        </td>
                        <td>
                            <asp:Label ID="Label26" runat="server" Text="By Us:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEOCByUs" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                        </td>
                        <td></td>
                        <td></td>
                      
                    </tr>
                    <tr>
                                                                      
                        <td>
                            <asp:Label ID="Label28" runat="server" Text="F.E.D%:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtFEDPercent" runat="server" Width="120px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="Label29" runat="server" Text="By Party:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtFEDByParty" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                                
                        </td>
                        <td>
                            <asp:Label ID="Label30" runat="server" Text="By Us:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtFEDByUs" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                        </td>
                        <td></td>
                        <td></td>
                      
                    </tr>
                    <tr>
                                                                      
                        <td>
                            <asp:Label ID="Label32" runat="server" Text="Others%:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtOthersPercent" runat="server" Width="120px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="Label33" runat="server" Text="By Party:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtOthersByParty" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                                
                        </td>
                        <td>
                            <asp:Label ID="Label34" runat="server" Text="By Us:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtOthersByUs" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                        </td>
                        <td></td>
                        <td></td>
                      
                    </tr>
                    <tr>
                                                                      
                         <td>
                            <asp:Label ID="Label35" runat="server" Text="Short/Excess Duty PO No:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtExcessShortDutyPONo" runat="server" Width="120px"></asp:TextBox>
                                
                        </td>
                        <td>
                            <asp:Label ID="Label36" runat="server" Text="By Party:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtExcessShortDutyByParty" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                                
                        </td>
                        <td>
                            <asp:Label ID="Label37" runat="server" Text="By Us:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtExcessShortDutyByUs" CssClass="decimalOnly" runat="server" Width="120px"></asp:TextBox>
                        </td>
                        <td></td>
                        <td></td>
                      
                    </tr>
                    
                    
                </table>
              <div class="table table-responsive">
                <table id="tblJobDetail" runat="server" width="100%" style="display: none;" class="table table-bordered">
                    <tr>
                        <td colspan="10">
                            <asp:Label ID="lblCustomerName" runat="server" Text="" Font-Bold="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" Text="Cont No:" Font-Bold="true"></asp:Label>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="lblContainerNo" runat="server" Text="" Width="100px" Font-Bold="false"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" Text="Dated:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblContainerDate" runat="server" Text="" Width="100px" Font-Bold="false"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" Text="Des:" Font-Bold="true"></asp:Label>
                        </td>
                        <td colspan="4">
                            <asp:Label ID="lblDescription" runat="server" Text="" Width="350px" Font-Bold="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" Text="Container:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblContainer" runat="server" Text="" Width="100px" Font-Bold="false"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" Text="IGM No:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblIGMNo" runat="server" Text="" Width="100px" Font-Bold="false"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" Text="Dated:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblIGMDated" runat="server" Text="" Width="100px" Font-Bold="false"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" Text="Index No:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblIndexNo" runat="server" Text="" Width="100px" Font-Bold="false"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" Text="S.S:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblSS" runat="server" Text="" Width="100px" Font-Bold="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" Text="QTY:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblQty" runat="server" Text="" Width="100px" Font-Bold="false"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" Text="B.E.Cash No:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblBECashNo" runat="server" Text="" Width="100px" Font-Bold="false"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" Text="Dated:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblBECashDated" runat="server" Text="" Width="100px" Font-Bold="false"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" Text="Machine Date:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblMachineNo" runat="server" Text="" Width="100px" Font-Bold="false"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" Text="DT:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblMachineDate" runat="server" Text="" Width="100px" Font-Bold="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                        </td>
                        <td style="text-align: center" colspan="2">
                            <asp:Label runat="server" Text="Delivery Date:" Font-Bold="true"></asp:Label>
                            <asp:Label ID="lblDeliveryDate" runat="server" Text="" Font-Bold="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" Text="CNF Value Rs." Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblCNFValue" runat="server" Text="" Font-Bold="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" Text="Import Value Rs." Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblImportValue" runat="server" Text="" Font-Bold="false"></asp:Label>
                        </td>
                    </tr>
                </table>
                  </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
            <ProgressTemplate>
                <div id="processMessage">
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:UpdatePanel ID="Upd1" runat="server">
            <ContentTemplate>
              <div style="clear: both;">
                </div>
               <div style="margin-bottom: 15px;">
                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                        <ContentTemplate>
                           
                             <asp:GridView ID="GV_CommercialInvoiceDutiesDetail" runat="server" CssClass="data main table table-bordered"
                                AutoGenerateColumns="False" OnRowDeleting="GV_CommercialInvoiceDutiesDetail_RowDeleting">
                               
                                <Columns>
                                    <asp:TemplateField HeaderText="Description" HeaderStyle-HorizontalAlign="Left" >
                                        <ItemTemplate>
                                            <%--<asp:TextBox ID="txtProduct" runat="server" AutoComplete="Off" CssClass="autoCompleteCodes" Width="250px" require="Enter Product" validate="SaveInvoice"  Text='<%#Bind("txtProduct") %>'></asp:TextBox>--%>
                                            <asp:DropDownList ID="ddlDescription_duties" Width="170" CssClass="form-control" ValidationGroup="Validate" runat="server" validate="SaveInvoice" custom="Select Duties Description" customFn="var IInvoiceDutiesDescID = parseInt(this.value); return IInvoiceDutiesDescID > 0;">
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Number">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtNumber_duties" runat="server" CssClass="autoCompleteCodes4 form-control"
                                               Text='<%#Bind("txtNumber_duties") %>'>
                                            </asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Remarks" Visible="false">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtRemarks_duties" runat="server" CssClass="autoCompleteCodes4 form-control"
                                                Text='<%#Bind("txtRemarks_duties") %>'>
                                            </asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle  />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Date">
                                        <ItemTemplate>
                                            <%--<asp:TextBox ID="txtQuantity" runat="server" ReadOnly="true" CssClass="gv_txtQuantity SmallTextbox decimalOnly" Text='<%#Bind("txtQuantity")%>' /> </asp:TextBox>--%>
                                            <asp:TextBox ID="txtDate_duties" runat="server" CssClass="SmallTextbox form-control" 
                                                 Text='<%#Bind("txtDate_duties") %>'></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="By Party">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtByParty_duties" runat="server" CssClass="SmallTextbox decimalOnly form-control"
                                                 Text='<%#Bind("txtByParty_duties")%>'></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle  />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="By US">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtByUs_duties" runat="server" CssClass="SmallTextbox decimalOnly form-control"
                                                Text='<%#Bind("txtByUs_duties")%>'></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </asp:TemplateField>
                                    <asp:CommandField ShowDeleteButton="true"/>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div>
                    <asp:Button ID="btnAddLines_duties" runat="server" Text="Add lines" CssClass="btn-primary btn_spacing"
                        OnClick="btnAddLines_duties_Click" />
                    <asp:Button Visible="false" ID="btnClearAllLines_duties" runat="server" Text="Clear all lines"
                        CssClass="btn_1" OnClick="btnClearAllLines_duties_Click" />
                </div>
                <br />
              
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <div class="table-responsive">
                            <asp:GridView ID="GV_CommercialInvoiceDetail" runat="server" CssClass="data main table table-bordered"
                                AutoGenerateColumns="False" OnRowDeleting="GV_CommercialInvoiceDetail_RowDeleting">
                                <Columns>
                                    <asp:TemplateField HeaderText="Description" HeaderStyle-HorizontalAlign="Left" >
                                        <ItemTemplate>
                                            <%--<asp:TextBox ID="txtProduct" runat="server" AutoComplete="Off" CssClass="autoCompleteCodes" Width="250px" require="Enter Product" validate="SaveInvoice"  Text='<%#Bind("txtProduct") %>'></asp:TextBox>--%>
                                            <asp:DropDownList ID="ddlDescription" CssClass="form-control" Width="170" runat="server" ValidationGroup="Validate" validate="SaveInvoice" custom="Select Invoice Description" customFn="var IDescID = parseInt(this.value); return IDescID > 0;">
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Number" >
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtNumber" runat="server" CssClass="autoCompleteCodes4 form-control"
                                                Text='<%#Bind("txtNumber") %>'>
                                            </asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle  />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Remarks" >
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtRemarks" runat="server" CssClass="autoCompleteCodes4 form-control"
                                                Text='<%#Bind("txtRemarks") %>'>
                                            </asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle  />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Date/Amount" >
                                        <ItemTemplate>
                                            <%--<asp:TextBox ID="txtQuantity" runat="server" ReadOnly="true" CssClass="gv_txtQuantity SmallTextbox decimalOnly" Text='<%#Bind("txtQuantity")%>' /> </asp:TextBox>--%>
                                            <asp:TextBox ID="txtDate" runat="server" CssClass="SmallTextbox form-control" 
                                                 Text='<%#Bind("txtDate") %>'></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle  />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="By Party" >
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtByParty" runat="server" CssClass="SmallTextbox decimalOnly form-control"
                                               require="Enter By Party Price" ValidationGroup="Validate" validate="SaveInvoice" Text='<%#Bind("txtByParty")%>'></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="By US">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtByUs" runat="server" CssClass="SmallTextbox decimalOnly form-control"
                                                require="Enter By Us Price" ValidationGroup="Validate" validate="SaveInvoice" Text='<%#Bind("txtByUs")%>'></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle />
                                    </asp:TemplateField>
                                    <asp:CommandField ShowDeleteButton="true" />
                                </Columns>
                            </asp:GridView>
                                </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>            
                <div>
                    <asp:Button ID="btnAddLines" runat="server" Text="Add lines" CssClass="btn-primary btn_spacing"
                        OnClick="btnAddLines_Click" />
                    <asp:Button Visible="false" ID="btnClearAllLines" runat="server" Text="Clear all lines"
                        CssClass="btn_1" OnClick="btnClearAllLines_Click" />
                </div>
                <div class="subtotal">
                    <table>
                        <tr>
                            <td style="width: 320px">
                                Total By Party
                            </td>
                            <td>
                                <input id="txttotalByParty" readonly="readonly" runat="server" class="subtotal_txt" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 320px">
                                Total By US
                            </td>
                            <td>
                                <input id="txtTotalByUS" readonly="readonly" runat="server" class="subtotal_txt" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="clear: both;">
                </div>
                <div style="margin-bottom: 10px;">
                    <asp:UpdatePanel ID="updpnlbtn" runat="server">
                        <ContentTemplate>
                            <table style="width: 950px;">
                                <tr>
                                    <td style="text-align: right">
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                            CssClass="btn-primary btn_spacing float_right" />
                                        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn-primary btn_spacing float_right"
                                            OnClick="btnSave_Click" ValidationGroup="Validate" OnClientClick="return validate('SaveInvoice');" />
                                    </td>
                                </tr>
                            </table>
                            <div id="Notification_ItemID" style="display: none; width: 98%; margin: auto;">
                                <div class="alert-red">
                                    <h4>
                                        Error!</h4>
                                    <label id="IdError" runat="server" style="color: White">
                                        Add Atleast One Record</label>
                                </div>
                            </div>
                            <div id="Notification_Success" style="display: none; width: 98%; margin: auto;">
                                <div class="alert-green">
                                    <h4>
                                        Success</h4>
                                    <label id="lblSuccessMsg" runat="server" style="color: White">
                                        Invoice Created Successfully</label>
                                </div>
                            </div>
                            <div id="Notification_Error" style="display: none; width: 98%; margin: auto;">
                                <div class="alert-red">
                                    <h4>
                                        Error!</h4>
                                    <label id="lblNewError" runat="server" style="color: White">
                                        Please Select Item</label>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div style="clear: both;">
                </div>
                
                <div style="clear: both">
                </div>

                
                     <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title">Enclosed Documents/Attachments</h3>
                </div>
                         
                   
                        <div class="container">

                         <div class="row">
                            <div class="col-md-2">
                                <label>Delivery Challan</label> &nbsp;
                                <asp:CheckBox ID="chkDeliveryChallan" runat="server" />
                            </div>
                            <div class="col-md-2">
                                <label>L/C Contract</label>
                                <asp:CheckBox ID="chkLCContract" runat="server" />
                            </div>
                            <div class="col-md-2">
                                <label>Certificates</label>
                                <asp:CheckBox ID="chkCertificates" runat="server" />
                            </div>
                            <div class="col-md-2">
                                 <label>Packing List</label>
                                <asp:CheckBox ID="chkPackingList" runat="server" />
                            </div>
                            <div class="col-md-2">
                                <label>Invoice</label>
                                <asp:CheckBox ID="chkInvoice" runat="server" />
                            </div>
                            <div class="col-md-2">
                                <label>Weboc GD&#39;S</label>
                                <asp:CheckBox ID="chkWeboc" runat="server" />
                            </div>
                        </div>
                                
                         <div class="row">
                               <div class="col-md-2">
                                   <label>Paccs Coupon</label>
                                <asp:CheckBox ID="chkPaccsCoupon" runat="server" />
                               </div>
                               <div class="col-md-2">
                                   <label>Cash Payment Receipt</label>
                                <asp:CheckBox ID="chkCashPayReceipt" runat="server" />
                               </div>
                               <div class="col-md-2">
                                   <label>Excise Challan</label>
                                <asp:CheckBox ID="chkExciseDutyChallan" runat="server" />
                               </div>
                               <div class="col-md-2">
                                   <label>Bond Papers</label>
                                <asp:CheckBox ID="chkBondPapers" runat="server" />
                               </div>
                               <div class="col-md-2">
                                   <label>Delivery Order Receipt</label>
                                <asp:CheckBox ID="chkDOR" runat="server" />
                               </div>
                               <div class="col-md-2">
                                   <label>Q.I.C.T.L Invoice</label>
                                <asp:CheckBox ID="chkPICTLInv" runat="server" />
                               </div>
                           </div>
                                
                         <div class="row">
                               <div class="col-md-2">
                                    <label>Transportation Bill</label>
                                <asp:CheckBox ID="chkTransportBill" runat="server" />
                               </div>
                               <div class="col-md-2">
                                   <label>G.S.T Invoice</label>
                                <asp:CheckBox ID="chkGSTInv" runat="server" />
                               </div>
                              
                           </div>

                         <div class="row">
                               <div class="col-md-2"></div>
                               <div class="col-md-2"></div>
                               <div class="col-md-2"></div>
                               <div class="col-md-2"></div>
                               <div class="col-md-2"></div>
                               <div class="col-md-2"></div>
                           </div>
                     
                         <div class="row" style="display:none;">
                            
                                <label>I/T Challan</label> &nbsp;
                                <asp:CheckBox ID="chkITChallan" runat="server" />
                            
                                <label>B/E Importer (Copy)</label>
                                <asp:CheckBox ID="chkBEImporter" runat="server" />
                            
                                <label>KPT Wharfage Bill/Coupen</label>
                                <asp:CheckBox ID="chkKPTWharfage" runat="server" />
                            
                                <label>KPT Storage Bill/Coupen</label>
                                <asp:CheckBox ID="chkKPTStorage" runat="server" />
                            
                                <label>M.T.O Lift On Off Receipt</label>
                                <asp:CheckBox ID="chkMTOLift" runat="server" />
                            
                                <label>Yard Charges Receipt</label>
                                <asp:CheckBox ID="chkYardCharges" runat="server" />
                           
                                <label>E Form (Copy)</label>
                                <asp:CheckBox ID="chkEForm" runat="server" />
                            
                        </div>

                         <div class="row" style="display:none;">

                            <div class="col-md-2">
                                <label>B/L (Copy)</label> &nbsp;
                                <asp:CheckBox ID="chkBL" runat="server" />
                            </div>
                            <div class="col-md-2">
                                <label>Air way B/L</label>
                                <asp:CheckBox ID="chkAirwayBL" runat="server" />
                            </div>
                            <div class="col-md-2">
                                <label>Insurance</label>
                                <asp:CheckBox ID="chkInsuranceDoc" runat="server" />
                            </div>
                            <div class="col-md-2">
                                 <label>Excise &amp; Taxation Challan</label>
                                <asp:CheckBox ID="chkExciseTaxChallan" runat="server" />
                            </div>
                            <div class="col-md-2">
                                <label>B/E Exchange Control</label>
                                <asp:CheckBox ID="chkBEExchange" runat="server" />
                            </div>
                            <div class="col-md-2">
                                <label>Original</label>
                                <asp:CheckBox ID="chkOriginal" runat="server" />
                            </div>                           

                        </div>
                     
                         <div class="row">
                               <div class="col-md-2">
                                   <label>Duplicate</label>
                                <asp:CheckBox ID="chkDuplicate" runat="server" />
                               </div>
                               <div class="col-md-2"></div>
                               <div class="col-md-2"></div>
                               <div class="col-md-2"></div>
                               <div class="col-md-2"></div>
                               <div class="col-md-2"></div>
                           </div>
                     
                         <div class="row">
                            <div style="display:none;">
                                <label>
                                EndorsmentReceipt</label> &nbsp;
                                <asp:CheckBox ID="chkEndorsmentReceipt" runat="server" />
                            </div>

                               <div class="col-md-2">
                                    <asp:TextBox CssClass="form-control" ID="OtherDocs1" runat="server" style="width:129px; font-size:12px;"></asp:TextBox>
                            <asp:CheckBox ID="chkOtherDocs1"  runat="server" />
                               </div>
                               <div class="col-md-2">
                                   <asp:TextBox CssClass="form-control" ID="OtherDocs2" runat="server" style="width:129px; font-size:12px;"></asp:TextBox>
                            <asp:CheckBox ID="chkOtherDocs2"  runat="server" />
                               </div>
                               <div class="col-md-2">
                                    <asp:TextBox CssClass="form-control" ID="OtherDocs3" runat="server" style="width:129px; font-size:12px;"></asp:TextBox>
                            <asp:CheckBox ID="chkOtherDocs3"  runat="server" />
                               </div>
                               <div class="col-md-2">
                                   <asp:TextBox CssClass="form-control" ID="OtherDocs4" runat="server" style="width:129px; font-size:12px;"></asp:TextBox>
                            <asp:CheckBox ID="chkOtherDocs4"  runat="server" />
                               </div>
                               <div class="col-md-2">
                                    <asp:TextBox CssClass="form-control" ID="OtherDocs5" runat="server" style="width:129px; font-size:12px;"></asp:TextBox>
                            <asp:CheckBox ID="chkOtherDocs5" runat="server" />
                               </div>
                               <div class="col-md-2">
                                   <asp:TextBox CssClass="form-control" ID="OtherDocs6" runat="server" style="width:129px; font-size:12px;"></asp:TextBox>
                            <asp:CheckBox ID="chkOtherDocs6"  runat="server" />
                               </div>
                            
                           
                        </div>

                         <div class="row" style="display:none;">
                            <div class="col-md-2">
                            <asp:TextBox CssClass="form-control" ID="OtherDocs7" runat="server" style="width:129px; font-size:12px;"></asp:TextBox>
                            <asp:CheckBox ID="chkOtherDocs7" runat="server" />
                            </div>
                            <div class="col-md-2">
                            <asp:TextBox CssClass="form-control" ID="OtherDocs8" runat="server" style="width:129px; font-size:12px;"></asp:TextBox>
                            <asp:CheckBox ID="chkOtherDocs8" runat="server" />
                            </div>
                            <div class="col-md-2">
                            <asp:TextBox CssClass="form-control" ID="OtherDocs9" runat="server" style="width:129px; font-size:12px;"></asp:TextBox>
                            <asp:CheckBox ID="chkOtherDocs9" runat="server" />
                            </div>
                            <div class="col-md-2">
                            <asp:TextBox CssClass="form-control" ID="OtherDocs10" runat="server" style="width:129px; font-size:12px;"></asp:TextBox>
                            <asp:CheckBox ID="chkOtherDocs10" runat="server" />
                            </div>
                            <div class="col-md-2">
                            <asp:TextBox CssClass="form-control" ID="OtherDocs11" runat="server" style="width:129px; font-size:12px;"></asp:TextBox>
                            <asp:CheckBox ID="chkOtherDocs11" runat="server" />
                            </div>
                        </div>
                        
                         <div style="display:none;" class="row">
                        <div class="col-md-4">
                            Exporter
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="txtExporter" runat="server" TextMode="MultiLine" CssClass="textarea"
                                Width="202px" Text=""></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            Consignee
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="txtConsignee" placeholder="Consignee" runat="server" TextMode="MultiLine"
                                CssClass="textarea" Width="202px"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            Buyer
                        </div>
                        <div class="col-md-4">
                            <asp:TextBox ID="txtBuyer" runat="server" placeholder="Buyer" TextMode="MultiLine"
                                CssClass="textarea" Width="206px"></asp:TextBox>
                        </div>
                    </div>
                            </div>
                   
                </div>
                    
               
                
               
                    
                
                <div style="clear: both">
                </div>
                <%--<table  style="width:70%;">--%>
                <table style="display:none;">
                    <tr>
                       
                        <%--<td style="width: 136px;">--%>
                        <td>
                            <asp:Label ID="Label15" runat="server" Text="Status:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlStatus" runat="server" require="Select Status" validate="SaveInvoice" style="width:128px;"> 
                            <asp:ListItem Text="Open" Value="0"></asp:ListItem>
                            <asp:ListItem Text="Close" Value="1"></asp:ListItem>
                           
                        </asp:DropDownList>
                                
                        </td>
                        
                        <%--<td style="width: 159px;">--%>
                        <td>
                            <asp:Label ID="Label17" runat="server" Text="Cheque No:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtChequeNo" CssClass="sam_textbox" runat="server" Width="120px"></asp:TextBox>
                                
                        </td>
                        <td>
                            <asp:Label ID="Label16" runat="server" Text="Received Date:" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtReceivedDate" runat="server" Width="120px"></asp:TextBox>
                        </td>
                   </tr>
            </table>
                <table style="width: 960px; height: 60px;" id="shiping">
                    <tr style="display:none;">
                        <td style="width: 90px; white-space: nowrap;">
                            ExportersRef
                        </td>
                        <td style="width: 210px;">
                            <asp:TextBox ID="txtExportersRef" runat="server" placeholder="ExportersRef" CssClass="sam_textbox"
                                Width="200px"></asp:TextBox>
                        </td>
                        <td style="width: 90px; white-space: nowrap;">
                            Form 'E' No :
                        </td>
                        <td style="width: 210px;">
                            <asp:TextBox ID="txtFormENo" runat="server" placeholder="Form E No" CssClass="sam_textbox"
                                Width="200px"></asp:TextBox>
                        </td>
                        <td style="width: 90px;">
                            Freight :
                        </td>
                        <td style="width: 210px; white-space: nowrap;">
                            <asp:TextBox ID="txtFreight" runat="server" placeholder="Freight" CssClass="sam_textbox"
                                Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="display:none;">
                        <td style="width: 90px; white-space: nowrap;">
                            Net Weight :
                        </td>
                        <td style="width: 210px;">
                            <asp:TextBox ID="txtNetWeight" runat="server" placeholder="Net Weight" CssClass="sam_textbox decimalOnly"
                                Width="200px"></asp:TextBox>
                        </td>
                        <td style="width: 90px; white-space: nowrap;">
                            Gross Weight :
                        </td>
                        <td style="width: 210px;">
                            <asp:TextBox ID="txtGrossWeight" runat="server" placeholder="Gross Weight" CssClass="sam_textbox decimalOnly"
                                Width="200px"></asp:TextBox>
                        </td>
                        <td style="width: 90px; white-space: nowrap;">
                            Proforma No :
                        </td>
                        <td style="width: 210px;">
                            <asp:TextBox ID="txtproformaNo" runat="server" placeholder="Proforma No" CssClass="sam_textbox"
                                Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="display:none;">
                        <td style="width: 90px;">
                            Insurance :
                        </td>
                        <td style="width: 210px;" colspan="3">
                            <asp:TextBox ID="txtInsurance" runat="server" placeholder="Insurance" CssClass="sam_textbox"
                                Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="display:none;">
                        <td style="display: none;">
                            Invoice ID
                        </td>
                        <td>
                            Terms
                        </td>
                        <td colspan="4">
                            <asp:TextBox ID="txtTerm" runat="server" CssClass="sam_textbox" placeholder="Terms"
                                Width="97%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="display:none;">
                        <td style="display: none;">
                            <asp:TextBox ID="txtInvoiceID" runat="server" CssClass="sam_textbox"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" style="text-align: left; padding-left: 5px;">
                            Note
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <asp:TextBox ID="txtNote" runat="server" style="height:50px; min-height:0;"
                                TextMode="MultiLine" MaxLength="100" CssClass="note form-control"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                <br />
                <asp:HiddenField ID="hdnMinDate" runat="server" />
                <asp:HiddenField ID="hdnMaxDate" runat="server" />
                
                <div class="file_uploader" style="display:none;">
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
            </div>
</asp:Content>
