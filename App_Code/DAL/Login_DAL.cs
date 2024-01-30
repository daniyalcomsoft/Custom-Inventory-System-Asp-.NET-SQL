using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using SQLHelper;

/// <summary>
/// Summary description for User_DAL
/// </summary>
public class Login_DAL
{
	public Login_DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public virtual DataTable GetCompanyInfo(string Code)
    {


        SqlParameter[] Gparam = {
                                    new SqlParameter("@Code",Code)
                               };
        return SqlHelper.ExecuteDataset(PrimaryConnectionString.PrimaryCon, CommandType.StoredProcedure, "[SP_GetCompanyInfo]", Gparam).Tables[0];
    }

    public virtual DataTable GetUserByLoginID(string LoginID,string con)
    {


        SqlParameter[] Gparam = {
                                    new SqlParameter("@UserName",LoginID)
                               };
        return SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "SP_GetUserByUserName", Gparam).Tables[0];
    }
    public virtual DataTable GetPermissionpPagesByRole(int RoleID, string con)
    {
        SqlParameter[] param = {
                                    new SqlParameter("@RoleID",RoleID)
                               };
        return SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "SP_GetPermissionPages", param).Tables[0];
    }
    public virtual DataSet GetMenuPageByRoleID(int RoleID, string con)
    {
        SqlParameter[] param = { new SqlParameter("@RoleID", RoleID) };
        return SqlHelper.ExecuteDataset(con, CommandType.StoredProcedure, "SP_GetMenuPageByRoleID", param);
    }
}