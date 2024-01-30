using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using SQLHelper;

/// <summary>
/// Summary description for RolePermission_DAL
/// </summary>
public class RolePermission_DAL
{
	public RolePermission_DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public virtual DataTable GetAllModule(int? ModuleID)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@ModuleID",ModuleID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetAllModuleByModuleID", Gparam).Tables[0];
    }

    public virtual DataTable GetAllPageByModuleID(int? ModuleID)
    {
        SqlParameter[] Gparam = {
                                    new SqlParameter("@ModuleID",ModuleID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetAllPageByModuleID", Gparam).Tables[0];
    }

    public virtual int DeletePagePermissionPagesByRole(int RoleID, SqlTransaction Tran)
    {
        SqlParameter[] param = {
                                    new SqlParameter("@RoleID", RoleID)
                               };
        return SqlHelper.ExecuteNonQuery(Tran, "[SP_DeleteRolePagePermission]", param);
    }

    public virtual int DeleteModulePermissionByRoleID(int RoleID, SqlTransaction Tran)
    {
        SqlParameter[] param = {
                                    new SqlParameter("@RoleID", RoleID)
                               };
        return Convert.ToInt32(SqlHelper.ExecuteNonQuery(Tran, "[SP_DeleteModulePermission]", param));
    }

    public virtual int InsertUpdateModulePermissionByRoleID(RolePermission_BLL RP, SqlTransaction Tran, Sessions Sess)
    {
        SqlParameter[] param = {new SqlParameter("@ModulePermissionID",RP.ModulePermissionID)
                                   ,new SqlParameter("@RoleID",RP.RoleID)
                                   ,new SqlParameter("@ModuleID",RP.ModuleID)
                                   ,new SqlParameter("@Can_View",RP.Can_View)
                                   ,new SqlParameter("@Can_Insert",RP.Can_Insert)
                                   ,new SqlParameter("@Can_Update",RP.Can_Update)
                                   ,new SqlParameter("@Can_Delete",RP.Can_Delete)
                                   ,new SqlParameter("@Active",RP.Active)
                                   ,new SqlParameter("@CreatedBy",Sess.UserID)
                                   ,new SqlParameter("@CreatedDate",DateTime.Now)
                                   };
        return Convert.ToInt32(SqlHelper.ExecuteScalar(Tran, "[SP_InsertUpdateModulPermissionByRoleID]", param));
    }

    public virtual int InsertUpdatePagePermission(RolePermission_BLL RP, SqlTransaction Tran, Sessions Sess)
    {
        SqlParameter[] param ={new SqlParameter("@UserRolePermissionID",RP.PermissionID) 
                                 ,new SqlParameter("@RoleID",RP.RoleID)
                                 ,new SqlParameter("@PageID",RP.PageID)
                                 ,new SqlParameter("@Can_View",RP.Can_View)
                                 ,new SqlParameter("@Can_Insert",RP.Can_Insert)
                                 ,new SqlParameter("@Can_Update",RP.Can_Update)
                                 ,new SqlParameter("@Can_Delete",RP.Can_Delete)
                                 ,new SqlParameter("@Active",RP.Active)
                                 ,new SqlParameter("@CreatedBy",Sess.UserID)
                                 ,new SqlParameter("@CreatedDate", DateTime.Now)
                                 };
        return Convert.ToInt32(SqlHelper.ExecuteScalar(Tran, "[SP_InsertUpdatePagePermission]", param));
    }

    public virtual DataTable GetPagePermissionpPagesByRole(int RoleID)
    {
        SqlParameter[] param = {
                                    new SqlParameter("@RoleID",RoleID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetPagePermissionPages", param).Tables[0];
      
    }
 
    public virtual DataTable GetModuleRightsByRoleID(int RoleID)
    {
        SqlParameter[] param = {
                                    new SqlParameter("@RoleID", RoleID)
                               };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "[SP_GetModuleRights]", param).Tables[0];
    }

    public virtual DataTable GetMenuByRoleID(int RoleID)
    {
        SqlParameter[] param = { new SqlParameter("@RoleID", RoleID) };
        return SqlHelper.ExecuteDataset(ConnectionString.PSMS, CommandType.StoredProcedure, "SP_GetMenuByRoleID", param).Tables[0];
    }
  
}