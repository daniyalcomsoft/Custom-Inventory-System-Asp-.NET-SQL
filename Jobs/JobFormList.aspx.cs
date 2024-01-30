using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SW.SW_Common;
using System.Data;
using SCGL.BAL;

public partial class Jobs_JobFormList : System.Web.UI.Page
{
    //CustomerForm_BAL BLL = new CustomerForm_BAL();

    private string FilterColumn
    {
        get
        {
            if (ViewState["FilterColumn"] != null)
                return (string)ViewState["FilterColumn"];
            else
                return "";
        }
        set
        {
            ViewState["FilterColumn"] = value;
        }
    }

    private string FilterValue
    {
        get
        {
            if (ViewState["FilterValue"] != null)
                return (string)ViewState["FilterValue"];
            else
                return "";
        }
        set
        {
            ViewState["FilterValue"] = value;
        }
    }

    void DataLoad()
    {
        SqlDataSource1.FilterExpression = "";
        SqlDataSource1.FilterParameters.Clear();
        if (FilterColumn != "" && FilterValue != "")
        {            
            SqlDataSource1.FilterExpression = FilterColumn + " Like {0}";
            SqlDataSource1.FilterParameters.Add(FilterColumn, "'%" + FilterValue + "%'");
            SqlDataSource1.DataBind();
        }
      
        grdJob.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PSMSSession"] == null)
        {
            Response.Redirect("Login.aspx");
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
                if (dtRole.Rows[row]["PageUrl"].ToString() == "Jobs/JobFormList.aspx")
                {
                    pageName = dtRole.Rows[row]["PageUrl"].ToString();
                    view = Convert.ToBoolean(dtRole.Rows[row]["Can_View"].ToString());
                    break;
                }
            }
            if (dtRole.Rows.Count > 0)
            {
                if (pageName == "Jobs/JobFormList.aspx" && view == true)
                {
                    DataLoad();
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
            Response.Redirect("JobForm.aspx?Id=" + e.CommandArgument.ToString());
        }
        else
        {
            JQ.showStatusMsg(this, "3", "User not Allowed to Update Record");
        }
    }

    protected void lbtnView_Command(object sender, CommandEventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        if (PSMS.Can_View == true)
        {
            int view = 1;
            Response.Redirect("JobForm.aspx?Id=" + e.CommandArgument.ToString() + "&view=" + view);
        }

        else
        {
            JQ.showStatusMsg(this, "3", "User not Allowed to View Record");
        }
    }

    protected void lbtnYes_Click(object sender, EventArgs e)
    {
        Job j = new Job();
        int CheckExsistingJob = j.CheckExsistingJob(Convert.ToInt32(lblJobID.Text));
        if(CheckExsistingJob>0)
        {
            lblDeleteMsg.Text= "Cannot Delete as Job is in use";
            lbtnYes.Visible = false;
            lbtnNo.Text = "Ok"; 
        }
        else
        {
            lblDeleteMsg.Text = j.Delete(Convert.ToInt32(lblJobID.Text)) ? "Successfully Deleted" : "";
            grdJob.DataBind();
            lbtnYes.Visible = false;
            lbtnNo.Text = "Ok"; 
        }
        

    }
    protected void lbtnDelete_Command(object sender, CommandEventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        if (PSMS.Can_Delete == true)
        {
            lblJobID.Text = e.CommandArgument.ToString();
            //lblDeleteMsg.Text = "Are you sure to want to delete !";
            //lbtnYes.Visible = true;
            //lbtnNo.Text = "No";
            JQ.ShowModal(this, "ModalConfirmation");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Confirmation", "ShowDialog('Confirmation');", true);
        }
        else
        { 
            JQ.showStatusMsg(this, "3", "User not Allowed to Delete Record");
        }
    }

    protected void btnNewJob_Click(object sender, EventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        if (PSMS.Can_Insert == true)
        {
            Response.Redirect("JobForm.aspx");
        }
        else
        {
            JQ.showStatusMsg(this, "3", "User not Allowed to Insert Customer Record");
        }
    }

    protected void grdJob_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdJob.PageIndex = e.NewPageIndex;
        DataLoad();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (txtSearch.Text != "")
        {
            FilterColumn = ddlSearch.SelectedValue;
            if (ddlSearch.SelectedValue == "Completed")
                FilterValue = txtSearch.Text.ToUpper();
            else
                FilterValue = txtSearch.Text;
        }

        DataLoad();        
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtSearch.Text = "";
        FilterColumn = "";
        FilterValue = "";
        ddlSearch.SelectedIndex = 0;
        DataLoad();
    }

    protected void btnConfirmation_Click(object sender, EventArgs e)
    {
        Job j = new Job();
        int CheckExsistingJob = j.CheckExsistingJob(Convert.ToInt32(lblJobID.Text));
        if (CheckExsistingJob > 0)
        {
            lblDeleteMsg.Text = "Cannot Delete as Job is in use";
            lbtnYes.Visible = false;
            lbtnNo.Text = "Ok";
        }
        else
        {
            //lblDeleteMsg.Text = j.Delete(Convert.ToInt32(lblJobID.Text)) ? "Successfully Deleted" : "";
            JQ.CloseModal(this, "ModalConfirmation");
            JQ.ShowStatusMsg(this, "1", "Record Deleted Successfully");
            grdJob.DataBind();
            //lbtnYes.Visible = false;
            //lbtnNo.Text = "Ok";
        }
    }
}
