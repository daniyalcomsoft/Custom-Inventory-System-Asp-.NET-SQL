using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SW.SW_Common;
using System.Data;

public partial class AdminSetup_SalesTax : System.Web.UI.Page
{
    SalesTax_BAL STBLL = new SalesTax_BAL();
    SuperAdmin_BAL SABL = new SuperAdmin_BAL();
    User_BLL UBO = new User_BLL();
    Province_BLL BL = new Province_BLL();
    TaxInfo_BLL TBL = new TaxInfo_BLL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PSMSSession"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        Reload_JS();
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
                if (dtRole.Rows[row]["PageUrl"].ToString() == "AdminSetup/SalesTax.aspx")
                {
                    pageName = dtRole.Rows[row]["PageUrl"].ToString();
                    view = Convert.ToBoolean(dtRole.Rows[row]["Can_View"].ToString());
                    break;
                }
            }
            if (dtRole.Rows.Count > 0)
            {
                if (pageName == "AdminSetup/SalesTax.aspx" && view == true)
                {
                    PM.Bind_DropDown(cmbProvince, new Province_BLL().GetProvinceList(DBNull.Value), "Province", "ProvinceID");
                    PM.Bind_DropDown(cmbTaxRule, new TaxInfo_BLL().GetTaxList(DBNull.Value), "TaxRule", "TaxRuleID");
                    OnLoad();
                }
                else
                {
                    Response.Redirect("Default.aspx", false);
                }
            }

        }
        selectinit();

    }
    #region Method
    private void OnLoad()
    {
        PM.BindDataGrid(GridSalesTax, STBLL.getSalesTax());
    }
    public void selectinit()
    {
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), "selectpic();", true);
    }

    //protected void GridSalesTax_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    SCGL_Session SBO = (SCGL_Session)Session["SessionBO"];
    //    DataTable dt = PM.getFinancialYearByID(SBO.FinYearID);
    //    string FinYearID = SCGL_Common.Convert_ToString(dt.Rows[0]["FinYearID"]);

    //    //DataTable dtn = STBLL.getSalesTaxYear();
    //    //DataTable dts = STBLL.getalloverSalesTaxYear();
    //    //for (int i = 0; i < dtn.Rows.Count; i++)
    //    //{



    //    //        int rowID = SCGL_Common.Convert_ToInt(dtn.Rows[i]["FinyearID"].ToString());


    //    //       // int ID = SCGL_Common.Convert_ToInt(dts.Rows[0]["FinYearID"].ToString());
    //    //        if (rowID == 3)
    //    //        {
    //    //            e.Row.Cells[0].BackColor = System.Drawing.Color.LightSkyBlue;
    //    //        } 


    //    //}


    //    if (e.Row.Cells[0].Text == FinYearID)
    //    {
    //        e.Row.Cells[0].BackColor = System.Drawing.Color.LightSkyBlue;
    //        e.Row.Cells[1].BackColor = System.Drawing.Color.LightSkyBlue;
    //        e.Row.Cells[2].BackColor = System.Drawing.Color.LightSkyBlue;
    //        e.Row.Cells[3].BackColor = System.Drawing.Color.LightSkyBlue;
    //        e.Row.Cells[4].BackColor = System.Drawing.Color.LightSkyBlue;
    //        e.Row.Cells[5].BackColor = System.Drawing.Color.LightSkyBlue;
    //        e.Row.Cells[4].Enabled = false;
    //        e.Row.Cells[5].Enabled = false;

    //    }
    //}

    private void RefreshControl()
    {
        cmbProvince.SelectedValue = "0";
        cmbTaxRule.SelectedValue = "0";
        txtSalesTaxYearID.Text = "";
        txtSalesTaxYear.Text = "";
        txtDateFrom.Text = "";
        txtDateTo.Text = "";
        //txtTaxRule.Text = "";
        txtBankHold.Text = "";
        txtIncomeTax.Text = "";
    }
    #endregion


    public void Reload_JS()
    {
        SCGL_Common.ReloadJS(this, "MyDate();");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        if (txtSalesTaxYearID.Text == "")
        {
            if (PSMS.Can_Insert == true)
            {
                SaveSalesTaxYear();

            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "temp", "CloseDialog('NewSalesTax')", true);
                JQ.showStatusMsg(this, "3", "User not Allowed to Insert New Record");
            }
        }
        else
        {
            if (PSMS.Can_Update == true)
            {
                SaveSalesTaxYear();

            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "temp", "CloseDialog('NewSalesTax')", true);
                JQ.showStatusMsg(this, "3", "User not Allowed to Update Record");
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
                SalesTax_BAL STBAL = STBLL.GetSalesTaxByID(Convert.ToInt32(e.CommandArgument));
                
                txtSalesTaxYearID.Text = SCGL_Common.Convert_ToString(STBAL.TaxDetailID);
                txtDateFrom.Text = STBAL.FromDate.ToString();
                txtDateTo.Text = STBAL.ToDate.ToString();
                cmbProvince.SelectedValue = Convert.ToInt32(STBAL.ProvinceID).ToString();
                cmbTaxRule.SelectedValue = Convert.ToInt32(STBAL.TaxRuleID).ToString();
                //txtTaxRule.Text = STBAL.TaxRule;
                txtSalesTaxYear.Text = Convert.ToDecimal(STBAL.ServiceTax).ToString();
                txtBankHold.Text = Convert.ToDecimal(STBAL.HoldTax).ToString();
                txtIncomeTax.Text = Convert.ToDecimal(STBAL.IncomeTax).ToString();
                JQ.ShowModal(this, "ModalTax");
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

            JQ.ShowDialog(this, "NewSalesTax");
        }
        else
        { JQ.showStatusMsg(this, "3", "User not Allowed to Insert New Record"); }
    }
    //protected void lbtnYes_Click(object sender, EventArgs e)
    //{
    //    SalesTax_BAL STBAL = STBLL.GetSalesTaxByID(Convert.ToInt32(lblGroupID.Text));
    //    string StarDate = STBAL.YearFrom;
    //    string EndDate = STBAL.YearTo;
    //    lblDeleteMsg.Text = STBLL.DeleteSalesTax(Convert.ToInt32(lblGroupID.Text), StarDate, EndDate);
    //    PM.BindDataGrid(GridSalesTax, STBLL.getSalesTax());
    //    lbtnYes.Visible = false;
    //    lbtnNo.Text = "Ok";s

    //}

    protected void btnConfirmation_Click(object sender, EventArgs e)
    {
        SalesTax_BAL STBAL = STBLL.GetSalesTaxByID(Convert.ToInt32(lblGroupID.Text));
        //string StarDate = Convert.ToDateTime(STBAL.FromDate).ToString();
        //string EndDate = Convert.ToDateTime(STBAL.ToDate).ToString();
        lblDeleteMsg.Text = STBLL.DeleteSalesTax(Convert.ToInt32(lblGroupID.Text));
        PM.BindDataGrid(GridSalesTax, STBLL.getSalesTax());        
        JQ.CloseModal(this, "ModalConfirmation");
        JQ.ShowStatusMsg(this, "1", "Record Deleted Successfully");
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
        { JQ.ShowStatusMsg(this, "3", "User not Allowed to Delete Record"); }
    }

    protected void GridSalesTax_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        OnLoad();
        GridSalesTax.PageIndex = e.NewPageIndex;
        GridSalesTax.DataBind();
    }

    private void SaveSalesTaxYear()
    {
        Sessions PSMSSession = (Sessions)Session["PSMSSession"];
        int CurrentSalesTaxID = txtSalesTaxYearID.Text.Equals("") ? 0 : SCGL_Common.Convert_ToInt(txtSalesTaxYearID.Text);
        int countoverlapperiod = STBLL.CountSalesTaxOverlapPeriods(CurrentSalesTaxID, SCGL_Common.CheckDateTime(txtDateFrom.Text), SCGL_Common.CheckDateTime(txtDateTo.Text));
        if (countoverlapperiod > 0)
        {
            JQ.showStatusMsg(this, "2", "Cannot add overlap period");
        }
        else
        {
            DateTime dt = DateTime.Now;
            STBLL.TaxDetailID = txtSalesTaxYearID.Text.Equals("") ? 0 : Convert.ToInt32(txtSalesTaxYearID.Text);
            STBLL.ProvinceID = Convert.ToInt32(cmbProvince.SelectedValue);
            STBLL.TaxRuleID = Convert.ToInt32(cmbTaxRule.SelectedValue);

            STBLL.FromDate = txtDateFrom.Text;
            STBLL.ToDate = txtDateTo.Text;
            //STBLL.TaxRule = txtTaxRule.Text;
            STBLL.ServiceTax = Convert.ToDecimal(txtSalesTaxYear.Text);
            STBLL.HoldTax = Convert.ToDecimal(txtBankHold.Text);
            STBLL.IncomeTax = Convert.ToDecimal(txtIncomeTax.Text);
            STBLL.User = PSMSSession.UserID;
            STBLL.Date = DateTime.Now;
            STBLL.CreateModifySalesTax(STBLL, (Sessions)Session["PSMSSession"]);
            PM.BindDataGrid(GridSalesTax, STBLL.getSalesTax());
            JQ.CloseModal(this, "ModalTax");
            btnClear_Click();
            JQ.showStatusMsg(this, "1", "Successfull Record Update");
        }
    }

    private void btnClear_Click()
    {
        cmbProvince.SelectedValue = "0";
        cmbTaxRule.SelectedValue = "0";
        txtSalesTaxYear.Text = "";
        txtDateFrom.Text = "";
        txtDateTo.Text = "";
        txtBankHold.Text = "";
        txtIncomeTax.Text = "";
    }

}
