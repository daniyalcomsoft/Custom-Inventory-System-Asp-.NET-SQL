<%@ Page Title="Voucher List" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="GLHome.aspx.cs" Inherits="Transactions_GLHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {

            $('#Confirmation').dialog({
                autoOpen: false,
                draggable: true,
                title: "Delete Voucher",
                width: 386,
                height: 95,
                open: function(type, data) {
                    $(this).parent().appendTo("form");
                }
            });
            ddlSearch();
           
        });
    function OpenUserPermission() {
        showDialog('Confirmation');
        return false;
    }
    function ddlSearch() {
           $("[id $= ddlSearch]").change(function() {
               var ddlVal = $("[id $= ddlSearch]").val();
               if (ddlVal == "Voucher Type") {
                   $("[id $= txtVoucherType]").show();
                   $("[id $= txtVoucherNo]").val('');
                   $("[id $= txtVoucherNo]").hide();
               }
               else if (ddlVal == "Voucher No") 
               {
                    $("[id $= txtVoucherNo]").show();
                     $("[id $= txtVoucherType]").val('');
                    $("[id $= txtVoucherType]").hide();
               }
           });
       }

       function setSearchElem() {
           if ($("[id $=ddlSearch]").val() == "Voucher Type") {
               $("[id $= txtVoucherType]").show();
               $("[id $= txtVoucherNo]").hide();

           }
           else {
               $("[id $= txtVoucherNo]").show();
               $("[id $= txtVoucherType]").hide();

           }
       }
</script>
    <style>
        .dom{
            background: #00897b !important;
            color: #ffffff !important;
            
        }
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title"> Voucher List</h3>
                </div>


    <div  class="Update_area">   
   <div id="StausMsg"></div>

        <div class="container">

            <div class="row" style="padding:10px;">
            
             <div class="col-md-4" >
                 <label>New Transaction :</label>
                 <asp:DropDownList ID="cmbAddNewVoucher" runat="server" 
                    onselectedindexchanged="cmbAddNewVoucher_SelectedIndexChanged" 
                    AutoPostBack="True" CssClass="form-control">
                    <asp:ListItem Selected="True" Value="0">Add New</asp:ListItem>
                    <asp:ListItem Value="1">General Voucher</asp:ListItem>
                    <asp:ListItem Value="3">Cash Reciept Voucher</asp:ListItem>
                    <asp:ListItem Value="2">Cash Payment Voucher</asp:ListItem>
                </asp:DropDownList>
            </div>
               
            
             <div class="col-md-4">
                 <label >Show :</label>
                <asp:DropDownList ID="cmbTransactionFilter" runat="server" 
                    AppendDataBoundItems="True" AutoPostBack="True" CssClass="form-control"
                    onselectedindexchanged="cmbTransactionFilter_SelectedIndexChanged">
                    <asp:ListItem Value="0">All Transaction</asp:ListItem>
                </asp:DropDownList>
                 </div>
            
                <div class="col-md-4">
                    <%--<asp:Label ID="Label1" runat="server" Text="Search By :"></asp:Label>--%>
                    <label >Search By :</label>
                     <asp:DropDownList ID="ddlSearch"  runat="server" CssClass="form-control">
            <asp:ListItem Selected="True" Value="Voucher Type" Text="Voucher Type"></asp:ListItem>
            <asp:ListItem Value="Voucher No" Text="Voucher No"></asp:ListItem>
              </asp:DropDownList>
                </div>
               
       </div>
       
            <div class="row" style="padding:10px;">
              
               <div class="col-md-4">
            <asp:TextBox ID="txtVoucherType" runat="server"  
                ontextchanged="txtVoucherType_TextChanged" Placeholder="Voucher Type / Voucher No" CssClass="form-control" ></asp:TextBox> 
                   <asp:TextBox ID="txtVoucherNo" CssClass="decimalOnly form-control" style="display:none;" runat="server" ontextchanged="txtVoucherNo_TextChanged"></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <asp:LinkButton ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" 
                onclick="btnSearch_Click">
                        <i class="fa fa-search"></i>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-default" 
                onclick="btnClear_Click">
                        <i class="fa fa-remove"></i>
                    </asp:LinkButton>
                </div>
                                                                         
           </div>
            
            
        
            <asp:GridView ID="GridVoucher" runat="server" CssClass="table table-striped table-bordered dataTable table-responsive table-hover" AutoGenerateColumns="False" onrowdatabound="GridVoucher_RowDataBound" AllowPaging="True" PageSize="10" onpageindexchanging="GridVoucher_PageIndexChanging">
                 <EmptyDataTemplate>
                    <h4>No record found</h4>
                 </EmptyDataTemplate>
                    <Columns>
                        <asp:BoundField DataField="VoucharDate" HeaderText="Date" ReadOnly="True" SortExpression="VoucharDate" dataformatstring="{0:MM/dd/yyyy}"  />
                        <asp:BoundField DataField="VoucherNumber" HeaderText="Number"  SortExpression="VoucherNumber" />
                        <asp:BoundField DataField="VoucherTypeName" HeaderText="Type"  SortExpression="VoucherTypeName" />
                        <asp:BoundField DataField="Narration" HeaderText="Narration" SortExpression="Narration" />
                        <asp:BoundField DataField="Amount" HeaderText="Amount" ReadOnly="True" DataFormatString="{0:n}" ItemStyle-HorizontalAlign="Right" SortExpression="Amount" />
                        <asp:TemplateField ItemStyle-Width="15%"  HeaderText="Action" >
                            <ItemTemplate>
                                <asp:Label ID="lblVoucherTypeID" runat="server" Text='<%# Eval("VoucherTypeID") %>' Visible="False"></asp:Label>
                                <asp:LinkButton ID="LbtnView" runat="server" CssClass="view" CommandName="View" CommandArgument='<%# Container.DataItemIndex %>' oncommand="LbtnView_Command">
                                    <i class="icon fa-eye icon_custom" aria-hidden="true"></i>
                                </asp:LinkButton>
                                <asp:Label ID="lblVoucherNumber" runat="server" Text='<%# Eval("VoucherNumber") %>' Visible="False"></asp:Label>
                                 <asp:LinkButton ID="lbtnEdit" runat="server" cssClass="edit" 
                                    CommandArgument='<%# Container.DataItemIndex %>' CommandName="Edited" 
                                    oncommand="lbtnEdit_Command" >
                                         <i class="icon fa-edit icon_custom" aria-hidden="true"></i>
                                    </asp:LinkButton>
                                <asp:LinkButton ID="lbtnDelete" runat="server" cssClass="delete" CommandName="deleted" CommandArgument='<%# Container.DataItemIndex %>' oncommand="lbtnDelete_Command" OnClientClick = "return OpenRolePermission('Add');">
                                    <i class="icon fa-trash-o icon_custom" aria-hidden="true"></i>
                                </asp:LinkButton>
                                <asp:Label ID="lblVoucherNumberDel" runat="server" Text='<%# Eval("VoucherNumber") %>' Visible="False"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                      
                    </Columns>
                </asp:GridView>
            
        </div>
                <br />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ASCS %>" SelectCommand="SELECT  DISTINCT Convert(varchar(20),VoucharDate,101) AS VoucharDate, VoucherNumber,VoucherTypeID, VoucherTypeName, Narration,ISNULL(Debit,Credit) AS Amount
