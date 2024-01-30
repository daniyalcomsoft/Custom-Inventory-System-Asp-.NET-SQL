using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SW.SW_Common;

public partial class Purchase_VendorForm : System.Web.UI.Page
{

    VendorForm_BAL cfbal = new VendorForm_BAL();
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
                if (dtRole.Rows[row]["PageUrl"].ToString() == "Purchase/VendorForm.aspx")
                {
                    pageName = dtRole.Rows[row]["PageUrl"].ToString();
                    view = Convert.ToBoolean(dtRole.Rows[row]["Can_View"].ToString());
                    break;
                }
            }
            if (dtRole.Rows.Count > 0)
            {
                if (pageName == "Purchase/VendorForm.aspx" && view == true)
                {
                    if (Request.QueryString["Id"] != null)
                    {
                        BindControl(SCGL_Common.Convert_ToInt(Request.QueryString["Id"]));
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
    public void BindControl(int Id)
    {
        if (Request.QueryString["view"] != null)
        {
            btnSave.Visible = false;
        }
        VendorForm_BAL VendorBL = new VendorForm_BAL();
        VendorForm_BAL Vendor = VendorBL.GetVendorInfo(Id);
        txtTitle.Text = Vendor.title;
        txtfirstName.Text = Vendor.fName;
        txtlastName.Text = Vendor.lName;
        txtSuffix.Text = Vendor.Suffix;
        txtEmail.Text = Vendor.Email;
        txtCompany.Text = Vendor.CompanyName;
        txtPhone.Text = Vendor.Phone;
        txtMobile.Text = Vendor.Mobile;
        txtFax.Text = Vendor.Fax;
        txtDisplayName.Text = Vendor.DisplayName;
        txtntn.Text = Vendor.NTNNo;
        txtcnic.Text = Vendor.CNICNo;
        txtgst.Text = Vendor.GSTNo;
        txtNote.Text = Vendor.Note;
        chkPrintDispName.Checked = Vendor.displayNameClick;
        txtOther.Text = Vendor.Other;
        txtWebsite.Text = Vendor.Website;
        txtBank.Text = Vendor.BankName;
        txtAccNo.Text = Vendor.AccNo;
        TxtIBAN.Text = Vendor.IBAN;
        txtStreet.Text = Vendor.BillAddressStreet;
        txtCity.Text = Vendor.City;
        txtState.Text = Vendor.State;
        txtZip.Text = (Vendor.Zip).ToString();
        txtCountry.Text = Vendor.Country;
        chkShipAddress.Checked = Vendor.ShippingAddressCheck;
        txtShipStreet.Text = Vendor.ShippingAddressStreet;
        txtShipCity.Text = Vendor.ShippingCity;
        txtShipState.Text = Vendor.ShippingState;
        txtShipZip.Text = (Vendor.ShippingZip).ToString();
        txtShipCountry.Text = Vendor.ShippingCountry;
        txtTerms.Text = Vendor.Terms;
        txtFacebook.Text = Vendor.FacebookId;
        txtMessanger.Text = Vendor.MessangerId;
        txtSkype.Text = Vendor.SkypeId;
        txtGooglePlus.Text = Vendor.GooglePlusId;
        txtOpeningBlnc.Text = Vendor.OpeningBalance;
        txtASDate.Text =  Vendor.Date;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        save();
        emptyfiled();
        if (dt.Rows.Count > 0 && Request.QueryString["Id"]!=null)
        {
            Response.Redirect("VendorList.aspx");
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("VendorList.aspx");
    }
    public void save()
    {
        cfbal.Vendor_ID = 0;
        if (Request.QueryString["Id"] == null)
        {
            cfbal.Vendor_ID = 0;
        }
        else
        {
            cfbal.Vendor_ID = SCGL_Common.Convert_ToInt(Request.QueryString["Id"]);
        }
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
        cfbal.NTNNo = txtntn.Text;
        cfbal.CNICNo = txtcnic.Text;
        cfbal.GSTNo = txtgst.Text;
        cfbal.Note = txtNote.Text;
        if (chkPrintDispName.Checked)
        {
            cfbal.displayNameClick = true;
        }
        else
        {
            cfbal.displayNameClick = false;
        }
        cfbal.Other = txtOther.Text;
        cfbal.Website = txtWebsite.Text;
        cfbal.BankName = txtBank.Text;
        cfbal.AccNo = txtAccNo.Text;
        cfbal.IBAN = TxtIBAN.Text;
        cfbal.BillAddressStreet = txtStreet.Text;
        cfbal.City = txtCity.Text;
        cfbal.State = txtState.Text;
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
        cfbal.OpeningBalance = txtOpeningBlnc.Text;
        cfbal.Date = txtASDate.Text;
        //Here all ids from session but here problem RoleId not available in Session.
        cfbal.UserID = int.Parse(((Sessions)(Session["PSMSSession"])).UserID.ToString());
        cfbal.Site_ID = int.Parse(((Sessions)(Session["PSMSSession"])).SiteID.ToString()); 
        cfbal.RoleID = 1;

        dt = cfbal.CreateModifyVendorForm(cfbal);
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["Msg"].ToString() == "Record inserted successfully.")
            {
                JQ.ShowStatusMsg(this, "1", "Inserted");
            }
            else if(dt.Rows[0]["Msg"].ToString() == "Record updated successfully.")
            {
                JQ.ShowStatusMsg(this, "1", "Updated");
            }
            else
            {
                JQ.ShowStatusMsg(this, "2", "Error!. Please Fill the Fields");
            };
        }
    }
    DataTable dt;
    public void emptyfiled()
    {
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
        txtntn.Text = "";
        txtcnic.Text = "";
        txtgst.Text = "";
        txtNote.Text = "";
        chkPrintDispName.Checked = false; 
        txtOther.Text = ""; 
        txtWebsite.Text = ""; 
        txtBank.Text = ""; 
        txtAccNo.Text = "";
        TxtIBAN.Text = ""; 
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
    }
    public void Reload_JS()
    {
        SCGL_Common.ReloadJS(this, "MyDate();");
    }
    protected void chkShipAddress_CheckedChanged(object sender, EventArgs e)
    {
        if (chkShipAddress.Checked)
        {
            txtShipZip.ReadOnly = true;
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
