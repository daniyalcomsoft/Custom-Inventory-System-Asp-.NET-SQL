<%@ Page Title="View Commercial Invoices" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Invoice_Views.aspx.cs" Inherits="Sales_Invoice_View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            CreateModalPopUp('#Confirmation', 290, 100, 'ALERT');
            ddlSearch();
            bindCustomers();
        });

        function ddlSearch() {
            $("[id $= ddlSearch]").change(function() {
            var ddlVal = $("[id $= ddlSearch]").val();
                if (ddlVal == "Invoice ID") {
                    $("[id $= txtInvoiceID]").show();
                    $("[id $= txtCustomerName]").val('');
                    $("[id $= txtCustomerName]").hide();
                    $("[id $= txtJobNumber]").val('');
                    $("[id $= txtJobNumber]").hide();
                   // $("[id $= txtCustomerName]").val()='';
                }
                else if (ddlVal == "Customer Name") {
                    $("[id $= txtCustomerName]").show();
                       $("[id $= txtInvoiceID]").val('');
                       $("[id $= txtInvoiceID]").hide();
                       $("[id $= txtJobNumber]").val('');
                       $("[id $= txtJobNumber]").hide();
                   }
                   else {
                       $("[id $= txtJobNumber]").show();
                       $("[id $= txtInvoiceID]").val('');
                       $("[id $= txtInvoiceID]").hide();
                       $("[id $= txtCustomerName]").val('');
                       $("[id $= txtCustomerName]").hide();
                   }
         
            });
        }

        function bindCustomers() {


            $("[id$=txtCustomerName]").autocomplete({
                source: function(request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "WebMethod.aspx/Customers",
                        data: "{ 'Match': '" + request.term + "'}",
                        dataType: "json",
                        success: function(Data) {
                            response($.map(Data.d, function(item) {
                                return {
                                    CusID: item.CustomerID,
                                    label: item.CustomerName
                                }
                            }))
                        }
                    });
                },
                minLength: 1,
                select: function(event, ui) {
                    $("[id$=ddlCustomer]").val(ui.item.CusID);
                }
            });
        }





        function setSearchElem() {
            if ($("[id $=ddlSearch]").val() == "Invoice ID") {
                $("[id $= txtInvoiceID]").show();
                $("[id $= txtCustomerName]").hide();
                $("[id $= txtJobNumber]").hide();
            }
            else if ($("[id $=ddlSearch]").val() == "Customer Name") {
                $("[id $= txtCustomerName]").show();
                $("[id $= txtInvoiceID]").hide();
                $("[id $= txtJobNumber]").hide();
            }
            else {
                $("[id $= txtJobNumber]").show();
                $("[id $= txtCustomerName]").hide();
                $("[id $= txtInvoiceID]").hide();
            }
        }
    </script>
    <style type="text/css">
        .box_body
        {
            border: 1px solid #029FE2;
            margin-bottom: 10px;
            min-height: 75px;
            color: #444;
        }
        .box_header
        {
        background-color: #029FE2;
        height: 28px;
        }
        .box_txt
        {
        font-family: arial;
        text-align: left;
        color: white;
        padding: 4px 0px 0px 8px;
        font-weight: bolder;
        font-size: 15px;
        }
        .box_inner
        {
        padding: 10px;
        }
        .btn_1 {
        height: 25px;
        padding: 0px 10px;
        line-height: 20px;
        background-color: #029FE2;
        border-radius: 4px;
        color: #EDF6E3;
        font-size: 12px;
        border: 1px solid #029FE2;
        border-image: initial;
        font-weight: bold;
        margin-left: 5px;
        }
        .btn_1:hover {
        background-color: #2C8CB4;
        }
        #ctl00_ContentPlaceHolder1_btnSearch{
            border:none !important;
            background:#00897b;
        }
        #ctl00_ContentPlaceHolder1_btnClear{
            border:none !important;
            background:#00897b;
        }
        
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title"> Commercial Invoice View</h3>
                </div>

    <div class="Container">
        <div class="row">
            <div class="col-md-9"></div>
            <div class="col-md-2">
                <asp:LinkButton ID="btnCreateSalesInvoice" CssClass="buttonImp btn btn-primary" runat="server" 
                         onclick="btnCreateSalesInvoice_Click">
                        Create Commercial Invoice
                     </asp:LinkButton>
            </div>
            <div class="col-md-1"></div>
        </div>
         
                     
                 
    </div>
    <div id="StausMsg">
    </div>
    <div id="content">
    <br />
  
        <br />
        <div class="row">
           
            <div class="col-md-2">            
                <asp:Label ID="Label2" style="margin-left:10px; margin-top:8px; float:right;" runat="server" Text="Search By :"></asp:Label>
                </div>
            
            <div class="col-md-3">                            
            <asp:DropDownList ID="ddlSearch" CssClass="form-control"  runat="server" >
            <asp:ListItem Selected="True" Value="Invoice ID" Text="Invoice ID"></asp:ListItem>
            <asp:ListItem Value="Customer Name" Text="Customer Name"></asp:ListItem>
            <asp:ListItem Value="Job Number" Text="Job Number"></asp:ListItem>
            </asp:DropDownList>
            </div>

            <div class="col-md-3">
            <asp:TextBox ID="txtInvoiceID" CssClass="decimalOnly form-control" runat="server" 
                ontextchanged="txtInvoiceID_TextChanged"></asp:TextBox> 
                <asp:TextBox ID="txtCustomerName" CssClass="form-control" style="display:none;" runat="server"></asp:TextBox>  
             <asp:TextBox ID="txtJobNumber" CssClass="form-control" style="display:none;" runat="server"></asp:TextBox>
                   
            </div>

               
            
            <div class="col-md-3" style="margin-bottom:10px;"> 
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" 
                onclick="btnSearch_Click"  />
            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-primary" 
                onclick="btnClear_Click" />
            </div>

    </div>
    

    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:GridView ID="GridSalesInvoiceView" runat="server" 
            DataSourceID="objInvoice" CssClass="data main table table-bordered" AutoGenerateColumns="False"
        DataKeyNames="InvoiceID" AllowPaging="True" PageSize="15" 
            onpageindexchanging="GridSalesInvoiceView_PageIndexChanging">
            <Columns>        
            
                <asp:BoundField DataField="InvoiceID" HeaderText="Invoice ID" SortExpression="InvoiceID"/>
                <asp:BoundField DataField="DisplayName" HeaderText="Customer Name" SortExpression="DisplayName" />
                <asp:BoundField DataField="JobNumber" HeaderText="Job Number" SortExpression="JobNumber" />
                <asp:BoundField DataField="InvoiceDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Invoice Date" SortExpression="InvoiceDate" />
                <asp:BoundField DataField="TotalByParty" HeaderText="Total By Party" dataformatstring="{0:#,0.00}" SortExpression="TotalByParty"/>
                <asp:BoundField DataField="TotalByUS" HeaderText="Total By Us" dataformatstring="{0:#,0.00}" SortExpression="TotalByUS"/>
         
                <asp:TemplateField HeaderText="View" HeaderStyle-Width="35px">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbtnView" runat="server" cssClass="view"
                        CommandArgument='<%# Eval("InvoiceID") %>' OnCommand="lbtnView_Command"></asp:LinkButton>
                    </ItemTemplate>
                    <HeaderStyle Width="35px" />
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Edit" HeaderStyle-Width="31px">
                    <ItemTemplate>
                        <asp:LinkButton ID="LbtnEdit" runat="server" cssClass="edit"
                        CommandArgument='<%# Eval("InvoiceID") %>' OnCommand="LbtnEdit_Command" ToolTip='<%# Eval("TMessage") %>' ></asp:LinkButton>
                    </ItemTemplate>
                    <HeaderStyle Width="31px" />
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Delete" HeaderStyle-Width="41px">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbtnDelete" runat="server" CssClass="delete"
                        CommandArgument='<%# Eval("InvoiceID") %>'  ToolTip='<%# Eval("TMessage") %>'  OnCommand="lbtnDelete_Command"></asp:LinkButton>
                    </ItemTemplate>
                    <HeaderStyle Width="41px" />
                </asp:TemplateField>            
                
            </Columns>
        </asp:GridView>
    </ContentTemplate>
    </asp:UpdatePanel>
    
        <asp:ObjectDataSource ID="objInvoice" runat="server" 
            SelectMethod="getallInvoice" TypeName="Invoice_BAL">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="InvoiceID" Type="Int32" />
                <asp:Parameter DefaultValue="" Name="FinYearID" Type="Int32" />                
            </SelectParameters>
        </asp:ObjectDataSource>
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:PSMS %>" 
        SelectCommand="vt_SCGL_SpGetInvoice" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
   
    
  <asp:Label ID="lblGroupID" runat="server" Visible="false"></asp:Label>
    <div id="Confirmation" style="display:none;">
        <asp:UpdatePanel ID="upConfirmation" runat="server">
            <ContentTemplate>
                <asp:Label ID="lblDeleteMsg" runat="server" Text=""></asp:Label>
                <br /><br /><asp:LinkButton ID="lbtnYes" CssClass="Button1" runat="server" OnClick="lbtnYes_Click">Yes</asp:LinkButton>&nbsp&nbsp
                <asp:LinkButton ID="lbtnNo" CssClass="Button1" runat="server"
                OnClientClick="return closeDialog('Confirmation');">No</asp:LinkButton>            
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

           </div>
</asp:Content>

