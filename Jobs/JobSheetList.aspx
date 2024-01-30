<%@ Page Title="View Jobs" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="JobSheetList.aspx.cs" Inherits="Jobs_JobSheetList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            CreateModalPopUp('#Confirmation', 290, 100, 'ALERT');
            ddlSearch();
            bindCustomers();
        });

        function ddlSearch() {
            $("[id $= ddlSearch]").change(function () {
                var ddlVal = $("[id $= ddlSearch]").val();
                if (ddlVal == "Invoice ID") {
                    $("[id $= txtInvoiceID]").show();
                    $("[id $= txtCustomerName]").val('');
                    $("[id $= txtCustomerName]").hide();
                    // $("[id $= txtCustomerName]").val()='';
                }
                else {
                    $("[id $= txtCustomerName]").show();
                    $("[id $= txtInvoiceID]").val('');
                    $("[id $= txtInvoiceID]").hide();
                }

            });
        }

        function bindCustomers() {


            $("[id$=txtCustomerName]").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "WebMethod.aspx/Customers",
                        data: "{ 'Match': '" + request.term + "'}",
                        dataType: "json",
                        success: function (Data) {
                            response($.map(Data.d, function (item) {
                                return {
                                    CusID: item.CustomerID,
                                    label: item.CustomerName
                                }
                            }))
                        }
                    });
                },
                minLength: 1,
                select: function (event, ui) {
                    $("[id$=ddlCustomer]").val(ui.item.CusID);
                }
            });
        }





        function setSearchElem() {
            if ($("[id $=ddlSearch]").val() == "Invoice ID") {
                $("[id $= txtInvoiceID]").show();

                $("[id $= txtCustomerName]").hide();
            }
            else {
                $("[id $= txtCustomerName]").show();

                $("[id $= txtInvoiceID]").hide();
            }
        }
    </script>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
        
             
                   
                
                    
                 
   <div class="panel panel-bordered panel-primary">

                <div class="panel-heading form-group">
                    <h3 class="panel-title">Job Sheet List</h3>
                </div>
            <div class="Update_area">                
                <div id="StausMsg"></div>
    
  <div class="container">
      <div class="row">
          <div class="col-md-4">
                        <label>Search By:</label>
          <asp:DropDownList ID="ddlSearch"  runat="server" CssClass="form-control">
            <asp:ListItem Selected="True" Value="Invoice ID" Text="Job ID"></asp:ListItem>
            <asp:ListItem Value="Customer Name" Text="Customer Name"></asp:ListItem>
            </asp:DropDownList>
          </div>
          <div class="col-md-3" style="margin-top:28px;">
              <asp:TextBox ID="txtInvoiceID" CssClass="decimalOnly form-control" runat="server" 
                ontextchanged="txtInvoiceID_TextChanged"></asp:TextBox> 
             <asp:TextBox ID="txtCustomerName" CssClass="form-control" style="display:none;" runat="server"></asp:TextBox>
          </div>
          <div class="col-md-1" style="margin-top:28px; margin-left:-28px;">
               <asp:LinkButton ID="btnSearch" runat="server" Text="Search" cssclass="btn btn-primary" 
                onclick="btnSearch_Click" >
                   <i class="fa fa-search"></i>
               </asp:LinkButton>
           </div>
          <div class="col-md-4" style="margin-top:28px; text-align:right;">
             
            <asp:LinkButton ID="btnClear" runat="server" Text="Clear" cssclass="btn btn-primary" 
                onclick="btnClear_Click" />
               <asp:LinkButton ID="btnCreateSalesInvoice" CssClass="btn btn-primary" runat="server" 
                         onclick="btnCreateSalesInvoice_Click">
                        Create Job Sheet
                     </asp:LinkButton>
        
          </div>

      </div>
      <br />

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:GridView ID="GridJobSheetView" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False"
        DataKeyNames="JobSheetID" AllowPaging="true" PageSize="15" 
            onpageindexchanging="GridJobSheetView_PageIndexChanging">
        
            <Columns>        
            
                <asp:BoundField DataField="JobSheetID" HeaderText="Job Sheet ID" SortExpression="JobSheetID"/>
                <asp:BoundField DataField="JobNumber" HeaderText="Job No." SortExpression="JobNumber"/>
                <asp:BoundField DataField="DisplayName" HeaderText="Customer Name" SortExpression="DisplayName" />
                <asp:BoundField DataField="Total" HeaderText="Total" dataformatstring="{0:#,0.00}" SortExpression="Total"/>
         
                <asp:TemplateField HeaderText="Action" HeaderStyle-Width="15%">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbtnView" runat="server" cssClass="view"
                        CommandArgument='<%# Eval("JobSheetID") %>' OnCommand="lbtnView_Command"></asp:LinkButton>
                        <asp:LinkButton ID="LbtnEdit" runat="server" cssClass="edit"
                        CommandArgument='<%# Eval("JobSheetID") %>' OnCommand="LbtnEdit_Command" >
                            <i class="fa fa-edit"></i>
                        </asp:LinkButton>
                         <asp:LinkButton ID="lbtnDelete" runat="server" CssClass="delete"
                        CommandArgument='<%# Eval("JobSheetID") %>' OnCommand="lbtnDelete_Command">
                            <i class="fa fa-trash-o"></i>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>        
                
            </Columns>
        </asp:GridView>
    </ContentTemplate>
    </asp:UpdatePanel>

                  </div>
                   </div>
                </div>
                

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:PSMS %>" 
        SelectCommand="SP_GetInvoiceForCustomer" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
   
    
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
</asp:Content>

