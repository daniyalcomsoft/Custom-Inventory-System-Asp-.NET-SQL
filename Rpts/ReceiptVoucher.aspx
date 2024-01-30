<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ReceiptVoucher.aspx.cs" Inherits="Rpts_ReceiptVoucher" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="row">
        <div class="col-md-2"> </div>
        <div class="col-md-8"> 
<rsweb:ReportViewer  ID="ReportViewer1" KeepSessionAlive="false" Height="620px"  Width="100%"  runat="server" ></rsweb:ReportViewer></div>
         <div class="col-md-2"> </div>
        </div>
</asp:Content>