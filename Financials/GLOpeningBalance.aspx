<%@ Page Title="Opening Balance" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="GLOpeningBalance.aspx.cs" Inherits="Financials_GLOpeningBalance" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%--
    <script src="Script/jquery-1.6.2.min.js" type="text/javascript" charset="utf-8"></script>

    <script src="Script/jquery-ui-1.8.16.custom.min.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            
            CreateModalPopUp('#Confirmation', 280, 120, 'ALERT');

            $('#FindAccount').dialog({
                autoOpen: false,
                draggable: true,
                title: "Find",
                width: 726,
                height: 449,
                open: function(type, data) {
                    $(this).parent().appendTo("form");
                }
            });
            Load_AutoComplete_Code();
        });
    function OpenUserPermission() {
        ShowDialog('FindAccount');
        return false;
    }
    function SelectRow(row) {
        var _selectColor = "#303030";
        var _normalColor = "#909090";
        var _selectFontSize = "3em";
        var _normalFontSize = "2em";
        // get all data rows - siblings to current
        var _rows = row.parentNode.childNodes;
        // deselect all data rows
        try {
            for (i = 0; i < _rows.length; i++) {
                var _firstCell = _rows[i].getElementsByTagName("td")[0];
                _firstCell.style.color = _normalColor;
                _firstCell.style.fontSize = _normalFontSize;
                _firstCell.style.fontWeight = "normal";
            }
        }
        catch (e) { }
        // select current row (formatting applied to first cell)
        var _selectedRowFirstCell = row.getElementsByTagName("td")[0];
        _selectedRowFirstCell.style.color = _selectColor;
        _selectedRowFirstCell.style.fontSize = _selectFontSize;
        _selectedRowFirstCell.style.fontWeight = "bold";
    }
    
    function Load_AutoComplete_Code() {
        $("[id$=txtSearchAccount]").autocomplete({
            source: function(request, response) {
                $("[id $= txtTitle]").val('');
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: 'Services/GetData.asmx/GetAccountCodeTitle',
                    data: "{ 'Match': '" + request.term + "'}",
                    dataType: "json",
                    success: function(data) {
                        response($.map(data.d, function(item) {
                            return {
                                label: item.CodeTitle,
                                value: item.AccCode,
                                Title: item.Title
                            }
                        }))
                    }
                });
            },
            minLength: 3,
            select: function(event, ui) {
            $("[id$=txtSearchAccount]").val(ui.item.AccCode);
            $("[id$=HidSearchAccount]").val(ui.item.AccCode);
            }
        });
        $('.autoCompleteCodes').autocomplete({
                source: function(request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: 'Services/GetData.asmx/GetAccountCodeTitle',
                        data: "{ 'Match': '" + request.term + "'}",
                        dataType: "json",
                        success: function(data) {
                            response($.map(data.d, function(item) {
                                return {
                                label: item.CodeTitle,
                                value: item.AccCode,
                                Title: item.Title
                                    }
                                                                  
                            }))
                        }
                    });
                },
               

            });
    }
