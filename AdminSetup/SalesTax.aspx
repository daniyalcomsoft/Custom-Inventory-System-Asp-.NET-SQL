<%@ Page Title="Setting Sales Tax" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SalesTax.aspx.cs" Inherits="AdminSetup_SalesTax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script src="Script/jquery-1.6.2.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="Script/jquery.validator.js" type="text/javascript"></script>

    <script src="Script/jquery-ui-1.8.16.custom.min.js" type="text/javascript" charset="utf-8"></script>
    <link href="Css/validator.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" href="Css/Style.css" type="text/css" />
<script type="text/javascript" language="javascript">
    //$(document).ready(function() {

    //    CreateModalPopUp('#NewSalesTax', 550, 400, 'Add/Modify SalesTax Year');
    //    CreateModalPopUp('#Confirmation', 290, 200, 'ALERT');
    //});
    function MyDate() {

        $(".DateTimePicker").datepicker();
    }
    function selectpic() {
        $(".selectpicker").selectpicker();
    }

    $(document).ready(function () {
        $('#btnNew').click(function () {
            $('#ModalTax').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
            $('#ModalTax').find('select').val('0');
            showhidecontrol('btnSave', true);
            enabledModal('ModalTax');
        })
    });
        
    </script>

    

    <style type="text/css">
    .CheckBoxs
        {
            float: left;
        }
        .CheckBoxs input[type=checkbox]
        {
            float: left;
            margin-right: 4px;
            margin-top: 2px;
        }
         .alertbox div
       {
           margin-top:0px;
       }
    
       <style type="text/css">
        body
        {
            background-image: none;
        }
        .input
        {
            height: 26px;
            line-height: 40px;
            border: outset 1px #ccc;
            font-size: 14px;
        }
        .btn_1
        {
            height: 30px;
            width: 120px;
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title">Tax Setup</h3>
                </div>

    <div class="Update_area">
    <div class="Heading">
     
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    
                    <ContentTemplate>
                        <script type="text/javascript">

                            $(document).ready(function () {
                                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                                function EndRequestHandler(sender, args) {
                                    $('#btnNew').click(function () {
                                        $('#ModalTax').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
                                        $('#ModalTax').find('select').val('0');
                                        showhidecontrol('btnSave', true);
                                        enabledModal('ModalTax');
                                    });

                                }
                            });

                        </script>
                        <div class="container">
                            <div class="row">
                                <div class="col-md-4"></div>
                                <div class="col-md-4"></div>
                                <div class="col-md-4" style="text-align:right;">
                                    <button type="button" id="btnNew" data-toggle="modal" data-target="#ModalTax" class="buttonImp btn btn-primary" >Create Tax</button>
                                </div>
                                
                        
                                </div>
                            </div>

                    </ContentTemplate>
                   <%-- <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnNew" EventName="Click" />
                    </Triggers>--%>
                </asp:UpdatePanel>
            
    </div>
    
   
<div id="StausMsg">
</div>
    <asp:Label ID="lblGroupID" runat="server" Visible="false"></asp:Label>
    
    <div id="Confirmation" style="display:none;">
        <asp:UpdatePanel ID="upConfirmation" runat="server">
            <ContentTemplate>
                
                <asp:Label ID="lblDeleteMsg" runat="server" Text=""></asp:Label>
               <%-- <br /><br /><asp:LinkButton ID="lbtnYes" CssClass="Button1 btn btn-primary" runat="server" OnClick="lbtnYes_Click">Yes</asp:LinkButton>&nbsp&nbsp
                <asp:LinkButton ID="lbtnNo" CssClass="Button1 btn btn-primary" runat="server"
                        OnClientClick="return closeDialog('Confirmation');">No</asp:LinkButton>--%>
            
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
   <br />
    <%--<div style="width:400px; height:30px;margin-left: 274px;">
                   <div>
                        <label style="font-size: 16px;margin-top: 5px;">
                            SalesTax Year:</label>
                        <asp:DropDownList runat="server" CssClass="input" ID="ddlFinYear" validate="group"
                         custom="Select SalesTax Year" customFn="var goal = parseInt(this.value); return goal > 0;">
                       </asp:DropDownList>
                    </div> 
                    <div>
                         <asp:Button ID="lbtnsetasdefault" CssClass="btn_1" Text="Set as Default" runat="server"
                         OnClientClick="return validate('group');" onclick="lbtnsetasdefault_Click"  />
                    </div>
    </div>
    <br />--%>
         <asp:UpdatePanel ID="UpdatePanel2" runat="server" ChildrenAsTriggers="true">
    <ContentTemplate> 
    <div align="center">
    <div class="container">
    <asp:GridView ID="GridSalesTax" CssClass="main data table table-bordered" runat="server" AutoGenerateColumns="False" 
              DataKeyNames="TaxDetailID" AllowPaging="true" PageSize="14" 
            onpageindexchanging="GridSalesTax_PageIndexChanging">
        <Columns>
            <asp:BoundField DataField="TaxDetailID" HeaderText="Tax Detail ID" InsertVisible="False" ItemStyle-HorizontalAlign="Center"
                ReadOnly="True" SortExpression="TaxDetailID" />
            
                  <asp:BoundField DataField="Province" HeaderText="Province" SortExpression="Province" />
                  <asp:BoundField DataField="TaxRule" HeaderText="Tax Rule" SortExpression="TaxRule" />
                  <asp:BoundField DataField="FromDate" HeaderText="From Date" SortExpression="FromDate" DataFormatString="{0:MM/dd/yyyy}" />
                  <asp:BoundField DataField="ToDate" HeaderText="To Date" SortExpression="ToDate" dataformatstring="{0:MM/dd/yyyy}" />
                  <asp:BoundField DataField="ServiceTax" HeaderText="Service Tax (%)" SortExpression="ServiceTax" />
                  <asp:BoundField DataField="HoldTax" HeaderText="Hold Tax (%)" SortExpression="HoldTax" />
                  <asp:BoundField DataField="IncomeTax" HeaderText="Income Tax (%)" SortExpression="IncomeTax" />
            <%-- DataFormatString="{0:dd/MM/yyyy}"--%>
            <asp:TemplateField HeaderText="Actions" ItemStyle-Width="10%">
                <ItemTemplate>
                
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <asp:LinkButton ID="lbtnEdit" runat="server" 
                        CommandArgument='<%# Eval("TaxDetailID") %>' OnCommand="lbtnEdit_Command" CssClass="edit">
                        <i class="icon fa-edit icon_custom" aria-hidden="true"></i>
                    </asp:LinkButton>
                    <asp:LinkButton ID="lbtnDelete" runat="server" cssClass="delete" 
                        CommandArgument='<%# Eval("TaxDetailID") %>' oncommand="lbtnDelete_Command">
                        <i class="icon fa-trash-o icon_custom" aria-hidden="true"></i>
                    </asp:LinkButton>
            </ContentTemplate>
              <Triggers>
                <asp:AsyncPostBackTrigger ControlID="lbtnEdit" EventName="Click" />
              </Triggers>
            </asp:UpdatePanel>
                </ItemTemplate>
            </asp:TemplateField>
            
        </Columns>
    </asp:GridView>
    </div>
    </div>
    </ContentTemplate>
    </asp:UpdatePanel>
        
      
          <div class="modal fade modal-primary" id="ModalTax" aria-hidden="true"
        aria-labelledby="ModalUserRole" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
          <div class="modal-dialog">
            <div class="modal-content">
      <asp:UpdatePanel ID="UpdatePanel1" runat="server">
      <ContentTemplate>
           <div class="modal-header">
                    <h4 class="modal-title">Create Tax</h4>
                </div> 

          <div class="modal-body">
                    <div class="row">
                        <div id="StatusMsgPopup">
                        </div>
              <div class="col-md-12">
                   <div class="form-horizontal" id="ModalForm">

                  <div class="form-group">
                       <label class="col-sm-3 control-label">Tax ID:</label> 
                      <div class="col-md-7">
                           <asp:TextBox ID="txtSalesTaxYearID" runat="server" CssClass="form-control" AutoComplete="Off" ReadOnly="True" ></asp:TextBox>
                      </div>
                  </div>
                       <div class="form-group">
                                    <label class="col-sm-3 control-label">Province :</label>
                                    <div class="col-sm-7">
                                         <asp:DropDownList runat="server" ID="cmbProvince" data-live-search="true" CssClass="form-control selectpicker" Width="100%" />
                                         <asp:RequiredFieldValidator  runat="server" ControlToValidate="cmbProvince"
                                             ErrorMessage="Required!" Display ="Dynamic" ForeColor="Red"  InitialValue="0" ValidationGroup="Validate" Type="Integer"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                     <div class="form-group">
                                    <label class="col-sm-3 control-label">TaxRule :</label>
                                    <div class="col-sm-7">
                                         <asp:DropDownList runat="server" ID="cmbTaxRule" data-live-search="true" CssClass="form-control selectpicker" Width="100%" />
                                         <asp:RequiredFieldValidator  runat="server" ControlToValidate="cmbTaxRule"
                                             ErrorMessage="Required!" Display ="Dynamic" ForeColor="Red"  InitialValue="0" ValidationGroup="Validate" Type="Integer"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                       
                  <div class="form-group">
                      <label class="col-sm-3 control-label"> Date From:</label>                       
                      <div class="col-md-7">
                          <asp:TextBox ID="txtDateFrom" CssClass="DateTimePicker form-control"
                         require="Enter Date From" placeholder="Date From" validate="SalesTaxYear" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtDateFrom"
                                             ErrorMessage="Required!" Display ="Dynamic" ForeColor="Red"  ValidationGroup="Validate" ></asp:RequiredFieldValidator>
                                             
                      </div>
                  </div>     
               
                  <div class="form-group">
                      <label class="col-sm-3 control-label">Date To:</label>                        
                      <div class="col-md-7">
                          <asp:TextBox ID="txtDateTo"  CssClass="DateTimePicker form-control" 
                        require="Enter Date To" validate="SalesTaxYear" placeholder="Date To" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtDateTo"
                                             ErrorMessage="Required!" Display ="Dynamic" ForeColor="Red"  ValidationGroup="Validate" ></asp:RequiredFieldValidator>
                      </div>
                  </div>    

                       <div class="form-group">
                       <label class="col-sm-3 control-label"> Service Tax (%):</label>                     
                      <div class="col-md-7">
                          <asp:TextBox ID="txtSalesTaxYear" require="Enter Sales Tax" 
                        validate="Sales Tax" CssClass="form-control" runat="server" placeholder="Sales Tax (%)"></asp:TextBox>
                         <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtSalesTaxYear"
                                             ErrorMessage="Required!" Display ="Dynamic" ForeColor="Red"  ValidationGroup="Validate" ></asp:RequiredFieldValidator>
                      </div>
                  </div>
                       
                       <div class="form-group">
                       <label class="col-sm-3 control-label"> Bank Hold Tax (%):</label>                     
                      <div class="col-md-7">
                          <asp:TextBox ID="txtBankHold" require="Enter Sales Tax" 
                        validate="Sales Tax" CssClass="form-control" runat="server" placeholder="Bank Hold Tax (%)"></asp:TextBox>
                      </div>
                  </div>
                       
                       <div class="form-group">
                       <label class="col-sm-3 control-label"> Income Tax (%):</label>                     
                      <div class="col-md-7">
                          <asp:TextBox ID="txtIncomeTax" require="Enter Sales Tax" 
                        validate="Sales Tax" CssClass="form-control" runat="server" placeholder="Income Tax (%)"></asp:TextBox>
                      </div>
                  </div>        
                </div>
              </div>
              </div>
                </div>

           <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                  <asp:LinkButton ID="btnSave" CssClass="Button1 btn btn-primary" runat="server" 
                                    onclick="btnSave_Click" ValidationGroup="Validate" OnClientClick="return validate('SalesTaxYear')">Save</asp:LinkButton>
                </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
        </Triggers>
        </asp:UpdatePanel>
                </div>
        </div>
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
                   <asp:Button runat="server" ID="btnConfirmation" OnClick="btnConfirmation_Click"  CssClass="btn1 btn-primary waves-effect waves-light"  Text="Yes" />
                </div>
             </ContentTemplate></asp:UpdatePanel>
            </div>
        </div>
    </div>      
     
     <br />
</div>
         </div>
</asp:Content>

