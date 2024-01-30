<%@ Page Title="View Jobs" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="JobFormList.aspx.cs" Inherits="Jobs_JobFormList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            CreateModalPopUp('#Confirmation', 290, 100, 'ALERT');
            $("[id$=ddlSearch]").change(function () {
                $("[id$=txtSearch]").val("");
            });
        });       
    </script>
    <style type="text/css">
        .box_body {
            border: 1px solid #029FE2;
            margin-bottom: 10px;
            min-height: 75px;
            color: #444;
        }

        .box_header {
            background-color: #029FE2;
            height: 28px;
        }

        .box_txt {
            font-family: arial;
            text-align: left;
            color: white;
            padding: 4px 0px 0px 8px;
            font-weight: bolder;
            font-size: 15px;
        }

        .box_inner {
            padding: 10px;
        }

        .btn_1 {
            height: 25px;
            padding: 0px 10px;
            line-height: 20px;
            background-color: #029FE2;
            border-radius: 4px;
            color: #EDF6E3;
            font-size: 12px;
            border: 1px solid #029FE2;
            border-image: initial;
            font-weight: bold;
            margin-left: 5px;
        }

            .btn_1:hover {
                background-color: #2C8CB4;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
                
                   
               

    <div class="panel panel-bordered panel-primary">

                <div class="panel-heading form-group">
                    <h3 class="panel-title">Manage Job</h3>
                </div>
            <div class="Update_area">                
                <div id="StausMsg"></div>
    
        
            <div class="container">
                <div class="row" style="padding:10px;">
                    <div class="col-md-5">
                        <label>Search By:</label>
                <asp:DropDownList ID="ddlSearch" runat="server" CssClass="form-control" >
                    <asp:ListItem Selected="True" Value="JobNumber" Text="Job Number"></asp:ListItem>
                    <asp:ListItem Value="DisplayName" Text="Customer Name"></asp:ListItem>
                    <asp:ListItem Value="Completed" Text="Completed"></asp:ListItem>
                </asp:DropDownList>
                    </div>
                    <div class="col-md-3" style="margin-top:26px;">
                        <asp:TextBox ID="txtSearch" CssClass="form-control" runat="server" ></asp:TextBox>
                    </div>
                    <div class="col-md-1" style="margin-top:26px; margin-left: -28px;">
                        <asp:LinkButton ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click">
                             <i class="fa fa-search"></i>
                        </asp:LinkButton>
                    </div>
                    <div class="col-md-3" style="text-align:right; margin-top:26px;">
                        <asp:LinkButton ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-primary" OnClick="btnClear_Click" />
                         <asp:LinkButton ID="btnNewJob" CssClass="btn btn-primary" runat="server" OnClick="btnNewJob_Click">Create Job</asp:LinkButton>
                    </div>
                </div>
           
                
                                
                
                
            
        

       
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="grdJob" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False"
                        DataKeyNames="JobID" AllowPaging="true" PageSize="15" DataSourceID="SqlDataSource1"
                        OnPageIndexChanging="grdJob_PageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="JobNumber" HeaderText="Number"
                                SortExpression="JobNumber" />
                            <asp:BoundField DataField="JobDescription" HeaderText="Job Description"
                                SortExpression="JobDescription" />
                            <asp:BoundField DataField="DisplayName" HeaderText="Customer Name"
                                SortExpression="DisplayName" />
                            <asp:BoundField DataField="Completed" HeaderText="Completed"
                                SortExpression="Completed" />

                            <asp:TemplateField HeaderText="Action" HeaderStyle-Width="15%">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbtnView" runat="server" CssClass="view"
                                        CommandArgument='<%# Eval("JobID") %>' OnCommand="lbtnView_Command">
                                         <i class="icon icon_custom fa fa-eye"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="LbtnEdit" runat="server" CssClass="edit"
                                        CommandArgument='<%# Eval("JobID") %>' OnCommand="LbtnEdit_Command">
                                         <i class="icon icon_custom fa fa-edit"></i>
                                    </asp:LinkButton>
                                   <asp:LinkButton ID="lbtnDelete" runat="server" CssClass="delete"
                                        CommandArgument='<%# Eval("JobID") %>' OnCommand="lbtnDelete_Command">
                                         <i class="icon icon_custom fa fa-trash-o"></i>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                           <%-- <asp:TemplateField HeaderText="Edit" HeaderStyle-Width="31px">
                                <ItemTemplate>
                                    
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete" HeaderStyle-Width="41px">
                                <ItemTemplate>
                                    
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:ASCS %>"
            SelectCommand="SELECT J.[JobID],J.[JobNumber],J.[JobDescription],C.[DisplayName]
	,CASE WHEN J.[Completed] = 1 THEN 'TRUE' ELSE 'FALSE' END Completed FROM [Job] J
	INNER JOIN Customer C ON J.[CustomerID] = C.[CustomerID]" SelectCommandType="Text"></asp:SqlDataSource>
    
 </div>
                </div>
    <asp:Label ID="lblJobID" runat="server" Visible="false"></asp:Label>
    <div id="Confirmation" style="display: none;">
        <asp:UpdatePanel ID="upConfirmation" runat="server">
            <ContentTemplate>
                <asp:Label ID="lblDeleteMsg" runat="server" Text=""></asp:Label>
                <br />
                <br />
                <asp:LinkButton ID="lbtnYes" CssClass="Button1" runat="server" OnClick="lbtnYes_Click">Yes</asp:LinkButton>&nbsp&nbsp
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
                   <asp:Button runat="server" ID="btnConfirmation" OnClick="btnConfirmation_Click"  CssClass="btn1 btn-primary waves-effect waves-light"  Text="Yes" />
                </div>
             </ContentTemplate></asp:UpdatePanel>
            </div>
        </div>
    </div> 

</asp:Content>

