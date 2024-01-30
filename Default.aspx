<%@ Page Title="" Language="C#"  MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <style>
        .box-pad{
            padding-bottom: 4px;
        }
        #ctl00_imgwhtlogo{
            
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>
      
   </ContentTemplate></asp:UpdatePanel>
  <%--  <div class="page-content container-fluid">

        <!-- First Row -->
        <h3  runat="server" style="font-family: system-ui;">PROJECT SUMMARY</h3>
        <div  runat="server" class="row">
            <div class="col-xl-3 col-md-3 info-panel form-group">
                <div class="card card-shadow">
                    <div class="card-block bg-white p-20 box-pad">
                        <button type="button" class="btn btn-floating btn-sm btn-warning">
                            <i class="icon fa-th"></i>
                        </button>
                        <span class="ml-15 font-weight-400">PROJECTS</span>
                        <div class="content-text text-center mb-0">
                            <i class="text-danger icon wb-triangle-up font-size-20"></i>
                            <span runat="server" id="TotalProject" class="font-size-40 font-weight-100">399</span>
                            <p class="blue-grey-400 font-weight-100 m-0">Total Projects</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-3 info-panel form-group">
                <div class="card card-shadow">
                    <div class="card-block bg-white p-20 box-pad">
                        <button type="button" class="btn btn-floating btn-sm btn-primary">
                            <i class="icon fa-clock-o"></i>
                        </button>
                        <span class="ml-15 font-weight-400">PENDING PROJECTS</span>
                        <div class="content-text text-center mb-0">
                            <i class="text-danger icon wb-triangle-up font-size-20"></i>
                            <span runat="server" id="PendingProject" class="font-size-40 font-weight-100">04</span>
                            <p class="blue-grey-400 font-weight-100 m-0">Pending Projects</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-3 info-panel form-group">
                <div class="card card-shadow">
                    <div class="card-block bg-white p-20 box-pad">
                        <button type="button" class="btn btn-floating btn-sm btn-success">
                            <i class="icon fa-check"></i>
                        </button>
                        <span class="ml-15 font-weight-400">COMPLETED PROJECTS</span>
                        <div class="content-text text-center mb-0">
                            <i class="text-danger icon wb-triangle-up font-size-20"></i>
                            <span runat="server" id="CompleteProject" class="font-size-40 font-weight-100">78</span>
                            <p class="blue-grey-400 font-weight-100 m-0">Completed Projects</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-3 info-panel form-group">
                <div class="card card-shadow">
                    <div class="card-block bg-white p-20 box-pad">
                        <button type="button" class="btn btn-floating btn-sm btn-danger">
                            <i class="icon fa-tags"></i>
                        </button>
                        <span class="ml-15 font-weight-400">BLOCKED PROJECT</span>
                        <div class="content-text text-center mb-0">
                            <i class="text-success icon wb-triangle-down font-size-20"></i>
                            <span runat="server" id="ItemRequest" class="font-size-40 font-weight-100">115</span>
                            <p class="blue-grey-400 font-weight-100 m-0">Blocked Project</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Second Row -->

        <h3 style="font-family: system-ui;">MAINTENANCE SUMMARY</h3>
        <div class="row">
            <div class="col-xl-3 col-md-3 info-panel form-group">
                <div class="card card-shadow">
                    <div class="card-block bg-white p-20 box-pad">
                        <button type="button" class="btn btn-floating btn-sm btn-info">
                            <i class="icon fa-th"></i>
                        </button>
                        <span class="ml-15 font-weight-400">TOTAL MAINTENANCE</span>
                        <div class="content-text text-center mb-0">
                            <i class="text-danger icon wb-triangle-up font-size-20"></i>
                            <span runat="server" id="TotalMaintenance" class="font-size-40 font-weight-100">399</span>
                            <p class="blue-grey-400 font-weight-100 m-0">Total Maintenance</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-3 info-panel form-group">
                <div class="card card-shadow">
                    <div class="card-block bg-white p-20 box-pad">
                        <button type="button" class="btn btn-floating btn-sm btn-danger">
                            <i class="icon fa-money"></i>
                        </button>
                        <span class="ml-15 font-weight-400">PENDING MAINTENANCE</span>
                        <div class="content-text text-center mb-0">
                            <i class="text-danger icon wb-triangle-up font-size-20"></i>
                            <span runat="server" id="WithoutPayment" class="font-size-40 font-weight-100">04</span>
                            <p class="blue-grey-400 font-weight-100 m-0">Maintenance without Payment Request</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-3 info-panel form-group">
                <div class="card card-shadow">
                    <div class="card-block bg-white p-20 box-pad">
                        <button type="button" class="btn btn-floating btn-sm btn-warning">
                            <i class="icon fa-money"></i>
                        </button>
                        <span class="ml-15 font-weight-400">PENDING MAINTENANCE</span>
                        <div class="content-text text-center mb-0">
                            <i class="text-danger icon wb-triangle-up font-size-20"></i>
                            <span runat="server" id="WithPayment" class="font-size-40 font-weight-100">78</span>
                            <p class="blue-grey-400 font-weight-100 m-0">Maintenance with Payment Request</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-3 info-panel form-group">
                <div class="card card-shadow">
                    <div class="card-block bg-white p-20 box-pad">
                        <button type="button" class="btn btn-floating btn-sm btn-success">
                            <i class="icon fa-check"></i>
                        </button>
                        <span class="ml-15 font-weight-400">COMPLETED MAINTENANCE</span>
                        <div class="content-text text-center mb-0">
                            <i class="text-success icon wb-triangle-down font-size-20"></i>
                            <span runat="server" id="Completed" class="font-size-40 font-weight-100">115</span>
                            <p class="blue-grey-400 font-weight-100 m-0">Completed Maintenance</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

       <div class="modal fade modal-primary" id="ModalVendorPercentage" aria-hidden="true"
        aria-labelledby="ModalVendor" data-backdrop="static" data-keyboard="false" role="dialog" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                 <asp:UpdatePanel ID="UpdatePanel4" runat="server"><ContentTemplate>
                <div class="modal-header">
                    <h4 class="modal-title">Vendor</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div id="StatussMsgPopup">
                        </div>
                        <div class="col-sm-12">
                            <div class="form-horizontal" id="ModalFrm">
                                
                                
                                  <div class="form-group">
                                    <label class="col-sm-3 control-label">Advance :</label>
                                    <div class="col-sm-7">
                                        <asp:TextBox runat="server" ID="txtAdvance" CssClass="form-control" Width="100%" placeholder="Advance" />
                                        <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtAdvance"
                                             ErrorMessage="Required!" Display ="Dynamic" ForeColor="Red"  ValidationGroup="Validateper" ></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                  <div class="form-group">
                                    <label class="col-sm-3 control-label">First Running :</label>
                                    <div class="col-sm-7">
                                        <asp:TextBox runat="server" ID="txtFirstRunning" CssClass="form-control" Width="100%" placeholder="First Running" />
                                        <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtFirstRunning"
                                             ErrorMessage="Required!" Display ="Dynamic" ForeColor="Red"  ValidationGroup="Validateper" ></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                  <div class="form-group">
                                    <label class="col-sm-3 control-label">Second Running :</label>
                                    <div class="col-sm-7">
                                        <asp:TextBox runat="server" ID="txtSecondRunning" CssClass="form-control" Width="100%" placeholder="Second Running" />
                                        <asp:RequiredFieldValidator  runat="server" ControlToValidate="txtSecondRunning"
                                             ErrorMessage="Required!" Display ="Dynamic" ForeColor="Red"  ValidationGroup="Validateper" ></asp:RequiredFieldValidator>
                                        <label id="lbmsg" runat="server"></label>
                                          </div>
                                </div>
                               

                              
                              
                                
                               
                             
                                 
                               
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                   <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                   <asp:Button runat="server" ID="btnpersave" OnClick="btnpersave_Click" ValidationGroup="Validateper" CssClass="btn1 btn-primary waves-effect waves-light"  Text="Save" />
                </div>
             </ContentTemplate></asp:UpdatePanel>
            </div>
        </div>
    </div>--%>
</asp:Content>