FROM         vt_SCGL_Transaction"></asp:SqlDataSource>
            
   
          
    </div>

             </div>
    </ContentTemplate>
    </asp:UpdatePanel>
     <div id="Confirmation" style="display: none;">
        <asp:UpdatePanel ID="upConfirmation" runat="server">
            <ContentTemplate>
                <asp:Label ID="lblDeleteMsg" runat="server" Text=""></asp:Label>
                <br /><br />
                <asp:LinkButton ID="lbtnYes" CssClass="Button1" runat="server" onclick="lbtnYes_Click">Yes</asp:LinkButton>
                <asp:LinkButton ID="lbtnNo" CssClass="Button1" runat="server" OnClientClick="return closeDialog('Confirmation');">No</asp:LinkButton>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

     <div class="modal fade modal-primary" id="ModalConfirmation" aria-hidden="true"
        aria-labelledby="ModalConfirmation" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                 <asp:UpdatePanel ID="UpdatePanel5" runat="server"><ContentTemplate>
                <div class="modal-header">
                    <h4 class="modal-title">Confirmation</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div id="Div1">
                        </div>
                        <div class="col-sm-12">
                            <asp:HiddenField runat="server" ID="hdDeleteID" />
                           <label>Are you sure you want to delete this record?</label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                   <asp:LinkButton runat="server" ID="btnConfirmation" OnClick="btnConfirmation_Click"  CssClass="btn1 btn-primary waves-effect waves-light"  Text="Yes" />
                </div>
             </ContentTemplate></asp:UpdatePanel>
            </div>
        </div>
    </div> 

</asp:Content>