//    function NullVal() {
//        if ($("[id $= _txtSearchAccount]").val().length < 3) {
//            $("[id $= _txtSearchAccount]").val("");
//        }
//    }
    function ValidateDebitCredit() {

        if (($('.Debit').val() == "") && ($('.Credit').val() == "")) {
            $('.Debit').css('border-color', 'red');
            $('.Credit').css('border-color', 'red');
            return false;
        }
        else {
            $('.Debit').removeAttr('border-color');
            $('.Credit').removeAttr('border-color');
        }
        return validate('checkcode');
    }

    $(document).ready(function () {
        $('#btnFind').click(function () {
            $('#ModalOpen').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
            $('#ModalOpen').find('select').val('0');
            enabledModal('ModalOpen');
            showhidecontrol('btnSave', true);
        })
    });

         function ClientWOSelected(sender, e) {
            $get("<%=hfACCId.ClientID %>").value = e.get_value();}
    </script>

    <style>
        #ctl00_ContentPlaceHolder1_btnFindAcc{
            border:none;
            background:#009688;
            color: #FFFFFF;
            font-style:normal;
        }


         .ptext {
        white-space: nowrap;
        overflow: scroll;
        text-overflow: ellipsis;
       
    }
    .completionList1 {
    position: absolute;
    top: 100%;
    left: 0;
    z-index: 9999999999 !important;   
    float: left;
    min-width: 160px;
    padding: 5px 0;
    margin: 2px 0 0;
    list-style: none;
    font-size: 14px;
    text-align: left;
    background-color: #ffffff;
    border: 1px solid #cccccc;
    border: 1px solid rgba(0, 0, 0, 0.15);
    border-radius: 4px;
    -webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, 0.175);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.175);
    background-clip: padding-box;
    height:500px;

        } 
    .hed{
            position: relative;
    display: inline;
    margin-left:30px;
    }



    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:HiddenField ID="HidSearchAccount" runat="server" />
    
    <div class="panel panel-bordered panel-primary">
                <div class="panel-heading form-group">
                    <h3 class="panel-title">Opening Balance</h3>
                </div>
    <div id="StausMsg"></div>
     
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <script type="text/javascript">

                            $(document).ready(function () {
                                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                                function EndRequestHandler(sender, args) {
                                    $('#btnFind').click(function () {
                                        $('#ModalOpen').find('input,select,textarea').not(':button,:submit,:checkbox').val('');
                                        $('#ModalOpen').find('select').val('0');
                                        enabledModal('ModalOpen');

                                        showhidecontrol('btnSave', true);
                                    });

                                }
                            });

                        </script>
                    <div class="container">
                   <div class="row">
                       <div class="col-md-6">

                    <%--<label style="margin-right:5px;">Search Account:</label>--%>                    
                    <asp:Label ID="lblTransID" runat="server" Text="" Visible="false"></asp:Label>
                    <asp:TextBox ID="txtSearchAccount" runat="server" placeholder="Search Account" AutoComplete="Off" CssClass="autoCompleteCodes form-control" 
                         require="Enter Account No." validate="FindAccount"></asp:TextBox>

                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSearchAccount"
                                    ErrorMessage="Required!" Display="Dynamic" ForeColor="Red" ValidationGroup="Validate"></asp:RequiredFieldValidator>

                        <asp:AutoCompleteExtender ServiceMethod="SearchAccount" MinimumPrefixLength="1"
                                    CompletionInterval="10" BehaviorID="AutoCompleteExs" CompletionListCssClass="completionList completionList1 ptext ptextfont"
                                    CompletionListItemCssClass="listItem "
                                    CompletionListHighlightedItemCssClass="itemHighlighted " EnableCaching="false" CompletionSetCount="10"
                                    TargetControlID="txtSearchAccount" ID="AutoCompleteExtender2" runat="server" FirstRowSelected="true" OnClientItemSelected="ClientWOSelected">
                                </asp:AutoCompleteExtender>
                         <asp:HiddenField ID="hfACCId" runat="server" />
                        <em style="color: red" id="emsg" runat="server" visible="false">Project not found!</em>




                    </div>
                       <div class="col-md-2" style="margin-left: -28px; margin-top:-1px;">
                   <asp:LinkButton ID="lbtnFind" runat="server" CssClass="buttonNew btn btn-primary" OnClick="lbtnFind_Click"
                            OnClientClick="return validate('FindAccount');">
                       <i class="fa fa-search"></i>
                   </asp:LinkButton> 
                    </div>

                       <div class="col-md-4" style="text-align:right; padding-right:0px !important;">
                            <%--<asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" class="search" CausesValidation="False" 
                    OnClientClick="return ShowDialog('FindAccount');" data-toggle="modal" data-target="#ModalOpen" Text="Search Account" style="margin-left:10px;" ></asp:LinkButton>--%>
                      
                        <asp:LinkButton ID="btnClearFilter" CssClass="btn btn-primary" runat="server" 
                            onclick="btnClearFilter_Click">Clear Search</asp:LinkButton>
                        <asp:LinkButton ID="lbtnUpdate" CssClass="btn btn-primary" runat="server" OnClick="lbtnUpdate_Click" OnClientClick="return ValidateDebitCredit();">Update</asp:LinkButton>

                            </div>
                    
                    </div>
                    
                    <div style=" margin-top: 15px;">
                        <asp:GridView ID="GridOpeningBalance" CssClass="data main table table-bordered" 
                            runat="server" AutoGenerateColumns="False" ShowFooter="True">
                            <Columns>
                                <asp:BoundField DataField="Code" HeaderText="Account Code" SortExpression="Code"
                                     ReadOnly="True">
                                    
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Title">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTitle" runat="server" HeaderStyle-Width="290px" Text='<%# Eval("Title") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblTotal" runat="server" Text="Total"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Debit" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="128px">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDebit" Text='<%# Eval("Debit","{0:n}") %>' CssClass="RightAlign_Textbox form-control" 
                                            runat="server" AutoComplete="Off" AutoPostBack="True" 
                                            ontextchanged="txtDebit_TextChanged"></asp:TextBox>
                                        <asp:Label ID="lblSubsidaryID" runat="server" Visible="false" Text='<%# Eval("SubsidaryID") %>'></asp:Label>
                                           <asp:Label ID="lblCode" runat="server" Visible="false" Text='<%# Eval("Code") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtTotalDebit" ReadOnly="true" runat="server" CssClass="RightAlign_Textbox form-control"
                                            AutoComplete="Off"></asp:TextBox>
                                    </FooterTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Width="128px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Credit" HeaderStyle-Width="128px" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtCredit" Text='<%# Eval("Credit","{0:n}") %>' CssClass="RightAlign_Textbox form-control"
                                            runat="server" AutoPostBack="True" ontextchanged="txtCredit_TextChanged"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtTotalCredit" ReadOnly="true" CssClass="RightAlign_Textbox form-control" runat="server" ></asp:TextBox>
                                    </FooterTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Width="128px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    </div>
                    <div>
                        <asp:Label ID="lblError" runat="server" Text="Debit and Credit should be equal" Visible="false"
                            ForeColor="Red"></asp:Label>
                        
                    </div>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ASCS %>"
                        SelectCommand="vt_CB_GL_SpOpeningBalance" SelectCommandType="StoredProcedure">
                    </asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>
        
    
        <div class="modal fade modal-primary" id="ModalOpen" aria-hidden="true"
        aria-labelledby="ModalUserRole" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
          <div class="modal-dialog" style="width:800px;">
            <div class="modal-content">
          <asp:UpdatePanel ID="UpdatePanel3" runat="server">
             <ContentTemplate>
                 <div class="modal-header">
                    <h4 class="modal-title">Check Account</h4>
                </div>
                 <%--<div id="FindAccount">--%>
                 <div class="container">
                    <div class="row" style="padding:10px;">
                        <div class="col-md-6">
                <label style="padding-left: 20px">Enter Account No. </label>
                &nbsp;
                <asp:TextBox ID="txtAccountNo" CssClass="form-control" runat="server"> </asp:TextBox>
                            </div>
                        <div class="col-md-6" style="margin-top:26px;">
                <asp:Button ID="btnFindAcc" runat="server" Text="Find" CssClass="btn btn-primary" Style="border:none !important;" OnClick="btnFindAcc_Click" />
                            </div>
                
                </div>

               
                    
                 <asp:GridView ID="GrdAccounts" runat="server" CssClass="data main table table-bordered" 
                     AllowPaging="True" PageSize="25" 
                     onpageindexchanging="GrdAccounts_PageIndexChanging" 
                     AutoGenerateColumns="False" onrowcommand="GrdAccounts_RowCommand" 
                     onrowdatabound="GrdAccounts_RowDataBound" >
                     <Columns>
                         <asp:TemplateField HeaderText="Select">
                             <ItemTemplate>
                                 <asp:LinkButton ID="lnkSelect" runat="server" OnClick="lnkSelect_Click">Select</asp:LinkButton>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
                         <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                         <asp:BoundField DataField="CurrentBal" HeaderText="Current Balance" ReadOnly="True" 
                             SortExpression="CurrentBal" DataFormatString="{0:n}" >
                             <ItemStyle HorizontalAlign="Right" />
                         </asp:BoundField>
                     </Columns>
                  </asp:GridView>
                      </div>
                 <%-- </div>--%>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>

                 <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                     ConnectionString="<%$ ConnectionStrings:ASCS %>" 
                     SelectCommand="vt_SCGL_SPGetSubCodeTitleLikeAll" 
                     SelectCommandType="StoredProcedure">
                     <SelectParameters>
                         <asp:Parameter Name="Match" Type="String" />
                     </SelectParameters>
                 </asp:SqlDataSource>
             </ContentTemplate>
          </asp:UpdatePanel>
                 </div>
               </div>
             </div>
         
    <div id="Confirmation" style="display: none;">
            <asp:UpdatePanel ID="upConfirmation" runat="server">
                <ContentTemplate>
                    <asp:Label ID="lblDeleteMsg" runat="server" Text="No Record Found"></asp:Label>
                    <asp:HiddenField ID="HidDeleteID" runat="server" />
                    <br />
                    <br />
                    <br />
                    <asp:LinkButton ID="lbtnNo" CssClass="Button1" runat="server" OnClientClick="return closeDialog('Confirmation');">OK</asp:LinkButton>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
         </div>

</asp:Content>
