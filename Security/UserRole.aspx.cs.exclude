using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class Security_UserRole : System.Web.UI.Page
{
    Company_BLL Com = new Company_BLL();
   
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
                if (dtRole.Rows[row]["PageUrl"].ToString() == "Security/UserRole.aspx")
                {
                    pageName = dtRole.Rows[row]["PageUrl"].ToString();
                    view = Convert.ToBoolean(dtRole.Rows[row]["Can_View"].ToString());
                    break;
                }
            }
            if (dtRole.Rows.Count > 0)
            {
                if (pageName == "Security/UserRole.aspx" && view == true)
                {
                    PM.Bind_DropDown(ddlCompany, Com.BindCompany());
                }
                else
                {
                    Response.Redirect("Default.aspx", false);
                }
            }

        }
    }


    [WebMethod]
    public static string GetData()
    {
        string Json = "";
        Sessions PSMSSession = (Sessions)HttpContext.Current.Session["PSMSSession"];
        if (PSMSSession != null)
        {
            UserRole_BLL Role = new UserRole_BLL();
            Json = JsonConvert.SerializeObject(Role.GetAllRole(null), Formatting.Indented);
        }
        return Json;
    }

    [WebMethod]
    public static void SaveRole(int CompanyID, string RoleName, string Description, bool Status)
    {
        Sessions PSMSSession = (Sessions)HttpContext.Current.Session["PSMSSession"];
        if (PSMSSession != null)
        {
            UserRole_BLL Role = new UserRole_BLL();
            Role.CompanyID = CompanyID;
            Role.RoleName = RoleName;
            Role.Description = Description;
            Role.Status = Status;
            Role.CreatedBy = PSMSSession.UserID;
            Role.CreatedDate = DateTime.Now;
            Role.InsertRole(Role);
        }
    }

    [WebMethod]
    public static string ViewRole(int RoleID)
    {
        string Json = "";
        Sessions PSMSSession = (Sessions)HttpContext.Current.Session["PSMSSession"];
        if (PSMSSession != null)
        {
            UserRole_BLL Role = new UserRole_BLL();
            Json = JsonConvert.SerializeObject(Role.GetAllRole(RoleID), Formatting.Indented);
        }

        return Json;
    }

    [WebMethod]
    public static void EditRole(int CompanyID, int RoleID, string RoleName, string Description, bool Status)
    {
        Sessions PSMSSession = (Sessions)HttpContext.Current.Session["PSMSSession"];
        if (PSMSSession != null)
        {
            UserRole_BLL Role = new UserRole_BLL();
            Role.RoleID = RoleID;
            Role.CompanyID = CompanyID;
            Role.RoleName = RoleName;
            Role.Description = Description;
            Role.Status = Status;
            Role.UpdatedBy = PSMSSession.UserID;
            Role.UpdatedDate = DateTime.Now;
            Role.UpdateRole(Role);
        }
    }

    [WebMethod]
    public static void DeleteRole(int RoleID)
    {
        Sessions PSMSSession = (Sessions)HttpContext.Current.Session["PSMSSession"];
        if (PSMSSession != null)
        {
            UserRole_BLL Role = new UserRole_BLL();
            Role.DeleteRole(RoleID);
        }
    }

    [WebMethod]
    public static string RolePermission(int RoleID, string RoleName)
    {
        var url = "";
        Sessions PSMSSession = (Sessions)HttpContext.Current.Session["PSMSSession"];
        if (PSMSSession != null)
        {
            string user = HttpContext.Current.User.Identity.Name;
            url = String.Format("RolePermission.aspx?ID={0}&Name={1}", EncryptDecrypt.Encrypt(RoleID.ToString()), EncryptDecrypt.Encrypt(RoleName));
        }
        return url;
    }

    [WebMethod]
    public static bool ChildRecordExistsByRole(int RoleID)
    {
        bool YN = new bool();
        Sessions PSMSSession = (Sessions)HttpContext.Current.Session["PSMSSession"];
        if (PSMSSession != null)
        {
            UserRole_BLL Role = new UserRole_BLL();
            YN = Role.ChildRecordExistsByRole(RoleID);
        }
        return YN;
    }


    protected void btnConfirmation_Click(object sender, EventArgs e)
    {

    }
}