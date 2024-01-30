<%@ Page Title="View Customers" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" 
CodeFile="CustomerForm_Views.aspx.cs" Inherits="Sales_CustomerForm_Views" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

   <script type="text/javascript" language="javascript">
       $(document).ready(function() {
           CreateModalPopUp('#Confirmation', 290, 100, 'ALERT');
           ddlSearch();
       });

       function ddlSearch() {
           $("[id $= ddlSearch]").change(function() {
               var ddlVal = $("[id $= ddlSearch]").val();
               if (ddlVal == "Customer Name") {
                   $("[id $= txtCustomerName]").show();
                    $("[id $= txtMobileNo]").hide();
                   $("[id $= txtMobileNo]").val('');
                    $("[id $= txtEmail]").val('');
                   $("[id $= txtEmail]").hide();
               }
               else if (ddlVal == "Mobile No") {
                   $("[id $= txtMobileNo]").show();
                    $("[id $= txtCustomerName]").val('');
                   $("[id $= txtCustomerName]").hide();
                    $("[id $= txtEmail]").val('');
                   $("[id $= txtEmail]").hide();
               }
               else {
                   $("[id $= txtEmail]").show();
                   $("[id $= txtCustomerName]").val('');
                   $("[id $= txtCustomerName]").hide();
                   $("[id $= txtMobileNo]").val('');
                   $("[id $= txtMobileNo]").hide();
               }
           });
       }

       function setSearchElem() {
           if ($("[id$=ddlSearch]").val() == "Customer Name") {
               $("[id $= txtCustomerName]").show();
               $("[id $= txtMobileNo]").hide();
               $("[id $= txtEmail]").hide();

           }
           else if ($("[id$=ddlSearch]").val() == "Mobile No") {
               $("[id $= txtMobileNo]").show();
               $("[id $= txtCustomerName]").hide();
               $("[id $= txtEmail]").hide();

           }

           else {
               $("[id $= txtEmail]").show();
               $("[id $= txtMobileNo]").hide();
               $("[id $= txtCustomerName]").hide();

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
        #ctl00_ContentPlaceHolder1_btnSearch{
            border:none;
            background:#009688;
        }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title">Customer Form View</h3>
                </div>   
         <div class="container">
             <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
                      <div class="row">
                          <div class="col-md-1" style="margin-top:10px;">
                              <asp:Label ID="Label1" runat="server" Text="Search By"></asp:Label>
                          </div>
                          <div class="col-md-3">
                               
                                <asp:DropDownList ID="ddlSearch"  runat="server" CssClass="form-control">
                                <asp:ListItem Selected="True" Value="Customer Name" Text="Customer Name"></asp:ListItem>
                                <asp:ListItem Value="Mobile No" Text="Mobile No"></asp:ListItem>
                                <asp:ListItem Value="Email" Text="Email"></asp:ListItem>
                                </asp:DropDownList>
                          </div>
                          <div class="col-md-3">
                              <asp:TextBox ID="txtCustomerName" CssClass="form-control" runat="server" ontextchanged="txtCustomerName_TextChanged" ></asp:TextBox> 
                                <asp:TextBox ID="txtMobileNo" CssClass="decimalOnly form-control"  style="display:none;" runat="server" ontextchanged="txtMobileNo_TextChanged"></asp:TextBox>
                                <asp:TextBox ID="txtEmail"  CssClass="form-control" style="display:none;" runat="server" ontextchanged="txtEmail_TextChanged"></asp:TextBox>
                          </div>
                          <div class="col-md-3 bs-example">
                              <div class="btn-group">
                              <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-primary" onclick="btnSearch_Click">
                                  <i class="fa fa-search"></i>
                              </asp:LinkButton>
                                    </div>
                              <div class="btn-group">
                              <asp:LinkButton ID="btnClear" runat="server" CssClass="btn btn-default" onclick="btnClear_Click" >
                                  <i class="fa fa-remove"></i>
                              </asp:LinkButton>
                                   </div>
                          </div>
                          <div class="col-md-2" style="text-align:right;">
                              
                               <asp:LinkButton ID="btnCancel" CssClass="btn btn-primary" runat="server" onclick="btnCancel_Click">Create Customer</asp:LinkButton>
                          </div>
                      </div>  
           
           
            
                      
            
        
         <br />

                <div id="StausMsg"></div>
                
           
           
        
    

    
    
            
        <asp:GridView ID="GridCustomerView" runat="server" CssClass="table table-striped table-bordered dataTable table-responsive table-hover" AutoGenerateColumns="False" DataKeyNames="CustomerID" AllowPaging="true" PageSize="10" onpageindexchanging="GridCustomerView_PageIndexChanging">
        <Columns>        
            <asp:BoundField DataField="DisplayName" HeaderText="Name" SortExpression="DisplayName"/>
            <asp:BoundField DataField="CompanyName" HeaderText="Company Name" SortExpression="CompanyName" />
            <asp:BoundField DataField="Email" HeaderText="Email"  SortExpression="Email" />
            <asp:BoundField DataField="BankName" HeaderText="Bank" SortExpression="BankName" />
            <asp:BoundField DataField="AccNo" HeaderText="Account No" SortExpression="AccNo"/>
     
            <asp:TemplateField ItemStyle-Width="15%"  HeaderText="Action" >
                <ItemTemplate>
                    <asp:LinkButton ID="lbtnView" runat="server" cssClass="view" CommandArgument='<%# Eval("CustomerID") %>' oncommand="lbtnView_Command">
                        <i class="icon fa-eye icon_custom"></i>
                    </asp:LinkButton>
                     <asp:LinkButton ID="LbtnEdit" runat="server" cssClass="edit" CommandArgument='<%# Eval("CustomerID") %>' oncommand="LbtnEdit_Command">
                        <i class="icon fa-edit icon_custom"></i>
                    </asp:LinkButton>
                    <asp:LinkButton ID="lbtnDelete" runat="server" CssClass="delete" CommandArgument='<%# Eval("CustomerID") %>' OnCommand="lbtnDelete_Command">
                          <i class="icon fa-trash-o icon_custom"></i>
                     </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
               
    </ContentTemplate>
    </asp:UpdatePanel>
     </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:PSMS %>" 
        SelectCommand="vt_SCGL_SPGetCustomerRecords" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
   
    
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

           <div class="modal fade modal-primary" id="ModalConfirmation" aria-hidden="true"
        aria-labelledby="ModalConfirmation" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                 <asp:UpdatePanel ID="UpdatePanel4" runat="server"><ContentTemplate>
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
    
     </div>
</asp:Content>
