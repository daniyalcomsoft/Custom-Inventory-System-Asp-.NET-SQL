﻿using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Rpts_ReceiptVoucher : System.Web.UI.Page
{
    //Items_BLL BL = new Items_BLL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PSMSSession"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        if (!IsPostBack)
        {
            RolePermission_BLL PP = new RolePermission_BLL();
            DataTable dtRole = new DataTable();
            Sessions PSMSSession = (Sessions)Session["PSMSSession"];
            dtRole = PP.GetPagePermissionpPagesByRole(PSMSSession.RoleID);
            string pageName = null;
            bool view = false;
            foreach (DataRow dr in dtRole.Rows)
            {
                int row = dtRole.Rows.IndexOf(dr);
                if (dtRole.Rows[row]["PageUrl"].ToString() == "Rpts/ReceiptVoucher.aspx")
                {
                    pageName = dtRole.Rows[row]["PageUrl"].ToString();
                    view = Convert.ToBoolean(dtRole.Rows[row]["Can_View"].ToString());
                    break;
                }
            }
            if (dtRole.Rows.Count > 0)
            {
                if (pageName == "Rpts/ReceiptVoucher.aspx" && view == true)
                {
                    ConfigureReports();
                }
                else
                {
                    Response.Redirect("Default.aspx", false);
                }
            }

        }
    }
    private void ConfigureReports()
    {
        try
        {

            DataTable dt = new DataTable("ReportDataSet");
            //dt = BL.GetItemList(DBNull.Value);
            ReportViewer1.ProcessingMode = ProcessingMode.Local;
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~//Rpts//rdlcReports//ItemsReport.rdlc");
            ReportDataSource datasource = new ReportDataSource("Table", dt);
            Sessions PSMSSession = (Sessions)Session["PSMSSession"];
            ReportViewer1.LocalReport.EnableExternalImages = true;
            ReportParameter[] param = new ReportParameter[2];
            param[0] = new ReportParameter("Logo", Server.MapPath("~/App_Images/" + PSMSSession.FolderName + "/logo/logo.png"));
            param[1] = new ReportParameter("Color", PSMSSession.rptColor);
            ReportViewer1.LocalReport.SetParameters(param);
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(datasource);
            ReportViewer1.LocalReport.Refresh();
            ReportViewer1.DataBind();

        }
        catch (Exception ex)
        {

        }
    }
}