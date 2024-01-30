using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminSetup_TaxInfo : System.Web.UI.Page
{
    TaxInfo_BLL BL = new TaxInfo_BLL();
    SalesTax_BAL SBL = new SalesTax_BAL();
    static DataTable diTable;
    Sessions PSMS = new Sessions();
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
                if (dtRole.Rows[row]["PageUrl"].ToString() == "AdminSetup/TaxInfo.aspx")
                {
                    pageName = dtRole.Rows[row]["PageUrl"].ToString();
                    view = Convert.ToBoolean(dtRole.Rows[row]["Can_View"].ToString());
                    break;
                }
            }
            if (dtRole.Rows.Count > 0)
            {
                if (pageName == "AdminSetup/TaxInfo.aspx" && view == true)
                {
                    PM.Bind_DropDown(cmbProvince, new Province_BLL().GetProvinceList(DBNull.Value), "Province", "ProvinceID");
                    //PM.Bind_DropDown(ddprovince, new Province_BLL().GetProvinceList(DBNull.Value), "Province", "ProvinceID");
                    //PM.Bind_DropDown(cmbTaxRule, new TaxInfo_BLL().GetTaxList(DBNull.Value), "TaxRule", "TaxRuleID");
                    fillGrid();


                }
                else
                {
                    Response.Redirect("Default.aspx", false);
                }
            }
            
        }
        selectinit();
    }

    public void selectinit()
    {
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), "selectpic();", true);
    }

    public void fillGrid()
    {
        Sessions PSMSSession = (Sessions)Session["PSMSSession"];
        grd.DataSource = BL.GetTaxListbySearch((object)DBNull.Value, (object)DBNull.Value, (object)DBNull.Value);
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
        var Tax = BL.GetTaxList(e.CommandArgument);
        if (Tax.Rows.Count > 0)
        {
            hdID.Value = Tax.Rows[0]["TaxRuleID"].ToString();
            txtRuleTax.Text = Tax.Rows[0]["TaxRule"].ToString();
            cmbProvince.SelectedValue = Convert.ToInt32(Tax.Rows[0]["ProvinceID"]).ToString();
            btnSave.Visible = true;
            JQ.ShowModal(this, "ModalTax");
        }

    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        Sessions PSMSSession = (Sessions)Session["PSMSSession"];

        BL.TaxRuleID = hdID.Value == "" ? 0 : Convert.ToInt32(hdID.Value);
        BL.TaxRule = txtRuleTax.Text;
        BL.ProvinceID = Convert.ToInt32(cmbProvince.SelectedValue);
        BL.User = PSMSSession.UserID;
        BL.Date = DateTime.Now;
        BL.InsertUpdateTax(BL);
        hdID.Value = "";
        fillGrid();
        JQ.CloseModal(this, "ModalTax");
        JQ.ShowStatusMsg(this.Page, "1", "Tax Saved Successfully.");
    }


    protected void btnDelete_Command(object sender, CommandEventArgs e)
    {

        int TaxRuleID = Convert.ToInt32(e.CommandArgument);

        try
        {
            BL.TaxDelete(TaxRuleID);
            fillGrid();
            JQ.ShowStatusMsg(this.Page, "1", "Tax Deleted Successfully.");
        }
        catch(Exception ex)
        {
            JQ.ShowStatusMsg(this.Page, "4", "Tax used in Branch.");
        }

       

    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        TextBox txtSearchTaxRuleID = (TextBox)grd.HeaderRow.FindControl("txtSearchTaxRuleID");
        TextBox txtSearchTax = (TextBox)grd.HeaderRow.FindControl("txtSearchTax");
        TextBox txtProvince = (TextBox)grd.HeaderRow.FindControl("txtProvince");




        if (string.IsNullOrEmpty(txtSearchTaxRuleID.Text) && string.IsNullOrEmpty(txtSearchTax.Text) && string.IsNullOrEmpty(txtProvince.Text))

            fillGrid();
        else
        {
            grd.DataSource = BL.GetTaxListbySearch(
               string.IsNullOrEmpty(txtSearchTaxRuleID.Text) ? (object)DBNull.Value : txtSearchTaxRuleID.Text,
               string.IsNullOrEmpty(txtSearchTax.Text) ? (object)DBNull.Value : txtSearchTax.Text,
               string.IsNullOrEmpty(txtProvince.Text) ? (object)DBNull.Value : txtProvince.Text
               );




            grd.DataBind();

            setValues(txtSearchTaxRuleID.Text, txtSearchTax.Text, txtProvince.Text);

        }
    }
    public void setValues(string TaxRuleID, string TaxRule, string Province)
    {
        TextBox txtSearchTaxRuleID = (TextBox)grd.HeaderRow.FindControl("txtSearchTaxRuleID");
        TextBox txtSearchTax = (TextBox)grd.HeaderRow.FindControl("txtSearchTax");
        TextBox txtProvince = (TextBox)grd.HeaderRow.FindControl("txtProvince");

        txtSearchTaxRuleID.Text = TaxRuleID;
        txtSearchTax.Text = TaxRule;
        txtProvince.Text = Province;

    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        setValues(string.Empty, string.Empty, string.Empty);
        fillGrid();
    }

    protected void btnAddInfo_Click(object sender, EventArgs e)
    {
        CreateTaxDetailInfo();
    }

    private void CreateTaxDetailInfo()
    {
        try
        {
            if(!string.IsNullOrEmpty(txtRule.Text) && !string.IsNullOrEmpty(txtProv.Text))
            {
                if(diTable == null)
                {
                    diTable = new DataTable("TaxDetails");
                    //Add Columns
                    diTable.Columns.Add("TaxDetailID", typeof(int));
                    diTable.PrimaryKey = new DataColumn[] { diTable.Columns["TaxDetailID"] };
                    diTable.Columns.Add("FromDate", typeof(DateTime));
                    diTable.Columns.Add("ToDate", typeof(DateTime));
                    diTable.Columns.Add("ServiceTax", typeof(decimal));
                    diTable.Columns.Add("HoldTax", typeof(decimal));
                    diTable.Columns.Add("IncomeTax", typeof(decimal));

                }

                int CurrentSalesTaxID = txtSalesTaxYearID.Text.Equals("") ? 0 : Convert.ToInt32(txtSalesTaxYearID.Text);
                int countoverlapperiod = SBL.CountSalesTaxOverlapPeriods(CurrentSalesTaxID, Convert.ToDateTime(txtDateFrom.Text), Convert.ToDateTime(txtDateTo.Text));
                if (countoverlapperiod > 0)
                {
                    JQ.showStatusMsg(this, "2", "Cannot add overlap period");
                }
                else
                {

                    SBL.TaxRuleID = hdID.Value == "" ? 0 : Convert.ToInt32(hdID.Value);
                    //SBL.TaxRuleID = Convert.ToInt32(hdID.Value);
                    SBL.ProvinceID = Convert.ToInt32(cmbProvince.SelectedValue);
                    SBL.Province = txtProv.Text;

                    SBL.TaxDetailID = txtSalesTaxYearID.Text.Equals("") ? 0 : Convert.ToInt32(txtSalesTaxYearID.Text);
                    SBL.FromDate = txtDateFrom.Text;
                    SBL.ToDate = txtDateTo.Text;
                    SBL.ServiceTax = Convert.ToDecimal(txtSalesTaxYear.Text);
                    SBL.HoldTax = Convert.ToDecimal(txtBankHold.Text);
                    SBL.IncomeTax = Convert.ToDecimal(txtIncomeTax.Text);
                    SBL.User = PSMS.UserID;
                    SBL.Date = DateTime.Now;
                    SBL.CreateModifySalesTax(SBL, (Sessions)Session["PSMSSession"]);
                }
                OnLoad();
                btnClear_Click();

                //DataRow dr = diTable.NewRow();
                //dr["TaxDetailID"] = Convert.ToInt32(hfSalesTaxID.Value);
                //dr["FromDate"] = txtDateFrom.Text;
                //dr["ToDate"] = txtDateTo.Text;
                //dr["ServiceTax"] = txtSalesTaxYear.Text;
                //dr["HoldTax"] = txtBankHold.Text;
                //dr["IncomeTax"] = txtIncomeTax.Text;
                //diTable.Rows.Add(dr);
                //grdTaxDetails.DataSource = diTable;
                //grdTaxDetails.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }

    private void OnLoad()
    {
        PM.BindDataGrid(grdTaxDetails, SBL.GetTaxDetailByTaxRule(hdID.Value));
    }

    protected void btnClosed_Click(object sender, EventArgs e)
    {

    }

    protected void btnInfoSave_Click(object sender, EventArgs e)
    {

    }

    protected void btnTaxDetailDelete_Command(object sender, CommandEventArgs e)
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

    protected void btnTaxDetailInfo_Command(object sender, CommandEventArgs e)
    {
        JQ.ShowModal(this, "ModalDeal");
        var Tax = BL.GetTaxList(e.CommandArgument);
        if (Tax.Rows.Count > 0)
        {
            hdID.Value = Tax.Rows[0]["TaxRuleID"].ToString();
            txtRule.Text = txtRuleTax.Text = Tax.Rows[0]["TaxRule"].ToString();
            txtProv.Text = cmbProvince.SelectedValue = Convert.ToInt32(Tax.Rows[0]["ProvinceID"]).ToString();
            txtProv.Text = Tax.Rows[0]["Province"].ToString();
            btnSave.Visible = true;
        }
        OnLoad();
    }

    protected void btnEditTaxDetails_Command(object sender, CommandEventArgs e)
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        if (PSMS.Can_Update == true)
        {
            if (e.CommandArgument.ToString() != "")
            {
                SalesTax_BAL STBAL = SBL.GetSalesTaxByID(Convert.ToInt32(e.CommandArgument));

                txtSalesTaxYearID.Text = Convert.ToInt32(STBAL.TaxDetailID).ToString();
                txtDateFrom.Text = STBAL.FromDate.ToString();
                txtDateTo.Text = STBAL.ToDate.ToString();               
                txtSalesTaxYear.Text = Convert.ToDecimal(STBAL.ServiceTax).ToString();
                txtBankHold.Text = Convert.ToDecimal(STBAL.HoldTax).ToString();
                txtIncomeTax.Text = Convert.ToDecimal(STBAL.IncomeTax).ToString();
                //JQ.ShowModal(this, "ModalTax");
            }
        }
        else
        { JQ.showStatusMsg(this, "3", "User not Allowed to Update Record"); }
    }

    private void btnClear_Click()
    {
        txtSalesTaxYearID.Text = "";
        txtSalesTaxYear.Text = "";
        txtDateFrom.Text = "";
        txtDateTo.Text = "";
        txtBankHold.Text = "";
        txtIncomeTax.Text = "";
    }

    protected void btnConfirmation_Click(object sender, EventArgs e)
    {
        SalesTax_BAL STBAL = SBL.GetSalesTaxByID(Convert.ToInt32(lblGroupID.Text));
        lblDeleteMsg.Text = SBL.DeleteSalesTax(Convert.ToInt32(lblGroupID.Text));
        //PM.BindDataGrid(grdTaxDetails, SBL.getSalesTax());
        OnLoad();
        JQ.CloseModal(this, "ModalConfirmation");
        JQ.ShowStatusMsg(this, "1", "Record Deleted Successfully");
    }
}