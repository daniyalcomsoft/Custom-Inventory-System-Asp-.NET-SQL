<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UserRole.aspx.cs" Inherits="Security_UserRole" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Modal/UserRole/UserRole.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            BindGridView();
            $('#btnAddRole').click(function (e) {
                AddNewRole();
            });
            $('#btnSaveRole').click(function (e) {
                if ($("[Id$=txtRoleName]").val() != "") {
                    $("#sprole").hide();
                    SaveUpdateRole();
                }
                else {
                    $("#sprole").show();
                }
            });
            $('#btnSearch').click(function (e) {
               
                jQuery("#btnSearch").showLoading();
               
                    SearchGridData("GridUserRole", $("[Id$=txtSearch]").val(), 7);
                
                jQuery("#btnSearch").hideLoading();
            });
            $('#btnClear').click(function (e) {
                clearvalidate('Search');
               
                
                ClearRecordNotFound("GridUserRole", "txtSearch");
            });
        });

     

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 
                       <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title">Roles</h3>
                </div>

                <div class="panel-body">
                     <div class="row">
                           <div class="col-sm-8 form-group">
                                <div class="col-sm-6 form-group">
                             <asp:TextBox runat="server" ID="txtSearch" CssClass="form-control" Width="100%" placeholder="Search" Require="Enter Your Search" ValidateName="Search" ValidateType="TextBox" />  </div>
                              <div class="bs-example">
                                <div class="btn-group">
                                    <button type="button" id="btnSearch" class="btn btn-primary pull-right"><i class='icon fa-search' aria-hidden='true'></i>Search</button>
                                </div>
                                <div class="btn-group">
                                    <button type="button" id="btnClear" class="btn btn-default pull-right">Clear </button>
                                </div>
                           </div>
                           </div>
                        <div class="col-sm-4 form-group">
                          <button type="button"  class="btn btn-primary pull-right" id="btnAddRole">Add Role</button>
                        </div>
                    </div>
                            
                                <div class="GridWrapper table-responsive">
                                    <table id="GridUserRole" class="table table-bordered table-hover"></table>
                                </div>
                            
                   

                </div>
            </div>

    <!-- Modal -->
    <div class="modal fade modal-primary" id="ModalUserRole" aria-hidden="true"
        aria-labelledby="ModalUserRole" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Add Role</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div id="StatusMsgPopup">
                        </div>
                        <div class="col-sm-12">
                            <div class="form-horizontal" id="ModalForm">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Company Name :</label>
                                    <div class="col-sm-7">
                                        <asp:DropDownList  runat="server" ID="ddlCompany" Enabled="false" CssClass="form-control" Width="100%" />
                                        <asp:HiddenField runat="server" ID="HDDRoleID" Value="0" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Role Name :</label>
                                    <div class="col-sm-7">
                                        <asp:TextBox runat="server" ID="txtRoleName" CssClass="form-control"  Width="100%" placeholder="Role Name"  />
                                     <span id="sprole" style="color: red; display: none;">Required!</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Description :</label>
                                    <div class="col-sm-7">
                                        <asp:TextBox runat="server" ID="txtDescription" CssClass="form-control" Width="100%" placeholder="Description" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Status :</label>
                                    <div class="col-sm-7">
                                        <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control" Width="100%">
                                            <asp:ListItem Selected="True" Text="Active" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Deactive" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-pure" data-dismiss="modal">Close</button>
                    <button type="button" id="btnSaveRole" class="btn btn-primary">Save</button>
                </div>
            </div>
        </div>
    </div>
              
    <!-- End Modal -->
</asp:Content>

