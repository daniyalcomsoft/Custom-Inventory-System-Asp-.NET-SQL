<%@ Page Title="Create/Modify Job" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="JobSheetForm.aspx.cs" Inherits="Jobs_JobSheetForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<%--    <script src="Script/jquery-1.6.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="Script/jquery-ui-1.8.16.custom.min.js" type="text/javascript" charset="utf-8"></script>--%>

<script type="text/javascript">
    $(document).ready(function () {
        //        $("input[id$='btnaddlines2']").click(function() {
        //        });

        MyDate();
        //vale();
        GrossTotalDeduction();
        TotalGridAmount();
        //calculateSum();
       
    });


    function calculateSum() {        
        var sum = 0;
        $(".sumition").each(function () {            
            if (!isNaN(this.value) && this.value.length != 0) {
                sum += parseFloat(this.value);
            }
        });

        $("[id $= txttotal2]").val(sum.toFixed(2)).change();
    }


    //function TotalGridAmount() {
     //   total = 0;
     //   GrandInvoiceTotal = 0;
      //  GrandTotal = 0;

      //  $("[id $= txttotal2]").change(function () {
      //      GrandTotals();
    //
     //   });
  //  }

    function TotalGridAmount() {
        total = 0;
        GrandInvoiceTotal = 0;
        GrandTotal = 0;

        $(".gv_txtAmount").change(function () {
            GrossTotalDeduction();

        });
    }


    //function GrossTotalDeduction() {
    //    debugger
    //    grosstotal = 0;
    //    $(".gv_txtAmount").each(function (index, item) {
    //        if ($(item).val() == "") { $(item).val(0); }

    //        grosstotal = grosstotal + parseFloat($(item).val());
    //    });
    //    $("[id $= txttotal2]").val(grosstotal.toFixed(2)).change();

    //}
    //var grossdeduction;

   // function MyDate() {
    //    dateMin = $("[id $= hdnMinDate]").val();
     //   dateMax = $("[id $= hdnMaxDate]").val();
    //    $(".DateTimePicker").datepicker({ minDate: new Date(dateMin), maxDate: new Date(dateMax) });
   // }

    function MyDate() {
        $(".DateTimePicker").datepicker();
    }

    function ChangeDateEvent() {
        $("[id $= txtInvoiceDate]").change(function () {
            dateMin = $("[id $= hdnMinDate]").val();
            dateMax = $("[id $= hdnMaxDate]").val();
            var invoiceDate = $("[id$=txtInvoiceDate]").val();
            if (Date.parse(invoiceDate) < Date.parse(dateMin) || Date.parse(invoiceDate) > Date.parse(dateMax)) {
                $("[id$=txtInvoiceDate]").val('');
            }
        });
    }




    function vale() {

        $(".gv_txtQuantity").blur(function () {
            var quantity = $(this).val();
            var rate = $(this).parent().siblings().find(".gv_txtRate").val();
            var TotalPrice = parseFloat(quantity * rate);
            var Fixed = TotalPrice.toFixed(2);
            var Total = $(this).parent().siblings().find(".gv_txtAmount").val(Fixed);
            GrossTotalDeduction();
        });
        $(".gv_txtRate").blur(function () {
            var DeductionType = $(this).parent().siblings().find(".gv_txtDescription").val();
            var units = $(this).val();
            if (DeductionType == "Amount") {

                var Total = $(this).parent().siblings().find(".gv_txtAmount").val(units);
            }
            else {
                var quantity = $(this).parent().siblings().find(".gv_txtQuantity").val();
                var TotalPrice = parseFloat(quantity * units);
                var Fixed = TotalPrice.toFixed(2);
                var Total = $(this).parent().siblings().find(".gv_txtAmount").val(Fixed);
            }
            GrossTotalDeduction();
        });

    }
    var gross;


    function GrossTotalDeduction() {
        debugger
        grosstotal = 0;
        $(".gv_txtAmount").each(function (index, item) {
            if ($(item).val() == "") { $(item).val(0); }

            grosstotal = grosstotal + parseFloat($(item).val());
        });
        $("[id $= txttotal2]").val(grosstotal.toFixed(2)).change();

    }
    var grossdeduction;
    var selectedRow = -1;

    function Job_AutoCom_Dialog() {
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

        $('#FindJobs').dialog({
            autoOpen: false,
            draggable: true,
            title: "Find",
            width: 972,
            height: 450,
            open: function (type, data) {
                $(this).parent().appendTo("form");
            }
        });
    }
