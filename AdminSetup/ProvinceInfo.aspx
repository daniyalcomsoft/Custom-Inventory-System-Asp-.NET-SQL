<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ProvinceInfo.aspx.cs" Inherits="AdminSetup_ProvinceInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        $(document).ready(function () {
            $('#btnAdd').click(function () {
                $('#ModalProvince').find('input,textarea').not(':button,:submit').val('');

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
                    $('#btnAdd').click(function () {
                        $('#ModalProvince').find('input,select,textarea').not(':button,:submit').val('');

                    });

                }
            });
            </script>
          <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title">Province List</h3>
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
                          <button type="button"  data-toggle="modal" data-target="#ModalProvince" class="btn btn-primary pull-right" id="btnAdd">Add Province</button>
                        </div>
                    </div>
                      <div class="GridWrapper table-responsive">
                                     <asp:GridView runat="server" EmptyDataRowStyle-HorizontalAlign="Center" ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" ID="grd" OnPageIndexChanging="grd_PageIndexChanging" AllowPaging="true" PageSize="10" DataKeyNames="ProvinceID" CssClass="table table-striped table-bordered dataTable table-responsive table-hover" >
                                        <EmptyDataTemplate>
                                            <h4>No record found</h4>
                                        </EmptyDataTemplate>
                                          <Columns>
                                                  <asp:TemplateField SortExpression="ProvinceID" ItemStyle-Width="10%">
                                    <HeaderTemplate>

                                        <bold>Province #</bold>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="txtSearchProvinceID" placeholder="Province #"></asp:TextBox>

                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%# Eval("ProvinceID") %>
                                    </ItemTemplate>
                                </asp:TemplateField>  
                                                <asp:TemplateField SortExpression="Province" ItemStyle-Width="10%">
                                    <HeaderTemplate>

                                        <bold>Province</bold>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="txtSearchProvince" placeholder="Province"></asp:TextBox>

                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%# Eval("Province") %>
                                    </ItemTemplate>
                                </asp:TemplateField>                                       
                                            
                                               <asp:TemplateField ItemStyle-Width="10%"  HeaderText="Action" >
                                                 <ItemTemplate>
                                                     <asp:LinkButton runat="server" ToolTip="Edit" OnCommand="btnEdit_Command" CommandArgument='<%# Eval("ProvinceID") %>'  ID="btnEdit" >
                                                         <i class="icon fa-edit icon_custom"  aria-hidden="true"></i>
                                                     </asp:LinkButton>
                                                      <asp:LinkButton runat="server" ToolTip="Delete" OnCommand="btnDelete_Command" CommandArgument='<%# Eval("ProvinceID") %>'  ID="btnDelete" >
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
    <div class="modal fade modal-primary" id="ModalProvince" aria-hidden="true"
        aria-labelledby="ModalProvince" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                 <asp:UpdatePanel ID="UpdatePanel2" runat="server"><ContentTemplate>
                <div class="modal-header">
                    <h4 class="modal-title">Province</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div id="StatusMsgPopup">
                        </div>
                        <div class="col-sm-12">
                            <div class="form-horizontal" id="ModalForm">
                                 
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">Province :<span class="required-field">*</span></label>
                                    <div class="col-sm-7">
                                          <asp:HiddenField runat="server" ID="hdID" />
                                       
                                         <asp:TextBox runat="server" ID="txtProvince" CssClass="form-control"  Width="100%" placeholder="Province"  />
                                          <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtProvince"
                                             ErrorMessage="Required!" Display ="Dynamic" ForeColor="Red"  ValidationGroup="Validate" ></asp:RequiredFieldValidator>
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
             
    <!-- End Modal -->
</asp:Content>



