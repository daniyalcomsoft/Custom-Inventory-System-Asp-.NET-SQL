using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Sales_CustomerType : System.Web.UI.Page
{
    CustomerType_BAL BL = new CustomerType_BAL();
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
                if (dtRole.Rows[row]["PageUrl"].ToString() == "Sales/CustomerType.aspx")
                {
                    pageName = dtRole.Rows[row]["PageUrl"].ToString();
                    view = Convert.ToBoolean(dtRole.Rows[row]["Can_View"].ToString());
                    break;
                }
            }
            if (dtRole.Rows.Count > 0)
            {
                if (pageName == "Sales/CustomerType.aspx" && view == true)
                {
                    fillGrid();


                }
                else
                {
                    Response.Redirect("Default.aspx", false);
                }
            }

        }
    }

    public void fillGrid()
    {
        Sessions PSMSSession = (Sessions)Session["PSMSSession"];
        grd.DataSource = BL.GetCustomerTypeListbySearch((object)DBNull.Value, (object)DBNull.Value);
        grd.DataBind();
    }
    protected void grd_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grd.PageIndex = e.NewPageIndex;
        int page = grd.PageSize;
        btnSearch_Click(null, null); ;
    }
    protected void btnEdit_Command(object sender, CommandEventArgs e)
    {
        var CustomerType = BL.GetCustomerTypeList(e.CommandArgument);
        if (CustomerType.Rows.Count > 0)
        {

            hdID.Value = CustomerType.Rows[0]["CustomerTypeID"].ToString();
            txtCustomerType.Text = CustomerType.Rows[0]["CustomerType"].ToString();
          


            btnSave.Visible = true;
            JQ.ShowModal(this, "ModalCustomerType");
        }

    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        Sessions PSMSSession = (Sessions)Session["PSMSSession"];

        BL.CustomerTypeID = hdID.Value == "" ? 0 : Convert.ToInt32(hdID.Value);
        BL.CustomerType = txtCustomerType.Text;
       
        BL.User = PSMSSession.UserID;
        BL.Date = DateTime.Now;

        BL.InsertUpdateCustomerType(BL);
        hdID.Value = "";
        fillGrid();
        JQ.CloseModal(this, "ModalCustomerType");
        JQ.ShowStatusMsg(this.Page, "1", "Customer Type Saved Successfully.");






    }


    protected void btnDelete_Command(object sender, CommandEventArgs e)
    {

        int CustomerTypeID = Convert.ToInt32(e.CommandArgument);

        try
        {
            BL.DeleteCustomerType(CustomerTypeID);
            fillGrid();
            JQ.ShowStatusMsg(this.Page, "1", "Customer Type Deleted Successfully.");
        }
        catch(Exception ex)
        {
            JQ.ShowStatusMsg(this.Page, "4", "Customer Type used in Branch.");
        }

       

    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        TextBox txtSearchCustomerTypeID = (TextBox)grd.HeaderRow.FindControl("txtSearchCustomerTypeID");
        TextBox txtSearchCustomerType = (TextBox)grd.HeaderRow.FindControl("txtSearchCustomerType");




        if (string.IsNullOrEmpty(txtSearchCustomerTypeID.Text) && string.IsNullOrEmpty(txtSearchCustomerType.Text))

            fillGrid();
        else
        {
            grd.DataSource = BL.GetCustomerTypeListbySearch(
               string.IsNullOrEmpty(txtSearchCustomerTypeID.Text) ? (object)DBNull.Value : txtSearchCustomerTypeID.Text,
               string.IsNullOrEmpty(txtSearchCustomerType.Text) ? (object)DBNull.Value : txtSearchCustomerType.Text);




            grd.DataBind();

            setValues(txtSearchCustomerTypeID.Text, txtSearchCustomerType.Text);

        }
    }
    public void setValues(string CustomerTypeID, string CustomerType)
    {
        TextBox txtSearchCustomerTypeID = (TextBox)grd.HeaderRow.FindControl("txtSearchCustomerTypeID");
        TextBox txtSearchCustomerType = (TextBox)grd.HeaderRow.FindControl("txtSearchCustomerType");
        txtSearchCustomerTypeID.Text = CustomerTypeID;
        txtSearchCustomerType.Text = CustomerType;

    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        setValues(string.Empty, string.Empty);
        fillGrid();
    }
}