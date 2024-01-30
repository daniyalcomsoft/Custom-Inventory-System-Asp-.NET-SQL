<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Users.aspx.cs" Inherits="Security_Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        $(document).ready(function () {
            $('#btnAddUser').click(function () {
                $('#ModalUser').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
                $('#ModalUser').find('select').val('0');
                enabledModal('ModalUser');
                showhidecontrol('btnSave', true);
            })
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>
          <script type="text/javascript">
              $(document).ready(function () {
                  Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                  function EndRequestHandler(sender, args) {
                      $('#btnAddUser').click(function () {
                          $('#ModalUser').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
                          $('#ModalUser').find('select').val('0');
                          enabledModal('ModalUser');
                         
                          showhidecontrol('btnSave', true);
                      });

                  }
              });
            </script>
          <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title">Users</h3>
                </div>

                <div class="panel-body">
                     <div class="row">
                           <div class="col-sm-8 form-group">
                                <div class="col-sm-6 form-group">
                             <asp:TextBox runat="server" ID="txtSearch" CssClass="form-control" Width="100%" placeholder="Search"  />  </div>
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
                          <button type="button"  data-toggle="modal" data-target="#ModalUser" class="btn btn-primary pull-right" id="btnAddUser">Add User</button>
                        </div>
                    </div>
                      <div class="GridWrapper table-responsive">
                                     <asp:GridView runat="server" OnRowDataBound="grdUsers_RowDataBound" EmptyDataRowStyle-HorizontalAlign="Center" ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" ID="grdUsers" OnPageIndexChanging="grdUsers_PageIndexChanging" AllowPaging="true" PageSize="10" DataKeyNames="UserID" CssClass="table table-striped table-bordered dataTable table-responsive table-hover" >
                                        <EmptyDataTemplate>
                                            <h4>No record found</h4>
                                        </EmptyDataTemplate>
                                          <Columns>
                                             <asp:BoundField DataField="UserID" SortExpression="UserID" HeaderStyle-CssClass="hide" ItemStyle-CssClass="hide" />
                                           
                                             <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                             <asp:BoundField DataField="UserName" HeaderText="User ID" SortExpression="UserName" />
                                             <asp:BoundField DataField="RoleName" HeaderText="Role" SortExpression="RoleName" />
                                               <asp:BoundField DataField="Phone" HeaderText="Contact" SortExpression="Phone" />
                                               <asp:TemplateField ItemStyle-Width="15%"  HeaderText="Action" >
                                                 <ItemTemplate>
                                                      <asp:LinkButton runat="server" ToolTip="View" OnCommand="btnView_Command" CommandArgument='<%# Eval("UserID") %>' ID="btnView" >
                                                         <i class="icon fa-eye icon_custom" aria-hidden="true"></i>
                                                     </asp:LinkButton>
                                                     <asp:LinkButton runat="server" ToolTip="Edit" OnCommand="btnEdit_Command" CommandArgument='<%# Eval("UserID") %>'  ID="btnEdit" >
                                                         <i class="icon fa-edit icon_custom"  aria-hidden="true"></i>
                                                     </asp:LinkButton>
                                                      <asp:LinkButton runat="server" ToolTip="Delete" OnCommand="btnDelete_Command" CommandArgument='<%# Eval("UserID") %>'  ID="btnDelete" >
                                                         <i class="icon fa-trash-o icon_custom"  aria-hidden="true"></i>
                                                     </asp:LinkButton>
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
    <div class="modal fade modal-primary" id="ModalUser" aria-hidden="true"
        aria-labelledby="ModalUserRole" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                 <asp:UpdatePanel ID="UpdatePanel2" runat="server"><ContentTemplate>
                <div class="modal-header">
                    <h4 class="modal-title">Users</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div id="StatusMsgPopup">
                        </div>
                        <div class="col-sm-12">
                            <div class="form-horizontal" id="ModalForm">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Role :</label>
                                    <div class="col-sm-7">
                                          <asp:HiddenField runat="server" ID="hdID" />
                                        <asp:DropDownList runat="server" ID="cmbRole"  CssClass="form-control"  Width="100%" />
                                        <asp:RequiredFieldValidator  runat="server" ControlToValidate="cmbRole"
                                             ErrorMessage="Required!" Display ="Dynamic" ForeColor="Red"  InitialValue="0" ValidationGroup="Validate" Type="Integer"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Name :</label>
                                    <div class="col-sm-7">
                                      
                                        <asp:TextBox runat="server" ID="txtName" CssClass="form-control"  Width="100%" placeholder="Name"  />
                                          <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtName"
                                             ErrorMessage="Required!" Display ="Dynamic" ForeColor="Red"  ValidationGroup="Validate" ></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">UserID :</label>
                                    <div class="col-sm-7">
                                        <asp:TextBox runat="server" autocomplete="false"  ID="txtUserID" CssClass="form-control" Width="100%" placeholder="UserID"  />
                                          <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtUserID"
                                             ErrorMessage="Required!" Display ="Dynamic" ForeColor="Red"  ValidationGroup="Validate" ></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Password :</label>
                                    <div class="col-sm-7">
                                        <asp:TextBox runat="server" autocomplete="false"  ID="txtPassword" TextMode="Password" CssClass="form-control" Width="100%" placeholder="Password"  />
                                          <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtPassword"
                                             ErrorMessage="Required!" Display ="Dynamic" ForeColor="Red"  ValidationGroup="Validate" ></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                 <div class="form-group">
                                    <label class="col-sm-3 control-label">Phone :</label>
                                    <div class="col-sm-7">
                                        <asp:TextBox runat="server" ID="txtPhone"  CssClass="form-control" Width="100%" placeholder="Phone" />
                                    </div>
                                </div>
                                 <div class="form-group">
                                    <label class="col-sm-3 control-label">Email :</label>
                                    <div class="col-sm-7">
                                        <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" Width="100%" placeholder="Email" />
                                    </div>
                                </div>
                                 <div class="form-group">
                                    <label class="col-sm-3 control-label">Address :</label>
                                    <div class="col-sm-7">
                                        <asp:TextBox runat="server" ID="txtAddress" TextMode="MultiLine" CssClass="form-control" Width="100%" placeholder="Address" />
                                    </div>
                                </div>
                                 <div class="form-group">
                                    <label class="col-sm-3 control-label"></label>
                                    <div class="col-sm-7">
                                        <asp:CheckBox runat="server" Checked="true" Text="&nbsp;&nbsp;Active" ID="chkActive" /> 
                                    </div>
                                </div>
                               
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                   <asp:Button runat="server" ID="btnSave" UseSubmitBehavior="false" OnClientClick="if (!Page_ClientValidate('Validate')){ return false; } this.disabled = true; this.value = 'Saving...';" OnClick="btnSave_Click" ValidationGroup="Validate" CssClass="btn1 btn-primary waves-effect waves-light"  Text="Save" />
                </div>
             </ContentTemplate></asp:UpdatePanel>
            </div>
        </div>
    </div>

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

