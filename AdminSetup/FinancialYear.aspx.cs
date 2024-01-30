using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SW.SW_Common;
using System.Drawing;

public partial class AdminSetup_FinancialYear : System.Web.UI.Page
{
    Financial_BAL FBLL = new Financial_BAL();
    User_BLL UBO = new User_BLL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PSMSSession"] == null)
        {
            Response.Redirect("Login.aspx");
        }       
        Reload_JS();
        if (!IsPostBack)
        {
            RolePermission_BLL PP = new RolePermission_BLL();
            DataTable dtRole = new DataTable();
            Sessions PSMS = (Session["PSMSSession"]) as Sessions;
            dtRole = PP.GetPagePermissionpPagesByRole(PSMS.RoleID);
            string pageName = null;
            bool view = false;
            foreach (DataRow dr in dtRole.Rows)
            {
                int row = dtRole.Rows.IndexOf(dr);
                if (dtRole.Rows[row]["PageUrl"].ToString() == "AdminSetup/FinancialYear.aspx")
                {
                    pageName = dtRole.Rows[row]["PageUrl"].ToString();
                    view = Convert.ToBoolean(dtRole.Rows[row]["Can_View"].ToString());
                    break;
                }
            }
            if (dtRole.Rows.Count > 0)
            {
                if (pageName == "AdminSetup/FinancialYear.aspx" && view == true)
                {
                    LoadFinYear();
                    OnLoad();
                }
                else
                {
                    Response.Redirect("Default.aspx", false);
                }
            }
            
        }
    }
    #region Method
    private void OnLoad()
    {
        PM.BindDataGrid(GridFinancial, FBLL.getFinancialYear());
    }

    protected void GridFinancial_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        PSMS.FinYearID = Convert.ToInt32(ddlFinYear.SelectedValue);
        DataTable dt = PM.getFinancialYearByID(PSMS.FinYearID);
        string FinYearID = SCGL_Common.Convert_ToString(dt.Rows[0]["FinYearID"]);
        
        //DataTable dtn = FBLL.getFinancialYear();
        //DataTable dts = FBLL.getalloverFinancialYear();
        //for (int i = 0; i < dtn.Rows.Count; i++)
        //{
           
           
             
        //        int rowID = SCGL_Common.Convert_ToInt(dtn.Rows[i]["FinyearID"].ToString());


        //       // int ID = SCGL_Common.Convert_ToInt(dts.Rows[0]["FinYearID"].ToString());
        //        if (rowID == 3)
        //        {
        //            e.Row.Cells[0].BackColor = System.Drawing.Color.LightGray;
        //        } 
            
           
        //}


        if (e.Row.Cells[0].Text == FinYearID)
        {
            e.Row.Cells[0].BackColor = System.Drawing.Color.Silver;
            e.Row.Cells[1].BackColor = System.Drawing.Color.Silver;
            e.Row.Cells[2].BackColor = System.Drawing.Color.Silver;
            e.Row.Cells[3].BackColor = System.Drawing.Color.Silver;
            e.Row.Cells[4].BackColor = System.Drawing.Color.Silver;
            e.Row.Cells[5].BackColor = System.Drawing.Color.Silver;
            e.Row.Cells[4].Enabled = false;
            e.Row.Cells[5].Enabled = false;
            
        }
    }

    private void RefreshControl()
    {
        txtFinancialYearID.Text = "";
        txtFinancialYear.Text = "";
        txtDateFrom.Text = "";
        txtDateTo.Text = "";
    }
    #endregion

    public void LoadFinYear()
    {
        ddlFinYear.DataSource = UBO.GetFinacialYear();
        ddlFinYear.DataValueField = "FinYearID";
        ddlFinYear.DataTextField = "FinYearTitle";
        ddlFinYear.DataBind();
        ddlFinYear.Items.Insert(0, new ListItem("--Please Select--", "0"));
        ddlFinYear.SelectedValue = UBO.GetDefaultFinancialYear().ToString();
    }

    public void Reload_JS()
    {
        SCGL_Common.ReloadJS(this, "MyDate();");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        if (txtFinancialYearID.Text == "")
        {
            if (PSMS.Can_Insert == true)
            {
                SaveFYear();
                JQ.CloseModal(this, "ModalFinance");
                btnClear_Click();

            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "temp", "CloseDialog('NewFinancial')", true);
                JQ.ShowStatusMsg(this, "3", "User not Allowed to Insert New Record");
            }
        }
        else
        {
            if (PSMS.Can_Update == true)
            {
                SaveFYear();
                JQ.CloseModal(this, "ModalFinance");
                btnClear_Click();

            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "temp", "CloseDialog('NewFinancial')", true);
                JQ.ShowStatusMsg(this, "3", "User not Allowed to Update Record");
            }
        }
    }
    protected void lbtnEdit_Command(object sender, CommandEventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        if (PSMS.Can_Update == true)
        {
            if (e.CommandArgument.ToString() != "")
            {
                Financial_BAL FBAL=FBLL.GetFinancialYearByID(Convert.ToInt32(e.CommandArgument));
                txtFinancialYearID.Text = SCGL_Common.Convert_ToString(FBAL.FinYearID);
                txtFinancialYear.Text = FBAL.FinYearTitle;
                //txtDateFrom.Text = SCGL_Common.CheckDateTime(FBAL.YearFrom).ToShortDateString();
                txtDateFrom.Text = FBAL.YearFrom.ToString();
                //txtDateTo.Text = SCGL_Common.CheckDateTime(FBAL.YearTo).ToShortDateString();
                txtDateTo.Text = FBAL.YearTo.ToString();
                //JQ.ShowDialog(this, "NewFinancial");
                JQ.ShowModal(this, "ModalFinance");
            }
        }
        else
        { JQ.showStatusMsg(this, "3", "User not Allowed to Update Record"); }
    }
    protected void btnNew_Click(object sender, EventArgs e)
    {

        Sessions PSMS = (Sessions)Session["PSMSSession"];
        if (PSMS.Can_Insert == true)
        {
            RefreshControl();
          
            JQ.ShowDialog(this, "NewFinancial");
        }
        else
        { JQ.showStatusMsg(this, "3", "User not Allowed to Insert New Record"); }
    }
    //protected void lbtnYes_Click(object sender, EventArgs e)
    //{
    //    Financial_BAL FBAL = FBLL.GetFinancialYearByID(Convert.ToInt32(lblGroupID.Text));
    //    string StarDate = FBAL.YearFrom;
    //    string EndDate = FBAL.YearTo;
    //    lblDeleteMsg.Text = FBLL.DeleteFinancialYear(Convert.ToInt32(lblGroupID.Text), StarDate, EndDate);
    //    PM.BindDataGrid(GridFinancial, FBLL.getFinancialYear());
    //    lbtnYes.Visible = false;
    //    lbtnNo.Text = "Ok";

    //}

    protected void btnConfirmation_Click(object sender, EventArgs e)
    {
        Financial_BAL FBAL = FBLL.GetFinancialYearByID(Convert.ToInt32(lblGroupID.Text));
        string StarDate = FBAL.YearFrom;
        string EndDate = FBAL.YearTo;
        lblDeleteMsg.Text = FBLL.DeleteFinancialYear(Convert.ToInt32(lblGroupID.Text), StarDate, EndDate);
        PM.BindDataGrid(GridFinancial, FBLL.getFinancialYear());
        //lbtnYes.Visible = false;
        //lbtnNo.Text = "Ok";
        JQ.CloseModal(this, "ModalConfirmation");
        JQ.ShowStatusMsg(this, "1", "Record Deleted Successfully");
    }
    protected void lbtnDelete_Command(object sender, CommandEventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        if (PSMS.Can_Delete == true)
        {
            lblGroupID.Text = e.CommandArgument.ToString();
            lblDeleteMsg.Text = "Are you sure to want to delete !";
            //lbtnYes.Visible = true;
            //lbtnNo.Text = "No";
            JQ.ShowModal(this, "ModalConfirmation");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Confirmation", "ShowDialog('Confirmation');", true);
        }
        else
        { JQ.ShowStatusMsg(this, "3", "User not Allowed to Delete Record"); }
    }

    protected void GridFinancial_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        OnLoad();
        GridFinancial.PageIndex = e.NewPageIndex;
        GridFinancial.DataBind();
    }

    private void SaveFYear()
    {
        int CurrentFinYearID=txtFinancialYearID.Text.Equals("") ? 0 :SCGL_Common.Convert_ToInt(txtFinancialYearID.Text);
        int countoverlapperiod = FBLL.CountOverlapPeriods(CurrentFinYearID,SCGL_Common.CheckDateTime(txtDateFrom.Text), SCGL_Common.CheckDateTime(txtDateTo.Text));
        if (countoverlapperiod > 0)
        {
            JQ.ShowStatusMsg(this, "2", "Cannot add overlap period");
        }
        else 
        { 
            FBLL.FinYearID = txtFinancialYearID.Text.Equals("") ? 0 :SCGL_Common.Convert_ToInt(txtFinancialYearID.Text);
            FBLL.FinYearTitle = txtFinancialYear.Text;
            //FBLL.YearFrom = txtDateFrom.Text.Equals("") ? DateTime.Now : SCGL_Common.CheckDateTime(txtDateFrom.Text);
            FBLL.YearFrom = txtDateFrom.Text.ToString();
            //FBLL.YearTo = txtDateTo.Text.Equals("") ? DateTime.Now : SCGL_Common.CheckDateTime(txtDateTo.Text);
            FBLL.YearTo = txtDateTo.Text.ToString();
             FBLL.CreateModifyFinancial(FBLL, (Sessions)Session["PSMSSession"]);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "temp", "CloseDialog('NewFinancial')", true);
            PM.BindDataGrid(GridFinancial, FBLL.getFinancialYear());
            JQ.ShowStatusMsg(this, "1", "Successfull Record Update");
        }
    }

    protected void lbtnsetasdefault_Click(object sender, EventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        if (PSMS.Can_Insert == true)
        {

            int DefaultFinYearID = SCGL_Common.Convert_ToInt(ddlFinYear.SelectedValue);
            FBLL.SetDefaultFinancialYear(DefaultFinYearID);
            Session.Abandon();
            Response.Redirect("/Login.aspx");
        }
        else
        { JQ.ShowStatusMsg(this, "3", "User not Allowed to Insert Record"); }
    }

    private void btnClear_Click()
    {
        txtFinancialYear.Text = "";
        txtDateFrom.Text = "";
        txtDateTo.Text = "";
    }
}
