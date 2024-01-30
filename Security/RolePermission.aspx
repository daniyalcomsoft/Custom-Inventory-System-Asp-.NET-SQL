<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="RolePermission.aspx.cs" Inherits="Security_RolePermission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
       <script type="text/javascript">
           $(document).ready(function () {
               $('.tab-a').on("click", function () {
                   $("#<%=hddTabID.ClientID %>").val($(this).find('a').attr('id'));
               });
           });
           
           function TabActive() {
               var ActiveID = $("#<%=hddTabID.ClientID %>").val();
               if (ActiveID != "") {
                   $('#' + ActiveID + '').trigger('click');
               }
           }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
              <script type="text/javascript">
                  $(document).ready(function () {
                      Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                      function EndRequestHandler(sender, args) {
                          $(function () {
                              $('.tab-a').on("click", function () {
                                  $("#<%=hddTabID.ClientID %>").val($(this).find('a').attr('id'));
                                  //post code
                              });
                          });
                      }
                  });
            </script>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-bordered">
                        <div class="panel-heading">
                            <h3 class="panel-title">Role Permission</h3>
                        </div>
                        <div class="panel-body">
                            <div class="form-horizontal">
                                <div class="form-group clearfix">
                                    <div class="col-sm-4">
                                        <h4>
                                            <asp:Label runat="server" ID="lblRoleName">Role Name</asp:Label></h4>
                                    </div>
                                    <div class="col-sm-8">
                                        <div class="bs-example pull-right">
                                            <div class="btn-group">
                                                <asp:HiddenField runat="server" ID="hddRoleID" />
                                                <asp:LinkButton ID="lbtnSave" runat="server" CssClass="btn btn-primary" OnClick="lbtnSave_Click"><i class="icon fa-save" aria-hidden="true"></i>Save</asp:LinkButton>
                                            </div>
                                            <div class="btn-group">
                                                <a href="UserRole.aspx" class="btn btn-default">Cancel</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Example Tabs Left -->
                                <div class="example-wrap">
                                     <asp:HiddenField runat="server" ID="hddTabID" />
                                    <div class="nav-tabs-vertical" id="tabs">
                                        <ul class="nav nav-tabs margin-right-25" data-plugin="nav-tabs" role="tablist">
                                            <li class="tab-a active" role="presentation"><a data-toggle="tab" href="#AllModule" aria-controls="AllModule" id="LIAllModule"
                                                role="tab">All Module</a></li>
                                          
                                             <li class="tab-a" role="presentation"><a data-toggle="tab" href="#tbVendors" aria-controls="Vendors" id="LIVendors"
                                                role="tab">Vendors</a></li>
                                             <li class="tab-a" role="presentation"><a data-toggle="tab" href="#tbItems" aria-controls="Items" id="LIItems"
                                                role="tab">Items</a></li>
                                             <li class="tab-a" role="presentation"><a data-toggle="tab" href="#tbProjects" aria-controls="Projects" id="LIProjects"
                                                role="tab">Projects</a></li>
                                           
                                             <li class="tab-a" role="presentation"><a data-toggle="tab" href="#tbPayments" aria-controls="Payments" id="LIPayments"
                                                role="tab">Payments</a></li>    
                                                  <li class="tab-a" role="presentation"><a data-toggle="tab" href="#tbQuotation" aria-controls="Quotation" id="LIQuotation"
                                                role="tab">Quotation</a></li> 
                                            
                                                                                 
                                             <li class="tab-a" role="presentation"><a data-toggle="tab" href="#tbMaintenance" aria-controls="Maintenance" id="LIMaintenance"
                                                role="tab">Maintenance</a></li>
                                      
                                             <li class="tab-a" role="presentation"><a data-toggle="tab" href="#tbSecurity" aria-controls="Security" id="LISecurity"
                                                role="tab">Security</a></li>
                                             <li class="tab-a" role="presentation"><a data-toggle="tab" href="#tbReports" aria-controls="Reports" id="LIReports"
                                                role="tab">Reports</a></li>
                                        </ul>
                                        <div class="tab-content padding-vertical-15">
                                            <div class="tab-pane active" id="AllModule" role="tabpanel">
                                                <asp:GridView ID="GridAllModule" runat="server" ShowHeaderWhenEmpty="true" CssClass="table table-striped table-bordered dataTable table-responsive" AutoGenerateColumns="False" DataKeyNames="ModuleID" OnRowDataBound="GridAllModule_RowDataBound">
                                                    <Columns>
                                                       
                                                        <asp:BoundField DataField="ModuleName" HeaderText="Module Name" SortExpression="ModuleName" HeaderStyle-Width="20%" />
                                                        <asp:TemplateField HeaderText="Allow" HeaderStyle-Width="10%">
                                                            <ItemTemplate>
                                                                <asp:CheckBox runat="server" ID="ChkView" AutoPostBack="true" OnCheckedChanged="ChkView_CheckedChanged" />
                                                                <asp:Label runat="server" Visible="false" ID="lblModuleID" Text='<%#Eval("ModuleID") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                      
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        
                                             <div class="tab-pane" id="tbVendors" role="tabpanel">
                                                <asp:GridView ID="GridVendors" runat="server" PageSize="100" ShowHeaderWhenEmpty="true" CssClass="table table-striped table-bordered dataTable table-responsive" AutoGenerateColumns="False">
                                                    <Columns>
                                                        
                                                        <asp:BoundField DataField="PageName" HeaderText="Page Name" SortExpression="PageName" HeaderStyle-Width="50%" />
                                                        <asp:TemplateField HeaderText="View" HeaderStyle-Width="10%">
                                                            <ItemTemplate>
                                                                <asp:CheckBox runat="server" ID="ChkView" />
                                                                  <asp:Label runat="server" Visible="false" ID="lblPageID" Text='<%#Eval("PageID") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                       
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                           <div class="tab-pane" id="tbItems" role="tabpanel">
                                                <asp:GridView ID="GridItems" runat="server" PageSize="100" ShowHeaderWhenEmpty="true" CssClass="table table-striped table-bordered dataTable table-responsive" AutoGenerateColumns="False">
                                                    <Columns>
                                                        
                                                        <asp:BoundField DataField="PageName" HeaderText="Page Name" SortExpression="PageName" HeaderStyle-Width="50%" />
                                                        <asp:TemplateField HeaderText="View" HeaderStyle-Width="10%">
                                                            <ItemTemplate>
                                                                <asp:CheckBox runat="server" ID="ChkView" />
                                                                  <asp:Label runat="server" Visible="false" ID="lblPageID" Text='<%#Eval("PageID") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                       
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                               <div class="tab-pane" id="tbProjects" role="tabpanel">
                                                <asp:GridView ID="GridProjects" runat="server" PageSize="100" ShowHeaderWhenEmpty="true" CssClass="table table-striped table-bordered dataTable table-responsive" AutoGenerateColumns="False">
                                                    <Columns>
                                                        
                                                        <asp:BoundField DataField="PageName" HeaderText="Page Name" SortExpression="PageName" HeaderStyle-Width="50%" />
                                                        <asp:TemplateField HeaderText="View" HeaderStyle-Width="10%">
                                                            <ItemTemplate>
                                                                <asp:CheckBox runat="server" ID="ChkView" />
                                                                  <asp:Label runat="server" Visible="false" ID="lblPageID" Text='<%#Eval("PageID") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                       
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                           <div class="tab-pane" id="tbQuotation" role="tabpanel">
                                                <asp:GridView ID="GridQuotation" runat="server" PageSize="100" ShowHeaderWhenEmpty="true" CssClass="table table-striped table-bordered dataTable table-responsive" AutoGenerateColumns="False">
                                                    <Columns>
                                                        
                                                        <asp:BoundField DataField="PageName" HeaderText="Page Name" SortExpression="PageName" HeaderStyle-Width="50%" />
                                                        <asp:TemplateField HeaderText="View" HeaderStyle-Width="10%">
                                                            <ItemTemplate>
                                                                <asp:CheckBox runat="server" ID="ChkView" />
                                                                  <asp:Label runat="server" Visible="false" ID="lblPageID" Text='<%#Eval("PageID") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                       
                                                    </Columns>
                                                </asp:GridView>
                                            </div>  
                                            
                                              
                                              <div class="tab-pane" id="tbMaintenance" role="tabpanel">
                                                <asp:GridView ID="GridMaintenance" runat="server" PageSize="100" ShowHeaderWhenEmpty="true" CssClass="table table-striped table-bordered dataTable table-responsive" AutoGenerateColumns="False">
                                                    <Columns>
                                                        
                                                        <asp:BoundField DataField="PageName" HeaderText="Page Name" SortExpression="PageName" HeaderStyle-Width="50%" />
                                                        <asp:TemplateField HeaderText="View" HeaderStyle-Width="10%">
                                                            <ItemTemplate>
                                                                <asp:CheckBox runat="server" ID="ChkView" />
                                                                  <asp:Label runat="server" Visible="false" ID="lblPageID" Text='<%#Eval("PageID") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                       
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <div class="tab-pane" id="tbPayments" role="tabpanel">
                                                <asp:GridView ID="GridPayments" runat="server" PageSize="100" ShowHeaderWhenEmpty="true" CssClass="table table-striped table-bordered dataTable table-responsive" AutoGenerateColumns="False">
                                                    <Columns>
                                                        
                                                        <asp:BoundField DataField="PageName" HeaderText="Page Name" SortExpression="PageName" HeaderStyle-Width="50%" />
                                                        <asp:TemplateField HeaderText="View" HeaderStyle-Width="10%">
                                                            <ItemTemplate>
                                                                <asp:CheckBox runat="server" ID="ChkView" />
                                                                  <asp:Label runat="server" Visible="false" ID="lblPageID" Text='<%#Eval("PageID") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                       
                                                    </Columns>
                                                </asp:GridView>
                                            </div>     
                                              
                                                        
                                            <div class="tab-pane" id="tbSecurity" role="tabpanel">
                                                <asp:GridView ID="GridSecurity" runat="server" PageSize="100" ShowHeaderWhenEmpty="true" CssClass="table table-striped table-bordered dataTable table-responsive" AutoGenerateColumns="False">
                                                    <Columns>
                                                     
                                                        <asp:BoundField DataField="PageName" HeaderText="Page Name" SortExpression="PageName" HeaderStyle-Width="50%" />
                                                        <asp:TemplateField HeaderText="Allow" HeaderStyle-Width="10%">
                                                            <ItemTemplate>
                                                                <asp:CheckBox runat="server" ID="ChkView" />
                                                                  <asp:Label runat="server" Visible="false" ID="lblPageID" Text='<%#Eval("PageID") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                     
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                             <div class="tab-pane" id="tbReports" role="tabpanel">
                                                <asp:GridView ID="GridReports" runat="server" PageSize="100" ShowHeaderWhenEmpty="true" CssClass="table table-striped table-bordered dataTable table-responsive" AutoGenerateColumns="False">
                                                    <Columns>
                                                     
                                                        <asp:BoundField DataField="PageName" HeaderText="Page Name" SortExpression="PageName" HeaderStyle-Width="50%" />
                                                        <asp:TemplateField HeaderText="Allow" HeaderStyle-Width="10%">
                                                            <ItemTemplate>
                                                                <asp:CheckBox runat="server" ID="ChkView" />
                                                                  <asp:Label runat="server" Visible="false" ID="lblPageID" Text='<%#Eval("PageID") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                       
                                                    </Columns>
                                                </asp:GridView>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <!-- End Example Tabs Left -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

