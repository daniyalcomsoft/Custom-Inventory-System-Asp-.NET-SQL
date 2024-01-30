using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Configuration;
using SW.SW_Common;

public partial class MasterPage : System.Web.UI.MasterPage
{
   
    string PageUrl = string.Empty;
    public string webTheme;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {           
            if (Session["PSMSSession"] != null)
            {
                Sessions PSMSSession = (Sessions)Session["PSMSSession"];
                if (PSMSSession.PermissionTable.Rows.Count > 0)
                {
                    
                    PM.BindaDropDown(cmbFinYear, new User_BLL().GetFinacialYear(), "FinYearID" ,"FinYearTitle");
                    cmbFinYear.SelectedValue = PSMSSession.FinYearID.ToString();
                    CheckAllowedPages();
                }
                else
                {
                    PM.ToastMsg(this.Page, Constants.Information, "User not allowed permission", Constants.bottom_right);
                }
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        FillMenu();
        
        JQ.DatePicker(this.Page);
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), "autocom();", true);
    }
 
    private void CheckAllowedPages()
    {
        Sessions PSMSSession = (Sessions)Session["PSMSSession"];
        if (PSMSSession.Permission != null)
        {
            PageUrl = Request.Url.Segments.Last();

            DataRow[] dr = PSMSSession.PermissionTable.Select("PageUrl like '%" + PageUrl.ToString() + "%'");
            if (dr.Length > 0)
            {
                if (true)
                {
                    PSMSSession.Can_Insert = dr.Length > 0 ? Convert.ToBoolean(dr[0]["Can_Insert"]) : false;
                    PSMSSession.Can_Update = dr.Length > 0 ? Convert.ToBoolean(dr[0]["Can_Update"]) : false;
                    PSMSSession.Can_Delete = dr.Length > 0 ? Convert.ToBoolean(dr[0]["Can_Delete"]) : false;
                    PSMSSession.Can_View = dr.Length > 0 ? Convert.ToBoolean(dr[0]["Can_View"]) : false;
                }
                else
                {
                    Response.Redirect("" + PSMSSession.PageRefrence.ToString() + "");
                }
            }
        }
    }

    private void FillMenu()
    {
        Sessions PSMSSession = (Sessions)Session["PSMSSession"];
        if (PSMSSession != null)
        {
          
            webTheme = PSMSSession.Theme;
            imgwhtlogo.ImageUrl = ConfigurationManager.AppSettings["webroot"] + "App_Images/"+ PSMSSession.FolderName + "/logo/logowhite.png";
            spcname.InnerText = PSMSSession.CompanyName;
            DataTable dtMenu = PSMSSession.MenuTable;
            DataTable dtSubMenu = PSMSSession.SubMenuTable;
            DataTable dtPages = PSMSSession.PageTable;
            string Menujson = JsonConvert.SerializeObject(dtMenu, Formatting.Indented);
            string SubMenujson = JsonConvert.SerializeObject(dtSubMenu, Formatting.Indented);
            string Pagesjson = JsonConvert.SerializeObject(dtPages, Formatting.Indented);
            hdnMenu.Value = Menujson;
            hdnSubMenu.Value = SubMenujson;
            hdnPages.Value = Pagesjson;
            hdnMenuLink.Value = ConfigurationManager.AppSettings["webroot"];
        }
    }
    protected void btnSavePassword_Click(object sender, EventArgs e)
    {
        try
        {
            Sessions PSMSSession = (Sessions)Session["PSMSSession"];
            if (string.IsNullOrEmpty(txtCurrentPassword.Text) || string.IsNullOrEmpty(txtNewPassword.Text) || string.IsNullOrEmpty(txtConfirmPassword.Text))
            {
                lbmsg.InnerText = "Password fields required.";
                return;

            }
            User_BLL b = new User_BLL();
            DataTable dt = b.GetUserList(PSMSSession.UserID);
            string oldp = EncryptDecrypt.Decrypt(dt.Rows[0]["Password"].ToString());
            if (oldp != txtCurrentPassword.Text)
            {
                lbmsg.InnerText = "Current Password Invalid";
                return;

            }
            if (txtNewPassword.Text == txtConfirmPassword.Text)
            {

                b.ChangePassword(PSMSSession.UserID, EncryptDecrypt.Encrypt(txtNewPassword.Text));
                JQ.CloseModal(this.Page, "ModalChangePassword");
                JQ.ShowStatusMsg(this.Page, "1", "Password changed successfully.");

            }
            else
            {
                lbmsg.InnerText = "Password mismatch";

            }
        }
        catch (Exception ex)
        { lbmsg.InnerText = ex.Message; }
    }

    protected void btnlogout_Click(object sender, EventArgs e)
    {
        Session["PSMSSession"] = null;
        SessionHelper.AbandonSession(System.Web.HttpContext.Current);//Delete any existing sessions
        Response.Redirect(ConfigurationManager.AppSettings["webroot"]+"/Login.aspx", false);
    }

    
    protected void cmbFinYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        Sessions PSMS = (Sessions)Session["PSMSSession"];
        Financial_BAL FBLL = new Financial_BAL();
        if (PSMS.Can_Insert == true)
        {

            int DefaultFinYearID = SCGL_Common.Convert_ToInt(cmbFinYear.SelectedValue);
            FBLL.SetDefaultFinancialYear(DefaultFinYearID);
        }



    }

  
}
