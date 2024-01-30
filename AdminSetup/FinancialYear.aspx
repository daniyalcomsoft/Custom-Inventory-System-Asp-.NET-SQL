<%@ Page Title="Setting Financial Year" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FinancialYear.aspx.cs" Inherits="AdminSetup_FinancialYear" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">



<script type="text/javascript">

        function MyDate() {

            $(".DateTimePicker").datepicker();
        }
        
        $(document).ready(function () {
            $('#btnNew').click(function () {
                $('#ModalFinance').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
                $('#ModalFinance').find('select').val('0');
                showhidecontrol('btnSave', true);
                enabledModal('ModalFinance');
                
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
    
       
        body
        {
            background-image: none;
        }
        .input
        {
            height: 30px;
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
        #ctl00_ContentPlaceHolder1_lbtnsetasdefault{
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
                    <h3 class="panel-title"> Financial Year</h3>
                </div>
    <div class="Update_area">
    <div class="Heading">
     <div class="row">                             
            </div>   
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <script type="text/javascript">

                            $(document).ready(function () {
                                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                                function EndRequestHandler(sender, args) {
                                    $('#btnNew').click(function () {
                                        $('#ModalFinance').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
                                        $('#ModalFinance').find('select').val('0');
                                        showhidecontrol('btnSave', true);
                                        enabledModal('ModalFinance');

                                        
                                    });

                                }
                            });

                        </script>
                        <div class="container">
                            <div class="row">
                                <div class="col-md-10"></div>
                                <div class="col-md-2" style="padding:5px;">
                        <button id="btnNew" data-toggle="modal" data-target="#ModalFinance" type="button" class="btn btn-primary">Create Financial Year</button>
                                    </div>
                        
                                </div>
                            </div>

                    </ContentTemplate>
                    <%--<Triggers>
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
               <%-- <br /><br /><asp:LinkButton ID="lbtnYes" CssClass="Button1" runat="server" OnClick="lbtnYes_Click">Yes</asp:LinkButton>&nbsp&nbsp
                <asp:LinkButton ID="lbtnNo" CssClass="Button1" runat="server"
                        OnClientClick="return CloseDialog('Confirmation');">No</asp:LinkButton>--%>
            
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
   <br />
    <div class="container">
        <div class="row">
        <div class="col-md-5">
             <label>Financial Year:</label>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="ddlFinYear" ValidationGroup="validate"
                         custom="Select Financial Year" customFn="var goal = parseInt(this.value); return goal > 0;">
                       </asp:DropDownList>
        </div>
                   
                    <div class="col-md-3" style="margin-top:23px;">
                         <asp:Button ID="lbtnsetasdefault" CssClass="btn btn-primary" Text="Set as Default" runat="server"
                         ValidationGroup="validate" onclick="lbtnsetasdefault_Click"  />
                    </div>
            <div class="col-md-2"> </div> 
        <div class="col-md-3"></div>
            </div>
    </div>
    <br />
         <asp:UpdatePanel ID="UpdatePanel2" runat="server" ChildrenAsTriggers="true">
    <ContentTemplate> 
    <div class="container">
    <div class="table-responsive">
    <asp:GridView ID="GridFinancial" CssClass="table table-striped table-bordered dataTable table-responsive table-hover" runat="server" AutoGenerateColumns="False" DataKeyNames="FinYearID" AllowPaging="true" PageSize="10" OnRowDataBound="GridFinancial_RowDataBound" onpageindexchanging="GridFinancial_PageIndexChanging">
        <Columns>
            <asp:BoundField DataField="FinYearID" HeaderText="Financial Year ID" InsertVisible="False" ItemStyle-HorizontalAlign="Center" ReadOnly="True" SortExpression="FinYearID" />
            <asp:BoundField DataField="FinYearTitle" HeaderText="Financial Year Title" SortExpression="FinYearTitle" />
            <asp:BoundField DataField="YearFrom"  HeaderText="Year From" SortExpression="YearFrom" dataformatstring="{0:MM/dd/yyyy}" />
            <asp:BoundField DataField="YearTo" HeaderText="Year To" 
SortExpression="YearTo" dataformatstring="{0:MM/dd/yyyy}" />
            <%-- DataFormatString="{0:dd/MM/yyyy}"--%>
            <asp:TemplateField HeaderText="Edit" HeaderStyle-Width="31px">
                <ItemTemplate>
                
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <asp:LinkButton ID="lbtnEdit" runat="server" 
                        CommandArgument='<%# Eval("FinYearID") %>' Enabled='<%# Eval("ISEnabled") %>'  oncommand="lbtnEdit_Command" cssClass="edit">
                        <i class="icon fa-edit icon_custom" aria-hidden="true"></i>
                    </asp:LinkButton>
            </ContentTemplate>
              <Triggers>
                <asp:AsyncPostBackTrigger ControlID="lbtnEdit" EventName="Click" />
              </Triggers>
            </asp:UpdatePanel>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Delete" HeaderStyle-Width="41px">
                <ItemTemplate>
                    <asp:LinkButton ID="lbtnDelete" runat="server" cssClass="delete" 
                        CommandArgument='<%# Eval("FinYearID") %>' Enabled='<%# Eval("ISEnabled") %>' oncommand="lbtnDelete_Command">
                        <i class="icon fa-trash-o icon_custom" aria-hidden="true"></i>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    </div>
    </div>
    </ContentTemplate>
    </asp:UpdatePanel>
        
      

        <div class="modal fade modal-primary" id="ModalFinance" aria-hidden="true"
        aria-labelledby="ModalUserRole" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
          <div class="modal-dialog">
            <div class="modal-content">
      <asp:UpdatePanel ID="UpdatePanel4" runat="server">
      <ContentTemplate>
           <div class="modal-header">
                    <h4 class="modal-title">Create Financial Year</h4>
                </div> 
          <div class="modal-body">
                    <div class="row">
                        <div id="StatusMsgPopup">
                        </div>
              <div class="col-md-12">
                   <div class="form-horizontal" id="ModalForm">

                  <div class="form-group">
                       <label class="col-sm-3 control-label">Financial Year ID:</label> 
                      <div class="col-md-7">
                           <asp:TextBox ID="txtFinancialYearID" CssClass="form-control" runat="server" AutoComplete="Off" 
                        ReadOnly="True" ></asp:TextBox>
                      </div>
                  </div>

                  <div class="form-group">
                       <label class="col-sm-3 control-label"> Financial Year:</label>                     
                      <div class="col-md-7">
                           <asp:TextBox ID="txtFinancialYear" require="Enter Financial Year Title" 
                        runat="server" CssClass="form-control" placeholder="Year Title"></asp:TextBox>
                        <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtFinancialYear"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate1" ></asp:RequiredFieldValidator>
                      </div>
                  </div>

                  <div class="form-group">
                      <label class="col-sm-3 control-label"> Date From:</label>                       
                      <div class="col-md-7">
                          <asp:TextBox ID="txtDateFrom" CssClass="DateTimePicker form-control"
                         require="Enter Date From" placeholder="Date From" runat="server" ></asp:TextBox>      
                        <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtDateFrom"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate1" ></asp:RequiredFieldValidator>
                                             
                      </div>
                  </div>     
               
                  <div class="form-group">
                      <label class="col-sm-3 control-label">Date To:</label>                        
                      <div class="col-md-7">
                          <asp:TextBox ID="txtDateTo"  CssClass="DateTimePicker form-control" 
                        require="Enter Date To" placeholder="Date To" runat="server" ></asp:TextBox>
                        <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtDateTo"
                                             ErrorMessage="Required!" Display="Dynamic" ForeColor="Red"  ValidationGroup="validate1" ></asp:RequiredFieldValidator>
                      </div>
                  </div>               
                </div>
              </div>
              </div>
                </div>
           <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                   <asp:Button ID="btnSave" CssClass="btn btn-primary" runat="server" 
                                    onclick="btnSave_Click"  ValidationGroup="validate1" Text="Save" />
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
                 <asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>
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

