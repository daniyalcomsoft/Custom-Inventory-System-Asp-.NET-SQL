<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="TaxInfo.aspx.cs" Inherits="AdminSetup_TaxInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        function selectpic() {
            $(".selectpicker").selectpicker();
        }
        function MyDate() {

            $(".DateTimePicker").datepicker();
        }


        $(document).ready(function () {
            $('#btnAdd').click(function () {
                $('#ModalTax').find('input,select,textarea').not(':button,:submit').val('');
                $('#ModalTax').find('select').val('0');
                showhidecontrol('btnSave', true);
                enabledModal('ModalTax');

            })
        });

        function ItemsSelected(sender, e) {
             $get("<%=hfSalesTaxID.ClientID %>").value = e.get_value();
           }
       

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>
        <script type="text/javascript">
            $(document).ready(function () {
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                function EndRequestHandler(sender, args) {
                    $('#btnAdd').click(function () {
                        $('#ModalTax').find('input,select,textarea').not(':button,:submit').val('');

                    });

                }
            });
            </script>
          <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title">Tax List</h3>
                </div>

                <div class="panel-body">
                     <div class="row">
                           <div class="col-sm-8 form-group">
                              <div class="bs-example">
                                <div class="btn-group">
                                    <asp:LinkButton runat="server" OnClick="btnSearch_Click" ID="btnSearch" CssClass="btn btn-primary pull-right"><i class='icon fa-search' aria-hidden='true'></i>Search</asp:LinkButton>
                                </div>
                                <div class="btn-group">
                                     <asp:LinkButton runat="server" ID="btnClear" OnClick="btnClear_Click" Text="Clear" CssClass="btn btn-default pull-right"/> 
                                </div>
                           </div>
                           </div>
                        <div class="col-sm-4 form-group">
                          <button type="button"  data-toggle="modal" data-target="#ModalTax" class="btn btn-primary pull-right" id="btnAdd">Add Tax Rule</button>
                        </div>
                    </div>
                      <div class="GridWrapper table-responsive">
                                     <asp:GridView runat="server" EmptyDataRowStyle-HorizontalAlign="Center" ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" ID="grd" OnPageIndexChanging="grd_PageIndexChanging" AllowPaging="true" PageSize="10" DataKeyNames="TaxRuleID" CssClass="table table-striped table-bordered dataTable table-responsive table-hover" >
                                        <EmptyDataTemplate>
                                            <h4>No record found</h4>
                                        </EmptyDataTemplate>
                                          <Columns>
                                                  <asp:TemplateField SortExpression="TaxRuleID" ItemStyle-Width="10%">
                                    <HeaderTemplate>

                                        <bold>Tax Rule #</bold>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="txtSearchTaxRuleID" placeholder="Tax Rule #"></asp:TextBox>

                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%# Eval("TaxRuleID") %>
                                    </ItemTemplate>
                                </asp:TemplateField>  
                                                <asp:TemplateField SortExpression="TaxRule" ItemStyle-Width="10%">
                                    <HeaderTemplate>

                                        <bold>Tax Rule</bold>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="txtSearchTax" placeholder="Tax Rule"></asp:TextBox>

                                       
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%# Eval("TaxRule") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                   

                                              <asp:TemplateField SortExpression="Province" ItemStyle-Width="10%">
                                    <HeaderTemplate>

                                        <bold>Province</bold>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="txtProvince" placeholder="Province"></asp:TextBox>

                                       
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%# Eval("Province") %>
                                    </ItemTemplate>
                                </asp:TemplateField>


                                            
                                               <asp:TemplateField ItemStyle-Width="10%"  HeaderText="Action" >
                                                 <ItemTemplate>
                                                     <asp:LinkButton runat="server" ToolTip="Edit" OnCommand="btnEdit_Command" CommandArgument='<%# Eval("TaxRuleID") %>'  ID="btnEdit" >
                                                         <i class="icon fa-edit icon_custom"  aria-hidden="true"></i>
                                                     </asp:LinkButton>
                                                      <asp:LinkButton runat="server" ToolTip="Delete" OnCommand="btnDelete_Command" CommandArgument='<%# Eval("TaxRuleID") %>'  ID="btnDelete" >
                                                         <i class="icon fa-trash-o icon_custom"  aria-hidden="true"></i>
                                                     </asp:LinkButton>
                                                     <asp:LinkButton runat="server" ID="btnTaxDetailInfo" OnCommand="btnTaxDetailInfo_Command" CommandArgument='<%# Eval("TaxRuleID") %>'>
                                                         <i class="icon fa-plus icon_custom"  aria-hidden="true"></i>
                                                     </asp:LinkButton>
                                                     <%--<button type="button" data-toggle="modal" data-target="#ModalDeal" class="btn1 btn-primary " id="btnAddDeal">Add Info</button>--%>
                                                     </ItemTemplate>
                                                   </asp:TemplateField>
                                                
                                               
                                         </Columns>
                                            <PagerStyle CssClass="GridPager" HorizontalAlign="Right" />
                        <PagerSettings  FirstPageText="First" PageButtonCount="5"  LastPageText="Last" Mode="NumericFirstLast" NextPageText="Next" Position="Bottom" PreviousPageText="Previous" />
                                     </asp:GridView>

                                </div>

                </div>
            </div>
   </ContentTemplate></asp:UpdatePanel>
 <!-- Modal -->
    <div class="modal fade modal-primary" id="ModalTax" aria-hidden="true"
        aria-labelledby="ModalTax" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                 <asp:UpdatePanel ID="UpdatePanel2" runat="server"><ContentTemplate>
                <div class="modal-header">
                    <h4 class="modal-title">Tax Rule</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div id="StatusMsgPopup">
                        </div>
                        <div class="col-sm-12">
                            <div class="form-horizontal" id="ModalForm">
                                 
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Tax Rule :<span class="required-field">*</span></label>
                                    <div class="col-sm-7">
                                          <asp:HiddenField runat="server" ID="hdID" />
                                       
                                         <asp:TextBox runat="server" ID="txtRuleTax" CssClass="form-control"  Width="100%" placeholder="Tax Rule"  />
                                          <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtRuleTax"
                                             ErrorMessage="Required!" Display ="Dynamic" ForeColor="Red"  ValidationGroup="Validate" ></asp:RequiredFieldValidator>
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

                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                   <asp:Button runat="server" ID="btnSave" OnClick="btnSave_Click" ValidationGroup="Validate"  CssClass="btn1 btn-primary waves-effect waves-light"  Text="Save" />
                </div>
             </ContentTemplate></asp:UpdatePanel>
            </div>
        </div>
    </div>






             
     <div class="modal fade modal-primary" id="ModalDeal" aria-hidden="true"
        aria-labelledby="ModalDeal" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">x</span></button>
                    <h4 class="modal-title">Tax Rule</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div id="StatusMsgsPopup">
                        </div>
                        <div class="col-sm-12">
                            <div class="form-horizontal" id="ModalForms">
                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                    <ContentTemplate>
                                       
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Tax Rule :</label>
                                            <div class="col-sm-4">
                                                 <asp:HiddenField runat="server" ID="HDRule" />
                                                <asp:TextBox runat="server" ID="txtRule" CssClass="form-control"  Width="100%" placeholder="Tax Rule" ReadOnly="true"  />
                                            </div>
                                       
                                            <label class="col-sm-2 control-label">Province :</label>
                                            <div class="col-sm-4">
                                                <asp:TextBox runat="server" ID="txtProv" CssClass="form-control"  Width="100%" placeholder="Province" ReadOnly="true"  />
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>

                                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                    <ContentTemplate>
                                        <script>
                                            function MyDate() {

                                                $(".DateTimePicker").datepicker();
                                            }
                                        </script>
                                        <div style="background-color: #009688;">
                                            <h4 class="deals" style="color: white; padding: 5px;">Tax Detail</h4>
                                        </div>
                                        <div class="form-group" id="btnLabelGroup" runat="server">
                                            <%--<label class="col-sm-3 control-label" id="btnLabel" runat="server">Item Name :</label>--%>


                                             <div class="col-sm-4" style="padding-top:5px;">
                                                 <asp:TextBox ID="txtSalesTaxYearID" runat="server" CssClass="form-control" AutoComplete="Off" ReadOnly="true" ></asp:TextBox>
                                                <asp:HiddenField ID="hfSalesTaxID" runat="server" />
                                            </div>
                                            <div class="col-sm-4" style="padding-top:5px;">
                                               <asp:TextBox ID="txtDateFrom" CssClass="DateTimePicker form-control" require="Enter Date From" placeholder="Date From" validate="SalesTaxYear" runat="server"></asp:TextBox>
                                                 <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtDateFrom" ErrorMessage="Required!" Display ="Dynamic" ForeColor="Red"  ValidationGroup="Validate1" ></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="col-sm-4" style="padding-top:5px;">
                                                 <asp:TextBox ID="txtDateTo"  CssClass="DateTimePicker form-control" require="Enter Date To" validate="SalesTaxYear" placeholder="Date To" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtDateTo" ErrorMessage="Required!" Display ="Dynamic" ForeColor="Red"  ValidationGroup="Validate1" ></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="col-sm-4" style="padding-top:5px;">
                                                <asp:TextBox ID="txtSalesTaxYear" CssClass="form-control" runat="server" placeholder="Service Tax (%)"></asp:TextBox>
                                            </div>
                                            <div class="col-sm-4" style="padding-top:5px;">
                                                <asp:TextBox ID="txtBankHold"  CssClass="form-control" runat="server" placeholder="Hold Tax (%)"></asp:TextBox>
                                            </div>
                                            <div class="col-sm-4" style="padding-top:5px;">
                                                <asp:TextBox ID="txtIncomeTax" CssClass="form-control" runat="server" placeholder="Income Tax (%)"></asp:TextBox>
                                            </div>
                                            <div class="col-sm-11" style="padding-top:5px;">
                                            </div>
                                            <div class="col-sm-1" style="padding-top:5px; margin-right:4px;">
                                                <asp:Button runat="server" ID="btnAddInfo" OnClick="btnAddInfo_Click" CssClass="btn1 btn-primary waves-effect waves-light" Text="ADD Detail" />
                                            </div>
                                        </div>

                                        <div class="col-8">
                                            <div class="GridWrapper table-responsive">
                                                <asp:GridView runat="server" EmptyDataRowStyle-HorizontalAlign="Center" ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" ID="grdTaxDetails" DataKeyNames="TaxDetailID" CssClass="table table-striped table-bordered dataTable table-responsive table-hover">
                                                    <EmptyDataTemplate>
                                                        <h4>No record found</h4>
                                                    </EmptyDataTemplate>
                                                    <Columns>
                                                        <asp:BoundField DataField="TaxDetailID" HeaderText="Tax Detail #" SortExpression="TaxDetailID" />
                                                        <asp:BoundField DataField="FromDate" HeaderText="From Date" SortExpression="FromDate" DataFormatString="{0:MM/dd/yyyy}" />
                                                        <asp:BoundField DataField="ToDate" HeaderText="To Date" SortExpression="ToDate" dataformatstring="{0:MM/dd/yyyy}" />
                                                        <asp:BoundField DataField="ServiceTax" HeaderText="Service Tax (%)" SortExpression="ServiceTax" />
                                                        <asp:BoundField DataField="HoldTax" HeaderText="Hold Tax (%)" SortExpression="HoldTax" />
                                                        <asp:BoundField DataField="IncomeTax" HeaderText="Income Tax (%)" SortExpression="IncomeTax" />
                                                        <asp:TemplateField ItemStyle-Width="20%" HeaderText="Action">
                                                            <ItemTemplate>
                                                                <asp:LinkButton runat="server" ToolTip="Delete" OnCommand="btnTaxDetailDelete_Command" CommandArgument='<%# Eval("TaxDetailID") %>' ID="btnTaxDetailDelete">
                                                         <i class="icon fa-trash-o icon_custom"  aria-hidden="true"></i>
                                                                </asp:LinkButton>
                                                                 <asp:LinkButton runat="server" ToolTip="Edit" OnCommand="btnEditTaxDetails_Command" CommandArgument='<%# Eval("TaxDetailID") %>' ID="btnEditTaxDetails">
                                                         <i class="icon fa-edit icon_custom"  aria-hidden="true"></i>
                                                                </asp:LinkButton>
                                                            </ItemTemplate>

                                                            
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>

                <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                    <ContentTemplate>
                        <div class="modal-footer">
                        </div>
                    </ContentTemplate>
                   
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

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



     <asp:Label ID="lblGroupID" runat="server" Visible="false"></asp:Label>
    <div class="modal fade modal-primary" id="ModalConfirmation" aria-hidden="true"
        aria-labelledby="ModalConfirmation" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                 <asp:UpdatePanel ID="UpdatePanel3" runat="server"><ContentTemplate>
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
     







    <!-- End Modal -->
</asp:Content>



