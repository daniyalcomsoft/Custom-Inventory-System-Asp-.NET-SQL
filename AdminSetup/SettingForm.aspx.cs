using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SW.SW_Common;
using System.Data;
//using CrystalDecisions.CrystalReports.Engine;
using System.Data.SqlClient;

public partial class AdminSetup_SettingForm : System.Web.UI.Page
{
   
   
    Setting_BAL BLL = new Setting_BAL();
    bool a=false;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PSMSSession"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        //txtCodelbl1.Text = titlecode.Value;
        JQ.RecallJS(this, "Load_AutoComplete_Code();");

        


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
                if (dtRole.Rows[row]["PageUrl"].ToString() == "AdminSetup/SettingForm.aspx?Id=1")
                {
                    pageName = dtRole.Rows[row]["PageUrl"].ToString();
                    view = Convert.ToBoolean(dtRole.Rows[row]["Can_View"].ToString());
                    break;
                }
            }
            if (dtRole.Rows.Count > 0)
            {
                if (pageName == "AdminSetup/SettingForm.aspx?Id=1" && view == true)
                {
                    if (Request.QueryString["Id"] != null)
                    {
                        BindControl(SCGL_Common.Convert_ToInt(Request.QueryString["Id"]));
                    }
                    else if (Request.QueryString["Id"] == null)
                    {
                        //Response.Redirect("SettingForm_Views.aspx");
                    }
                   
                    string IncomeAccount = txtIncomAcc.Text;
                   
                    string DepositAccount = txtDepositAcc.Text;
                    string CustomerAccount = txtCustomerAcc.Text;
                    string COGSAccount = txtCOGSAcc.Text;
                    string InventoryAccount = txtInvAcc.Text;
                    string InventoryAdjAccount = txtInvAdjAcc.Text;
                    string PurchaseAccount = txtPurchaseAcc.Text;
                    string PurchaseDiscAccount = txtPurchaseDiscountAcc.Text;
                    string SaleDiscAccount = txtSaleDiscountAcc.Text;
                    string ExpenseAccount = txtExpenseAcc.Text;
                    string SalesTaxAccount = txtSalesTaxAcc.Text;
                    string ShippingAccount = txtShippingAcc.Text;
                    string DetentionExpAccount = txtDetentionExpAcc.Text;
                    string ImpressedAccount = txtImpressedAcc.Text;
                    string CashAccount = txtCashAcc.Text;

                    GLCashPaymentVoucher_BAL myCode = new GLCashPaymentVoucher_BAL();
                  
                    string dsIncomeAccount = myCode.GetTitleByCodeNumber2(IncomeAccount);
                    
                    string dsDepositAccount = myCode.GetTitleByCodeNumber(DepositAccount);
                    string dsCustomerAccount = myCode.GetTitleByCodeNumber(CustomerAccount);
                    string dsCOGSAccount = myCode.GetTitleByCodeNumber2(COGSAccount);
                    string dsInventoryAccount = myCode.GetTitleByCodeNumber2(InventoryAccount);
                    string dsInventoryAdjAccount = myCode.GetTitleByCodeNumber2(InventoryAdjAccount);
                    string dsPurchaseAccount = myCode.GetTitleByCodeNumber2(PurchaseAccount);
                    string dsPurchaseDiscAccount = myCode.GetTitleByCodeNumber2(PurchaseDiscAccount);
                    string dsSaleDiscAccount = myCode.GetTitleByCodeNumber2(SaleDiscAccount);
                    string dsExpenseAccount = myCode.GetTitleByCodeNumber(ExpenseAccount);
                    string dsSalesTaxAccount = myCode.GetTitleByCodeNumber2(SalesTaxAccount);
                    string dsShippingAccount = myCode.GetTitleByCodeNumber(ShippingAccount);
                    string dsDetentionExpAccount = myCode.GetTitleByCodeNumber2(DetentionExpAccount);
                    string dsImpressedAccount = myCode.GetTitleByCodeNumber(ImpressedAccount);
                    string dsCashAccount = myCode.GetTitleByCodeNumber2(CashAccount);
                    
                    txtCodelblIncomeAccount.Text = dsIncomeAccount;
                    
                    txtCodelblDepositAccount.Text = dsDepositAccount;
                    txtCodelblCustomerAccount.Text = dsCustomerAccount;
                    txtCodelblCOGSAccount.Text = dsCOGSAccount;
                    txtCodelblInventoryAccount.Text = dsInventoryAccount;
                    txtCodelblInventoryAdjAccount.Text = dsInventoryAdjAccount;
                    txtCodelblPurchase.Text = dsPurchaseAccount;
                    txtCodelblPurchaseDiscount.Text = dsPurchaseDiscAccount;
                    txtCodelblSaleDiscount.Text = dsSaleDiscAccount;
                    txtCodelblExpense.Text = dsExpenseAccount;
                    txtCodelblSalesTax.Text = dsSalesTaxAccount;
                    txtCodelblShippingAccount.Text = dsShippingAccount;
                    txtCodelblDetentionExpAccount.Text = dsDetentionExpAccount;
                    txtCodelblImpressedAccount.Text = dsImpressedAccount;
                    txtCodelblCashAccount.Text = dsCashAccount;
                   
                    CheckAccountsinuse();
                }
                else
                {
                    Response.Redirect("Default.aspx", false);
                }
            }
 
         }

        
    }
    /// <summary>
    /// Button Progamming
    /// </summary>
    /// 

    public void CheckAccountsinuse()
    {
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        int IncomeAccount = BLL.GetCheckIncomeAccountinuse(PSMS.FinYearID);
        if (IncomeAccount > 0)
        {
            txtIncomAcc.ReadOnly = true;
        }
        else 
        {
            txtIncomAcc.ReadOnly = false;
        }
        int ReceivableAccount = BLL.GetCheckReceivableAccountinuse(PSMS.FinYearID);
        if (ReceivableAccount > 0)
        {
            txtCustomerAcc.ReadOnly = true;
        }
        else
        {
            txtCustomerAcc.ReadOnly = false;
        }
        int COGSAccount = BLL.GetCheckCOGSAccountinuse(PSMS.FinYearID);
        if (COGSAccount > 0)
        {
            txtCOGSAcc.ReadOnly = true;
        }
        else
        {
            txtCOGSAcc.ReadOnly = false;
        }
        int InventoryAccount = BLL.GetCheckInventoryAccountinuse(PSMS.FinYearID);
        if (InventoryAccount > 0)
        {
            txtInvAcc.ReadOnly = true;
        }
        else
        {
            txtInvAcc.ReadOnly = false;
        }
        int InventoryAdjAccount = BLL.GetCheckInventoryAdjAccountinuse(PSMS.FinYearID);
        if (InventoryAdjAccount > 0)
        {
            txtInvAdjAcc.ReadOnly = true;
        }
        else
        {
            txtInvAcc.ReadOnly = false;
        }
        int PurchaseAccount = BLL.GetCheckPurchaseAccountinuse(PSMS.FinYearID);
        if (PurchaseAccount > 0)
        {
            txtPurchaseAcc.ReadOnly = true;
        }
        else
        {
            txtPurchaseAcc.ReadOnly = false;
        }

        int PurchaseDiscAccount = BLL.GetCheckPurchaseDiscountAccountinuse(PSMS.FinYearID);
        if (PurchaseDiscAccount > 0)
        {
            txtPurchaseDiscountAcc.ReadOnly = true;
        }
        else
        {
            txtPurchaseDiscountAcc.ReadOnly = false;
        }

        int SaleDiscAccount = BLL.GetCheckSaleDiscountAccountinuse(PSMS.FinYearID);
        if (PurchaseDiscAccount > 0)
        {
            txtSaleDiscountAcc.ReadOnly = true;
        }
        else
        {
            txtSaleDiscountAcc.ReadOnly = false;
        }

        int ExpenseAccount = BLL.GetCheckExpenseAccountinuse(PSMS.FinYearID);
        if (ExpenseAccount > 0)
        {
            txtExpenseAcc.ReadOnly = true;
        }
        else
        {
            txtExpenseAcc.ReadOnly = false;
        }

        int SalesTaxAccount = BLL.GetCheckSalesTaxAccountinuse(PSMS.FinYearID);
        if (SalesTaxAccount > 0)
        {
            txtSalesTaxAcc.ReadOnly = true;
        }
        else
        {
            txtSalesTaxAcc.ReadOnly = false;
        }
        int ShippingAccount = BLL.GetCheckShippingAccountinuse(PSMS.FinYearID);
        if (ShippingAccount > 0)
        {
            txtShippingAcc.ReadOnly = true;
        }
        else
        {
            txtShippingAcc.ReadOnly = false;
        }
        int DetentionExpenseAccount = BLL.GetCheckDetentionExpenseAccountinuse(PSMS.FinYearID);
        if (DetentionExpenseAccount > 0)
        {
            txtDetentionExpAcc.ReadOnly = true;
        }
        else
        {
            txtDetentionExpAcc.ReadOnly = false;
        }
        int ImpressedAccount = BLL.GetCheckImpressedAccountinuse(PSMS.FinYearID);
        if (ImpressedAccount > 0)
        {
            txtImpressedAcc.ReadOnly = true;
        }
        else
        {
            txtImpressedAcc.ReadOnly = false;
        }
        int CashAccount = BLL.GetCheckCashAccountinuse(PSMS.FinYearID);
        if (CashAccount > 0)
        {
            txtCashAcc.ReadOnly = true;
        }
        else
        {
            txtCashAcc.ReadOnly = false;
        }


    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        save();
        emptyfiled();
        //if (a == true)
        //{
        Response.Redirect("/Default.aspx");
        //}
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("/Default.aspx");
    }


    /// <summary>
    /// Method Area
    /// </summary>
    public void BindControl(int Id)
    {
        if (Request.QueryString["view"] != null)
        {
            btnSave.Visible = false;
        }
        Setting_BAL Setting = BLL.GetSettingInfo(Id);
       
        txtIncomAcc.Text = Setting.InventoryIncomeAccount;
       
        txtDepositAcc.Text = Setting.DepositAccount;
        txtCustomerAcc.Text = Setting.CustomerAccount;
        txtCOGSAcc.Text = Setting.CostOfGoodsSoldAccount;
        txtInvAcc.Text = Setting.InventoryAccount;
        txtInvAdjAcc.Text = Setting.InventoryAdjAccount;
        txtPurchaseAcc.Text = Setting.PurchaseAccount;
        txtPurchaseDiscountAcc.Text = Setting.PurchaseDiscountAccount;
        txtSaleDiscountAcc.Text = Setting.SaleDiscountAccount;
        txtExpenseAcc.Text = Setting.ExpenseAccount;
        txtSalesTaxAcc.Text = Setting.SalesTaxAccount;
        txtShippingAcc.Text = Setting.ShippingAccount;
        txtDetentionExpAcc.Text = Setting.DetentionExpenseAccount;
        txtImpressedAcc.Text = Setting.ImpressedAccount;
        txtCashAcc.Text = Setting.CashAccount;
       
    }
    public void save()
    {
        BLL.Setting_Id = 0;
        if (Request.QueryString["Id"] == null)
        {
            BLL.Setting_Id = 0;
        }
        else
        {
            BLL.Setting_Id = SCGL_Common.Convert_ToInt(Request.QueryString["Id"]);
        }
        //BLL.InventoryAssetAccount = txtAsetAcc.Text;
        BLL.InventoryIncomeAccount = txtIncomAcc.Text;
        //BLL.InventoryExpenseAccount = txtExpensAcc.Text;
        BLL.DepositAccount = txtDepositAcc.Text;
        BLL.CustomerAccount = txtCustomerAcc.Text;
        BLL.CostOfGoodsSoldAccount = txtCOGSAcc.Text;
        BLL.InventoryAccount = txtInvAcc.Text;
        BLL.InventoryAdjAccount = txtInvAdjAcc.Text;
        BLL.PurchaseAccount = txtPurchaseAcc.Text;
        BLL.PurchaseDiscountAccount = txtPurchaseDiscountAcc.Text;
        BLL.SaleDiscountAccount = txtSaleDiscountAcc.Text;
        BLL.ExpenseAccount = txtExpenseAcc.Text;
        BLL.SalesTaxAccount = txtSalesTaxAcc.Text;
        BLL.ShippingAccount = txtShippingAcc.Text;
        BLL.DetentionExpenseAccount = txtDetentionExpAcc.Text;
        BLL.ImpressedAccount = txtImpressedAcc.Text;
        BLL.CashAccount = txtCashAcc.Text;
        a = BLL.CreateModifySetting(BLL);
    }
    public void emptyfiled()
    {
        txtAsetAcc.Text = "";
        txtIncomAcc.Text = "";
        txtDepositAcc.Text = "";
        txtCustomerAcc.Text = "";
        txtCOGSAcc.Text = "";
        txtInvAcc.Text = "";
        txtInvAdjAcc.Text = "";
        txtPurchaseAcc.Text = "";
        txtPurchaseDiscountAcc.Text = "";
        txtSaleDiscountAcc.Text = "";
        txtExpenseAcc.Text = "";
        txtSalesTaxAcc.Text = "";
        txtShippingAcc.Text = "";
        txtDetentionExpAcc.Text = "";
        txtImpressedAcc.Text = "";
        txtCashAcc.Text = "";
    }




    protected void txtIncomAcc_TextChanged(object sender, EventArgs e)
    {
        string IncomeAccount = txtIncomAcc.Text;
        GLCashPaymentVoucher_BAL myCode = new GLCashPaymentVoucher_BAL();
        string dsIncomeAccount = myCode.GetTitleByCodeNumber2(IncomeAccount);
        txtCodelblIncomeAccount.Text = dsIncomeAccount;
        if (txtCodelblIncomeAccount.Text == "")
        {
            txtCodelblIncomeAccount.Text = "Incorrect Code!!!";

        }
        if (txtCodelblIncomeAccount.Text == "Incorrect Code!!!")
        {
            btnSave.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
        }

    }

    protected void txtDepositAcc_TextChanged(object sender, EventArgs e)
    {
        string DepositAccount = txtDepositAcc.Text;
        GLCashPaymentVoucher_BAL myCode = new GLCashPaymentVoucher_BAL();
        string dsDepositAccount = myCode.GetTitleByCodeNumber(DepositAccount);
        txtCodelblDepositAccount.Text = dsDepositAccount;
        if (txtCodelblDepositAccount.Text == "")
        {
            txtCodelblDepositAccount.Text = "Incorrect Code!!!";
        }
        if (txtCodelblDepositAccount.Text == "Incorrect Code!!!")
        {
            btnSave.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
        }
    }
    protected void txtCustomerAcc_TextChanged(object sender, EventArgs e)
    {
        string CustomerAccount = txtCustomerAcc.Text;
        GLCashPaymentVoucher_BAL myCode = new GLCashPaymentVoucher_BAL();
        string dsCustomerAccount = myCode.GetTitleByCodeNumber(CustomerAccount);
        txtCodelblCustomerAccount.Text = dsCustomerAccount;
        if (txtCodelblCustomerAccount.Text == "")
        {
            txtCodelblCustomerAccount.Text = "Incorrect Code!!!";
        }
        if (txtCodelblCustomerAccount.Text == "Incorrect Code!!!")
        {
            btnSave.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
        }
    }
    protected void txtCOGSAcc_TextChanged(object sender, EventArgs e)
    {
        string COGSAccount = txtCOGSAcc.Text;
        GLCashPaymentVoucher_BAL myCode = new GLCashPaymentVoucher_BAL();
        string dsCOGSAccount = myCode.GetTitleByCodeNumber2(COGSAccount);
        txtCodelblCOGSAccount.Text = dsCOGSAccount;
        if (txtCodelblCOGSAccount.Text == "")
        {
            txtCodelblCOGSAccount.Text = "Incorrect Code!!!";
        }
        if (txtCodelblCOGSAccount.Text == "Incorrect Code!!!")
        {
            btnSave.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
        }
    }
    protected void txtInvAcc_TextChanged(object sender, EventArgs e)
    {
        string InventoryAccount = txtInvAcc.Text;
        GLCashPaymentVoucher_BAL myCode = new GLCashPaymentVoucher_BAL();
        string dsInventoryAccount = myCode.GetTitleByCodeNumber2(InventoryAccount);
        txtCodelblInventoryAccount.Text = dsInventoryAccount;
        if (txtCodelblInventoryAccount.Text == "")
        {
            txtCodelblInventoryAccount.Text = "Incorrect Code!!!";
        }
        if (txtCodelblInventoryAccount.Text == "Incorrect Code!!!")
        {
            btnSave.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
        }
    }

    protected void txtInvAdjAcc_TextChanged(object sender, EventArgs e)
    {
        string InventoryAdjAccount = txtInvAdjAcc.Text;
        GLCashPaymentVoucher_BAL myCode = new GLCashPaymentVoucher_BAL();
        string dsInventoryAdjAccount = myCode.GetTitleByCodeNumber2(InventoryAdjAccount);
        txtCodelblInventoryAdjAccount.Text = dsInventoryAdjAccount;
        if (txtCodelblInventoryAdjAccount.Text == "")
        {
            txtCodelblInventoryAdjAccount.Text = "Incorrect Code!!!";
        }
        if (txtCodelblInventoryAdjAccount.Text == "Incorrect Code!!!")
        {
            btnSave.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
        }
    }

    protected void txtPurchaseAcc_TextChanged(object sender, EventArgs e)
    {
        string PurchaseAccount = txtPurchaseAcc.Text;
        GLCashPaymentVoucher_BAL myCode = new GLCashPaymentVoucher_BAL();
        string dsPurchaseAccount = myCode.GetTitleByCodeNumber2(PurchaseAccount);
        txtCodelblPurchase.Text = dsPurchaseAccount;
        if (txtCodelblPurchase.Text == "")
        {
            txtCodelblPurchase.Text = "Incorrect Code!!!";
        }
        if (txtCodelblPurchase.Text == "Incorrect Code!!!")
        {
            btnSave.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
        }
    }

    protected void txtPurchaseDiscountAcc_TextChanged(object sender, EventArgs e)
    {
        string PurchaseDiscAccount = txtPurchaseDiscountAcc.Text;
        GLCashPaymentVoucher_BAL myCode = new GLCashPaymentVoucher_BAL();
        string dsPurchaseDiscAccount = myCode.GetTitleByCodeNumber2(PurchaseDiscAccount);
        txtCodelblPurchaseDiscount.Text = dsPurchaseDiscAccount;
        if (txtCodelblPurchaseDiscount.Text == "")
        {
            txtCodelblPurchaseDiscount.Text = "Incorrect Code!!!";
        }
        if (txtCodelblPurchaseDiscount.Text == "Incorrect Code!!!")
        {
            btnSave.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
        }
    }

    protected void txtSaleDiscountAcc_TextChanged(object sender, EventArgs e)
    {
        string SaleDiscAccount = txtSaleDiscountAcc.Text;
        GLCashPaymentVoucher_BAL myCode = new GLCashPaymentVoucher_BAL();
        string dsSaleDiscAccount = myCode.GetTitleByCodeNumber2(SaleDiscAccount);
        txtCodelblSaleDiscount.Text = dsSaleDiscAccount;
        if (txtCodelblSaleDiscount.Text == "")
        {
            txtCodelblSaleDiscount.Text = "Incorrect Code!!!";
        }
        if (txtCodelblSaleDiscount.Text == "Incorrect Code!!!")
        {
            btnSave.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
        }
    }

    protected void txtExpenseAcc_TextChanged(object sender, EventArgs e)
    {
        string ExpenseAccount = txtExpenseAcc.Text;
        GLCashPaymentVoucher_BAL myCode = new GLCashPaymentVoucher_BAL();
        string dsExpenseAccount = myCode.GetTitleByCodeNumber(ExpenseAccount);
        txtCodelblExpense.Text = dsExpenseAccount;
        if (txtCodelblExpense.Text == "")
        {
            txtCodelblExpense.Text = "Incorrect Code!!!";
        }
        if (txtCodelblExpense.Text == "Incorrect Code!!!")
        {
            btnSave.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
        }
    }

    protected void txtSalesTaxAcc_TextChanged(object sender, EventArgs e)
    {
        string SalesTaxAccount = txtSalesTaxAcc.Text;
        GLCashPaymentVoucher_BAL myCode = new GLCashPaymentVoucher_BAL();
        string dsSalesTaxAccount = myCode.GetTitleByCodeNumber2(SalesTaxAccount);
        txtCodelblSalesTax.Text = dsSalesTaxAccount;
        if (txtCodelblSalesTax.Text == "")
        {
            txtCodelblSalesTax.Text = "Incorrect Code!!!";
        }
        if (txtCodelblSalesTax.Text == "Incorrect Code!!!")
        {
            btnSave.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
        }
    }

    protected void txtShippingAcc_TextChanged(object sender, EventArgs e)
    {
        string ShippingAccount = txtShippingAcc.Text;
        GLCashPaymentVoucher_BAL myCode = new GLCashPaymentVoucher_BAL();
        string dsShippingAccount = myCode.GetTitleByCodeNumber(ShippingAccount);
        txtCodelblShippingAccount.Text = dsShippingAccount;
        if (txtCodelblShippingAccount.Text == "")
        {
            txtCodelblShippingAccount.Text = "Incorrect Code!!!";
        }
        if (txtCodelblShippingAccount.Text == "Incorrect Code!!!")
        {
            btnSave.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
        }
    }

    protected void txtDetentionExpAcc_TextChanged(object sender, EventArgs e)
    {
        string DetentionExpAccount = txtDetentionExpAcc.Text;
        GLCashPaymentVoucher_BAL myCode = new GLCashPaymentVoucher_BAL();
        string dsDetentionExpAccount = myCode.GetTitleByCodeNumber2(DetentionExpAccount);
        txtCodelblDetentionExpAccount.Text = dsDetentionExpAccount;
        if (txtCodelblDetentionExpAccount.Text == "")
        {
            txtCodelblDetentionExpAccount.Text = "Incorrect Code!!!";

        }
        if (txtCodelblDetentionExpAccount.Text == "Incorrect Code!!!")
        {
            btnSave.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
        }

    }
    protected void txtImpressedAcc_TextChanged(object sender, EventArgs e)
    {
        string ImpressedAccount = txtImpressedAcc.Text;
        GLCashPaymentVoucher_BAL myCode = new GLCashPaymentVoucher_BAL();
        string dsImpressedAccount = myCode.GetTitleByCodeNumber(ImpressedAccount);
        txtCodelblImpressedAccount.Text = dsImpressedAccount;
        if (txtCodelblImpressedAccount.Text == "")
        {
            txtCodelblImpressedAccount.Text = "Incorrect Code!!!";
        }
        if (txtCodelblImpressedAccount.Text == "Incorrect Code!!!")
        {
            btnSave.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
        }
    }

    protected void txtCashAcc_TextChanged(object sender, EventArgs e)
    {
        string CashAccount = txtCashAcc.Text;
        GLCashPaymentVoucher_BAL myCode = new GLCashPaymentVoucher_BAL();
        string dsCashAccount = myCode.GetTitleByCodeNumber2(CashAccount);
        txtCodelblCashAccount.Text = dsCashAccount;
        if (txtCodelblCashAccount.Text == "")
        {
            txtCodelblCashAccount.Text = "Incorrect Code!!!";

        }
        if (txtCodelblCashAccount.Text == "Incorrect Code!!!")
        {
            btnSave.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
        }

    }

}
