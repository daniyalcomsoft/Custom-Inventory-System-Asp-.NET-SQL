using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SW.SW_Common;
using System.Data;
using System.Data.SqlClient;

public partial class Sales_CustomerForm_Views : System.Web.UI.Page
{
    CustomerForm_BAL BLL = new CustomerForm_BAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PSMSSession"] == null)
        {
            Response.Redirect("/Login.aspx");
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
                if (dtRole.Rows[row]["PageUrl"].ToString() == "Sales/CustomerForm_Views.aspx")
                {
                    pageName = dtRole.Rows[row]["PageUrl"].ToString();
                    view = Convert.ToBoolean(dtRole.Rows[row]["Can_View"].ToString());
                    break;
                }
            }
            if (dtRole.Rows.Count > 0)
            {
                if (pageName == "Sales/CustomerForm_Views.aspx" && view == true)
                {
                    GridCustomerView.DataSource = BLL.GetCustomerData();
                    GridCustomerView.DataBind();
                }
                else
                {
                    Response.Redirect("Default.aspx", false);
                }
            }
            
        }
    }

    

    protected void LbtnEdit_Command(object sender, CommandEventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];        
        if (PSMS.Can_Update == true)
        {
            Response.Redirect("CustomerForm.aspx?Id=" + e.CommandArgument.ToString());
        }
        else
        { JQ.showStatusMsg(this, "3", "User not Allowed to Update Record"); }
    }
    protected void lbtnView_Command(object sender, CommandEventArgs e)
    {   
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        if (PSMS.Can_View == true)
        {
            int view = 1;
            Response.Redirect("CustomerForm.aspx?Id=" + e.CommandArgument.ToString() + "&view=" + view);
        }

        else
        { JQ.showStatusMsg(this, "3", "User not Allowed to View Record"); }
    }

    protected void lbtnYes_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(SCGL_Common.ConnectionString);
        con.Open();
        using (SqlTransaction trans = con.BeginTransaction())
        {
            try
            {
                    int ExsistingCustomers = BLL.CheckExsistingCust(Convert.ToInt32(lblGroupID.Text));
                    if (ExsistingCustomers > 0)
                    {
                        lblDeleteMsg.Text = "Cannot Delete as Customer is being used in Job!";
                        lbtnYes.Visible = false;
                        lbtnNo.Text = "Ok";
                    }
                    else 
                    {
                        lblDeleteMsg.Text = BLL.DeleteCustomer(Convert.ToInt32(lblGroupID.Text), trans);
                        if (lblDeleteMsg.Text == "Record deleted successfully !")
                        {
                            BLL.Delete_Apartsubsidary(Convert.ToInt32(lblGroupID.Text), trans);
                        }
                        trans.Commit();
                        PM.BindDataGrid(GridCustomerView, BLL.GetCustomerData());
                        lbtnYes.Visible = false;
                        lbtnNo.Text = "Ok";
                    }
                    
            }
            catch (Exception ex)
            {
                lblDeleteMsg.Text = ex.Message;
                trans.Rollback();
            }
            finally
            {
                if (con.State == System.Data.ConnectionState.Open)
                    con.Close();
            }
        }
    }
    protected void lbtnDelete_Command(object sender, CommandEventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        if (PSMS.Can_Delete == true)
        {
            lblGroupID.Text = e.CommandArgument.ToString();
            JQ.ShowModal(this, "ModalConfirmation");
        }
        else
        { 
            JQ.showStatusMsg(this, "3", "User not Allowed to Delete Record");
        }
    }
        

    
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        if (PSMS.Can_Insert == true)
        {
            Response.Redirect("CustomerForm.aspx");
        }

        else
        { JQ.showStatusMsg(this, "3", "User not Allowed to Insert Customer Record"); }
        
    }

    protected void GridCustomerView_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (txtCustomerName.Text != "")
        {
            if (ddlSearch.Text == "Customer Name")
            {
                PM.BindDataGrid(GridCustomerView, BLL.searchCustomerByCustomerName(txtCustomerName.Text));
                GridCustomerView.PageIndex = e.NewPageIndex;
                GridCustomerView.DataBind();
            }
        }
        else if (txtMobileNo.Text != "")
        {
            if (ddlSearch.Text == "Mobile No")
            {
                PM.BindDataGrid(GridCustomerView, BLL.searchCustomerByMobileNumber(txtMobileNo.Text));
                GridCustomerView.PageIndex = e.NewPageIndex;
                GridCustomerView.DataBind();
            }
        }
        else if (txtEmail.Text != "")
        {
            if (ddlSearch.Text == "Email")
            {
                PM.BindDataGrid(GridCustomerView, BLL.searchCustomerByEmail(txtEmail.Text));
                GridCustomerView.PageIndex = e.NewPageIndex;
                GridCustomerView.DataBind();
            }
        }
        else
        {
            GridCustomerView.DataSource = BLL.GetCustomerData();
            GridCustomerView.PageIndex = e.NewPageIndex;
            GridCustomerView.DataBind();
        }
        
        
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        if (txtCustomerName.Text != "")
        {
            if (ddlSearch.Text == "Customer Name")
            {
                PM.BindDataGrid(GridCustomerView, BLL.searchCustomerByCustomerName(txtCustomerName.Text));
                txtMobileNo.Text = "";
                txtEmail.Text = "";
            }
        }
        if (txtMobileNo.Text != "")
        {
            if (ddlSearch.Text == "Mobile No")
            {
                PM.BindDataGrid(GridCustomerView, BLL.searchCustomerByMobileNumber(txtMobileNo.Text));
                txtCustomerName.Text = "";
                txtEmail.Text = "";
            }
        }

        if (txtEmail.Text != "")
        {
            if (ddlSearch.Text == "Email")
            {
                PM.BindDataGrid(GridCustomerView, BLL.searchCustomerByEmail(txtEmail.Text));
                txtCustomerName.Text = "";
                txtMobileNo.Text = "";
            }
        }

        SCGL_Common.ReloadJS(this, "setSearchElem();");
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtCustomerName.Text = "";
        txtMobileNo.Text = "";
        txtEmail.Text = "";
        PM.BindDataGrid(GridCustomerView, BLL.GetCustomerData());
    }
    protected void txtCustomerName_TextChanged(object sender, EventArgs e)
    {
        if (txtCustomerName.Text == "")
        {
            PM.BindDataGrid(GridCustomerView, BLL.GetCustomerData());
        }
    }
    protected void txtMobileNo_TextChanged(object sender, EventArgs e)
    {
        if (txtMobileNo.Text == "")
        {
            PM.BindDataGrid(GridCustomerView, BLL.GetCustomerData());
        }
    }
    protected void txtEmail_TextChanged(object sender, EventArgs e)
    {
        if (txtEmail.Text == "")
        {
            PM.BindDataGrid(GridCustomerView, BLL.GetCustomerData());
        }
    }

    protected void btnConfirmation_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(ConnectionString.PSMS);
        con.Open();
        using (SqlTransaction trans = con.BeginTransaction())
        {
            try
            {
                int ExsistingCustomers = BLL.CheckExsistingCust(Convert.ToInt32(lblGroupID.Text));
                if (ExsistingCustomers > 0)
                {
                    JQ.showStatusMsg(this, "3", "Cannot Delete as Customer is being used in Job!");
                }
                else
                {
                    lblDeleteMsg.Text = BLL.DeleteCustomer(Convert.ToInt32(lblGroupID.Text), trans);
                    if (lblDeleteMsg.Text == "Record deleted successfully !")
                    {
                        BLL.Delete_Apartsubsidary(Convert.ToInt32(lblGroupID.Text), trans);
                    }
                    trans.Commit();
                    PM.BindDataGrid(GridCustomerView, BLL.GetCustomerData());
                    //lbtnYes.Visible = false;
                    //lbtnNo.Text = "Ok";
                    JQ.CloseModal(this, "ModalConfirmation");
                    JQ.showStatusMsg(this, "1", "Customer Deleted Successfully! ");
                }

            }
            catch (Exception ex)
            {
                lblDeleteMsg.Text = ex.Message;
                trans.Rollback();
            }
            finally
            {
                if (con.State == System.Data.ConnectionState.Open)
                    con.Close();
            }
        }
    }
}
