using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using SQLHelper;

/// <summary>
/// Summary description for UserRole_DAL
/// </summary>
public class UserRole_DAL
{
	public UserRole_DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public virtual DataTable GetAllRole(int? RoleID)
    {
        SqlParameter[] param = {
                                    new SqlParameter("@RoleID",RoleID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetAllRole", param).Tables[0];
    }

    public virtual int InsertRole(UserRole_BLL Role)
    {
        SqlParameter[] param = {
                                    new SqlParameter("@CompanyID",Role.CompanyID)
                                   ,new SqlParameter("@RoleName",Role.RoleName)
                                   ,new SqlParameter("@Description",Role.Description)
                                   ,new SqlParameter("@Status",Role.Status)
                                   ,new SqlParameter("@CreatedDate",Role.CreatedDate)
                                   ,new SqlParameter("@CreatedBy",Role.CreatedBy)
                               };
        return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, "[SP_InsertRole]", param));
    }

    public virtual int UpdateRole(UserRole_BLL Role)
    {
        SqlParameter[] param = {
                                    new SqlParameter("@RoleID",Role.RoleID)
                                   ,new SqlParameter("@CompanyID",Role.CompanyID)
                                   ,new SqlParameter("@RoleName",Role.RoleName)
                                   ,new SqlParameter("@Description",Role.Description)
                                   ,new SqlParameter("@Status",Role.Status)
                                   ,new SqlParameter("@UpdatedDate",Role.UpdatedDate)
                                   ,new SqlParameter("@UpdatedBy",Role.UpdatedBy)
                               };
        return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, "[SP_UpdateRole]", param));
    }

    public virtual int DeleteRole(int RoleID)
    {
        SqlParameter[] param = {
                                    new SqlParameter("@RoleID",RoleID)
                               };
        return Convert.ToInt32(SqlHelper.ExecuteScalar(ConnectionString.PSMS, "[SP_DeleteRole]", param));
    }

    public virtual bool ChildRecordExistsByRole(int RoleID)
    {
        SqlParameter[] param = {
                                    new SqlParameter("@RoleID",RoleID)
                               };
        return Convert.ToBoolean(SqlHelper.ExecuteScalar(ConnectionString.PSMS, "[SP_ChildRecordExistsByRole]", param));
    }
}