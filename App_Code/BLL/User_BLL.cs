using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for User_BLL
/// </summary>
public class User_BLL:User_DAL
{
	public User_BLL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public int UserID { get; set; }
    public int RoleID { get; set; }
    public string Name { get; set; }
    public string UserName { get; set; }
    public string Password { get; set; }
    public string Phone { get; set; }
    public string Email { get; set; }
    public string Address { get; set; }
    public bool Status { get; set; }
    public int User { get; set; }
    public DateTime Date { get; set; }

    // by daniyal
    public string Prefix { get; set; }
    public string FirstName { get; set; }
    public string MiddleName { get; set; }
    public string LastName { get; set; }
    public string CellPhonePrimary { get; set; }
    public string CellPhoneSecondary { get; set; }
    public string HomePhone { get; set; }
    public string OfficePhone { get; set; }
    public string MailingAddress { get; set; }
    public string District { get; set; }
    public string City { get; set; }
    public string Postal { get; set; }

    public override System.Data.DataTable GetUserByUserName(string UserName)
    {
        return base.GetUserByUserName(UserName);
    }


    // 1/7/2022/ by daniyal / 5:55 PM
    private string _UserPassword;
    public string UserPassword
    {
        get
        {
            return _UserPassword;
        }
        set
        {
            _UserPassword = value;
        }
    }
    public bool? specialPermission { get; set; }
    public Int16? IsActive { get; set; }
    
    public override System.Data.DataTable CheckUserRolebeforeDelete(int RoleID)
    {
        return base.CheckUserRolebeforeDelete(RoleID);
    }
    public override System.Data.DataTable GetFinacialYear()
    {
        return base.GetFinacialYear();
    }

    public override int GetDefaultFinancialYear()
    {
        return base.GetDefaultFinancialYear();
    }
    public override System.Data.DataRow CreateModifyUser(User_BLL BOUser, SCGL_Session BOsession)
    {
        return base.CreateModifyUser(BOUser, BOsession);
    }
    public override int DeleteUser(int UserID)
    {
        return base.DeleteUser(UserID);
    }
    public override System.Data.DataTable GetAllUserInfo()
    {
        return base.GetAllUserInfo();
    }
    public override User_BLL GetUserInfo(int UserID)
    {
        return base.GetUserInfo(UserID);
    }
    public override System.Data.DataTable GetUserInfoDropdown()
    {
        return base.GetUserInfoDropdown();
    }
    public override System.Data.DataTable GetUserPermissionByUserID(int UserID)
    {
        return base.GetUserPermissionByUserID(UserID);
    }
    public override int IsRole(string UserName, string Password)
    {
        return base.IsRole(UserName, Password);
    }
    public override int IsUser(string UserName, string Password)
    {
        return base.IsUser(UserName, Password);
    }
    public override void SetSpecialPermissionTrueFalse(int UserID)
    {
        base.SetSpecialPermissionTrueFalse(UserID);
    }
}