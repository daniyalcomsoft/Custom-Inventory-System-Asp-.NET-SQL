<%@ Page Title="Setting Accounts" Language="C#" MasterPageFile="~/MasterPage.master" 
AutoEventWireup="true" CodeFile="SettingForm.aspx.cs" Inherits="AdminSetup_SettingForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
$(document).ready(function() {
 Load_AutoComplete_Code();

});

function Load_AutoComplete_Code() {
    debugger
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
                                    currBal: item.Balance,
                                }
                            }))
                        }
                    });
                },
                minLength: 3,
                select: function(event, ui) {
                    $('#' + $(this).attr('id') + 'lbl').text(ui.item.Title);
                    $("[id$=titlecode]").val(ui.item.Title);
                }

            })
            };
</script>
    <style type="text/css">
        .style1
        {
            width: 138px;
        }
        .style2
        {
            width: 180px;
        }
        #ctl00_ContentPlaceHolder1_btnCancel{
            border:none;
            background:#00897b;
            font-style:normal !important;
        }
        #ctl00_ContentPlaceHolder1_btnSave{
            border:none;
            background:#00897b;
            font-style:normal !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
          <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title">Create/Modify Account Settings</h3>
                </div>
<div id="StausMsg">
    </div>
    <br />
   <div class="container">


       <div class="row" style="display:none;">
                   
                    <div class="col-md-3">
                        <label>Asset Account</label>
                    </div>
                    <div class="col-md-6">
                         <asp:TextBox ID="txtAsetAcc" runat="server"
                      CssClass="form-control"
                     class="textfield autoCompleteCodes" placeholder="Asset Account" 
                    AutoPostBack="True"
                    MaxLength="9"></asp:TextBox>
                    </div>
                    <div class="col-md-3"></div>
                
           
               
           
               <asp:Label ID="txtCodelblAssetAccount" style="text-align:left" runat="server" 
                    ForeColor="#2C8CB4" Width="202px"></asp:Label>
               <input id="titlecode" runat="server" type="hidden" />
            </div>

       <div class="row" style="padding:5px;">
                   
                    <div class="col-md-3">
             <label>Income Account</label>
            </div>
                    <div class="col-md-6">
            <asp:TextBox ID="txtIncomAcc" runat="server" 
               validate="group" require="Please enter a Income Account" CssClass="autoCompleteCodes form-control"
                  class="textfield" placeholder="Income Account" AutoPostBack="true" 
                    ontextchanged="txtIncomAcc_TextChanged" MaxLength="9" ></asp:TextBox>
                        </div>
                    <div class="col-md-3"></div>
            
               <asp:Label ID="txtCodelblIncomeAccount" runat="server" ForeColor="#2C8CB4" Width="202px"></asp:Label>
           </div>

       <%--<tr align="left" style="display:none;">
            <td class="style2">
             <label>Expense Account</label> 
            </td>
            <td class="style1">
            <asp:TextBox ID="txtExpensAcc" runat="server" Style="width: 190px; height:28px; padding-right: 1px;"
               CssClass="autoCompleteCodes"
                  class="textfield" placeholder="Expense Account" 
                    AutoPostBack="True" MaxLength="9"></asp:TextBox>
            
            </td>
            <td class="style3" style="width:150px">
               <asp:Label ID="txtCodelblExpenseAccount" runat="server" ForeColor="#2C8CB4" Width="202px" 
                    Height="16px"></asp:Label>
           </td>
        </tr>--%>
              
       <div class="row" style="padding:5px;">
                   
                    <div class="col-md-3">
             <label>Deposit Account</label> 
           </div>
                    <div class="col-md-6">
            <asp:TextBox ID="txtDepositAcc" runat="server" 
               validate="group" require="Please enter a Deposit Account" CssClass="autoCompleteCodes form-control"
                  class="textfield" placeholder="Deposit Account" AutoPostBack="True" 
                    ontextchanged="txtDepositAcc_TextChanged" MaxLength="9"></asp:TextBox>
                        </div>
                    <div class="col-md-3"></div>
           
               <asp:Label ID="txtCodelblDepositAccount" runat="server" ForeColor="#2C8CB4" Width="201px" 
                    Height="16px"></asp:Label>
              </div>
          
       <div class="row" style="padding:5px;">
                    
                    <div class="col-md-3">
             <label>Customer Account</label> 
            </div>
                    <div class="col-md-6">
            <asp:TextBox ID="txtCustomerAcc" runat="server" 
               validate="group" require="Please enter a Customer Account" CssClass="autoCompleteCodes form-control"
                  class="textfield" placeholder="Deposit Account" AutoPostBack="True" 
                    ontextchanged="txtCustomerAcc_TextChanged" MaxLength="9"></asp:TextBox>
                 </div>
                    <div class="col-md-3"></div>
               <asp:Label ID="txtCodelblCustomerAccount" runat="server" ForeColor="#2C8CB4" Width="204px"></asp:Label>
            </div>

       <div class="row" style="padding:5px;">
             
                    <div class="col-md-3">
             <label>COGS Account</label> 
            </div>
                    <div class="col-md-6">
            <asp:TextBox ID="txtCOGSAcc" runat="server" 
               validate="group" require="Please enter Cost Of Goods Sold Account" CssClass="autoCompleteCodes form-control"
                  class="textfield" placeholder="Cost Of Goods Sold Account" AutoPostBack="True" 
                    ontextchanged="txtCOGSAcc_TextChanged" MaxLength="9"></asp:TextBox>
           </div>
                    <div class="col-md-3"></div>
               <asp:Label ID="txtCodelblCOGSAccount" runat="server" ForeColor="#2C8CB4" Width="204px"></asp:Label>
            </div>

       <div class="row" style="padding:5px;">
                   
                    <div class="col-md-3">
             <label>Inventory Account</label> 
           </div>
                    <div class="col-md-6">
            <asp:TextBox ID="txtInvAcc" runat="server" 
               validate="group" require="Please enter an Inventory Account" CssClass="autoCompleteCodes form-control"
                  class="textfield" placeholder="Inventory Account" AutoPostBack="True" 
                    ontextchanged="txtInvAcc_TextChanged" MaxLength="9"></asp:TextBox>
            </div>
                    <div class="col-md-3"></div>
               <asp:Label ID="txtCodelblInventoryAccount" runat="server" ForeColor="#2C8CB4" Width="204px"></asp:Label>
           </div>

       <div class="row" style="padding:5px;">
                    
                    <div class="col-md-3">
             <label>Inventory Adjsutment Account</label> 
            </div>
                    <div class="col-md-6">
            <asp:TextBox ID="txtInvAdjAcc" runat="server" 
               validate="group" require="Please enter an Inventory Adjustment Account" CssClass="autoCompleteCodes form-control"
                  class="textfield" placeholder="Inventory Adjustment Account" AutoPostBack="True" 
                    ontextchanged="txtInvAdjAcc_TextChanged" MaxLength="9"></asp:TextBox>
            </div>
                    <div class="col-md-3"></div>
               <asp:Label ID="txtCodelblInventoryAdjAccount" runat="server" ForeColor="#2C8CB4" Width="204px"></asp:Label>
          </div>

       <div class="row" style="padding:5px;">
                    
                    <div class="col-md-3">
             <label>Purchase Account</label> 
            </div>
                    <div class="col-md-6">
            <asp:TextBox ID="txtPurchaseAcc" runat="server"
               validate="group" require="Please enter a Purchase Account" CssClass="autoCompleteCodes form-control"
                  class="textfield" placeholder="Purchase Account" AutoPostBack="True" 
                    ontextchanged="txtPurchaseAcc_TextChanged" MaxLength="9"></asp:TextBox>
            </div>
                    <div class="col-md-3"></div>
               <asp:Label ID="txtCodelblPurchase" runat="server" ForeColor="#2C8CB4" Width="204px"></asp:Label>
            </div>

       <div class="row" style="padding:5px;">
                    
                    <div class="col-md-3">
             <label>Purchase Discount Account</label> 
            </div>
                    <div class="col-md-6">
            <asp:TextBox ID="txtPurchaseDiscountAcc" runat="server" 
                CssClass="autoCompleteCodes form-control"  validate="group" require="Please enter a Purchase Discount Account"
                  class="textfield" placeholder="Purchase Discount Account" AutoPostBack="True" ontextchanged="txtPurchaseDiscountAcc_TextChanged"
                     MaxLength="9"></asp:TextBox>
           </div>
                    <div class="col-md-3"></div>
               <asp:Label ID="txtCodelblPurchaseDiscount" runat="server" ForeColor="#2C8CB4" Width="204px"></asp:Label>
            </div>

       <div class="row" style="padding:5px;">
                   
                    <div class="col-md-3">
             <label>Sales Discount Account</label> 
            </div>
                    <div class="col-md-6">
            <asp:TextBox ID="txtSaleDiscountAcc" runat="server" 
               CssClass="autoCompleteCodes form-control"  validate="group" require="Please enter a Sale Discount Account"
                  class="textfield" placeholder="Sale Disocunt  Account" AutoPostBack="True" ontextchanged="txtSaleDiscountAcc_TextChanged"
                    MaxLength="9"></asp:TextBox>
             </div>
                    <div class="col-md-3"></div>
               <asp:Label ID="txtCodelblSaleDiscount" runat="server" ForeColor="#2C8CB4" Width="204px"></asp:Label>
           </div>

       <div class="row" style="padding:5px;">
                    
                    <div class="col-md-3">
             <label>Expense Account</label> 
           </div>
                    <div class="col-md-6">
            <asp:TextBox ID="txtExpenseAcc" runat="server" 
               CssClass="autoCompleteCodes form-control"  validate="group" require="Please enter an Expense Account"
                  class="textfield" placeholder="Expense Account" AutoPostBack="True" ontextchanged="txtExpenseAcc_TextChanged"
                    MaxLength="9"></asp:TextBox>
            </div>
                    <div class="col-md-3"></div>
               <asp:Label ID="txtCodelblExpense" runat="server" ForeColor="#2C8CB4" Width="204px"></asp:Label>
           
             </div>

       <div class="row" style="padding:5px;">
                   
                    <div class="col-md-3">
             <label>Sales Tax Account</label> 
            </div>
                    <div class="col-md-6">
            <asp:TextBox ID="txtSalesTaxAcc" runat="server"
               CssClass="autoCompleteCodes form-control"  validate="group" require="Please enter a Sales Tax Account"
                  class="textfield" placeholder="Sales Tax Account" AutoPostBack="True" ontextchanged="txtSalesTaxAcc_TextChanged"
                    MaxLength="9"></asp:TextBox>
             </div>
                    <div class="col-md-3"></div>
               <asp:Label ID="txtCodelblSalesTax" runat="server" ForeColor="#2C8CB4" Width="204px"></asp:Label>
            </div>

       <div class="row" style="padding:5px;">
                    
                    <div class="col-md-3">
             <label>Shipping Account</label> 
           </div>
                    <div class="col-md-6">
            <asp:TextBox ID="txtShippingAcc" runat="server" 
               CssClass="autoCompleteCodes form-control"  validate="group" require="Please enter a Shipping Account"
                  class="textfield" placeholder="Shipping Account" AutoPostBack="True" ontextchanged="txtShippingAcc_TextChanged"
                    MaxLength="9"></asp:TextBox>
            </div>
                    <div class="col-md-3"></div>
               <asp:Label ID="txtCodelblShippingAccount" runat="server" ForeColor="#2C8CB4" Width="204px"></asp:Label>
           </div>

       <div class="row" style="padding:5px;">
                   
                    <div class="col-md-3">
             <label>Detention Expense Account</label> 
            </div>
                    <div class="col-md-6">
            <asp:TextBox ID="txtDetentionExpAcc" runat="server" 
               CssClass="autoCompleteCodes form-control"  validate="group" require="Please enter a Detention Expense Account"
                  class="textfield" placeholder="Detention Expense Account" AutoPostBack="True" ontextchanged="txtDetentionExpAcc_TextChanged"
                    MaxLength="9"></asp:TextBox>
             </div>
                    <div class="col-md-3"></div>
               <asp:Label ID="txtCodelblDetentionExpAccount" runat="server" ForeColor="#2C8CB4" Width="204px"></asp:Label>
           </div>

       <div class="row" style="padding:5px;">
                    
                    <div class="col-md-3">
             <label>Impressed Account</label> 
             </div>
                    <div class="col-md-6">
            <asp:TextBox ID="txtImpressedAcc" runat="server" 
               CssClass="autoCompleteCodes form-control"  validate="group" require="Please enter an Impressed Account"
                  class="textfield" placeholder="Impressed Account" AutoPostBack="True" ontextchanged="txtImpressedAcc_TextChanged"
                    MaxLength="9"></asp:TextBox>
           </div>
                    <div class="col-md-3"></div>
               <asp:Label ID="txtCodelblImpressedAccount" runat="server" ForeColor="#2C8CB4" Width="204px"></asp:Label>
           </div>

       <div class="row" style="padding:5px;">
                   
                    <div class="col-md-3">
             <label>Cash Account</label> 
           </div>
                    <div class="col-md-6">
            <asp:TextBox ID="txtCashAcc" runat="server"
               CssClass="autoCompleteCodes form-control"  validate="group" require="Please enter a Cash Account"
                  class="textfield" placeholder="Cash Account" AutoPostBack="True" ontextchanged="txtCashAcc_TextChanged"
                    MaxLength="9"></asp:TextBox>
            </div>
                    <div class="col-md-3"></div>
               <asp:Label ID="txtCodelblCashAccount" runat="server" ForeColor="#2C8CB4" Width="204px"></asp:Label>
           </div>

       <div class="row" style="padding:10px;">
                    <div class="col-md-3"></div>
                    <div class="col-md-3"></div>
                    <div class="col-md-3">

                <asp:Button ID="btnCancel" runat="server" Text="Cancel"
                 Style="border:none;"
                    onclick="btnCancel_Click" CssClass="btn btn-success" /> 
                                                
                <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" CssClass="btn btn-success"
                Style="width: 75px; height:25px; margin:5px 19px 0 0;"
                 OnClientClick="return validate('group');" />
                        
                    
                        </div>
                    <div class="col-md-3"></div>
             </div>
                
                   

</div>
    </div>
</asp:Content>