</script>

<style type="text/css">
    .block, .block-fluid {
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

  

    .top_heading {
        text-align: center;
    }

    select {
        border: 01px solid #ccc;
        height: 30px;
        width: 250px;
    }

    input {
        height: 30px;
        line-height: 30px;
        border: outset 1px #CCC;
        font-size: 14px;
        border-image: initial;
        width: 250px;
    }

    .ui-tabs .ui-tabs-panel {
        display: block;
        border-width: 0;
        padding: 0.2em 0.2em;
        background: none;
    }

    .blance {
        text-align: right;
        font-size: 16px;
        font-weight: bold;
    }

    .amount {
        font-size: 16px;
    }

    .textarea {
        width: 200px;
        position: relative;
        top: -1px;
    }

    .sam_textbox {
        width: 120px;
    }

    .sam_textbox1 {
        width: 70px;
    }

    .btn_1 {
        height: 30px;
        width: 100px;
        line-height: 27px;
        background-color: #029FE2;
        border-radius: 4px;
        color: #EDF6E3;
        font-size: 12px;
        border: 1px solid #029FE2;
    }

        .btn_1:hover {
            background-color: #2C8CB4;
        }

    .btn_spacing {
        margin-right: 5px;
    }

    .subtotal {
        float: right;
    }

        .subtotal table {
            width: 480px;
            text-align: right;
        }

            .subtotal table tr {
                line-height: 40px;
            }

                .subtotal table tr td div select {
                    line-height: 20px;
                }

    .discount_value {
        width: 150px;
        height: 35px;
    }

    .comment_box {
        height: 86px;
        width: 350px;
        resize: none;
    }

    hr {
        border-bottom: 1px solid #CCC;
    }

    .file_uploader {
        margin-top: 15px;
    }

    .subtotal_txt {
        float: right;
        max-width: 150px;
        border: 1px solid transparent !important;
        text-align: right;
        font-weight: bold;
    }

    .float_right {
        float: right;
    }

    select .alertbox div {
        margin-top: -50px !important;
    }

    table.data td {
        font-size: 1.06em;
        border: none !important;
        color: #555;
        padding: 2px 2px !important;
        border-top: 1px solid #E6E6E6 !important;
        border-left: 1px solid #F2F2F2 !important;
        font-family: Verdana, Geneva, sans-serif;
        border-image: initial;
    }

    table.data {
        width: 100%;
        background: white;
        border: 2px solid #029FE2;
        font-size: 10px;
    }

        table.data th {
            font-size: 10px !important;
        }

        table.data input[type="text"] {
            width: 83px;
            line-height: 20px;
            height: 20px;
        }

    .data tr td:nth-child(8) {
        text-align: center;
        width: 75px;
    }

    .note {
        width: 96.4%;
        padding-left: 10px;
        height: 130px;
        min-height: 130px;
        max-height: 130px;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
    <div class="panel panel-bordered panel-primary">

                <div class="panel-heading form-group">
                    <h3 class="panel-title">Job Sheet</h3>
                </div>
            <div class="Update_area">                
                <div id="StausMsg"></div>
        
        <asp:UpdatePanel ID="Upd1" runat="server">
            <ContentTemplate>            
            
       
        
       <div class="container">
           <div class="row" style="padding:10px;">
               <div class="col-md-6">
                   <label>Job No.</label>
                    <asp:DropDownList runat="server" CssClass="form-control input" id="ddlJobNo" AutoPostBack="true"
                        validate="SaveInvoice" custom="Select Job No" 
                        onselectedindexchanged="ddlJobNo_SelectedIndexChanged">        
                        </asp:DropDownList> 
                  
               </div>
                <div class="col-md-6">
                        <label>Customer</label> 
                    <asp:HiddenField ID="hdnCustomerID" runat="server" />
                    <asp:TextBox ID="txtCustomer" runat="server" ReadOnly="true" Text="" CssClass="form-control"></asp:TextBox>
                   </div>
               <div class="col-md-12">
                    <label>Description</label> 
                   
                    <asp:TextBox ID="txtDescription2" placeholder="Description" runat="server" TextMode="MultiLine" CssClass="form-control" ></asp:TextBox>
               </div>
               <div class="col-md-12">
                   <label> Other Details</label> 
                    <asp:TextBox ID="txtOtherDetails" placeholder="Other Details" runat="server" TextMode="MultiLine" CssClass="form-control" ></asp:TextBox>
               </div>
           </div>
       
        
            
                        
                     
                      
                   
        
        
       
            
                     
                    
                   
                     
                   

     
   
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GV_CommercialInvoiceDetail" runat="server" CssClass="table table-bordered"
                                AutoGenerateColumns="False" OnRowDeleting="GV_CommercialInvoiceDetail_RowDeleting"> 
                                <Columns>
                                    <asp:TemplateField HeaderText="Date" ItemStyle-Width="86px">
                                        <ItemTemplate>
                                            <%--<asp:TextBox ID="txtQuantity" runat="server" ReadOnly="true" CssClass="gv_txtQuantity SmallTextbox decimalOnly" Text='<%#Bind("txtQuantity")%>' /> </asp:TextBox>--%>
 
                                            <asp:TextBox ID="txtDate" runat="server" CssClass="form-control DateTimePicker" require="Enter Date" validate="SaveInvoice" Text='<%#Bind("txtDate") %>'></asp:TextBox>   
                                        </ItemTemplate>
                                        <ItemStyle Width="86px" />
                                    </asp:TemplateField>

                                    <%--<asp:TemplateField HeaderText="Payment Type" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="250px">
                                        <ItemTemplate>
                                          
                                       <asp:DropDownList ID="ddlInventory" runat="server" Width="246px" >
                                       </asp:DropDownList>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle Width="250px" />
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Payment Type">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlPaymentType" runat="server" validate="SaveInvoice" custom="Select Payment Type" CssClass="form-control" AutoPostBack="true"
                                                customFn="var goal = parseInt(this.value); return goal > 0;" onselectedindexchanged="ddlPaymentType_SelectedIndexChanged"> 
                                                <asp:ListItem Text="--Please Select--" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Receipt" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Payment" Value="2"></asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                        
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Local/Official" >
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlInfoType" runat="server" CssClass="form-control" validate="SaveInvoice" custom="Select Info Type" 
                                                customFn="var goal = parseInt(this.value); return goal > 0;" > 
                                                <asp:ListItem Text="--Please Select--" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Local" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Official" Value="2"></asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                        
                                    </asp:TemplateField>                                  
                                    <asp:TemplateField HeaderText="P.O No." >
                                        <ItemTemplate>
                                                <asp:TextBox ID="txtPONo" runat="server" CssClass="form-control" Enabled="false" style="width: 106px;" validate="SaveInvoice" Text='<%#Bind("txtPONo") %>'></asp:TextBox>   
                                        </ItemTemplate>
                                       
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Expense" >
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlExpense" runat="server" CssClass="form-control" Enabled="false" require="Select Expense" validate="SaveInvoice">
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                        
                                    </asp:TemplateField> 
                                    
                                    <asp:TemplateField HeaderText="Payment Through" >
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlPaymentThrough" runat="server" require="Select Payment Through Account"  CssClass="form-control"  validate="SaveInvoice" custom="Select Payment Through Account" 
                                                customFn="var goal = parseInt(this.value); return goal > 0;" >
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                        <ItemStyle Width="114px" />
                                    </asp:TemplateField> 
                                    
                                     <asp:TemplateField HeaderText="Description" >
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" require="Enter Description" validate="SaveInvoice" Text='<%#Bind("txtDescription") %>'></asp:TextBox>   
                                        </ItemTemplate>
                                       
                                    </asp:TemplateField>    

                                    <asp:TemplateField HeaderText="Amount" >
                                        <ItemTemplate>
                                            <input id="txtAmount"  runat="server" class="form-control gv_txtAmount" style="width: 106px;text-align:right;" value='<%#Bind("txtAmount") %>' />
                                        </ItemTemplate>
                                        <ItemStyle Width="114px" />
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField HeaderText="Cost Center" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="150px">
                                        <ItemTemplate>
                                           
                                       <asp:DropDownList ID="ddlCostCenter" runat="server" Width="146px" >
                                             </asp:DropDownList>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle Width="150px" />
                                    </asp:TemplateField> --%>
                                     
                                    <asp:CommandField ShowDeleteButton="true" />
                                </Columns>
                            </asp:GridView>

                            <div class="row">
                                <div class="col-md-4">
                                     <asp:LinkButton ID="btnAddLines" runat="server" Text="Add lines" CssClass="btn btn-primary" OnClick="btnAddLines_Click" />
                                </div>
                                <div class="col-md-6"></div>
                                <div class="col-md-2">
                                    <label>Total</label>
                                <input id="txttotal2" readonly="true" runat="server" class="form-control" />
                                </div>
                                
                            </div>
                            <div class="row" style="margin-top:10px;">
                                <div class="col-md-9"></div>
                                <div class="col-md-3" style="text-align:right;">
                                    <asp:LinkButton ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" onclick="btnSave_Click" OnClientClick="return validate('SaveInvoice');" />
                                     <asp:LinkButton ID="btnCancel" runat="server" Text="Cancel" onclick="btnCancel_Click" CssClass="btn btn-primary"  />
                                
                                </div>
                            </div>
                            
                        </ContentTemplate>
                    </asp:UpdatePanel>
                   
           
                   
                    
                    <asp:Button Visible="false" ID="btnClearAllLines" runat="server" Text="Clear all lines" CssClass="btn btn-primary"  OnClick="btnClearAllLines_Click" />
                
              
                
                                
                            
                               
                             
                     </div>
 
           
            <asp:UpdatePanel ID="updpnlbtn" runat="server">
                <ContentTemplate> 
                   
                               

     <div style="clear: both;"></div>       
          <div id="Notification_ItemID" style="display:none; width:98%; margin:auto;">
                <div class="alert-red">
                    <h4>Error!</h4>
                    <label id="IdError" runat="server" style="color:White">Add Atleast One Record</label> 
                </div>
            </div>
        
      
            <div id="Notification_Success" style="display:none; width:98%; margin:auto;">
                <div class="alert-green">
                    <h4>Success</h4>
                    <label id="lblSuccessMsg" runat="server" style="color:White">Invoice Created Successfully</label>
                </div>
            </div>
  
            <div id="Notification_Error" style="display:none; width:98%; margin:auto;">
                <div class="alert-red">  
                    <h4>Error!</h4>
                        <label id="lblNewError" runat="server" style="color:White">Please Select Item</label> 
                    </div>
                </div>
                    
            </ContentTemplate>
            </asp:UpdatePanel>
            </div>        

       <div style="clear: both;"></div>    
       
        <br />       
           <asp:HiddenField ID="hdnMinDate" runat="server" />
           <asp:HiddenField ID="hdnMaxDate" runat="server" />
           

            
         </ContentTemplate>
         </asp:UpdatePanel>
    </div>
        </div>

</asp:Content>

