using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SW.SW_Common;
using System.Data.SqlClient;

public partial class Sales_CustomerForm : System.Web.UI.Page
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
                if (dtRole.Rows[row]["PageUrl"].ToString() == "Sales/CustomerForm.aspx")
                {
                    pageName = dtRole.Rows[row]["PageUrl"].ToString();
                    view = Convert.ToBoolean(dtRole.Rows[row]["Can_View"].ToString());
                    break;
                }
            }
            if (dtRole.Rows.Count > 0)
            {
                if (pageName == "Sales/CustomerForm.aspx" && view == true)
                {
                    PM.Bind_DropDown(cmbCusType, new CustomerType_BAL().GetCustomerTypeList(DBNull.Value), "CustomerType", "CustomerTypeID");
                    PM.Bind_DropDown(cmbTaxCompany, new SalesTax_BAL().GetSalesTax(DBNull.Value), "TaxRuleProvince", "TaxRuleID");
                    if (Request.QueryString["Id"] != null)
                    {
                        BindControl(Convert.ToInt32(Request.QueryString["Id"]));
                    }
                    else
                    {
                    }
                }
                else
                {
                    Response.Redirect("Default.aspx", false);
                }
            }
            
        }
        Reload_JS();        
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        DataTable dt = PM.getFinancialYearByID(PSMS.FinYearID);
        hdnMinDate.Value = SCGL_Common.CheckDateTime(dt.Rows[0]["yearFrom"]).ToShortDateString();
        hdnMaxDate.Value = SCGL_Common.CheckDateTime(dt.Rows[0]["YearTo"]).ToShortDateString();
    }

    public void Reload_JS()
    {
        SCGL_Common.ReloadJS(this, "MyDate();");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        save();
        emptyfiled();
        if (dt.Rows.Count > 0 && Request.QueryString["Id"] != null)
        {
            Response.Redirect("CustomerForm_Views.aspx");
        }

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("CustomerForm_Views.aspx");
    }
    public void save()
    {
        int Success = 0;
        SqlConnection con = new SqlConnection(ConnectionString.PSMS);
        con.Open();
        SqlTransaction trans = con.BeginTransaction();
        CustomerForm_BAL cfbal = new CustomerForm_BAL();
        try
        {
            cfbal.CustomerID = 0;
            if (Request.QueryString["Id"] == null)
            {
                cfbal.CustomerID = 0;
            }
            else
            {
                cfbal.CustomerID = Convert.ToInt32(Request.QueryString["Id"]);
            }
            cfbal.CustomerTypeID = Convert.ToInt32(cmbCusType.SelectedValue);
            cfbal.TaxRuleID = Convert.ToInt32(cmbTaxCompany.SelectedValue);
            cfbal.title = txtTitle.Text;
            cfbal.fName = txtfirstName.Text;
            cfbal.lName = txtlastName.Text;
            cfbal.Suffix = txtSuffix.Text;
            cfbal.Email = txtEmail.Text;
            cfbal.CompanyName = txtCompany.Text;
            cfbal.Phone = txtPhone.Text;
            cfbal.Mobile = txtMobile.Text;
            cfbal.Fax = txtFax.Text;
            cfbal.DisplayName = txtDisplayName.Text;
            if (chkPrintDispName.Checked)
            {
                cfbal.displayNameClick = true;
            }
            else
            {
                cfbal.displayNameClick = false;
            }
            cfbal.NTN = txtNTN.Text;
            cfbal.SalesTaxRegNo = txtSalesTaxReg.Text;
            cfbal.BankName = txtBank.Text;
            cfbal.AccNo = txtAccNo.Text;
            cfbal.IBAN = TxtIBAN.Text;
            cfbal.Note = txtNote.Text;
            cfbal.BillAddressStreet = txtStreet.Text;
            cfbal.City = txtCity.Text;
            cfbal.State = txtState.Text;
            cfbal.PortofDischarge = txtportofdischarge.Text;
            cfbal.DestCountry = txtdestination.Text;
            cfbal.Consignee = txtconsignee.Text;
            cfbal.Buyer = txtbuyer.Text;
            if (txtZip.Text == "")
            {
                cfbal.Zip = 00000;
            }
            else
            {
                cfbal.Zip = Convert.ToInt32(txtZip.Text);
            }
            cfbal.Country = txtCountry.Text;
            if (chkShipAddress.Checked)
            {
                cfbal.ShippingAddressStreet = "null";
                cfbal.ShippingCity = "null";
                cfbal.ShippingState = "null";
                cfbal.ShippingZip = 00000;
                cfbal.ShippingCountry = "null";
            }
            else
            {
                cfbal.ShippingAddressStreet = txtShipStreet.Text;
                cfbal.ShippingCity = txtShipCity.Text;
                cfbal.ShippingState = txtShipState.Text;
                if (txtShipZip.Text == "")
                {
                    cfbal.ShippingZip = 00000;
                }
                else
                {
                    cfbal.ShippingZip = Convert.ToInt32(txtShipZip.Text);
                }
                cfbal.ShippingCountry = txtShipCountry.Text;
            }
            cfbal.Terms = txtTerms.Text;
            cfbal.FacebookId = txtFacebook.Text;
            cfbal.MessangerId = txtMessanger.Text;
            cfbal.SkypeId = txtSkype.Text;
            cfbal.GooglePlusId = txtGooglePlus.Text;
            cfbal.OpeningBalance = SCGL_Common.Convert_ToDecimal(txtOpeningBlnc.Text);
            cfbal.Date = txtASDate.Text;

            dt = cfbal.CreateModifyCustForm(cfbal, trans);

            if (cfbal.CustomerID == 0)
            {
                cfbal.CustID = SCGL_Common.Convert_ToInt(dt.Rows[0]["ID"].ToString());
                string CustomerAccount = cfbal.GetCustomerAccount(trans);

                //string MCode = ddlGLAccount.SelectedValue.Substring(0, 3);
                //string MCode = "04";
                string MCode = CustomerAccount.Substring(0, 2);
                cfbal.MainCode = MCode;
                //string CCode = ddlGLAccount.SelectedValue.Substring(3, 3);
                //string CCode = "004";
                string CCode = CustomerAccount.Substring(2, 3);
                cfbal.ControlCode = CCode;
                // chek exist of not if exist + 1 in max sucsidarycode  
                int SubSidiary_RecordCount = cfbal.SpSubsidiaryCodeCount(cfbal, trans);
                if (SubSidiary_RecordCount != 0)
                {
                    if (SubSidiary_RecordCount < 9)
                    {
                        SubSidiary_RecordCount = SubSidiary_RecordCount + 1;
                        cfbal.SubsidaryCode = "000" + SubSidiary_RecordCount;
                    }
                    else if (SubSidiary_RecordCount == 9)
                    {
                        SubSidiary_RecordCount = SubSidiary_RecordCount + 1;
                        cfbal.SubsidaryCode = "00" + SubSidiary_RecordCount;

                    }
                    else if (SubSidiary_RecordCount > 9 && SubSidiary_RecordCount < 99)
                    {
                        SubSidiary_RecordCount = SubSidiary_RecordCount + 1;
                        cfbal.SubsidaryCode = "00" + SubSidiary_RecordCount;

                    }
                    else if (SubSidiary_RecordCount == 99)
                    {
                        SubSidiary_RecordCount = SubSidiary_RecordCount + 1;
                        cfbal.SubsidaryCode = "0" + SubSidiary_RecordCount;

                    }
                    else if (SubSidiary_RecordCount > 99 && SubSidiary_RecordCount < 999)
                    {
                        SubSidiary_RecordCount = SubSidiary_RecordCount + 1;
                        cfbal.SubsidaryCode = "0" + SubSidiary_RecordCount;

                    }
                    else
                    {
                        SubSidiary_RecordCount = SubSidiary_RecordCount + 1;
                        cfbal.SubsidaryCode = SubSidiary_RecordCount.ToString();

                    }
                }
                else
                {
                    cfbal.SubsidaryCode = "0001";
                }
                //cfbal.Title = "Customer" + cfbal.SubsidaryCode;
                cfbal.Title = cfbal.DisplayName;
                cfbal.Code = MCode + CCode + cfbal.SubsidaryCode;

                if (cfbal.SubsidaryCode != "10000")
                {
                    cfbal.InsertApartSubsidiary(cfbal, trans);
                    Success = 1;
                }
                else
                {
                    trans.Rollback();
                    JQ.showStatusMsg(this, "2", "You cannot Create Control Accounts more than 9999");
                }
            }
            else 
            {
                cfbal.UpdateSubsidiary(cfbal, trans);
                Success = 1;
            }

           
                if (dt.Rows.Count > 0 && Success != 0)
                {
                    if ((dt.Rows[0]["Msg"].ToString() == "Record inserted successfully." && dt.Rows[0]["ID"].ToString() != "0"))
                    {
                   
                    trans.Commit();
                    JQ.ShowStatusMsg(this, "1", "Record Inserted Successfully");
                    }
                    else if((dt.Rows[0]["Msg"].ToString() == "Record updated successfully." && dt.Rows[0]["ID"].ToString() != "0"))
                    {
                    trans.Commit();
                    JQ.ShowStatusMsg(this, "1", "Record Updated Successfully");
                    }
                    else
                    {
                    
                    trans.Rollback();
                    JQ.ShowStatusMsg(this, "2", "Error!. Please Fill the Fields");
                }
                }
            
        }
        catch (Exception e)
        {
            trans.Rollback();
            throw;
        }
        finally 
        {
            con.Close();
        }
    }
    DataTable dt;

    public void BindControl(int Id)
    {
        if (Request.QueryString["view"] != null)
        {
            btnSave.Visible = false;
        }
        CustomerForm_BAL CustBL = new CustomerForm_BAL();
        CustomerForm_BAL Customer = CustBL.GetCustomerInfo(Id);
        cmbCusType.SelectedValue = Convert.ToInt32(Customer.CustomerTypeID).ToString();
        cmbCusType.SelectedValue = Convert.ToInt32(Customer.TaxRuleID).ToString();
        txtTitle.Text = Customer.title;
        txtfirstName.Text = Customer.fName;
        txtlastName.Text = Customer.lName;
        txtSuffix.Text = Customer.Suffix;
        txtEmail.Text = Customer.Email;
        txtCompany.Text = Customer.CompanyName;
        txtPhone.Text = Customer.Phone;
        txtMobile.Text = Customer.Mobile;
        txtFax.Text = Customer.Fax;
        txtDisplayName.Text = Customer.DisplayName;
        chkPrintDispName.Checked = Customer.displayNameClick;
        txtNTN.Text = Customer.NTN;
        txtSalesTaxReg.Text = Customer.SalesTaxRegNo;
        txtBank.Text = Customer.BankName;
        txtAccNo.Text = Customer.AccNo;
        TxtIBAN.Text = Customer.IBAN;
        txtNote.Text = Customer.Note;
        txtStreet.Text = Customer.BillAddressStreet;
        txtCity.Text = Customer.City;
        txtState.Text = Customer.State;
        txtZip.Text = (Customer.Zip).ToString();
        txtCountry.Text = Customer.Country;
        chkShipAddress.Checked = Customer.ShippingAddressCheck;
        txtShipStreet.Text = Customer.ShippingAddressStreet;
        txtShipCity.Text = Customer.ShippingCity;
        txtShipState.Text = Customer.ShippingState;
        txtShipZip.Text = (Customer.ShippingZip).ToString();
        txtShipCountry.Text = Customer.ShippingCountry;
        txtTerms.Text = Customer.Terms;
        txtFacebook.Text = Customer.FacebookId;
        txtMessanger.Text = Customer.MessangerId;
        txtSkype.Text = Customer.SkypeId;
        txtGooglePlus.Text = Customer.GooglePlusId;
        txtOpeningBlnc.Text =SCGL_Common.Convert_ToDecimal(Customer.OpeningBalance).ToString();
        txtASDate.Text = Customer.Date;
        txtportofdischarge.Text = Customer.PortofDischarge;
        txtdestination.Text = Customer.DestCountry;
        txtconsignee.Text = Customer.Consignee;
        txtbuyer.Text = Customer.Buyer;
    }

    public void emptyfiled()
    {
        cmbCusType.SelectedValue = "0";
        cmbTaxCompany.SelectedValue = "0";
        txtTitle.Text = "";
        txtfirstName.Text = "";
        txtlastName.Text = "";
        txtSuffix.Text = "";
        txtEmail.Text = "";
        txtCompany.Text = "";
        txtPhone.Text = "";
        txtMobile.Text = "";
        txtFax.Text = "";
        txtDisplayName.Text = "";
        chkPrintDispName.Checked = false;
        txtNTN.Text = "";
        txtSalesTaxReg.Text = "";
        txtBank.Text = "";
        txtAccNo.Text = "";
        TxtIBAN.Text = "";
        txtNote.Text = "";
        txtStreet.Text = "";
        txtCity.Text = "";
        txtState.Text = "";
        txtZip.Text = "";
        txtCountry.Text = "";
        chkShipAddress.Checked = false;
        txtShipStreet.Text = "";
        txtShipCity.Text = "";
        txtShipState.Text = "";
        txtShipZip.Text = "";
        txtShipCountry.Text = "";
        txtTerms.Text = "";
        txtFacebook.Text = "";
        txtMessanger.Text = "";
        txtSkype.Text = "";
        txtGooglePlus.Text = "";
        txtOpeningBlnc.Text = "";
        txtASDate.Text = "";
        txtportofdischarge.Text = "";
        txtdestination.Text = "";
        txtconsignee.Text = "";
        txtbuyer.Text = "";
    }

    protected void chkShipAddress_CheckedChanged(object sender, EventArgs e)
    {
        if (chkShipAddress.Checked)
        {
            txtShipZip.ReadOnly=true;
            txtShipCity.ReadOnly = true;
            txtShipState.ReadOnly = true;
            txtShipStreet.ReadOnly = true;
            txtShipCountry.ReadOnly = true;
        }
        else
        {
            txtShipZip.ReadOnly = false;
            txtShipCity.ReadOnly = false;
            txtShipState.ReadOnly = false;
            txtShipStreet.ReadOnly = false;
            txtShipCountry.ReadOnly = false;
        }
    }
}
