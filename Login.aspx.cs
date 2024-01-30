using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)

    {
        //LoadFinYear();
        Sessions PSMS = new Sessions();
        var userSess = Session["PSMSSession"];
        if (userSess != null)
        {
            PSMS = (Sessions)userSess;
            Session["PSMSSession"] = PSMS;
            Response.Redirect("Default.aspx",false);
        }
        
    }


    public void LoadFinYear()
    {
        //User_BLL UBO = new User_BLL();
        //ddlFinYear.DataSource = UBO.GetFinacialYear();
        //ddlFinYear.DataValueField = "FinYearID";
        //ddlFinYear.DataTextField = "FinYearTitle";
        //ddlFinYear.DataBind();
        //ddlFinYear.Items.Insert(0, new ListItem("--Please Select--", "0"));
        //ddlFinYear.SelectedValue = UBO.GetDefaultFinancialYear().ToString();

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
       
        string StatusLogin = "";
        Sessions PSMS = new Sessions();
        Login_BLL BL_Login = new Login_BLL();
        try
        {
        DataTable dtCompany = BL_Login.GetCompanyInfo(ddlCompany.SelectedValue);
        if (dtCompany.Rows.Count > 0)
        {


                if (string.IsNullOrEmpty(dtCompany.Rows[0]["Terminated"].ToString()))
                {
                    PSMS.Server = dtCompany.Rows[0]["Server"].ToString();
                    PSMS.Database = dtCompany.Rows[0]["DatabaseName"].ToString();
                    PSMS.dbUser = dtCompany.Rows[0]["DbUser"].ToString();
                    PSMS.dbPassword = dtCompany.Rows[0]["DbPassword"].ToString();
                    string conn = "Data Source=" + dtCompany.Rows[0]["Server"].ToString() + ";Initial Catalog=" + dtCompany.Rows[0]["DatabaseName"].ToString() + ";User ID=" + dtCompany.Rows[0]["DbUser"].ToString() + ";Password=" + dtCompany.Rows[0]["DbPassword"].ToString() + ";Connect Timeout=1000";
                    DataTable dtUser = BL_Login.GetUserByLoginID(txtUserID.Text, conn);
                    if (dtUser.Rows.Count > 0)
                    {
                        var DTPassword = from SN in dtUser.AsEnumerable()
                                         where SN.Field<string>("UserName") == dtUser.Rows[0]["UserName"].ToString() && SN.Field<string>("Password") == EncryptDecrypt.Encrypt(txtPassword.Text)
                                         select SN;
                        if (DTPassword != null && DTPassword.Count() != 0)
                        {
                            dtUser = DTPassword.CopyToDataTable();
                            if (dtUser.Rows.Count > 0)
                            {

                                PSMS.RoleID = Convert.ToInt32(dtUser.Rows[0]["RoleID"]);
                                PSMS.UserID = Convert.ToInt32(dtUser.Rows[0]["UserID"]);
                                PSMS.RoleName = dtUser.Rows[0]["RoleName"].ToString();
                                PSMS.UserFullName = dtUser.Rows[0]["Name"].ToString();
                                PSMS.UserName = dtUser.Rows[0]["UserName"].ToString();
                                PSMS.rptColor = dtUser.Rows[0]["rptColor"].ToString();
                                PSMS.FolderName = dtUser.Rows[0]["FolderName"].ToString();
                                PSMS.CompanyName = dtUser.Rows[0]["CompanyName"].ToString();
                                PSMS.FinYearID = Convert.ToInt32(dtUser.Rows[0]["FinYearID"]);
                                PSMS.Theme = dtUser.Rows[0]["Theme"].ToString();
                                //here
                                //PSMS.FinYearID = Convert.ToInt32(ddlFinYear.SelectedValue);                                
                                PSMS.SiteID = 1;
                                IPAddress[] UserIp = Dns.GetHostAddresses(Dns.GetHostName());
                                PSMS.UserIP = UserIp[0].ToString();  
                                //here                              
                                PSMS.Permission = "Checked";
                                if (Convert.ToBoolean(dtUser.Rows[0]["RoleStatus"]) == true)
                                {
                                    if (Convert.ToBoolean(dtUser.Rows[0]["UserStatus"]) == true)
                                    {

                                        if (Convert.ToBoolean(dtCompany.Rows[0]["IsActive"]) == true)
                                        {

                                            PSMS.PermissionTable = BL_Login.GetPermissionpPagesByRole(Convert.ToInt32(dtUser.Rows[0]["RoleID"]), conn);
                                            DataSet dsMenues = new DataSet();
                                            dsMenues = BL_Login.GetMenuPageByRoleID(Convert.ToInt32(dtUser.Rows[0]["RoleID"]), conn);

                                            PSMS.MenuTable = dsMenues.Tables[0];
                                            PSMS.SubMenuTable = dsMenues.Tables[1];
                                            PSMS.PageTable = dsMenues.Tables[2];


                                            HttpContext.Current.Session["PSMSSession"] = PSMS;


                                            StatusLogin = "Login Successfully";
                                        }
                                        else
                                        {
                                            StatusLogin = "Your access has been temporarily revoked.";
                                        }
                                    }
                                    else
                                    {
                                        StatusLogin = "User not Active";
                                    }
                                }
                                else
                                {
                                    StatusLogin = "Role not Active";
                                }
                            }
                        }
                        else
                        {
                            StatusLogin = "Invaild Password";
                        }
                    }
                    else
                    {
                        StatusLogin = "Invaild Username";
                    }


                }
                else
                {
                    StatusLogin = "Your access has been permanently revoked.";
                }
        }
        else
        {
            StatusLogin = "Invaild App Code";
        }

        }
        catch(Exception ex)
        {
            StatusLogin = "Your request has not been processed due to a temporary error.";
        }

        if (StatusLogin == "Login Successfully")
        { Response.Redirect("Default.aspx");  }
        else
        { lbmsg.InnerText = StatusLogin; }
        
    }

    private bool CheckPassword(string Password)
    {
        bool ValidRoot = false;
        string Constr = string.Empty;
        string path = Server.MapPath("") + "\\Services\\AppExcute.riz";
        StreamReader sr = new StreamReader(path);
        Constr = sr.ReadLine();
        if (Constr == Password)
        {
            ValidRoot = true;
        }
        else
        {
            ValidRoot = false;
        }
        return ValidRoot;
    }

    private void RootUserlogin(string Password)
    {
        string StatusLogin = "";
        bool RootUser = false;
        string finalValue = "";
        int Value = 0;
        byte[] ascii = System.Text.Encoding.ASCII.GetBytes(Password);
        foreach (Byte b in ascii)
        {
            Value = Convert.ToInt32(b.ToString());
            int Newvalue = Value + 1;
            finalValue += Convert.ToChar(Newvalue);
        }
        RootUser = CheckPassword(finalValue);
        if (RootUser == true)
        {
            Sessions PSMS = new Sessions();
            PSMS.UserID = 1;
            IPAddress[] UserIp = Dns.GetHostAddresses(Dns.GetHostName());
            PSMS.UserIP = UserIp[0].ToString();
            PSMS.SiteID = 1;
            PSMS.CompanyName = "Viftech Solutions Ltd"; //BLL.getSiteName();
            PSMS.UserName = "root";
            PSMS.isRoot = true;
            Session["PSMSSession"] = PSMS;
            Response.Redirect("Default.aspx");
        }
        else
        {
            StatusLogin = "Root Password is incorrect";
        }
    }
}


