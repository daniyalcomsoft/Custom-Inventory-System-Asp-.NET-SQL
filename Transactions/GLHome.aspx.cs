using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SW.SW_Common;


public partial class Transactions_GLHome : System.Web.UI.Page
{
    
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
                if (dtRole.Rows[row]["PageUrl"].ToString() == "Transactions/GLHome.aspx")
                {
                    pageName = dtRole.Rows[row]["PageUrl"].ToString();
                    view = Convert.ToBoolean(dtRole.Rows[row]["Can_View"].ToString());
                    break;
                }
            }
            if (dtRole.Rows.Count > 0)
            {
                if (pageName == "Transactions/GLHome.aspx" && view == true)
                {
                    FillVoucherTypeList();
                    SetVoucherGrid("0");
                }
                else
                {
                    Response.Redirect("Default.aspx", false);
                }
            }
           
        }
    }
    #region Methods
    private void FillVoucherTypeList()
    {
        GL_BAL GL = new GL_BAL();
        cmbTransactionFilter.DataSource = GL.GetVoucherType();
        cmbTransactionFilter.DataTextField = "VoucherTypeName";
        cmbTransactionFilter.DataValueField = "VoucherTypeID";
        cmbTransactionFilter.DataBind();
    }
    private void SetVoucherGrid(string VoucherTypeID)
    {
        Sessions PSMSSession = (Sessions)Session["PSMSSession"];
        int FinYearID = PSMSSession.FinYearID;
        GL_BAL GL = new GL_BAL();
        GridVoucher.DataSource = GL.GetVoucherByVoucherTypeID(VoucherTypeID,FinYearID);
        GridVoucher.DataBind();
    }
    #endregion
    protected void cmbAddNewVoucher_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (cmbAddNewVoucher.SelectedValue == "1")
        {

            Sessions PSMS = (Sessions)Session["PSMSSession"];
            if (PSMS != null)
            {
                DataRow[] dr = PSMS.PermissionTable.Select("PageUrl='Transactions/GLGeneralVoucher.aspx'");
                if (dr.Length > 0)
                {
                    if (Convert.ToBoolean(dr[0]["Can_Insert"]) == true)
                    {
                        Response.Redirect("GLGeneralVoucher.aspx");
                    }
                    else
                    {
                        Response.Write("<script>alert('you do not have rights to Insert new Record ');</script>");
                    }
                }
            }
        }
        if (cmbAddNewVoucher.SelectedValue == "3")
        {
            Sessions PSMS = (Sessions)Session["PSMSSession"];
            if (PSMS != null)
            {
                DataRow[] dr = PSMS.PermissionTable.Select("PageUrl='Transactions/GLCashRecievedVoucher.aspx'");
                if (dr.Length > 0)
                {
                    if (Convert.ToBoolean(dr[0]["Can_Insert"]) == true)
                    {
                        Response.Redirect("GLCashRecievedVoucher.aspx");
                    }
                    else
                    {
                        Response.Write("<script>alert('you do not have rights to Insert new Record ');</script>");
                    }
                }
            }
        }
        if (cmbAddNewVoucher.SelectedValue == "2")
        {
            Sessions PSMS = (Sessions)Session["PSMSSession"];
            if (PSMS != null)
            {
                DataRow[] dr = PSMS.PermissionTable.Select("PageUrl='Transactions/GLCashPaymentVoucher.aspx'");
                if (dr.Length > 0)
                {
                    if (Convert.ToBoolean(dr[0]["Can_Insert"]) == true)
                    {
                        Response.Redirect("GLCashPaymentVoucher.aspx");
                    }
                    else
                    {
                        Response.Write("<script>alert('you do not have rights to Insert new Record ');</script>");
                    }
                }
            }
        }
    }


    protected void GridVoucher_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.textDecoration='underline';";
            e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
        }
    }

    protected void cmbTransactionFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (cmbTransactionFilter.SelectedValue != "")
        {
            SetVoucherGrid(cmbTransactionFilter.SelectedValue);
        }
    }

    protected void lbtnEdit_Command(object sender, CommandEventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        var row = (GridViewRow)((Control)sender).NamingContainer;
        int index = row.RowIndex;
        Label lblVoucherTypeID = (Label)GridVoucher.Rows[index].FindControl("lblVoucherTypeID");
        Label lblVoucherNumber = (Label)GridVoucher.Rows[index].FindControl("lblVoucherNumber");
        if (PSMS.Can_Update == true)
        {
            if (Convert.ToInt32(lblVoucherTypeID.Text) == (int)PM.VoucherType.General_Voucher)
            {
                Response.Redirect("GLGeneralVoucher.aspx?VoucherNo=" + lblVoucherNumber.Text);
            }
            if (Convert.ToInt32(lblVoucherTypeID.Text) == (int)PM.VoucherType.Cash_Payment_Voucher || Convert.ToInt32(lblVoucherTypeID.Text) == (int)PM.VoucherType.Bank_Payment_Voucher)
            {
                Response.Redirect("GLCashPaymentVoucher.aspx?VoucherNo=" + lblVoucherNumber.Text);
            }
            if (Convert.ToInt32(lblVoucherTypeID.Text) == (int)PM.VoucherType.Cash_Recievalbe_Voucher || Convert.ToInt32(lblVoucherTypeID.Text) == (int)PM.VoucherType.Bank_Recievable_Voucher)
            {
                Response.Redirect("GLCashRecievedVoucher.aspx?VoucherNo=" + lblVoucherNumber.Text);
            }
        }
        else
        {
            JQ.showStatusMsg(this, "3", "User not Allowed to Update Record");
        }
    }
    protected void LbtnView_Command(object sender, CommandEventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        var row = (GridViewRow)((Control)sender).NamingContainer;
        int index = row.RowIndex;
        Label lblVoucherTypeID = (Label)GridVoucher.Rows[index].FindControl("lblVoucherTypeID");
        Label lblVoucherNumber = (Label)GridVoucher.Rows[index].FindControl("lblVoucherNumber");
        int view = 1;
        if (PSMS.Can_View == true)
        {
            if (Convert.ToInt32(lblVoucherTypeID.Text) == (int)PM.VoucherType.General_Voucher)
            {
                Response.Redirect("GLGeneralVoucher.aspx?VoucherNo=" + lblVoucherNumber.Text + "&view=" + view);
            }
            if (Convert.ToInt32(lblVoucherTypeID.Text) == (int)PM.VoucherType.Cash_Payment_Voucher || Convert.ToInt32(lblVoucherTypeID.Text) == (int)PM.VoucherType.Bank_Payment_Voucher)
            {
                Response.Redirect("GLCashPaymentVoucher.aspx?VoucherNo=" + lblVoucherNumber.Text + "&view=" + view);
            }
            if (Convert.ToInt32(lblVoucherTypeID.Text) == (int)PM.VoucherType.Cash_Recievalbe_Voucher || Convert.ToInt32(lblVoucherTypeID.Text) == (int)PM.VoucherType.Bank_Recievable_Voucher)
            {
                Response.Redirect("GLCashRecievedVoucher.aspx?VoucherNo=" + lblVoucherNumber.Text + "&view=" + view);
            }
        }
        else
        {
            JQ.showStatusMsg(this, "3", "User not Allowed to View Record");
        }
    }
    protected void lbtnDelete_Command(object sender, CommandEventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        if (PSMS.Can_Delete == true)
        {
            var row = (GridViewRow)((Control)sender).NamingContainer;
            int index = row.RowIndex;
            ViewState["Index"] = index;
            Label lblVoucherNumber = ((Label)GridVoucher.Rows[index].FindControl("lblVoucherNumberDel"));
            //lblDeleteMsg.Text = "Are you sure to want to Delete Voucher # [ " + lblVoucherNumber.Text + " ] ?";
            //lbtnYes.Visible = true;
            //lbtnNo.Text = "No";
            //JQ.ShowDialog(this, "Confirmation");
            JQ.ShowModal(this, "ModalConfirmation");
        }
        else
        {
            JQ.showStatusMsg(this, "3", "User not Allowed to Delete Record");
        }
    }
    protected void lbtnYes_Click(object sender, EventArgs e)
    {
        GL_BAL GBLL = new GL_BAL();
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        int FinYearID = PSMS.FinYearID;
        int index = Convert.ToInt32(ViewState["Index"]);
        Label lblVoucherTypeID = (Label)GridVoucher.Rows[index].FindControl("lblVoucherTypeID");
        Label lblVoucherNumber = ((Label)GridVoucher.Rows[index].FindControl("lblVoucherNumberDel"));
        if (Convert.ToInt32(lblVoucherTypeID.Text) == (int)PM.VoucherType.General_Voucher)
        {
            DataRow[] dr = PSMS.PermissionTable.Select("PageUrl='Transactions/GLGeneralVoucher.aspx'");
            if (dr.Length > 0)
            {
                if (Convert.ToBoolean(dr[0]["Can_Delete"]) == true)
                {
                    int a = GBLL.DeleteGL(Convert.ToInt32(lblVoucherNumber.Text));
                    if (a != 0)
                    {
                        GBLL.DeleteGL(Convert.ToInt32(lblVoucherNumber.Text));
                        GridVoucher.DataSource = null;
                        GridVoucher.DataSource = GBLL.GetVoucherByVoucherTypeID("0",FinYearID);
                        GridVoucher.DataBind();
                    }
                }
                else
                    Response.Write("<script>alert('You do not have rights to Delete');</script>");
            }
        }
        if (Convert.ToInt32(lblVoucherTypeID.Text) == (int)PM.VoucherType.Cash_Payment_Voucher)
        {
            DataRow[] dr = PSMS.PermissionTable.Select("PageUrl='Transactions/GLCashPaymentVoucher.aspx'");
            if (dr.Length > 0)
            {
                if (Convert.ToBoolean(dr[0]["Can_Delete"]) == true)
                {
                    int a = GBLL.DeleteGL(Convert.ToInt32(lblVoucherNumber.Text));
                    if (a != 0)
                    {
                        GBLL.DeleteGL(Convert.ToInt32(lblVoucherNumber.Text));
                        GridVoucher.DataSource = null;
                        GridVoucher.DataSource = GBLL.GetVoucherByVoucherTypeID("0",FinYearID);
                        GridVoucher.DataBind();
                    }
                }
                else
                    Response.Write("<script>alert('You do not have rights to Delete');</script>");
            }
        }
        if (Convert.ToInt32(lblVoucherTypeID.Text) == (int)PM.VoucherType.Cash_Recievalbe_Voucher)
        {
            DataRow[] dr = PSMS.PermissionTable.Select("PageUrl='Transactions/GLCashRecievedVoucher.aspx'");
            if (dr.Length > 0)
            {
                if (Convert.ToBoolean(dr[0]["Can_Delete"]) == true)
                {
                    int a = GBLL.DeleteGL(Convert.ToInt32(lblVoucherNumber.Text));
                    if (a != 0)
                    {
                        GBLL.DeleteGL(Convert.ToInt32(lblVoucherNumber.Text));
                        GridVoucher.DataSource = null;
                        GridVoucher.DataSource = GBLL.GetVoucherByVoucherTypeID("0",FinYearID);
                        GridVoucher.DataBind();
                    }
                }
                else
                    Response.Write("<script>alert('You do not have rights to Delete');</script>");
            }
        }
        JQ.CloseDialog(this, "Confirmation");
    }
    protected void GridVoucher_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        int FinYearID = PSMS.FinYearID;
        if (txtVoucherType.Text != "")
        {
            if (ddlSearch.Text == "Voucher Type")
            {
                GL_BAL GL = new GL_BAL();
                GridVoucher.DataSource = GL.SearchVoucherListByVoucherType(txtVoucherType.Text, FinYearID);
                GridVoucher.DataBind();
            }
        }
        else if (txtVoucherNo.Text != "")
        {
            if (ddlSearch.Text == "Voucher No")
            {
                GL_BAL GL = new GL_BAL();
                GridVoucher.DataSource = GL.SearchVoucherListByVoucherNo(SCGL_Common.Convert_ToInt(txtVoucherNo.Text), FinYearID);
                GridVoucher.DataBind();
            }
        }
       
        else
        {
            GL_BAL GL = new GL_BAL();
            GridVoucher.DataSource = GL.GetVoucherByVoucherTypeID("0",FinYearID);
            GridVoucher.PageIndex = e.NewPageIndex;
            GridVoucher.DataBind();
        }

        
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Sessions PSMSSession = (Sessions)Session["PSMSSession"];
        int FinYearID = PSMSSession.FinYearID;
        DataTable dt = new DataTable();
        if (txtVoucherType.Text != "")
        {
            if (ddlSearch.Text == "Voucher Type")
            {
                GL_BAL GL = new GL_BAL();
                GridVoucher.DataSource = GL.SearchVoucherListByVoucherType(txtVoucherType.Text,FinYearID);
                GridVoucher.DataBind();
                txtVoucherNo.Text = "";
                
            }
        }
        if (txtVoucherNo.Text != "")
        {
            if (ddlSearch.Text == "Voucher No")
            {
                GL_BAL GL = new GL_BAL();
                GridVoucher.DataSource = GL.SearchVoucherListByVoucherNo(Convert.ToInt32(txtVoucherNo.Text), FinYearID);
                GridVoucher.DataBind();
                txtVoucherType.Text = "";
               
            }
        }

        SCGL_Common.ReloadJS(this, "setSearchElem();");

        
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        int FinYearID = PSMS.FinYearID;
        txtVoucherType.Text = "";
        txtVoucherNo.Text = "";
       
        GL_BAL GL = new GL_BAL();
        GridVoucher.DataSource = GL.GetVoucherByVoucherTypeID("0",FinYearID);
        GridVoucher.DataBind();
    }
    protected void txtVoucherType_TextChanged(object sender, EventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        int FinYearID = PSMS.FinYearID;
        if (txtVoucherType.Text == "")
        {
            GL_BAL GL = new GL_BAL();
            GridVoucher.DataSource = GL.GetVoucherByVoucherTypeID("0",FinYearID);
            GridVoucher.DataBind();
        }
    }
    protected void txtVoucherNo_TextChanged(object sender, EventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        int FinYearID = PSMS.FinYearID;
        if (txtVoucherNo.Text == "")
        {
            GL_BAL GL = new GL_BAL();
            GridVoucher.DataSource = GL.GetVoucherByVoucherTypeID("0",FinYearID);
            GridVoucher.DataBind();
        }
    }

    protected void btnConfirmation_Click(object sender, EventArgs e)
    {
        GL_BAL GBLL = new GL_BAL();
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        int FinYearID = PSMS.FinYearID;
        int index = Convert.ToInt32(ViewState["Index"]);
        Label lblVoucherTypeID = (Label)GridVoucher.Rows[index].FindControl("lblVoucherTypeID");
        Label lblVoucherNumber = ((Label)GridVoucher.Rows[index].FindControl("lblVoucherNumberDel"));
        if (Convert.ToInt32(lblVoucherTypeID.Text) == (int)PM.VoucherType.General_Voucher)
        {
            DataRow[] dr = PSMS.PermissionTable.Select("PageUrl='Transactions/GLGeneralVoucher.aspx'");
            if (dr.Length > 0)
            {
                if (Convert.ToBoolean(dr[0]["Can_Delete"]) == true)
                {
                    int a = GBLL.DeleteGL(Convert.ToInt32(lblVoucherNumber.Text));
                    if (a != 0)
                    {
                        GBLL.DeleteGL(Convert.ToInt32(lblVoucherNumber.Text));
                        GridVoucher.DataSource = null;
                        GridVoucher.DataSource = GBLL.GetVoucherByVoucherTypeID("0", FinYearID);
                        GridVoucher.DataBind();
                    }
                }
                else
                    Response.Write("<script>alert('You do not have rights to Delete');</script>");
            }
        }
        if (Convert.ToInt32(lblVoucherTypeID.Text) == (int)PM.VoucherType.Cash_Payment_Voucher)
        {
            DataRow[] dr = PSMS.PermissionTable.Select("PageUrl='Transactions/GLCashPaymentVoucher.aspx'");
            if (dr.Length > 0)
            {
                if (Convert.ToBoolean(dr[0]["Can_Delete"]) == true)
                {
                    int a = GBLL.DeleteGL(Convert.ToInt32(lblVoucherNumber.Text));
                    if (a != 0)
                    {
                        GBLL.DeleteGL(Convert.ToInt32(lblVoucherNumber.Text));
                        GridVoucher.DataSource = null;
                        GridVoucher.DataSource = GBLL.GetVoucherByVoucherTypeID("0", FinYearID);
                        GridVoucher.DataBind();
                    }
                }
                else
                    Response.Write("<script>alert('You do not have rights to Delete');</script>");
            }
        }
        if (Convert.ToInt32(lblVoucherTypeID.Text) == (int)PM.VoucherType.Cash_Recievalbe_Voucher)
        {
            DataRow[] dr = PSMS.PermissionTable.Select("PageUrl='Transactions/GLCashRecievedVoucher.aspx'");
            if (dr.Length > 0)
            {
                if (Convert.ToBoolean(dr[0]["Can_Delete"]) == true)
                {
                    int a = GBLL.DeleteGL(Convert.ToInt32(lblVoucherNumber.Text));
                    if (a != 0)
                    {
                        GBLL.DeleteGL(Convert.ToInt32(lblVoucherNumber.Text));
                        GridVoucher.DataSource = null;
                        GridVoucher.DataSource = GBLL.GetVoucherByVoucherTypeID("0", FinYearID);
                        GridVoucher.DataBind();
                    }
                }
                else
                    Response.Write("<script>alert('You do not have rights to Delete');</script>");
            }
        }
        JQ.CloseModal(this, "ModalConfirmation");
    }
}
